///===
/// extcore/signal_spec_min_norm

pub(all) struct SignalspecminnormPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_min_norm_make_point(x : Double, y : Double) -> SignalspecminnormPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_min_norm_make_point3(x : Double, y : Double, z : Double) -> SignalspecminnormPoint {
  { x, y, z, label: 0 }
}

pub fn signal_spec_min_norm_point_x(pt : SignalspecminnormPoint) -> Double { pt.x }

pub fn signal_spec_min_norm_point_y(pt : SignalspecminnormPoint) -> Double { pt.y }

pub fn signal_spec_min_norm_point_z(pt : SignalspecminnormPoint) -> Double { pt.z }

pub fn signal_spec_min_norm_point_label(pt : SignalspecminnormPoint) -> Int { pt.label }

pub fn signal_spec_min_norm_point_dist(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_spec_min_norm_point_add(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_spec_min_norm_point_sub(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_spec_min_norm_point_scale(pt : SignalspecminnormPoint, s : Double) -> SignalspecminnormPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_spec_min_norm_point_dot(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_spec_min_norm_point_cross(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_spec_min_norm_point_norm(pt : SignalspecminnormPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_spec_min_norm_point_normalize(pt : SignalspecminnormPoint) -> SignalspecminnormPoint {
  let n = signal_spec_min_norm_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_spec_min_norm_point_scale(pt, 1.0 / n) }
}

pub fn signal_spec_min_norm_point_negate(pt : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_spec_min_norm_point_mid(a : SignalspecminnormPoint, b : SignalspecminnormPoint) -> SignalspecminnormPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_spec_min_norm_point_lerp(a : SignalspecminnormPoint, b : SignalspecminnormPoint, t : Double) -> SignalspecminnormPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_spec_min_norm_point_to_string(pt : SignalspecminnormPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SignalspecminnormSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_min_norm_make_series(vals : Array[Double], name : String) -> SignalspecminnormSeries {
  { vals, name, meta: 0 }
}

pub fn signal_spec_min_norm_series_len(s : SignalspecminnormSeries) -> Int { s.vals.length() }

pub fn signal_spec_min_norm_series_sum(s : SignalspecminnormSeries) -> Double { @_common.sum(s.vals) }

pub fn signal_spec_min_norm_series_mean(s : SignalspecminnormSeries) -> Double { @_common.mean(s.vals) }

pub fn signal_spec_min_norm_series_min(s : SignalspecminnormSeries) -> Double { @_common.min(s.vals) }

pub fn signal_spec_min_norm_series_max(s : SignalspecminnormSeries) -> Double { @_common.max(s.vals) }

pub fn signal_spec_min_norm_series_range(s : SignalspecminnormSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_spec_min_norm_series_var(s : SignalspecminnormSeries) -> Double { @_common.variance(s.vals) }

pub fn signal_spec_min_norm_series_std(s : SignalspecminnormSeries) -> Double { @_common.std(s.vals) }

pub fn signal_spec_min_norm_series_median(s : SignalspecminnormSeries) -> Double { @_common.median(s.vals) }

pub fn signal_spec_min_norm_series_scale(s : SignalspecminnormSeries, f : Double) -> SignalspecminnormSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_spec_min_norm_series_add(a : SignalspecminnormSeries, b : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_spec_min_norm_series_sub(a : SignalspecminnormSeries, b : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_spec_min_norm_series_normalize(s : SignalspecminnormSeries) -> SignalspecminnormSeries {
  let mn = signal_spec_min_norm_series_min(s)
  let mx = signal_spec_min_norm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_spec_min_norm_series_cumsum(s : SignalspecminnormSeries) -> SignalspecminnormSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_spec_min_norm_series_to_string(s : SignalspecminnormSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecminnormMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_min_norm_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecminnormMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_min_norm_matrix_identity(n : Int) -> SignalspecminnormMatrix {
  let m = signal_spec_min_norm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_spec_min_norm_matrix_get(m : SignalspecminnormMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_spec_min_norm_matrix_transpose(m : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_spec_min_norm_matrix_add(a : SignalspecminnormMatrix, b : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_spec_min_norm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_spec_min_norm_matrix_scale(m : SignalspecminnormMatrix, s : Double) -> SignalspecminnormMatrix {
  let result = signal_spec_min_norm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_spec_min_norm_matrix_multiply(a : SignalspecminnormMatrix, b : SignalspecminnormMatrix) -> SignalspecminnormMatrix {
  if a.cols != b.rows { return signal_spec_min_norm_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_spec_min_norm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_spec_min_norm_matrix_trace(m : SignalspecminnormMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_spec_min_norm_matrix_det(m : SignalspecminnormMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_spec_min_norm_matrix_norm(m : SignalspecminnormMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_spec_min_norm_matrix_to_string(m : SignalspecminnormMatrix) -> String {
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

pub(all) struct SignalspecminnormVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_min_norm_make_vector(comps : Array[Double]) -> SignalspecminnormVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_min_norm_vector_zero(dim : Int) -> SignalspecminnormVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_spec_min_norm_vector_add(a : SignalspecminnormVector, b : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_min_norm_vector_sub(a : SignalspecminnormVector, b : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_spec_min_norm_vector_scale(v : SignalspecminnormVector, s : Double) -> SignalspecminnormVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_spec_min_norm_vector_dot(a : SignalspecminnormVector, b : SignalspecminnormVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_spec_min_norm_vector_norm(v : SignalspecminnormVector) -> Double { @_common.sqrt(signal_spec_min_norm_vector_dot(v, v)) }

pub fn signal_spec_min_norm_vector_normalize(v : SignalspecminnormVector) -> SignalspecminnormVector {
  let n = signal_spec_min_norm_vector_norm(v)
  if n < 0.0000001 { v } else { signal_spec_min_norm_vector_scale(v, 1.0 / n) }
}

pub fn signal_spec_min_norm_vector_dist(a : SignalspecminnormVector, b : SignalspecminnormVector) -> Double {
  signal_spec_min_norm_vector_norm(signal_spec_min_norm_vector_sub(a, b))
}

pub fn signal_spec_min_norm_vector_to_string(v : SignalspecminnormVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_min_norm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_min_norm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_min_norm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_min_norm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_min_norm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_min_norm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_min_norm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_min_norm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_min_norm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_min_norm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_min_norm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_min_norm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_min_norm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_min_norm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_min_norm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_min_norm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_min_norm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_min_norm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_min_norm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_min_norm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_min_norm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_min_norm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_min_norm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_min_norm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_min_norm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_min_norm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_min_norm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_min_norm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_min_norm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecminnormFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_frame_make(size : Int) -> SignalspecminnormFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_frame_len(s : SignalspecminnormFrame) -> Int { s.size }

pub fn signal_spec_min_norm_frame_get(s : SignalspecminnormFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_frame_set(s : SignalspecminnormFrame, i : Int, v : Double) -> SignalspecminnormFrame {
  let result = signal_spec_min_norm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_frame_sum(s : SignalspecminnormFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_frame_mean(s : SignalspecminnormFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_frame_scale(s : SignalspecminnormFrame, f : Double) -> SignalspecminnormFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_frame_add(a : SignalspecminnormFrame, b : SignalspecminnormFrame) -> SignalspecminnormFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_frame_copy(s : SignalspecminnormFrame) -> SignalspecminnormFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_frame_fill(s : SignalspecminnormFrame, v : Double) -> SignalspecminnormFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_frame_min(s : SignalspecminnormFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_frame_max(s : SignalspecminnormFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_frame_to_string(s : SignalspecminnormFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_table_make(size : Int) -> SignalspecminnormTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_table_len(s : SignalspecminnormTable) -> Int { s.size }

pub fn signal_spec_min_norm_table_get(s : SignalspecminnormTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_table_set(s : SignalspecminnormTable, i : Int, v : Double) -> SignalspecminnormTable {
  let result = signal_spec_min_norm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_table_sum(s : SignalspecminnormTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_table_mean(s : SignalspecminnormTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_table_scale(s : SignalspecminnormTable, f : Double) -> SignalspecminnormTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_table_add(a : SignalspecminnormTable, b : SignalspecminnormTable) -> SignalspecminnormTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_table_copy(s : SignalspecminnormTable) -> SignalspecminnormTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_table_fill(s : SignalspecminnormTable, v : Double) -> SignalspecminnormTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_table_min(s : SignalspecminnormTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_table_max(s : SignalspecminnormTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_table_to_string(s : SignalspecminnormTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_graphn_make(size : Int) -> SignalspecminnormGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_graphn_len(s : SignalspecminnormGraphN) -> Int { s.size }

pub fn signal_spec_min_norm_graphn_get(s : SignalspecminnormGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_graphn_set(s : SignalspecminnormGraphN, i : Int, v : Double) -> SignalspecminnormGraphN {
  let result = signal_spec_min_norm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_graphn_sum(s : SignalspecminnormGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_graphn_mean(s : SignalspecminnormGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_graphn_scale(s : SignalspecminnormGraphN, f : Double) -> SignalspecminnormGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_graphn_add(a : SignalspecminnormGraphN, b : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_graphn_copy(s : SignalspecminnormGraphN) -> SignalspecminnormGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_graphn_fill(s : SignalspecminnormGraphN, v : Double) -> SignalspecminnormGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_graphn_min(s : SignalspecminnormGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_graphn_max(s : SignalspecminnormGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_graphn_to_string(s : SignalspecminnormGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_node_make(size : Int) -> SignalspecminnormNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_node_len(s : SignalspecminnormNode) -> Int { s.size }

pub fn signal_spec_min_norm_node_get(s : SignalspecminnormNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_node_set(s : SignalspecminnormNode, i : Int, v : Double) -> SignalspecminnormNode {
  let result = signal_spec_min_norm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_node_sum(s : SignalspecminnormNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_node_mean(s : SignalspecminnormNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_node_scale(s : SignalspecminnormNode, f : Double) -> SignalspecminnormNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_node_add(a : SignalspecminnormNode, b : SignalspecminnormNode) -> SignalspecminnormNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_node_copy(s : SignalspecminnormNode) -> SignalspecminnormNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_node_fill(s : SignalspecminnormNode, v : Double) -> SignalspecminnormNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_node_min(s : SignalspecminnormNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_node_max(s : SignalspecminnormNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_node_to_string(s : SignalspecminnormNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_edge_make(size : Int) -> SignalspecminnormEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_edge_len(s : SignalspecminnormEdge) -> Int { s.size }

pub fn signal_spec_min_norm_edge_get(s : SignalspecminnormEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_edge_set(s : SignalspecminnormEdge, i : Int, v : Double) -> SignalspecminnormEdge {
  let result = signal_spec_min_norm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_edge_sum(s : SignalspecminnormEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_edge_mean(s : SignalspecminnormEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_edge_scale(s : SignalspecminnormEdge, f : Double) -> SignalspecminnormEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_edge_add(a : SignalspecminnormEdge, b : SignalspecminnormEdge) -> SignalspecminnormEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_edge_copy(s : SignalspecminnormEdge) -> SignalspecminnormEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_edge_fill(s : SignalspecminnormEdge, v : Double) -> SignalspecminnormEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_edge_min(s : SignalspecminnormEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_edge_max(s : SignalspecminnormEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_edge_to_string(s : SignalspecminnormEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_path_make(size : Int) -> SignalspecminnormPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_path_len(s : SignalspecminnormPath) -> Int { s.size }

pub fn signal_spec_min_norm_path_get(s : SignalspecminnormPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_path_set(s : SignalspecminnormPath, i : Int, v : Double) -> SignalspecminnormPath {
  let result = signal_spec_min_norm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_path_sum(s : SignalspecminnormPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_path_mean(s : SignalspecminnormPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_path_scale(s : SignalspecminnormPath, f : Double) -> SignalspecminnormPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_path_add(a : SignalspecminnormPath, b : SignalspecminnormPath) -> SignalspecminnormPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_path_copy(s : SignalspecminnormPath) -> SignalspecminnormPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_path_fill(s : SignalspecminnormPath, v : Double) -> SignalspecminnormPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_path_min(s : SignalspecminnormPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_path_max(s : SignalspecminnormPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_path_to_string(s : SignalspecminnormPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cluster_make(size : Int) -> SignalspecminnormCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_cluster_len(s : SignalspecminnormCluster) -> Int { s.size }

pub fn signal_spec_min_norm_cluster_get(s : SignalspecminnormCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_cluster_set(s : SignalspecminnormCluster, i : Int, v : Double) -> SignalspecminnormCluster {
  let result = signal_spec_min_norm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cluster_sum(s : SignalspecminnormCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_cluster_mean(s : SignalspecminnormCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_cluster_scale(s : SignalspecminnormCluster, f : Double) -> SignalspecminnormCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cluster_add(a : SignalspecminnormCluster, b : SignalspecminnormCluster) -> SignalspecminnormCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_cluster_copy(s : SignalspecminnormCluster) -> SignalspecminnormCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cluster_fill(s : SignalspecminnormCluster, v : Double) -> SignalspecminnormCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cluster_min(s : SignalspecminnormCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_cluster_max(s : SignalspecminnormCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_cluster_to_string(s : SignalspecminnormCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_model_make(size : Int) -> SignalspecminnormModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_model_len(s : SignalspecminnormModel) -> Int { s.size }

pub fn signal_spec_min_norm_model_get(s : SignalspecminnormModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_model_set(s : SignalspecminnormModel, i : Int, v : Double) -> SignalspecminnormModel {
  let result = signal_spec_min_norm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_model_sum(s : SignalspecminnormModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_model_mean(s : SignalspecminnormModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_model_scale(s : SignalspecminnormModel, f : Double) -> SignalspecminnormModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_model_add(a : SignalspecminnormModel, b : SignalspecminnormModel) -> SignalspecminnormModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_model_copy(s : SignalspecminnormModel) -> SignalspecminnormModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_model_fill(s : SignalspecminnormModel, v : Double) -> SignalspecminnormModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_model_min(s : SignalspecminnormModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_model_max(s : SignalspecminnormModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_model_to_string(s : SignalspecminnormModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_layer_make(size : Int) -> SignalspecminnormLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_layer_len(s : SignalspecminnormLayer) -> Int { s.size }

pub fn signal_spec_min_norm_layer_get(s : SignalspecminnormLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_layer_set(s : SignalspecminnormLayer, i : Int, v : Double) -> SignalspecminnormLayer {
  let result = signal_spec_min_norm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_layer_sum(s : SignalspecminnormLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_layer_mean(s : SignalspecminnormLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_layer_scale(s : SignalspecminnormLayer, f : Double) -> SignalspecminnormLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_layer_add(a : SignalspecminnormLayer, b : SignalspecminnormLayer) -> SignalspecminnormLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_layer_copy(s : SignalspecminnormLayer) -> SignalspecminnormLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_layer_fill(s : SignalspecminnormLayer, v : Double) -> SignalspecminnormLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_layer_min(s : SignalspecminnormLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_layer_max(s : SignalspecminnormLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_layer_to_string(s : SignalspecminnormLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_buffer_make(size : Int) -> SignalspecminnormBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_buffer_len(s : SignalspecminnormBuffer) -> Int { s.size }

pub fn signal_spec_min_norm_buffer_get(s : SignalspecminnormBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_buffer_set(s : SignalspecminnormBuffer, i : Int, v : Double) -> SignalspecminnormBuffer {
  let result = signal_spec_min_norm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_buffer_sum(s : SignalspecminnormBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_buffer_mean(s : SignalspecminnormBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_buffer_scale(s : SignalspecminnormBuffer, f : Double) -> SignalspecminnormBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_buffer_add(a : SignalspecminnormBuffer, b : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_buffer_copy(s : SignalspecminnormBuffer) -> SignalspecminnormBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_buffer_fill(s : SignalspecminnormBuffer, v : Double) -> SignalspecminnormBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_buffer_min(s : SignalspecminnormBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_buffer_max(s : SignalspecminnormBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_buffer_to_string(s : SignalspecminnormBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_cursor_make(size : Int) -> SignalspecminnormCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_cursor_len(s : SignalspecminnormCursor) -> Int { s.size }

pub fn signal_spec_min_norm_cursor_get(s : SignalspecminnormCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_cursor_set(s : SignalspecminnormCursor, i : Int, v : Double) -> SignalspecminnormCursor {
  let result = signal_spec_min_norm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_cursor_sum(s : SignalspecminnormCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_cursor_mean(s : SignalspecminnormCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_cursor_scale(s : SignalspecminnormCursor, f : Double) -> SignalspecminnormCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cursor_add(a : SignalspecminnormCursor, b : SignalspecminnormCursor) -> SignalspecminnormCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_cursor_copy(s : SignalspecminnormCursor) -> SignalspecminnormCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cursor_fill(s : SignalspecminnormCursor, v : Double) -> SignalspecminnormCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_cursor_min(s : SignalspecminnormCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_cursor_max(s : SignalspecminnormCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_cursor_to_string(s : SignalspecminnormCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_view_make(size : Int) -> SignalspecminnormView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_view_len(s : SignalspecminnormView) -> Int { s.size }

pub fn signal_spec_min_norm_view_get(s : SignalspecminnormView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_view_set(s : SignalspecminnormView, i : Int, v : Double) -> SignalspecminnormView {
  let result = signal_spec_min_norm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_view_sum(s : SignalspecminnormView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_view_mean(s : SignalspecminnormView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_view_scale(s : SignalspecminnormView, f : Double) -> SignalspecminnormView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_view_add(a : SignalspecminnormView, b : SignalspecminnormView) -> SignalspecminnormView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_view_copy(s : SignalspecminnormView) -> SignalspecminnormView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_view_fill(s : SignalspecminnormView, v : Double) -> SignalspecminnormView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_view_min(s : SignalspecminnormView) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_view_max(s : SignalspecminnormView) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_view_to_string(s : SignalspecminnormView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_range_make(size : Int) -> SignalspecminnormRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_range_len(s : SignalspecminnormRange) -> Int { s.size }

pub fn signal_spec_min_norm_range_get(s : SignalspecminnormRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_range_set(s : SignalspecminnormRange, i : Int, v : Double) -> SignalspecminnormRange {
  let result = signal_spec_min_norm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_range_sum(s : SignalspecminnormRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_range_mean(s : SignalspecminnormRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_range_scale(s : SignalspecminnormRange, f : Double) -> SignalspecminnormRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_range_add(a : SignalspecminnormRange, b : SignalspecminnormRange) -> SignalspecminnormRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_range_copy(s : SignalspecminnormRange) -> SignalspecminnormRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_range_fill(s : SignalspecminnormRange, v : Double) -> SignalspecminnormRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_range_min(s : SignalspecminnormRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_range_max(s : SignalspecminnormRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_range_to_string(s : SignalspecminnormRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecminnormSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_min_norm_slice_make(size : Int) -> SignalspecminnormSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_min_norm_slice_len(s : SignalspecminnormSlice) -> Int { s.size }

pub fn signal_spec_min_norm_slice_get(s : SignalspecminnormSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_min_norm_slice_set(s : SignalspecminnormSlice, i : Int, v : Double) -> SignalspecminnormSlice {
  let result = signal_spec_min_norm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_spec_min_norm_slice_sum(s : SignalspecminnormSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_min_norm_slice_mean(s : SignalspecminnormSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_min_norm_slice_scale(s : SignalspecminnormSlice, f : Double) -> SignalspecminnormSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_slice_add(a : SignalspecminnormSlice, b : SignalspecminnormSlice) -> SignalspecminnormSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_min_norm_slice_copy(s : SignalspecminnormSlice) -> SignalspecminnormSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_slice_fill(s : SignalspecminnormSlice, v : Double) -> SignalspecminnormSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_min_norm_slice_min(s : SignalspecminnormSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_min_norm_slice_max(s : SignalspecminnormSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_min_norm_slice_to_string(s : SignalspecminnormSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


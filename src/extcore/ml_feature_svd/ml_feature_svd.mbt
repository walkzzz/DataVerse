///===
/// extcore/ml_feature_svd

pub(all) struct MlfeaturesvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_svd_make_point(x : Double, y : Double) -> MlfeaturesvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_svd_make_point3(x : Double, y : Double, z : Double) -> MlfeaturesvdPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_svd_point_x(pt : MlfeaturesvdPoint) -> Double { pt.x }

pub fn ml_feature_svd_point_y(pt : MlfeaturesvdPoint) -> Double { pt.y }

pub fn ml_feature_svd_point_z(pt : MlfeaturesvdPoint) -> Double { pt.z }

pub fn ml_feature_svd_point_label(pt : MlfeaturesvdPoint) -> Int { pt.label }

pub fn ml_feature_svd_point_dist(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_svd_point_add(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_svd_point_sub(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_svd_point_scale(pt : MlfeaturesvdPoint, s : Double) -> MlfeaturesvdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_svd_point_dot(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_svd_point_cross(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_svd_point_norm(pt : MlfeaturesvdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_svd_point_normalize(pt : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  let n = ml_feature_svd_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_svd_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_svd_point_negate(pt : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_svd_point_mid(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint) -> MlfeaturesvdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_svd_point_lerp(a : MlfeaturesvdPoint, b : MlfeaturesvdPoint, t : Double) -> MlfeaturesvdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_svd_point_to_string(pt : MlfeaturesvdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeaturesvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_svd_make_series(vals : Array[Double], name : String) -> MlfeaturesvdSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_svd_series_len(s : MlfeaturesvdSeries) -> Int { s.vals.length() }

pub fn ml_feature_svd_series_sum(s : MlfeaturesvdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_feature_svd_series_mean(s : MlfeaturesvdSeries) -> Double {
  let n = ml_feature_svd_series_len(s)
  if n == 0 { 0.0 } else { ml_feature_svd_series_sum(s) / n.to_double() }
}

pub fn ml_feature_svd_series_min(s : MlfeaturesvdSeries) -> Double {
  let n = ml_feature_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_svd_series_max(s : MlfeaturesvdSeries) -> Double {
  let n = ml_feature_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_svd_series_range(s : MlfeaturesvdSeries) -> Double {
  ml_feature_svd_series_max(s) - ml_feature_svd_series_min(s)
}

pub fn ml_feature_svd_series_var(s : MlfeaturesvdSeries) -> Double {
  let n = ml_feature_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_feature_svd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_feature_svd_series_std(s : MlfeaturesvdSeries) -> Double { @_common.sqrt(ml_feature_svd_series_var(s)) }

pub fn ml_feature_svd_series_median(s : MlfeaturesvdSeries) -> Double {
  let n = ml_feature_svd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_svd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_svd_series_scale(s : MlfeaturesvdSeries, f : Double) -> MlfeaturesvdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_svd_series_add(a : MlfeaturesvdSeries, b : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_svd_series_sub(a : MlfeaturesvdSeries, b : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_svd_series_normalize(s : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let mn = ml_feature_svd_series_min(s)
  let mx = ml_feature_svd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_svd_series_cumsum(s : MlfeaturesvdSeries) -> MlfeaturesvdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_svd_series_to_string(s : MlfeaturesvdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturesvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturesvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_svd_matrix_identity(n : Int) -> MlfeaturesvdMatrix {
  let m = ml_feature_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_svd_matrix_get(m : MlfeaturesvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_svd_matrix_transpose(m : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_svd_matrix_add(a : MlfeaturesvdMatrix, b : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_svd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_svd_matrix_scale(m : MlfeaturesvdMatrix, s : Double) -> MlfeaturesvdMatrix {
  let result = ml_feature_svd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_svd_matrix_multiply(a : MlfeaturesvdMatrix, b : MlfeaturesvdMatrix) -> MlfeaturesvdMatrix {
  if a.cols != b.rows { return ml_feature_svd_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_svd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_svd_matrix_trace(m : MlfeaturesvdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_svd_matrix_det(m : MlfeaturesvdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_svd_matrix_norm(m : MlfeaturesvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_svd_matrix_to_string(m : MlfeaturesvdMatrix) -> String {
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

pub(all) struct MlfeaturesvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_svd_make_vector(comps : Array[Double]) -> MlfeaturesvdVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_svd_vector_zero(dim : Int) -> MlfeaturesvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_svd_vector_add(a : MlfeaturesvdVector, b : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_svd_vector_sub(a : MlfeaturesvdVector, b : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_svd_vector_scale(v : MlfeaturesvdVector, s : Double) -> MlfeaturesvdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_svd_vector_dot(a : MlfeaturesvdVector, b : MlfeaturesvdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_svd_vector_norm(v : MlfeaturesvdVector) -> Double { @_common.sqrt(ml_feature_svd_vector_dot(v, v)) }

pub fn ml_feature_svd_vector_normalize(v : MlfeaturesvdVector) -> MlfeaturesvdVector {
  let n = ml_feature_svd_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_svd_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_svd_vector_dist(a : MlfeaturesvdVector, b : MlfeaturesvdVector) -> Double {
  ml_feature_svd_vector_norm(ml_feature_svd_vector_sub(a, b))
}

pub fn ml_feature_svd_vector_to_string(v : MlfeaturesvdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_svd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_svd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_svd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_svd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_svd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_svd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_svd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_svd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_svd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_svd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_svd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_svd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_svd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_svd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_svd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_svd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_svd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_svd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_svd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_svd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_svd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_svd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_svd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_svd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_svd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_svd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_svd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_svd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_svd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturesvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_frame_make(size : Int) -> MlfeaturesvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_frame_len(s : MlfeaturesvdFrame) -> Int { s.size }

pub fn ml_feature_svd_frame_get(s : MlfeaturesvdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_frame_set(s : MlfeaturesvdFrame, i : Int, v : Double) -> MlfeaturesvdFrame {
  let result = ml_feature_svd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_frame_sum(s : MlfeaturesvdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_frame_mean(s : MlfeaturesvdFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_frame_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_frame_scale(s : MlfeaturesvdFrame, f : Double) -> MlfeaturesvdFrame {
  let result = ml_feature_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_frame_add(a : MlfeaturesvdFrame, b : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_frame_copy(s : MlfeaturesvdFrame) -> MlfeaturesvdFrame {
  let result = ml_feature_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_frame_fill(s : MlfeaturesvdFrame, v : Double) -> MlfeaturesvdFrame {
  let result = ml_feature_svd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_frame_min(s : MlfeaturesvdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_frame_max(s : MlfeaturesvdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_frame_to_string(s : MlfeaturesvdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_table_make(size : Int) -> MlfeaturesvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_table_len(s : MlfeaturesvdTable) -> Int { s.size }

pub fn ml_feature_svd_table_get(s : MlfeaturesvdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_table_set(s : MlfeaturesvdTable, i : Int, v : Double) -> MlfeaturesvdTable {
  let result = ml_feature_svd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_table_sum(s : MlfeaturesvdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_table_mean(s : MlfeaturesvdTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_table_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_table_scale(s : MlfeaturesvdTable, f : Double) -> MlfeaturesvdTable {
  let result = ml_feature_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_table_add(a : MlfeaturesvdTable, b : MlfeaturesvdTable) -> MlfeaturesvdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_table_copy(s : MlfeaturesvdTable) -> MlfeaturesvdTable {
  let result = ml_feature_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_table_fill(s : MlfeaturesvdTable, v : Double) -> MlfeaturesvdTable {
  let result = ml_feature_svd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_table_min(s : MlfeaturesvdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_table_max(s : MlfeaturesvdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_table_to_string(s : MlfeaturesvdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_graphn_make(size : Int) -> MlfeaturesvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_graphn_len(s : MlfeaturesvdGraphN) -> Int { s.size }

pub fn ml_feature_svd_graphn_get(s : MlfeaturesvdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_graphn_set(s : MlfeaturesvdGraphN, i : Int, v : Double) -> MlfeaturesvdGraphN {
  let result = ml_feature_svd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_graphn_sum(s : MlfeaturesvdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_graphn_mean(s : MlfeaturesvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_graphn_scale(s : MlfeaturesvdGraphN, f : Double) -> MlfeaturesvdGraphN {
  let result = ml_feature_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_graphn_add(a : MlfeaturesvdGraphN, b : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_graphn_copy(s : MlfeaturesvdGraphN) -> MlfeaturesvdGraphN {
  let result = ml_feature_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_graphn_fill(s : MlfeaturesvdGraphN, v : Double) -> MlfeaturesvdGraphN {
  let result = ml_feature_svd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_graphn_min(s : MlfeaturesvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_graphn_max(s : MlfeaturesvdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_graphn_to_string(s : MlfeaturesvdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_node_make(size : Int) -> MlfeaturesvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_node_len(s : MlfeaturesvdNode) -> Int { s.size }

pub fn ml_feature_svd_node_get(s : MlfeaturesvdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_node_set(s : MlfeaturesvdNode, i : Int, v : Double) -> MlfeaturesvdNode {
  let result = ml_feature_svd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_node_sum(s : MlfeaturesvdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_node_mean(s : MlfeaturesvdNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_node_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_node_scale(s : MlfeaturesvdNode, f : Double) -> MlfeaturesvdNode {
  let result = ml_feature_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_node_add(a : MlfeaturesvdNode, b : MlfeaturesvdNode) -> MlfeaturesvdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_node_copy(s : MlfeaturesvdNode) -> MlfeaturesvdNode {
  let result = ml_feature_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_node_fill(s : MlfeaturesvdNode, v : Double) -> MlfeaturesvdNode {
  let result = ml_feature_svd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_node_min(s : MlfeaturesvdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_node_max(s : MlfeaturesvdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_node_to_string(s : MlfeaturesvdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_edge_make(size : Int) -> MlfeaturesvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_edge_len(s : MlfeaturesvdEdge) -> Int { s.size }

pub fn ml_feature_svd_edge_get(s : MlfeaturesvdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_edge_set(s : MlfeaturesvdEdge, i : Int, v : Double) -> MlfeaturesvdEdge {
  let result = ml_feature_svd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_edge_sum(s : MlfeaturesvdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_edge_mean(s : MlfeaturesvdEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_edge_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_edge_scale(s : MlfeaturesvdEdge, f : Double) -> MlfeaturesvdEdge {
  let result = ml_feature_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_edge_add(a : MlfeaturesvdEdge, b : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_edge_copy(s : MlfeaturesvdEdge) -> MlfeaturesvdEdge {
  let result = ml_feature_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_edge_fill(s : MlfeaturesvdEdge, v : Double) -> MlfeaturesvdEdge {
  let result = ml_feature_svd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_edge_min(s : MlfeaturesvdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_edge_max(s : MlfeaturesvdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_edge_to_string(s : MlfeaturesvdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_path_make(size : Int) -> MlfeaturesvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_path_len(s : MlfeaturesvdPath) -> Int { s.size }

pub fn ml_feature_svd_path_get(s : MlfeaturesvdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_path_set(s : MlfeaturesvdPath, i : Int, v : Double) -> MlfeaturesvdPath {
  let result = ml_feature_svd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_path_sum(s : MlfeaturesvdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_path_mean(s : MlfeaturesvdPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_path_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_path_scale(s : MlfeaturesvdPath, f : Double) -> MlfeaturesvdPath {
  let result = ml_feature_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_path_add(a : MlfeaturesvdPath, b : MlfeaturesvdPath) -> MlfeaturesvdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_path_copy(s : MlfeaturesvdPath) -> MlfeaturesvdPath {
  let result = ml_feature_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_path_fill(s : MlfeaturesvdPath, v : Double) -> MlfeaturesvdPath {
  let result = ml_feature_svd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_path_min(s : MlfeaturesvdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_path_max(s : MlfeaturesvdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_path_to_string(s : MlfeaturesvdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cluster_make(size : Int) -> MlfeaturesvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_cluster_len(s : MlfeaturesvdCluster) -> Int { s.size }

pub fn ml_feature_svd_cluster_get(s : MlfeaturesvdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_cluster_set(s : MlfeaturesvdCluster, i : Int, v : Double) -> MlfeaturesvdCluster {
  let result = ml_feature_svd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_cluster_sum(s : MlfeaturesvdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_cluster_mean(s : MlfeaturesvdCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_cluster_scale(s : MlfeaturesvdCluster, f : Double) -> MlfeaturesvdCluster {
  let result = ml_feature_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_cluster_add(a : MlfeaturesvdCluster, b : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_cluster_copy(s : MlfeaturesvdCluster) -> MlfeaturesvdCluster {
  let result = ml_feature_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_cluster_fill(s : MlfeaturesvdCluster, v : Double) -> MlfeaturesvdCluster {
  let result = ml_feature_svd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_cluster_min(s : MlfeaturesvdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_cluster_max(s : MlfeaturesvdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_cluster_to_string(s : MlfeaturesvdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_model_make(size : Int) -> MlfeaturesvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_model_len(s : MlfeaturesvdModel) -> Int { s.size }

pub fn ml_feature_svd_model_get(s : MlfeaturesvdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_model_set(s : MlfeaturesvdModel, i : Int, v : Double) -> MlfeaturesvdModel {
  let result = ml_feature_svd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_model_sum(s : MlfeaturesvdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_model_mean(s : MlfeaturesvdModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_model_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_model_scale(s : MlfeaturesvdModel, f : Double) -> MlfeaturesvdModel {
  let result = ml_feature_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_model_add(a : MlfeaturesvdModel, b : MlfeaturesvdModel) -> MlfeaturesvdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_model_copy(s : MlfeaturesvdModel) -> MlfeaturesvdModel {
  let result = ml_feature_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_model_fill(s : MlfeaturesvdModel, v : Double) -> MlfeaturesvdModel {
  let result = ml_feature_svd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_model_min(s : MlfeaturesvdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_model_max(s : MlfeaturesvdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_model_to_string(s : MlfeaturesvdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_layer_make(size : Int) -> MlfeaturesvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_layer_len(s : MlfeaturesvdLayer) -> Int { s.size }

pub fn ml_feature_svd_layer_get(s : MlfeaturesvdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_layer_set(s : MlfeaturesvdLayer, i : Int, v : Double) -> MlfeaturesvdLayer {
  let result = ml_feature_svd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_layer_sum(s : MlfeaturesvdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_layer_mean(s : MlfeaturesvdLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_layer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_layer_scale(s : MlfeaturesvdLayer, f : Double) -> MlfeaturesvdLayer {
  let result = ml_feature_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_layer_add(a : MlfeaturesvdLayer, b : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_layer_copy(s : MlfeaturesvdLayer) -> MlfeaturesvdLayer {
  let result = ml_feature_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_layer_fill(s : MlfeaturesvdLayer, v : Double) -> MlfeaturesvdLayer {
  let result = ml_feature_svd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_layer_min(s : MlfeaturesvdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_layer_max(s : MlfeaturesvdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_layer_to_string(s : MlfeaturesvdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_buffer_make(size : Int) -> MlfeaturesvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_buffer_len(s : MlfeaturesvdBuffer) -> Int { s.size }

pub fn ml_feature_svd_buffer_get(s : MlfeaturesvdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_buffer_set(s : MlfeaturesvdBuffer, i : Int, v : Double) -> MlfeaturesvdBuffer {
  let result = ml_feature_svd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_buffer_sum(s : MlfeaturesvdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_buffer_mean(s : MlfeaturesvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_buffer_scale(s : MlfeaturesvdBuffer, f : Double) -> MlfeaturesvdBuffer {
  let result = ml_feature_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_buffer_add(a : MlfeaturesvdBuffer, b : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_buffer_copy(s : MlfeaturesvdBuffer) -> MlfeaturesvdBuffer {
  let result = ml_feature_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_buffer_fill(s : MlfeaturesvdBuffer, v : Double) -> MlfeaturesvdBuffer {
  let result = ml_feature_svd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_buffer_min(s : MlfeaturesvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_buffer_max(s : MlfeaturesvdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_buffer_to_string(s : MlfeaturesvdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_cursor_make(size : Int) -> MlfeaturesvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_cursor_len(s : MlfeaturesvdCursor) -> Int { s.size }

pub fn ml_feature_svd_cursor_get(s : MlfeaturesvdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_cursor_set(s : MlfeaturesvdCursor, i : Int, v : Double) -> MlfeaturesvdCursor {
  let result = ml_feature_svd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_cursor_sum(s : MlfeaturesvdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_cursor_mean(s : MlfeaturesvdCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_cursor_scale(s : MlfeaturesvdCursor, f : Double) -> MlfeaturesvdCursor {
  let result = ml_feature_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_cursor_add(a : MlfeaturesvdCursor, b : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_cursor_copy(s : MlfeaturesvdCursor) -> MlfeaturesvdCursor {
  let result = ml_feature_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_cursor_fill(s : MlfeaturesvdCursor, v : Double) -> MlfeaturesvdCursor {
  let result = ml_feature_svd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_cursor_min(s : MlfeaturesvdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_cursor_max(s : MlfeaturesvdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_cursor_to_string(s : MlfeaturesvdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_view_make(size : Int) -> MlfeaturesvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_view_len(s : MlfeaturesvdView) -> Int { s.size }

pub fn ml_feature_svd_view_get(s : MlfeaturesvdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_view_set(s : MlfeaturesvdView, i : Int, v : Double) -> MlfeaturesvdView {
  let result = ml_feature_svd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_view_sum(s : MlfeaturesvdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_view_mean(s : MlfeaturesvdView) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_view_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_view_scale(s : MlfeaturesvdView, f : Double) -> MlfeaturesvdView {
  let result = ml_feature_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_view_add(a : MlfeaturesvdView, b : MlfeaturesvdView) -> MlfeaturesvdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_view_copy(s : MlfeaturesvdView) -> MlfeaturesvdView {
  let result = ml_feature_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_view_fill(s : MlfeaturesvdView, v : Double) -> MlfeaturesvdView {
  let result = ml_feature_svd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_view_min(s : MlfeaturesvdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_view_max(s : MlfeaturesvdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_view_to_string(s : MlfeaturesvdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_range_make(size : Int) -> MlfeaturesvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_range_len(s : MlfeaturesvdRange) -> Int { s.size }

pub fn ml_feature_svd_range_get(s : MlfeaturesvdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_range_set(s : MlfeaturesvdRange, i : Int, v : Double) -> MlfeaturesvdRange {
  let result = ml_feature_svd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_range_sum(s : MlfeaturesvdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_range_mean(s : MlfeaturesvdRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_range_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_range_scale(s : MlfeaturesvdRange, f : Double) -> MlfeaturesvdRange {
  let result = ml_feature_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_range_add(a : MlfeaturesvdRange, b : MlfeaturesvdRange) -> MlfeaturesvdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_range_copy(s : MlfeaturesvdRange) -> MlfeaturesvdRange {
  let result = ml_feature_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_range_fill(s : MlfeaturesvdRange, v : Double) -> MlfeaturesvdRange {
  let result = ml_feature_svd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_range_min(s : MlfeaturesvdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_range_max(s : MlfeaturesvdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_range_to_string(s : MlfeaturesvdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturesvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_svd_slice_make(size : Int) -> MlfeaturesvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_svd_slice_len(s : MlfeaturesvdSlice) -> Int { s.size }

pub fn ml_feature_svd_slice_get(s : MlfeaturesvdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_svd_slice_set(s : MlfeaturesvdSlice, i : Int, v : Double) -> MlfeaturesvdSlice {
  let result = ml_feature_svd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_slice_sum(s : MlfeaturesvdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_svd_slice_mean(s : MlfeaturesvdSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_svd_slice_sum(s) / s.size.to_double() }
}

pub fn ml_feature_svd_slice_scale(s : MlfeaturesvdSlice, f : Double) -> MlfeaturesvdSlice {
  let result = ml_feature_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_svd_slice_add(a : MlfeaturesvdSlice, b : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_svd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_svd_slice_copy(s : MlfeaturesvdSlice) -> MlfeaturesvdSlice {
  let result = ml_feature_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_svd_slice_fill(s : MlfeaturesvdSlice, v : Double) -> MlfeaturesvdSlice {
  let result = ml_feature_svd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_svd_slice_min(s : MlfeaturesvdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_slice_max(s : MlfeaturesvdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_svd_slice_to_string(s : MlfeaturesvdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


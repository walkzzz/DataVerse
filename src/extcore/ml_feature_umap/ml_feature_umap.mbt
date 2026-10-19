///===
/// extcore/ml_feature_umap

pub(all) struct MlfeatureumapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_umap_make_point(x : Double, y : Double) -> MlfeatureumapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_umap_make_point3(x : Double, y : Double, z : Double) -> MlfeatureumapPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_umap_point_x(pt : MlfeatureumapPoint) -> Double { pt.x }

pub fn ml_feature_umap_point_y(pt : MlfeatureumapPoint) -> Double { pt.y }

pub fn ml_feature_umap_point_z(pt : MlfeatureumapPoint) -> Double { pt.z }

pub fn ml_feature_umap_point_label(pt : MlfeatureumapPoint) -> Int { pt.label }

pub fn ml_feature_umap_point_dist(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_umap_point_add(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_umap_point_sub(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_umap_point_scale(pt : MlfeatureumapPoint, s : Double) -> MlfeatureumapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_umap_point_dot(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_umap_point_cross(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_umap_point_norm(pt : MlfeatureumapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_umap_point_normalize(pt : MlfeatureumapPoint) -> MlfeatureumapPoint {
  let n = ml_feature_umap_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_umap_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_umap_point_negate(pt : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_umap_point_mid(a : MlfeatureumapPoint, b : MlfeatureumapPoint) -> MlfeatureumapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_umap_point_lerp(a : MlfeatureumapPoint, b : MlfeatureumapPoint, t : Double) -> MlfeatureumapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_umap_point_to_string(pt : MlfeatureumapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeatureumapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_umap_make_series(vals : Array[Double], name : String) -> MlfeatureumapSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_umap_series_len(s : MlfeatureumapSeries) -> Int { s.vals.length() }

pub fn ml_feature_umap_series_sum(s : MlfeatureumapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_feature_umap_series_mean(s : MlfeatureumapSeries) -> Double {
  let n = ml_feature_umap_series_len(s)
  if n == 0 { 0.0 } else { ml_feature_umap_series_sum(s) / n.to_double() }
}

pub fn ml_feature_umap_series_min(s : MlfeatureumapSeries) -> Double {
  let n = ml_feature_umap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_umap_series_max(s : MlfeatureumapSeries) -> Double {
  let n = ml_feature_umap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_umap_series_range(s : MlfeatureumapSeries) -> Double {
  ml_feature_umap_series_max(s) - ml_feature_umap_series_min(s)
}

pub fn ml_feature_umap_series_var(s : MlfeatureumapSeries) -> Double {
  let n = ml_feature_umap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_feature_umap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_feature_umap_series_std(s : MlfeatureumapSeries) -> Double { @_common.sqrt(ml_feature_umap_series_var(s)) }

pub fn ml_feature_umap_series_median(s : MlfeatureumapSeries) -> Double {
  let n = ml_feature_umap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_umap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_umap_series_scale(s : MlfeatureumapSeries, f : Double) -> MlfeatureumapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_umap_series_add(a : MlfeatureumapSeries, b : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_umap_series_sub(a : MlfeatureumapSeries, b : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_umap_series_normalize(s : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let mn = ml_feature_umap_series_min(s)
  let mx = ml_feature_umap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_umap_series_cumsum(s : MlfeatureumapSeries) -> MlfeatureumapSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_umap_series_to_string(s : MlfeatureumapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureumapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_umap_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureumapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_umap_matrix_identity(n : Int) -> MlfeatureumapMatrix {
  let m = ml_feature_umap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_umap_matrix_get(m : MlfeatureumapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_umap_matrix_transpose(m : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_umap_matrix_add(a : MlfeatureumapMatrix, b : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_umap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_umap_matrix_scale(m : MlfeatureumapMatrix, s : Double) -> MlfeatureumapMatrix {
  let result = ml_feature_umap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_umap_matrix_multiply(a : MlfeatureumapMatrix, b : MlfeatureumapMatrix) -> MlfeatureumapMatrix {
  if a.cols != b.rows { return ml_feature_umap_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_umap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_umap_matrix_trace(m : MlfeatureumapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_umap_matrix_det(m : MlfeatureumapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_umap_matrix_norm(m : MlfeatureumapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_feature_umap_matrix_to_string(m : MlfeatureumapMatrix) -> String {
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

pub(all) struct MlfeatureumapVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_umap_make_vector(comps : Array[Double]) -> MlfeatureumapVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_umap_vector_zero(dim : Int) -> MlfeatureumapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_umap_vector_add(a : MlfeatureumapVector, b : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_umap_vector_sub(a : MlfeatureumapVector, b : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_umap_vector_scale(v : MlfeatureumapVector, s : Double) -> MlfeatureumapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_umap_vector_dot(a : MlfeatureumapVector, b : MlfeatureumapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_umap_vector_norm(v : MlfeatureumapVector) -> Double { @_common.sqrt(ml_feature_umap_vector_dot(v, v)) }

pub fn ml_feature_umap_vector_normalize(v : MlfeatureumapVector) -> MlfeatureumapVector {
  let n = ml_feature_umap_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_umap_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_umap_vector_dist(a : MlfeatureumapVector, b : MlfeatureumapVector) -> Double {
  ml_feature_umap_vector_norm(ml_feature_umap_vector_sub(a, b))
}

pub fn ml_feature_umap_vector_to_string(v : MlfeatureumapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_umap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_umap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_umap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_umap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_umap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_umap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_umap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_umap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_umap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_umap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_umap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_umap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_umap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_umap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_umap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_umap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_umap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_umap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_umap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_umap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_umap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_umap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_umap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_umap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_umap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_umap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_umap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_umap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_umap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureumapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_frame_make(size : Int) -> MlfeatureumapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_frame_len(s : MlfeatureumapFrame) -> Int { s.size }

pub fn ml_feature_umap_frame_get(s : MlfeatureumapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_frame_set(s : MlfeatureumapFrame, i : Int, v : Double) -> MlfeatureumapFrame {
  let result = ml_feature_umap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_frame_sum(s : MlfeatureumapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_frame_mean(s : MlfeatureumapFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_frame_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_frame_scale(s : MlfeatureumapFrame, f : Double) -> MlfeatureumapFrame {
  let result = ml_feature_umap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_frame_add(a : MlfeatureumapFrame, b : MlfeatureumapFrame) -> MlfeatureumapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_frame_copy(s : MlfeatureumapFrame) -> MlfeatureumapFrame {
  let result = ml_feature_umap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_frame_fill(s : MlfeatureumapFrame, v : Double) -> MlfeatureumapFrame {
  let result = ml_feature_umap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_frame_min(s : MlfeatureumapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_frame_max(s : MlfeatureumapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_frame_to_string(s : MlfeatureumapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_table_make(size : Int) -> MlfeatureumapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_table_len(s : MlfeatureumapTable) -> Int { s.size }

pub fn ml_feature_umap_table_get(s : MlfeatureumapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_table_set(s : MlfeatureumapTable, i : Int, v : Double) -> MlfeatureumapTable {
  let result = ml_feature_umap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_table_sum(s : MlfeatureumapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_table_mean(s : MlfeatureumapTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_table_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_table_scale(s : MlfeatureumapTable, f : Double) -> MlfeatureumapTable {
  let result = ml_feature_umap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_table_add(a : MlfeatureumapTable, b : MlfeatureumapTable) -> MlfeatureumapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_table_copy(s : MlfeatureumapTable) -> MlfeatureumapTable {
  let result = ml_feature_umap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_table_fill(s : MlfeatureumapTable, v : Double) -> MlfeatureumapTable {
  let result = ml_feature_umap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_table_min(s : MlfeatureumapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_table_max(s : MlfeatureumapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_table_to_string(s : MlfeatureumapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_graphn_make(size : Int) -> MlfeatureumapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_graphn_len(s : MlfeatureumapGraphN) -> Int { s.size }

pub fn ml_feature_umap_graphn_get(s : MlfeatureumapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_graphn_set(s : MlfeatureumapGraphN, i : Int, v : Double) -> MlfeatureumapGraphN {
  let result = ml_feature_umap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_graphn_sum(s : MlfeatureumapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_graphn_mean(s : MlfeatureumapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_graphn_scale(s : MlfeatureumapGraphN, f : Double) -> MlfeatureumapGraphN {
  let result = ml_feature_umap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_graphn_add(a : MlfeatureumapGraphN, b : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_graphn_copy(s : MlfeatureumapGraphN) -> MlfeatureumapGraphN {
  let result = ml_feature_umap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_graphn_fill(s : MlfeatureumapGraphN, v : Double) -> MlfeatureumapGraphN {
  let result = ml_feature_umap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_graphn_min(s : MlfeatureumapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_graphn_max(s : MlfeatureumapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_graphn_to_string(s : MlfeatureumapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_node_make(size : Int) -> MlfeatureumapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_node_len(s : MlfeatureumapNode) -> Int { s.size }

pub fn ml_feature_umap_node_get(s : MlfeatureumapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_node_set(s : MlfeatureumapNode, i : Int, v : Double) -> MlfeatureumapNode {
  let result = ml_feature_umap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_node_sum(s : MlfeatureumapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_node_mean(s : MlfeatureumapNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_node_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_node_scale(s : MlfeatureumapNode, f : Double) -> MlfeatureumapNode {
  let result = ml_feature_umap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_node_add(a : MlfeatureumapNode, b : MlfeatureumapNode) -> MlfeatureumapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_node_copy(s : MlfeatureumapNode) -> MlfeatureumapNode {
  let result = ml_feature_umap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_node_fill(s : MlfeatureumapNode, v : Double) -> MlfeatureumapNode {
  let result = ml_feature_umap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_node_min(s : MlfeatureumapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_node_max(s : MlfeatureumapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_node_to_string(s : MlfeatureumapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_edge_make(size : Int) -> MlfeatureumapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_edge_len(s : MlfeatureumapEdge) -> Int { s.size }

pub fn ml_feature_umap_edge_get(s : MlfeatureumapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_edge_set(s : MlfeatureumapEdge, i : Int, v : Double) -> MlfeatureumapEdge {
  let result = ml_feature_umap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_edge_sum(s : MlfeatureumapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_edge_mean(s : MlfeatureumapEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_edge_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_edge_scale(s : MlfeatureumapEdge, f : Double) -> MlfeatureumapEdge {
  let result = ml_feature_umap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_edge_add(a : MlfeatureumapEdge, b : MlfeatureumapEdge) -> MlfeatureumapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_edge_copy(s : MlfeatureumapEdge) -> MlfeatureumapEdge {
  let result = ml_feature_umap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_edge_fill(s : MlfeatureumapEdge, v : Double) -> MlfeatureumapEdge {
  let result = ml_feature_umap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_edge_min(s : MlfeatureumapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_edge_max(s : MlfeatureumapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_edge_to_string(s : MlfeatureumapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_path_make(size : Int) -> MlfeatureumapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_path_len(s : MlfeatureumapPath) -> Int { s.size }

pub fn ml_feature_umap_path_get(s : MlfeatureumapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_path_set(s : MlfeatureumapPath, i : Int, v : Double) -> MlfeatureumapPath {
  let result = ml_feature_umap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_path_sum(s : MlfeatureumapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_path_mean(s : MlfeatureumapPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_path_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_path_scale(s : MlfeatureumapPath, f : Double) -> MlfeatureumapPath {
  let result = ml_feature_umap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_path_add(a : MlfeatureumapPath, b : MlfeatureumapPath) -> MlfeatureumapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_path_copy(s : MlfeatureumapPath) -> MlfeatureumapPath {
  let result = ml_feature_umap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_path_fill(s : MlfeatureumapPath, v : Double) -> MlfeatureumapPath {
  let result = ml_feature_umap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_path_min(s : MlfeatureumapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_path_max(s : MlfeatureumapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_path_to_string(s : MlfeatureumapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cluster_make(size : Int) -> MlfeatureumapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_cluster_len(s : MlfeatureumapCluster) -> Int { s.size }

pub fn ml_feature_umap_cluster_get(s : MlfeatureumapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_cluster_set(s : MlfeatureumapCluster, i : Int, v : Double) -> MlfeatureumapCluster {
  let result = ml_feature_umap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_cluster_sum(s : MlfeatureumapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_cluster_mean(s : MlfeatureumapCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_cluster_scale(s : MlfeatureumapCluster, f : Double) -> MlfeatureumapCluster {
  let result = ml_feature_umap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_cluster_add(a : MlfeatureumapCluster, b : MlfeatureumapCluster) -> MlfeatureumapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_cluster_copy(s : MlfeatureumapCluster) -> MlfeatureumapCluster {
  let result = ml_feature_umap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_cluster_fill(s : MlfeatureumapCluster, v : Double) -> MlfeatureumapCluster {
  let result = ml_feature_umap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_cluster_min(s : MlfeatureumapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_cluster_max(s : MlfeatureumapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_cluster_to_string(s : MlfeatureumapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_model_make(size : Int) -> MlfeatureumapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_model_len(s : MlfeatureumapModel) -> Int { s.size }

pub fn ml_feature_umap_model_get(s : MlfeatureumapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_model_set(s : MlfeatureumapModel, i : Int, v : Double) -> MlfeatureumapModel {
  let result = ml_feature_umap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_model_sum(s : MlfeatureumapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_model_mean(s : MlfeatureumapModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_model_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_model_scale(s : MlfeatureumapModel, f : Double) -> MlfeatureumapModel {
  let result = ml_feature_umap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_model_add(a : MlfeatureumapModel, b : MlfeatureumapModel) -> MlfeatureumapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_model_copy(s : MlfeatureumapModel) -> MlfeatureumapModel {
  let result = ml_feature_umap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_model_fill(s : MlfeatureumapModel, v : Double) -> MlfeatureumapModel {
  let result = ml_feature_umap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_model_min(s : MlfeatureumapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_model_max(s : MlfeatureumapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_model_to_string(s : MlfeatureumapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_layer_make(size : Int) -> MlfeatureumapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_layer_len(s : MlfeatureumapLayer) -> Int { s.size }

pub fn ml_feature_umap_layer_get(s : MlfeatureumapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_layer_set(s : MlfeatureumapLayer, i : Int, v : Double) -> MlfeatureumapLayer {
  let result = ml_feature_umap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_layer_sum(s : MlfeatureumapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_layer_mean(s : MlfeatureumapLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_layer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_layer_scale(s : MlfeatureumapLayer, f : Double) -> MlfeatureumapLayer {
  let result = ml_feature_umap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_layer_add(a : MlfeatureumapLayer, b : MlfeatureumapLayer) -> MlfeatureumapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_layer_copy(s : MlfeatureumapLayer) -> MlfeatureumapLayer {
  let result = ml_feature_umap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_layer_fill(s : MlfeatureumapLayer, v : Double) -> MlfeatureumapLayer {
  let result = ml_feature_umap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_layer_min(s : MlfeatureumapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_layer_max(s : MlfeatureumapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_layer_to_string(s : MlfeatureumapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_buffer_make(size : Int) -> MlfeatureumapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_buffer_len(s : MlfeatureumapBuffer) -> Int { s.size }

pub fn ml_feature_umap_buffer_get(s : MlfeatureumapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_buffer_set(s : MlfeatureumapBuffer, i : Int, v : Double) -> MlfeatureumapBuffer {
  let result = ml_feature_umap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_buffer_sum(s : MlfeatureumapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_buffer_mean(s : MlfeatureumapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_buffer_scale(s : MlfeatureumapBuffer, f : Double) -> MlfeatureumapBuffer {
  let result = ml_feature_umap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_buffer_add(a : MlfeatureumapBuffer, b : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_buffer_copy(s : MlfeatureumapBuffer) -> MlfeatureumapBuffer {
  let result = ml_feature_umap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_buffer_fill(s : MlfeatureumapBuffer, v : Double) -> MlfeatureumapBuffer {
  let result = ml_feature_umap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_buffer_min(s : MlfeatureumapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_buffer_max(s : MlfeatureumapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_buffer_to_string(s : MlfeatureumapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_cursor_make(size : Int) -> MlfeatureumapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_cursor_len(s : MlfeatureumapCursor) -> Int { s.size }

pub fn ml_feature_umap_cursor_get(s : MlfeatureumapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_cursor_set(s : MlfeatureumapCursor, i : Int, v : Double) -> MlfeatureumapCursor {
  let result = ml_feature_umap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_cursor_sum(s : MlfeatureumapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_cursor_mean(s : MlfeatureumapCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_cursor_scale(s : MlfeatureumapCursor, f : Double) -> MlfeatureumapCursor {
  let result = ml_feature_umap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_cursor_add(a : MlfeatureumapCursor, b : MlfeatureumapCursor) -> MlfeatureumapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_cursor_copy(s : MlfeatureumapCursor) -> MlfeatureumapCursor {
  let result = ml_feature_umap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_cursor_fill(s : MlfeatureumapCursor, v : Double) -> MlfeatureumapCursor {
  let result = ml_feature_umap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_cursor_min(s : MlfeatureumapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_cursor_max(s : MlfeatureumapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_cursor_to_string(s : MlfeatureumapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_view_make(size : Int) -> MlfeatureumapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_view_len(s : MlfeatureumapView) -> Int { s.size }

pub fn ml_feature_umap_view_get(s : MlfeatureumapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_view_set(s : MlfeatureumapView, i : Int, v : Double) -> MlfeatureumapView {
  let result = ml_feature_umap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_view_sum(s : MlfeatureumapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_view_mean(s : MlfeatureumapView) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_view_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_view_scale(s : MlfeatureumapView, f : Double) -> MlfeatureumapView {
  let result = ml_feature_umap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_view_add(a : MlfeatureumapView, b : MlfeatureumapView) -> MlfeatureumapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_view_copy(s : MlfeatureumapView) -> MlfeatureumapView {
  let result = ml_feature_umap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_view_fill(s : MlfeatureumapView, v : Double) -> MlfeatureumapView {
  let result = ml_feature_umap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_view_min(s : MlfeatureumapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_view_max(s : MlfeatureumapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_view_to_string(s : MlfeatureumapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_range_make(size : Int) -> MlfeatureumapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_range_len(s : MlfeatureumapRange) -> Int { s.size }

pub fn ml_feature_umap_range_get(s : MlfeatureumapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_range_set(s : MlfeatureumapRange, i : Int, v : Double) -> MlfeatureumapRange {
  let result = ml_feature_umap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_range_sum(s : MlfeatureumapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_range_mean(s : MlfeatureumapRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_range_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_range_scale(s : MlfeatureumapRange, f : Double) -> MlfeatureumapRange {
  let result = ml_feature_umap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_range_add(a : MlfeatureumapRange, b : MlfeatureumapRange) -> MlfeatureumapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_range_copy(s : MlfeatureumapRange) -> MlfeatureumapRange {
  let result = ml_feature_umap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_range_fill(s : MlfeatureumapRange, v : Double) -> MlfeatureumapRange {
  let result = ml_feature_umap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_range_min(s : MlfeatureumapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_range_max(s : MlfeatureumapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_range_to_string(s : MlfeatureumapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureumapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_umap_slice_make(size : Int) -> MlfeatureumapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_umap_slice_len(s : MlfeatureumapSlice) -> Int { s.size }

pub fn ml_feature_umap_slice_get(s : MlfeatureumapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_umap_slice_set(s : MlfeatureumapSlice, i : Int, v : Double) -> MlfeatureumapSlice {
  let result = ml_feature_umap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_slice_sum(s : MlfeatureumapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_umap_slice_mean(s : MlfeatureumapSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_umap_slice_sum(s) / s.size.to_double() }
}

pub fn ml_feature_umap_slice_scale(s : MlfeatureumapSlice, f : Double) -> MlfeatureumapSlice {
  let result = ml_feature_umap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_umap_slice_add(a : MlfeatureumapSlice, b : MlfeatureumapSlice) -> MlfeatureumapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_umap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_umap_slice_copy(s : MlfeatureumapSlice) -> MlfeatureumapSlice {
  let result = ml_feature_umap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_umap_slice_fill(s : MlfeatureumapSlice, v : Double) -> MlfeatureumapSlice {
  let result = ml_feature_umap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_umap_slice_min(s : MlfeatureumapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_slice_max(s : MlfeatureumapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_umap_slice_to_string(s : MlfeatureumapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


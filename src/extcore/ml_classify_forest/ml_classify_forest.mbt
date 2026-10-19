///===
/// extcore/ml_classify_forest

pub(all) struct MlclassifyforestPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_forest_make_point(x : Double, y : Double) -> MlclassifyforestPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_forest_make_point3(x : Double, y : Double, z : Double) -> MlclassifyforestPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_forest_point_x(pt : MlclassifyforestPoint) -> Double { pt.x }

pub fn ml_classify_forest_point_y(pt : MlclassifyforestPoint) -> Double { pt.y }

pub fn ml_classify_forest_point_z(pt : MlclassifyforestPoint) -> Double { pt.z }

pub fn ml_classify_forest_point_label(pt : MlclassifyforestPoint) -> Int { pt.label }

pub fn ml_classify_forest_point_dist(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_forest_point_add(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_forest_point_sub(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_forest_point_scale(pt : MlclassifyforestPoint, s : Double) -> MlclassifyforestPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_forest_point_dot(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_forest_point_cross(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_forest_point_norm(pt : MlclassifyforestPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_forest_point_normalize(pt : MlclassifyforestPoint) -> MlclassifyforestPoint {
  let n = ml_classify_forest_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_forest_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_forest_point_negate(pt : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_forest_point_mid(a : MlclassifyforestPoint, b : MlclassifyforestPoint) -> MlclassifyforestPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_forest_point_lerp(a : MlclassifyforestPoint, b : MlclassifyforestPoint, t : Double) -> MlclassifyforestPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_forest_point_to_string(pt : MlclassifyforestPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyforestSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_forest_make_series(vals : Array[Double], name : String) -> MlclassifyforestSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_forest_series_len(s : MlclassifyforestSeries) -> Int { s.vals.length() }

pub fn ml_classify_forest_series_sum(s : MlclassifyforestSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_forest_series_mean(s : MlclassifyforestSeries) -> Double {
  let n = ml_classify_forest_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_forest_series_sum(s) / n.to_double() }
}

pub fn ml_classify_forest_series_min(s : MlclassifyforestSeries) -> Double {
  let n = ml_classify_forest_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_forest_series_max(s : MlclassifyforestSeries) -> Double {
  let n = ml_classify_forest_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_forest_series_range(s : MlclassifyforestSeries) -> Double {
  ml_classify_forest_series_max(s) - ml_classify_forest_series_min(s)
}

pub fn ml_classify_forest_series_var(s : MlclassifyforestSeries) -> Double {
  let n = ml_classify_forest_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_forest_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_forest_series_std(s : MlclassifyforestSeries) -> Double { @_common.sqrt(ml_classify_forest_series_var(s)) }

pub fn ml_classify_forest_series_median(s : MlclassifyforestSeries) -> Double {
  let n = ml_classify_forest_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_forest_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_forest_series_scale(s : MlclassifyforestSeries, f : Double) -> MlclassifyforestSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_forest_series_add(a : MlclassifyforestSeries, b : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_forest_series_sub(a : MlclassifyforestSeries, b : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_forest_series_normalize(s : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let mn = ml_classify_forest_series_min(s)
  let mx = ml_classify_forest_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_forest_series_cumsum(s : MlclassifyforestSeries) -> MlclassifyforestSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_forest_series_to_string(s : MlclassifyforestSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyforestMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_forest_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyforestMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_forest_matrix_identity(n : Int) -> MlclassifyforestMatrix {
  let m = ml_classify_forest_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_forest_matrix_get(m : MlclassifyforestMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_forest_matrix_transpose(m : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_forest_matrix_add(a : MlclassifyforestMatrix, b : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_forest_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_forest_matrix_scale(m : MlclassifyforestMatrix, s : Double) -> MlclassifyforestMatrix {
  let result = ml_classify_forest_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_forest_matrix_multiply(a : MlclassifyforestMatrix, b : MlclassifyforestMatrix) -> MlclassifyforestMatrix {
  if a.cols != b.rows { return ml_classify_forest_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_forest_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_forest_matrix_trace(m : MlclassifyforestMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_forest_matrix_det(m : MlclassifyforestMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_forest_matrix_norm(m : MlclassifyforestMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_forest_matrix_to_string(m : MlclassifyforestMatrix) -> String {
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

pub(all) struct MlclassifyforestVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_forest_make_vector(comps : Array[Double]) -> MlclassifyforestVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_forest_vector_zero(dim : Int) -> MlclassifyforestVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_forest_vector_add(a : MlclassifyforestVector, b : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_forest_vector_sub(a : MlclassifyforestVector, b : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_forest_vector_scale(v : MlclassifyforestVector, s : Double) -> MlclassifyforestVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_forest_vector_dot(a : MlclassifyforestVector, b : MlclassifyforestVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_forest_vector_norm(v : MlclassifyforestVector) -> Double { @_common.sqrt(ml_classify_forest_vector_dot(v, v)) }

pub fn ml_classify_forest_vector_normalize(v : MlclassifyforestVector) -> MlclassifyforestVector {
  let n = ml_classify_forest_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_forest_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_forest_vector_dist(a : MlclassifyforestVector, b : MlclassifyforestVector) -> Double {
  ml_classify_forest_vector_norm(ml_classify_forest_vector_sub(a, b))
}

pub fn ml_classify_forest_vector_to_string(v : MlclassifyforestVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_forest_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_forest_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_forest_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_forest_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_forest_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_forest_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_forest_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_forest_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_forest_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_forest_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_forest_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_forest_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_forest_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_forest_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_forest_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_forest_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_forest_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_forest_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_forest_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_forest_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_forest_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_forest_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_forest_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_forest_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_forest_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_forest_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_forest_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_forest_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_forest_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyforestFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_frame_make(size : Int) -> MlclassifyforestFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_frame_len(s : MlclassifyforestFrame) -> Int { s.size }

pub fn ml_classify_forest_frame_get(s : MlclassifyforestFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_frame_set(s : MlclassifyforestFrame, i : Int, v : Double) -> MlclassifyforestFrame {
  let result = ml_classify_forest_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_frame_sum(s : MlclassifyforestFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_frame_mean(s : MlclassifyforestFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_frame_scale(s : MlclassifyforestFrame, f : Double) -> MlclassifyforestFrame {
  let result = ml_classify_forest_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_frame_add(a : MlclassifyforestFrame, b : MlclassifyforestFrame) -> MlclassifyforestFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_frame_copy(s : MlclassifyforestFrame) -> MlclassifyforestFrame {
  let result = ml_classify_forest_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_frame_fill(s : MlclassifyforestFrame, v : Double) -> MlclassifyforestFrame {
  let result = ml_classify_forest_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_frame_min(s : MlclassifyforestFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_frame_max(s : MlclassifyforestFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_frame_to_string(s : MlclassifyforestFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_table_make(size : Int) -> MlclassifyforestTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_table_len(s : MlclassifyforestTable) -> Int { s.size }

pub fn ml_classify_forest_table_get(s : MlclassifyforestTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_table_set(s : MlclassifyforestTable, i : Int, v : Double) -> MlclassifyforestTable {
  let result = ml_classify_forest_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_table_sum(s : MlclassifyforestTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_table_mean(s : MlclassifyforestTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_table_scale(s : MlclassifyforestTable, f : Double) -> MlclassifyforestTable {
  let result = ml_classify_forest_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_table_add(a : MlclassifyforestTable, b : MlclassifyforestTable) -> MlclassifyforestTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_table_copy(s : MlclassifyforestTable) -> MlclassifyforestTable {
  let result = ml_classify_forest_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_table_fill(s : MlclassifyforestTable, v : Double) -> MlclassifyforestTable {
  let result = ml_classify_forest_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_table_min(s : MlclassifyforestTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_table_max(s : MlclassifyforestTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_table_to_string(s : MlclassifyforestTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_graphn_make(size : Int) -> MlclassifyforestGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_graphn_len(s : MlclassifyforestGraphN) -> Int { s.size }

pub fn ml_classify_forest_graphn_get(s : MlclassifyforestGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_graphn_set(s : MlclassifyforestGraphN, i : Int, v : Double) -> MlclassifyforestGraphN {
  let result = ml_classify_forest_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_graphn_sum(s : MlclassifyforestGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_graphn_mean(s : MlclassifyforestGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_graphn_scale(s : MlclassifyforestGraphN, f : Double) -> MlclassifyforestGraphN {
  let result = ml_classify_forest_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_graphn_add(a : MlclassifyforestGraphN, b : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_graphn_copy(s : MlclassifyforestGraphN) -> MlclassifyforestGraphN {
  let result = ml_classify_forest_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_graphn_fill(s : MlclassifyforestGraphN, v : Double) -> MlclassifyforestGraphN {
  let result = ml_classify_forest_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_graphn_min(s : MlclassifyforestGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_graphn_max(s : MlclassifyforestGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_graphn_to_string(s : MlclassifyforestGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_node_make(size : Int) -> MlclassifyforestNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_node_len(s : MlclassifyforestNode) -> Int { s.size }

pub fn ml_classify_forest_node_get(s : MlclassifyforestNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_node_set(s : MlclassifyforestNode, i : Int, v : Double) -> MlclassifyforestNode {
  let result = ml_classify_forest_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_node_sum(s : MlclassifyforestNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_node_mean(s : MlclassifyforestNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_node_scale(s : MlclassifyforestNode, f : Double) -> MlclassifyforestNode {
  let result = ml_classify_forest_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_node_add(a : MlclassifyforestNode, b : MlclassifyforestNode) -> MlclassifyforestNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_node_copy(s : MlclassifyforestNode) -> MlclassifyforestNode {
  let result = ml_classify_forest_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_node_fill(s : MlclassifyforestNode, v : Double) -> MlclassifyforestNode {
  let result = ml_classify_forest_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_node_min(s : MlclassifyforestNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_node_max(s : MlclassifyforestNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_node_to_string(s : MlclassifyforestNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_edge_make(size : Int) -> MlclassifyforestEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_edge_len(s : MlclassifyforestEdge) -> Int { s.size }

pub fn ml_classify_forest_edge_get(s : MlclassifyforestEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_edge_set(s : MlclassifyforestEdge, i : Int, v : Double) -> MlclassifyforestEdge {
  let result = ml_classify_forest_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_edge_sum(s : MlclassifyforestEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_edge_mean(s : MlclassifyforestEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_edge_scale(s : MlclassifyforestEdge, f : Double) -> MlclassifyforestEdge {
  let result = ml_classify_forest_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_edge_add(a : MlclassifyforestEdge, b : MlclassifyforestEdge) -> MlclassifyforestEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_edge_copy(s : MlclassifyforestEdge) -> MlclassifyforestEdge {
  let result = ml_classify_forest_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_edge_fill(s : MlclassifyforestEdge, v : Double) -> MlclassifyforestEdge {
  let result = ml_classify_forest_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_edge_min(s : MlclassifyforestEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_edge_max(s : MlclassifyforestEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_edge_to_string(s : MlclassifyforestEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_path_make(size : Int) -> MlclassifyforestPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_path_len(s : MlclassifyforestPath) -> Int { s.size }

pub fn ml_classify_forest_path_get(s : MlclassifyforestPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_path_set(s : MlclassifyforestPath, i : Int, v : Double) -> MlclassifyforestPath {
  let result = ml_classify_forest_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_path_sum(s : MlclassifyforestPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_path_mean(s : MlclassifyforestPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_path_scale(s : MlclassifyforestPath, f : Double) -> MlclassifyforestPath {
  let result = ml_classify_forest_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_path_add(a : MlclassifyforestPath, b : MlclassifyforestPath) -> MlclassifyforestPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_path_copy(s : MlclassifyforestPath) -> MlclassifyforestPath {
  let result = ml_classify_forest_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_path_fill(s : MlclassifyforestPath, v : Double) -> MlclassifyforestPath {
  let result = ml_classify_forest_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_path_min(s : MlclassifyforestPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_path_max(s : MlclassifyforestPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_path_to_string(s : MlclassifyforestPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cluster_make(size : Int) -> MlclassifyforestCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_cluster_len(s : MlclassifyforestCluster) -> Int { s.size }

pub fn ml_classify_forest_cluster_get(s : MlclassifyforestCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_cluster_set(s : MlclassifyforestCluster, i : Int, v : Double) -> MlclassifyforestCluster {
  let result = ml_classify_forest_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_cluster_sum(s : MlclassifyforestCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_cluster_mean(s : MlclassifyforestCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_cluster_scale(s : MlclassifyforestCluster, f : Double) -> MlclassifyforestCluster {
  let result = ml_classify_forest_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_cluster_add(a : MlclassifyforestCluster, b : MlclassifyforestCluster) -> MlclassifyforestCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_cluster_copy(s : MlclassifyforestCluster) -> MlclassifyforestCluster {
  let result = ml_classify_forest_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_cluster_fill(s : MlclassifyforestCluster, v : Double) -> MlclassifyforestCluster {
  let result = ml_classify_forest_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_cluster_min(s : MlclassifyforestCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_cluster_max(s : MlclassifyforestCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_cluster_to_string(s : MlclassifyforestCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_model_make(size : Int) -> MlclassifyforestModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_model_len(s : MlclassifyforestModel) -> Int { s.size }

pub fn ml_classify_forest_model_get(s : MlclassifyforestModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_model_set(s : MlclassifyforestModel, i : Int, v : Double) -> MlclassifyforestModel {
  let result = ml_classify_forest_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_model_sum(s : MlclassifyforestModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_model_mean(s : MlclassifyforestModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_model_scale(s : MlclassifyforestModel, f : Double) -> MlclassifyforestModel {
  let result = ml_classify_forest_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_model_add(a : MlclassifyforestModel, b : MlclassifyforestModel) -> MlclassifyforestModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_model_copy(s : MlclassifyforestModel) -> MlclassifyforestModel {
  let result = ml_classify_forest_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_model_fill(s : MlclassifyforestModel, v : Double) -> MlclassifyforestModel {
  let result = ml_classify_forest_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_model_min(s : MlclassifyforestModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_model_max(s : MlclassifyforestModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_model_to_string(s : MlclassifyforestModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_layer_make(size : Int) -> MlclassifyforestLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_layer_len(s : MlclassifyforestLayer) -> Int { s.size }

pub fn ml_classify_forest_layer_get(s : MlclassifyforestLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_layer_set(s : MlclassifyforestLayer, i : Int, v : Double) -> MlclassifyforestLayer {
  let result = ml_classify_forest_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_layer_sum(s : MlclassifyforestLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_layer_mean(s : MlclassifyforestLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_layer_scale(s : MlclassifyforestLayer, f : Double) -> MlclassifyforestLayer {
  let result = ml_classify_forest_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_layer_add(a : MlclassifyforestLayer, b : MlclassifyforestLayer) -> MlclassifyforestLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_layer_copy(s : MlclassifyforestLayer) -> MlclassifyforestLayer {
  let result = ml_classify_forest_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_layer_fill(s : MlclassifyforestLayer, v : Double) -> MlclassifyforestLayer {
  let result = ml_classify_forest_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_layer_min(s : MlclassifyforestLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_layer_max(s : MlclassifyforestLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_layer_to_string(s : MlclassifyforestLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_buffer_make(size : Int) -> MlclassifyforestBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_buffer_len(s : MlclassifyforestBuffer) -> Int { s.size }

pub fn ml_classify_forest_buffer_get(s : MlclassifyforestBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_buffer_set(s : MlclassifyforestBuffer, i : Int, v : Double) -> MlclassifyforestBuffer {
  let result = ml_classify_forest_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_buffer_sum(s : MlclassifyforestBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_buffer_mean(s : MlclassifyforestBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_buffer_scale(s : MlclassifyforestBuffer, f : Double) -> MlclassifyforestBuffer {
  let result = ml_classify_forest_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_buffer_add(a : MlclassifyforestBuffer, b : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_buffer_copy(s : MlclassifyforestBuffer) -> MlclassifyforestBuffer {
  let result = ml_classify_forest_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_buffer_fill(s : MlclassifyforestBuffer, v : Double) -> MlclassifyforestBuffer {
  let result = ml_classify_forest_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_buffer_min(s : MlclassifyforestBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_buffer_max(s : MlclassifyforestBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_buffer_to_string(s : MlclassifyforestBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_cursor_make(size : Int) -> MlclassifyforestCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_cursor_len(s : MlclassifyforestCursor) -> Int { s.size }

pub fn ml_classify_forest_cursor_get(s : MlclassifyforestCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_cursor_set(s : MlclassifyforestCursor, i : Int, v : Double) -> MlclassifyforestCursor {
  let result = ml_classify_forest_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_cursor_sum(s : MlclassifyforestCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_cursor_mean(s : MlclassifyforestCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_cursor_scale(s : MlclassifyforestCursor, f : Double) -> MlclassifyforestCursor {
  let result = ml_classify_forest_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_cursor_add(a : MlclassifyforestCursor, b : MlclassifyforestCursor) -> MlclassifyforestCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_cursor_copy(s : MlclassifyforestCursor) -> MlclassifyforestCursor {
  let result = ml_classify_forest_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_cursor_fill(s : MlclassifyforestCursor, v : Double) -> MlclassifyforestCursor {
  let result = ml_classify_forest_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_cursor_min(s : MlclassifyforestCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_cursor_max(s : MlclassifyforestCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_cursor_to_string(s : MlclassifyforestCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_view_make(size : Int) -> MlclassifyforestView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_view_len(s : MlclassifyforestView) -> Int { s.size }

pub fn ml_classify_forest_view_get(s : MlclassifyforestView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_view_set(s : MlclassifyforestView, i : Int, v : Double) -> MlclassifyforestView {
  let result = ml_classify_forest_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_view_sum(s : MlclassifyforestView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_view_mean(s : MlclassifyforestView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_view_scale(s : MlclassifyforestView, f : Double) -> MlclassifyforestView {
  let result = ml_classify_forest_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_view_add(a : MlclassifyforestView, b : MlclassifyforestView) -> MlclassifyforestView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_view_copy(s : MlclassifyforestView) -> MlclassifyforestView {
  let result = ml_classify_forest_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_view_fill(s : MlclassifyforestView, v : Double) -> MlclassifyforestView {
  let result = ml_classify_forest_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_view_min(s : MlclassifyforestView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_view_max(s : MlclassifyforestView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_view_to_string(s : MlclassifyforestView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_range_make(size : Int) -> MlclassifyforestRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_range_len(s : MlclassifyforestRange) -> Int { s.size }

pub fn ml_classify_forest_range_get(s : MlclassifyforestRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_range_set(s : MlclassifyforestRange, i : Int, v : Double) -> MlclassifyforestRange {
  let result = ml_classify_forest_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_range_sum(s : MlclassifyforestRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_range_mean(s : MlclassifyforestRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_range_scale(s : MlclassifyforestRange, f : Double) -> MlclassifyforestRange {
  let result = ml_classify_forest_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_range_add(a : MlclassifyforestRange, b : MlclassifyforestRange) -> MlclassifyforestRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_range_copy(s : MlclassifyforestRange) -> MlclassifyforestRange {
  let result = ml_classify_forest_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_range_fill(s : MlclassifyforestRange, v : Double) -> MlclassifyforestRange {
  let result = ml_classify_forest_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_range_min(s : MlclassifyforestRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_range_max(s : MlclassifyforestRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_range_to_string(s : MlclassifyforestRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyforestSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_forest_slice_make(size : Int) -> MlclassifyforestSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_forest_slice_len(s : MlclassifyforestSlice) -> Int { s.size }

pub fn ml_classify_forest_slice_get(s : MlclassifyforestSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_forest_slice_set(s : MlclassifyforestSlice, i : Int, v : Double) -> MlclassifyforestSlice {
  let result = ml_classify_forest_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_slice_sum(s : MlclassifyforestSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_forest_slice_mean(s : MlclassifyforestSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_forest_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_forest_slice_scale(s : MlclassifyforestSlice, f : Double) -> MlclassifyforestSlice {
  let result = ml_classify_forest_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_forest_slice_add(a : MlclassifyforestSlice, b : MlclassifyforestSlice) -> MlclassifyforestSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_forest_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_forest_slice_copy(s : MlclassifyforestSlice) -> MlclassifyforestSlice {
  let result = ml_classify_forest_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_forest_slice_fill(s : MlclassifyforestSlice, v : Double) -> MlclassifyforestSlice {
  let result = ml_classify_forest_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_forest_slice_min(s : MlclassifyforestSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_slice_max(s : MlclassifyforestSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_forest_slice_to_string(s : MlclassifyforestSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


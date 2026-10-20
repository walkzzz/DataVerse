///===
/// extcore/ml_metric_classify

pub(all) struct MlmetricclassifyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_classify_make_point(x : Double, y : Double) -> MlmetricclassifyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_classify_make_point3(x : Double, y : Double, z : Double) -> MlmetricclassifyPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_classify_point_x(pt : MlmetricclassifyPoint) -> Double { pt.x }

pub fn ml_metric_classify_point_y(pt : MlmetricclassifyPoint) -> Double { pt.y }

pub fn ml_metric_classify_point_z(pt : MlmetricclassifyPoint) -> Double { pt.z }

pub fn ml_metric_classify_point_label(pt : MlmetricclassifyPoint) -> Int { pt.label }

pub fn ml_metric_classify_point_dist(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_classify_point_add(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_classify_point_sub(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_classify_point_scale(pt : MlmetricclassifyPoint, s : Double) -> MlmetricclassifyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_classify_point_dot(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_classify_point_cross(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_classify_point_norm(pt : MlmetricclassifyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_classify_point_normalize(pt : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  let n = ml_metric_classify_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_classify_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_classify_point_negate(pt : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_classify_point_mid(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint) -> MlmetricclassifyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_classify_point_lerp(a : MlmetricclassifyPoint, b : MlmetricclassifyPoint, t : Double) -> MlmetricclassifyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_classify_point_to_string(pt : MlmetricclassifyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricclassifySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_classify_make_series(vals : Array[Double], name : String) -> MlmetricclassifySeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_classify_series_len(s : MlmetricclassifySeries) -> Int { s.vals.length() }

pub fn ml_metric_classify_series_sum(s : MlmetricclassifySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_classify_series_mean(s : MlmetricclassifySeries) -> Double { @_common.mean(s.vals) }

pub fn ml_metric_classify_series_min(s : MlmetricclassifySeries) -> Double { @_common.min(s.vals) }

pub fn ml_metric_classify_series_max(s : MlmetricclassifySeries) -> Double { @_common.max(s.vals) }

pub fn ml_metric_classify_series_range(s : MlmetricclassifySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_metric_classify_series_var(s : MlmetricclassifySeries) -> Double { @_common.variance(s.vals) }

pub fn ml_metric_classify_series_std(s : MlmetricclassifySeries) -> Double { @_common.std(s.vals) }

pub fn ml_metric_classify_series_median(s : MlmetricclassifySeries) -> Double { @_common.median(s.vals) }

pub fn ml_metric_classify_series_scale(s : MlmetricclassifySeries, f : Double) -> MlmetricclassifySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_classify_series_add(a : MlmetricclassifySeries, b : MlmetricclassifySeries) -> MlmetricclassifySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_classify_series_sub(a : MlmetricclassifySeries, b : MlmetricclassifySeries) -> MlmetricclassifySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_classify_series_normalize(s : MlmetricclassifySeries) -> MlmetricclassifySeries {
  let mn = ml_metric_classify_series_min(s)
  let mx = ml_metric_classify_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_classify_series_cumsum(s : MlmetricclassifySeries) -> MlmetricclassifySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_classify_series_to_string(s : MlmetricclassifySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclassifyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_classify_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricclassifyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_classify_matrix_identity(n : Int) -> MlmetricclassifyMatrix {
  let m = ml_metric_classify_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_classify_matrix_get(m : MlmetricclassifyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_classify_matrix_transpose(m : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  let result = ml_metric_classify_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_classify_matrix_add(a : MlmetricclassifyMatrix, b : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_classify_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_classify_matrix_scale(m : MlmetricclassifyMatrix, s : Double) -> MlmetricclassifyMatrix {
  let result = ml_metric_classify_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_classify_matrix_multiply(a : MlmetricclassifyMatrix, b : MlmetricclassifyMatrix) -> MlmetricclassifyMatrix {
  if a.cols != b.rows { return ml_metric_classify_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_classify_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_classify_matrix_trace(m : MlmetricclassifyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_classify_matrix_det(m : MlmetricclassifyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_classify_matrix_norm(m : MlmetricclassifyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_classify_matrix_to_string(m : MlmetricclassifyMatrix) -> String {
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

pub(all) struct MlmetricclassifyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_classify_make_vector(comps : Array[Double]) -> MlmetricclassifyVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_classify_vector_zero(dim : Int) -> MlmetricclassifyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_classify_vector_add(a : MlmetricclassifyVector, b : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_classify_vector_sub(a : MlmetricclassifyVector, b : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_classify_vector_scale(v : MlmetricclassifyVector, s : Double) -> MlmetricclassifyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_classify_vector_dot(a : MlmetricclassifyVector, b : MlmetricclassifyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_classify_vector_norm(v : MlmetricclassifyVector) -> Double { @_common.sqrt(ml_metric_classify_vector_dot(v, v)) }

pub fn ml_metric_classify_vector_normalize(v : MlmetricclassifyVector) -> MlmetricclassifyVector {
  let n = ml_metric_classify_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_classify_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_classify_vector_dist(a : MlmetricclassifyVector, b : MlmetricclassifyVector) -> Double {
  ml_metric_classify_vector_norm(ml_metric_classify_vector_sub(a, b))
}

pub fn ml_metric_classify_vector_to_string(v : MlmetricclassifyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_classify_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_classify_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_classify_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_classify_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_classify_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_classify_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_classify_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_classify_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_classify_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_classify_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_classify_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_classify_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_classify_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_classify_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_classify_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_classify_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_classify_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_classify_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_classify_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_classify_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_classify_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_classify_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_classify_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_classify_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_classify_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_classify_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_classify_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_classify_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_classify_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricclassifyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_frame_make(size : Int) -> MlmetricclassifyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_frame_len(s : MlmetricclassifyFrame) -> Int { s.size }

pub fn ml_metric_classify_frame_get(s : MlmetricclassifyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_frame_set(s : MlmetricclassifyFrame, i : Int, v : Double) -> MlmetricclassifyFrame {
  let result = ml_metric_classify_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_frame_sum(s : MlmetricclassifyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_frame_mean(s : MlmetricclassifyFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_frame_scale(s : MlmetricclassifyFrame, f : Double) -> MlmetricclassifyFrame {
  let result = ml_metric_classify_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_frame_add(a : MlmetricclassifyFrame, b : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_frame_copy(s : MlmetricclassifyFrame) -> MlmetricclassifyFrame {
  let result = ml_metric_classify_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_frame_fill(s : MlmetricclassifyFrame, v : Double) -> MlmetricclassifyFrame {
  let result = ml_metric_classify_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_frame_min(s : MlmetricclassifyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_frame_max(s : MlmetricclassifyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_frame_to_string(s : MlmetricclassifyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_table_make(size : Int) -> MlmetricclassifyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_table_len(s : MlmetricclassifyTable) -> Int { s.size }

pub fn ml_metric_classify_table_get(s : MlmetricclassifyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_table_set(s : MlmetricclassifyTable, i : Int, v : Double) -> MlmetricclassifyTable {
  let result = ml_metric_classify_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_table_sum(s : MlmetricclassifyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_table_mean(s : MlmetricclassifyTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_table_scale(s : MlmetricclassifyTable, f : Double) -> MlmetricclassifyTable {
  let result = ml_metric_classify_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_table_add(a : MlmetricclassifyTable, b : MlmetricclassifyTable) -> MlmetricclassifyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_table_copy(s : MlmetricclassifyTable) -> MlmetricclassifyTable {
  let result = ml_metric_classify_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_table_fill(s : MlmetricclassifyTable, v : Double) -> MlmetricclassifyTable {
  let result = ml_metric_classify_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_table_min(s : MlmetricclassifyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_table_max(s : MlmetricclassifyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_table_to_string(s : MlmetricclassifyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_graphn_make(size : Int) -> MlmetricclassifyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_graphn_len(s : MlmetricclassifyGraphN) -> Int { s.size }

pub fn ml_metric_classify_graphn_get(s : MlmetricclassifyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_graphn_set(s : MlmetricclassifyGraphN, i : Int, v : Double) -> MlmetricclassifyGraphN {
  let result = ml_metric_classify_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_graphn_sum(s : MlmetricclassifyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_graphn_mean(s : MlmetricclassifyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_graphn_scale(s : MlmetricclassifyGraphN, f : Double) -> MlmetricclassifyGraphN {
  let result = ml_metric_classify_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_graphn_add(a : MlmetricclassifyGraphN, b : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_graphn_copy(s : MlmetricclassifyGraphN) -> MlmetricclassifyGraphN {
  let result = ml_metric_classify_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_graphn_fill(s : MlmetricclassifyGraphN, v : Double) -> MlmetricclassifyGraphN {
  let result = ml_metric_classify_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_graphn_min(s : MlmetricclassifyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_graphn_max(s : MlmetricclassifyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_graphn_to_string(s : MlmetricclassifyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_node_make(size : Int) -> MlmetricclassifyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_node_len(s : MlmetricclassifyNode) -> Int { s.size }

pub fn ml_metric_classify_node_get(s : MlmetricclassifyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_node_set(s : MlmetricclassifyNode, i : Int, v : Double) -> MlmetricclassifyNode {
  let result = ml_metric_classify_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_node_sum(s : MlmetricclassifyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_node_mean(s : MlmetricclassifyNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_node_scale(s : MlmetricclassifyNode, f : Double) -> MlmetricclassifyNode {
  let result = ml_metric_classify_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_node_add(a : MlmetricclassifyNode, b : MlmetricclassifyNode) -> MlmetricclassifyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_node_copy(s : MlmetricclassifyNode) -> MlmetricclassifyNode {
  let result = ml_metric_classify_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_node_fill(s : MlmetricclassifyNode, v : Double) -> MlmetricclassifyNode {
  let result = ml_metric_classify_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_node_min(s : MlmetricclassifyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_node_max(s : MlmetricclassifyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_node_to_string(s : MlmetricclassifyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_edge_make(size : Int) -> MlmetricclassifyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_edge_len(s : MlmetricclassifyEdge) -> Int { s.size }

pub fn ml_metric_classify_edge_get(s : MlmetricclassifyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_edge_set(s : MlmetricclassifyEdge, i : Int, v : Double) -> MlmetricclassifyEdge {
  let result = ml_metric_classify_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_edge_sum(s : MlmetricclassifyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_edge_mean(s : MlmetricclassifyEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_edge_scale(s : MlmetricclassifyEdge, f : Double) -> MlmetricclassifyEdge {
  let result = ml_metric_classify_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_edge_add(a : MlmetricclassifyEdge, b : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_edge_copy(s : MlmetricclassifyEdge) -> MlmetricclassifyEdge {
  let result = ml_metric_classify_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_edge_fill(s : MlmetricclassifyEdge, v : Double) -> MlmetricclassifyEdge {
  let result = ml_metric_classify_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_edge_min(s : MlmetricclassifyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_edge_max(s : MlmetricclassifyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_edge_to_string(s : MlmetricclassifyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_path_make(size : Int) -> MlmetricclassifyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_path_len(s : MlmetricclassifyPath) -> Int { s.size }

pub fn ml_metric_classify_path_get(s : MlmetricclassifyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_path_set(s : MlmetricclassifyPath, i : Int, v : Double) -> MlmetricclassifyPath {
  let result = ml_metric_classify_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_path_sum(s : MlmetricclassifyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_path_mean(s : MlmetricclassifyPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_path_scale(s : MlmetricclassifyPath, f : Double) -> MlmetricclassifyPath {
  let result = ml_metric_classify_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_path_add(a : MlmetricclassifyPath, b : MlmetricclassifyPath) -> MlmetricclassifyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_path_copy(s : MlmetricclassifyPath) -> MlmetricclassifyPath {
  let result = ml_metric_classify_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_path_fill(s : MlmetricclassifyPath, v : Double) -> MlmetricclassifyPath {
  let result = ml_metric_classify_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_path_min(s : MlmetricclassifyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_path_max(s : MlmetricclassifyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_path_to_string(s : MlmetricclassifyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cluster_make(size : Int) -> MlmetricclassifyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_cluster_len(s : MlmetricclassifyCluster) -> Int { s.size }

pub fn ml_metric_classify_cluster_get(s : MlmetricclassifyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_cluster_set(s : MlmetricclassifyCluster, i : Int, v : Double) -> MlmetricclassifyCluster {
  let result = ml_metric_classify_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_cluster_sum(s : MlmetricclassifyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_cluster_mean(s : MlmetricclassifyCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_cluster_scale(s : MlmetricclassifyCluster, f : Double) -> MlmetricclassifyCluster {
  let result = ml_metric_classify_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_cluster_add(a : MlmetricclassifyCluster, b : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_cluster_copy(s : MlmetricclassifyCluster) -> MlmetricclassifyCluster {
  let result = ml_metric_classify_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_cluster_fill(s : MlmetricclassifyCluster, v : Double) -> MlmetricclassifyCluster {
  let result = ml_metric_classify_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_cluster_min(s : MlmetricclassifyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_cluster_max(s : MlmetricclassifyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_cluster_to_string(s : MlmetricclassifyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_model_make(size : Int) -> MlmetricclassifyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_model_len(s : MlmetricclassifyModel) -> Int { s.size }

pub fn ml_metric_classify_model_get(s : MlmetricclassifyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_model_set(s : MlmetricclassifyModel, i : Int, v : Double) -> MlmetricclassifyModel {
  let result = ml_metric_classify_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_model_sum(s : MlmetricclassifyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_model_mean(s : MlmetricclassifyModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_model_scale(s : MlmetricclassifyModel, f : Double) -> MlmetricclassifyModel {
  let result = ml_metric_classify_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_model_add(a : MlmetricclassifyModel, b : MlmetricclassifyModel) -> MlmetricclassifyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_model_copy(s : MlmetricclassifyModel) -> MlmetricclassifyModel {
  let result = ml_metric_classify_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_model_fill(s : MlmetricclassifyModel, v : Double) -> MlmetricclassifyModel {
  let result = ml_metric_classify_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_model_min(s : MlmetricclassifyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_model_max(s : MlmetricclassifyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_model_to_string(s : MlmetricclassifyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_layer_make(size : Int) -> MlmetricclassifyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_layer_len(s : MlmetricclassifyLayer) -> Int { s.size }

pub fn ml_metric_classify_layer_get(s : MlmetricclassifyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_layer_set(s : MlmetricclassifyLayer, i : Int, v : Double) -> MlmetricclassifyLayer {
  let result = ml_metric_classify_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_layer_sum(s : MlmetricclassifyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_layer_mean(s : MlmetricclassifyLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_layer_scale(s : MlmetricclassifyLayer, f : Double) -> MlmetricclassifyLayer {
  let result = ml_metric_classify_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_layer_add(a : MlmetricclassifyLayer, b : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_layer_copy(s : MlmetricclassifyLayer) -> MlmetricclassifyLayer {
  let result = ml_metric_classify_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_layer_fill(s : MlmetricclassifyLayer, v : Double) -> MlmetricclassifyLayer {
  let result = ml_metric_classify_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_layer_min(s : MlmetricclassifyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_layer_max(s : MlmetricclassifyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_layer_to_string(s : MlmetricclassifyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_buffer_make(size : Int) -> MlmetricclassifyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_buffer_len(s : MlmetricclassifyBuffer) -> Int { s.size }

pub fn ml_metric_classify_buffer_get(s : MlmetricclassifyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_buffer_set(s : MlmetricclassifyBuffer, i : Int, v : Double) -> MlmetricclassifyBuffer {
  let result = ml_metric_classify_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_buffer_sum(s : MlmetricclassifyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_buffer_mean(s : MlmetricclassifyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_buffer_scale(s : MlmetricclassifyBuffer, f : Double) -> MlmetricclassifyBuffer {
  let result = ml_metric_classify_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_buffer_add(a : MlmetricclassifyBuffer, b : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_buffer_copy(s : MlmetricclassifyBuffer) -> MlmetricclassifyBuffer {
  let result = ml_metric_classify_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_buffer_fill(s : MlmetricclassifyBuffer, v : Double) -> MlmetricclassifyBuffer {
  let result = ml_metric_classify_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_buffer_min(s : MlmetricclassifyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_buffer_max(s : MlmetricclassifyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_buffer_to_string(s : MlmetricclassifyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_cursor_make(size : Int) -> MlmetricclassifyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_cursor_len(s : MlmetricclassifyCursor) -> Int { s.size }

pub fn ml_metric_classify_cursor_get(s : MlmetricclassifyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_cursor_set(s : MlmetricclassifyCursor, i : Int, v : Double) -> MlmetricclassifyCursor {
  let result = ml_metric_classify_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_cursor_sum(s : MlmetricclassifyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_cursor_mean(s : MlmetricclassifyCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_cursor_scale(s : MlmetricclassifyCursor, f : Double) -> MlmetricclassifyCursor {
  let result = ml_metric_classify_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_cursor_add(a : MlmetricclassifyCursor, b : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_cursor_copy(s : MlmetricclassifyCursor) -> MlmetricclassifyCursor {
  let result = ml_metric_classify_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_cursor_fill(s : MlmetricclassifyCursor, v : Double) -> MlmetricclassifyCursor {
  let result = ml_metric_classify_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_cursor_min(s : MlmetricclassifyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_cursor_max(s : MlmetricclassifyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_cursor_to_string(s : MlmetricclassifyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_view_make(size : Int) -> MlmetricclassifyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_view_len(s : MlmetricclassifyView) -> Int { s.size }

pub fn ml_metric_classify_view_get(s : MlmetricclassifyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_view_set(s : MlmetricclassifyView, i : Int, v : Double) -> MlmetricclassifyView {
  let result = ml_metric_classify_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_view_sum(s : MlmetricclassifyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_view_mean(s : MlmetricclassifyView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_view_scale(s : MlmetricclassifyView, f : Double) -> MlmetricclassifyView {
  let result = ml_metric_classify_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_view_add(a : MlmetricclassifyView, b : MlmetricclassifyView) -> MlmetricclassifyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_view_copy(s : MlmetricclassifyView) -> MlmetricclassifyView {
  let result = ml_metric_classify_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_view_fill(s : MlmetricclassifyView, v : Double) -> MlmetricclassifyView {
  let result = ml_metric_classify_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_view_min(s : MlmetricclassifyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_view_max(s : MlmetricclassifyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_view_to_string(s : MlmetricclassifyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_range_make(size : Int) -> MlmetricclassifyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_range_len(s : MlmetricclassifyRange) -> Int { s.size }

pub fn ml_metric_classify_range_get(s : MlmetricclassifyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_range_set(s : MlmetricclassifyRange, i : Int, v : Double) -> MlmetricclassifyRange {
  let result = ml_metric_classify_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_range_sum(s : MlmetricclassifyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_range_mean(s : MlmetricclassifyRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_range_scale(s : MlmetricclassifyRange, f : Double) -> MlmetricclassifyRange {
  let result = ml_metric_classify_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_range_add(a : MlmetricclassifyRange, b : MlmetricclassifyRange) -> MlmetricclassifyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_range_copy(s : MlmetricclassifyRange) -> MlmetricclassifyRange {
  let result = ml_metric_classify_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_range_fill(s : MlmetricclassifyRange, v : Double) -> MlmetricclassifyRange {
  let result = ml_metric_classify_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_range_min(s : MlmetricclassifyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_range_max(s : MlmetricclassifyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_range_to_string(s : MlmetricclassifyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclassifySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_classify_slice_make(size : Int) -> MlmetricclassifySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_classify_slice_len(s : MlmetricclassifySlice) -> Int { s.size }

pub fn ml_metric_classify_slice_get(s : MlmetricclassifySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_classify_slice_set(s : MlmetricclassifySlice, i : Int, v : Double) -> MlmetricclassifySlice {
  let result = ml_metric_classify_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_slice_sum(s : MlmetricclassifySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_classify_slice_mean(s : MlmetricclassifySlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_classify_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_classify_slice_scale(s : MlmetricclassifySlice, f : Double) -> MlmetricclassifySlice {
  let result = ml_metric_classify_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_classify_slice_add(a : MlmetricclassifySlice, b : MlmetricclassifySlice) -> MlmetricclassifySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_classify_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_classify_slice_copy(s : MlmetricclassifySlice) -> MlmetricclassifySlice {
  let result = ml_metric_classify_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_classify_slice_fill(s : MlmetricclassifySlice, v : Double) -> MlmetricclassifySlice {
  let result = ml_metric_classify_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_classify_slice_min(s : MlmetricclassifySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_slice_max(s : MlmetricclassifySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_classify_slice_to_string(s : MlmetricclassifySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


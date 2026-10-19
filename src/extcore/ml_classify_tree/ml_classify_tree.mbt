///===
/// extcore/ml_classify_tree

pub(all) struct MlclassifytreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_tree_make_point(x : Double, y : Double) -> MlclassifytreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_tree_make_point3(x : Double, y : Double, z : Double) -> MlclassifytreePoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_tree_point_x(pt : MlclassifytreePoint) -> Double { pt.x }

pub fn ml_classify_tree_point_y(pt : MlclassifytreePoint) -> Double { pt.y }

pub fn ml_classify_tree_point_z(pt : MlclassifytreePoint) -> Double { pt.z }

pub fn ml_classify_tree_point_label(pt : MlclassifytreePoint) -> Int { pt.label }

pub fn ml_classify_tree_point_dist(a : MlclassifytreePoint, b : MlclassifytreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_tree_point_add(a : MlclassifytreePoint, b : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_tree_point_sub(a : MlclassifytreePoint, b : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_tree_point_scale(pt : MlclassifytreePoint, s : Double) -> MlclassifytreePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_tree_point_dot(a : MlclassifytreePoint, b : MlclassifytreePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_tree_point_cross(a : MlclassifytreePoint, b : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_tree_point_norm(pt : MlclassifytreePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_tree_point_normalize(pt : MlclassifytreePoint) -> MlclassifytreePoint {
  let n = ml_classify_tree_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_tree_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_tree_point_negate(pt : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_tree_point_mid(a : MlclassifytreePoint, b : MlclassifytreePoint) -> MlclassifytreePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_tree_point_lerp(a : MlclassifytreePoint, b : MlclassifytreePoint, t : Double) -> MlclassifytreePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_tree_point_to_string(pt : MlclassifytreePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifytreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_tree_make_series(vals : Array[Double], name : String) -> MlclassifytreeSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_tree_series_len(s : MlclassifytreeSeries) -> Int { s.vals.length() }

pub fn ml_classify_tree_series_sum(s : MlclassifytreeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_tree_series_mean(s : MlclassifytreeSeries) -> Double {
  let n = ml_classify_tree_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_tree_series_sum(s) / n.to_double() }
}

pub fn ml_classify_tree_series_min(s : MlclassifytreeSeries) -> Double {
  let n = ml_classify_tree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_tree_series_max(s : MlclassifytreeSeries) -> Double {
  let n = ml_classify_tree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_tree_series_range(s : MlclassifytreeSeries) -> Double {
  ml_classify_tree_series_max(s) - ml_classify_tree_series_min(s)
}

pub fn ml_classify_tree_series_var(s : MlclassifytreeSeries) -> Double {
  let n = ml_classify_tree_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_tree_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_tree_series_std(s : MlclassifytreeSeries) -> Double { @_common.sqrt(ml_classify_tree_series_var(s)) }

pub fn ml_classify_tree_series_median(s : MlclassifytreeSeries) -> Double {
  let n = ml_classify_tree_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_tree_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_tree_series_scale(s : MlclassifytreeSeries, f : Double) -> MlclassifytreeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_tree_series_add(a : MlclassifytreeSeries, b : MlclassifytreeSeries) -> MlclassifytreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_tree_series_sub(a : MlclassifytreeSeries, b : MlclassifytreeSeries) -> MlclassifytreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_tree_series_normalize(s : MlclassifytreeSeries) -> MlclassifytreeSeries {
  let mn = ml_classify_tree_series_min(s)
  let mx = ml_classify_tree_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_tree_series_cumsum(s : MlclassifytreeSeries) -> MlclassifytreeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_tree_series_to_string(s : MlclassifytreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifytreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_tree_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifytreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_tree_matrix_identity(n : Int) -> MlclassifytreeMatrix {
  let m = ml_classify_tree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_tree_matrix_get(m : MlclassifytreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_tree_matrix_transpose(m : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  let result = ml_classify_tree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_tree_matrix_add(a : MlclassifytreeMatrix, b : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_tree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_tree_matrix_scale(m : MlclassifytreeMatrix, s : Double) -> MlclassifytreeMatrix {
  let result = ml_classify_tree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_tree_matrix_multiply(a : MlclassifytreeMatrix, b : MlclassifytreeMatrix) -> MlclassifytreeMatrix {
  if a.cols != b.rows { return ml_classify_tree_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_tree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_tree_matrix_trace(m : MlclassifytreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_tree_matrix_det(m : MlclassifytreeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_tree_matrix_norm(m : MlclassifytreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_tree_matrix_to_string(m : MlclassifytreeMatrix) -> String {
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

pub(all) struct MlclassifytreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_tree_make_vector(comps : Array[Double]) -> MlclassifytreeVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_tree_vector_zero(dim : Int) -> MlclassifytreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_tree_vector_add(a : MlclassifytreeVector, b : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_tree_vector_sub(a : MlclassifytreeVector, b : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_tree_vector_scale(v : MlclassifytreeVector, s : Double) -> MlclassifytreeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_tree_vector_dot(a : MlclassifytreeVector, b : MlclassifytreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_tree_vector_norm(v : MlclassifytreeVector) -> Double { @_common.sqrt(ml_classify_tree_vector_dot(v, v)) }

pub fn ml_classify_tree_vector_normalize(v : MlclassifytreeVector) -> MlclassifytreeVector {
  let n = ml_classify_tree_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_tree_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_tree_vector_dist(a : MlclassifytreeVector, b : MlclassifytreeVector) -> Double {
  ml_classify_tree_vector_norm(ml_classify_tree_vector_sub(a, b))
}

pub fn ml_classify_tree_vector_to_string(v : MlclassifytreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_tree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_tree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_tree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_tree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_tree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_tree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_tree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_tree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_tree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_tree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_tree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_tree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_tree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_tree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_tree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_tree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_tree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_tree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_tree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_tree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_tree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_tree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_tree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_tree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_tree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_tree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_tree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_tree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_tree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifytreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_frame_make(size : Int) -> MlclassifytreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_frame_len(s : MlclassifytreeFrame) -> Int { s.size }

pub fn ml_classify_tree_frame_get(s : MlclassifytreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_frame_set(s : MlclassifytreeFrame, i : Int, v : Double) -> MlclassifytreeFrame {
  let result = ml_classify_tree_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_frame_sum(s : MlclassifytreeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_frame_mean(s : MlclassifytreeFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_frame_scale(s : MlclassifytreeFrame, f : Double) -> MlclassifytreeFrame {
  let result = ml_classify_tree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_frame_add(a : MlclassifytreeFrame, b : MlclassifytreeFrame) -> MlclassifytreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_frame_copy(s : MlclassifytreeFrame) -> MlclassifytreeFrame {
  let result = ml_classify_tree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_frame_fill(s : MlclassifytreeFrame, v : Double) -> MlclassifytreeFrame {
  let result = ml_classify_tree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_frame_min(s : MlclassifytreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_frame_max(s : MlclassifytreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_frame_to_string(s : MlclassifytreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_table_make(size : Int) -> MlclassifytreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_table_len(s : MlclassifytreeTable) -> Int { s.size }

pub fn ml_classify_tree_table_get(s : MlclassifytreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_table_set(s : MlclassifytreeTable, i : Int, v : Double) -> MlclassifytreeTable {
  let result = ml_classify_tree_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_table_sum(s : MlclassifytreeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_table_mean(s : MlclassifytreeTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_table_scale(s : MlclassifytreeTable, f : Double) -> MlclassifytreeTable {
  let result = ml_classify_tree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_table_add(a : MlclassifytreeTable, b : MlclassifytreeTable) -> MlclassifytreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_table_copy(s : MlclassifytreeTable) -> MlclassifytreeTable {
  let result = ml_classify_tree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_table_fill(s : MlclassifytreeTable, v : Double) -> MlclassifytreeTable {
  let result = ml_classify_tree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_table_min(s : MlclassifytreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_table_max(s : MlclassifytreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_table_to_string(s : MlclassifytreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_graphn_make(size : Int) -> MlclassifytreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_graphn_len(s : MlclassifytreeGraphN) -> Int { s.size }

pub fn ml_classify_tree_graphn_get(s : MlclassifytreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_graphn_set(s : MlclassifytreeGraphN, i : Int, v : Double) -> MlclassifytreeGraphN {
  let result = ml_classify_tree_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_graphn_sum(s : MlclassifytreeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_graphn_mean(s : MlclassifytreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_graphn_scale(s : MlclassifytreeGraphN, f : Double) -> MlclassifytreeGraphN {
  let result = ml_classify_tree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_graphn_add(a : MlclassifytreeGraphN, b : MlclassifytreeGraphN) -> MlclassifytreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_graphn_copy(s : MlclassifytreeGraphN) -> MlclassifytreeGraphN {
  let result = ml_classify_tree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_graphn_fill(s : MlclassifytreeGraphN, v : Double) -> MlclassifytreeGraphN {
  let result = ml_classify_tree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_graphn_min(s : MlclassifytreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_graphn_max(s : MlclassifytreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_graphn_to_string(s : MlclassifytreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_node_make(size : Int) -> MlclassifytreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_node_len(s : MlclassifytreeNode) -> Int { s.size }

pub fn ml_classify_tree_node_get(s : MlclassifytreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_node_set(s : MlclassifytreeNode, i : Int, v : Double) -> MlclassifytreeNode {
  let result = ml_classify_tree_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_node_sum(s : MlclassifytreeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_node_mean(s : MlclassifytreeNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_node_scale(s : MlclassifytreeNode, f : Double) -> MlclassifytreeNode {
  let result = ml_classify_tree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_node_add(a : MlclassifytreeNode, b : MlclassifytreeNode) -> MlclassifytreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_node_copy(s : MlclassifytreeNode) -> MlclassifytreeNode {
  let result = ml_classify_tree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_node_fill(s : MlclassifytreeNode, v : Double) -> MlclassifytreeNode {
  let result = ml_classify_tree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_node_min(s : MlclassifytreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_node_max(s : MlclassifytreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_node_to_string(s : MlclassifytreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_edge_make(size : Int) -> MlclassifytreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_edge_len(s : MlclassifytreeEdge) -> Int { s.size }

pub fn ml_classify_tree_edge_get(s : MlclassifytreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_edge_set(s : MlclassifytreeEdge, i : Int, v : Double) -> MlclassifytreeEdge {
  let result = ml_classify_tree_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_edge_sum(s : MlclassifytreeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_edge_mean(s : MlclassifytreeEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_edge_scale(s : MlclassifytreeEdge, f : Double) -> MlclassifytreeEdge {
  let result = ml_classify_tree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_edge_add(a : MlclassifytreeEdge, b : MlclassifytreeEdge) -> MlclassifytreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_edge_copy(s : MlclassifytreeEdge) -> MlclassifytreeEdge {
  let result = ml_classify_tree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_edge_fill(s : MlclassifytreeEdge, v : Double) -> MlclassifytreeEdge {
  let result = ml_classify_tree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_edge_min(s : MlclassifytreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_edge_max(s : MlclassifytreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_edge_to_string(s : MlclassifytreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_path_make(size : Int) -> MlclassifytreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_path_len(s : MlclassifytreePath) -> Int { s.size }

pub fn ml_classify_tree_path_get(s : MlclassifytreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_path_set(s : MlclassifytreePath, i : Int, v : Double) -> MlclassifytreePath {
  let result = ml_classify_tree_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_path_sum(s : MlclassifytreePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_path_mean(s : MlclassifytreePath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_path_scale(s : MlclassifytreePath, f : Double) -> MlclassifytreePath {
  let result = ml_classify_tree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_path_add(a : MlclassifytreePath, b : MlclassifytreePath) -> MlclassifytreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_path_copy(s : MlclassifytreePath) -> MlclassifytreePath {
  let result = ml_classify_tree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_path_fill(s : MlclassifytreePath, v : Double) -> MlclassifytreePath {
  let result = ml_classify_tree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_path_min(s : MlclassifytreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_path_max(s : MlclassifytreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_path_to_string(s : MlclassifytreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_cluster_make(size : Int) -> MlclassifytreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_cluster_len(s : MlclassifytreeCluster) -> Int { s.size }

pub fn ml_classify_tree_cluster_get(s : MlclassifytreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_cluster_set(s : MlclassifytreeCluster, i : Int, v : Double) -> MlclassifytreeCluster {
  let result = ml_classify_tree_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_cluster_sum(s : MlclassifytreeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_cluster_mean(s : MlclassifytreeCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_cluster_scale(s : MlclassifytreeCluster, f : Double) -> MlclassifytreeCluster {
  let result = ml_classify_tree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_cluster_add(a : MlclassifytreeCluster, b : MlclassifytreeCluster) -> MlclassifytreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_cluster_copy(s : MlclassifytreeCluster) -> MlclassifytreeCluster {
  let result = ml_classify_tree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_cluster_fill(s : MlclassifytreeCluster, v : Double) -> MlclassifytreeCluster {
  let result = ml_classify_tree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_cluster_min(s : MlclassifytreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_cluster_max(s : MlclassifytreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_cluster_to_string(s : MlclassifytreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_model_make(size : Int) -> MlclassifytreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_model_len(s : MlclassifytreeModel) -> Int { s.size }

pub fn ml_classify_tree_model_get(s : MlclassifytreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_model_set(s : MlclassifytreeModel, i : Int, v : Double) -> MlclassifytreeModel {
  let result = ml_classify_tree_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_model_sum(s : MlclassifytreeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_model_mean(s : MlclassifytreeModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_model_scale(s : MlclassifytreeModel, f : Double) -> MlclassifytreeModel {
  let result = ml_classify_tree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_model_add(a : MlclassifytreeModel, b : MlclassifytreeModel) -> MlclassifytreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_model_copy(s : MlclassifytreeModel) -> MlclassifytreeModel {
  let result = ml_classify_tree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_model_fill(s : MlclassifytreeModel, v : Double) -> MlclassifytreeModel {
  let result = ml_classify_tree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_model_min(s : MlclassifytreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_model_max(s : MlclassifytreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_model_to_string(s : MlclassifytreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_layer_make(size : Int) -> MlclassifytreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_layer_len(s : MlclassifytreeLayer) -> Int { s.size }

pub fn ml_classify_tree_layer_get(s : MlclassifytreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_layer_set(s : MlclassifytreeLayer, i : Int, v : Double) -> MlclassifytreeLayer {
  let result = ml_classify_tree_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_layer_sum(s : MlclassifytreeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_layer_mean(s : MlclassifytreeLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_layer_scale(s : MlclassifytreeLayer, f : Double) -> MlclassifytreeLayer {
  let result = ml_classify_tree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_layer_add(a : MlclassifytreeLayer, b : MlclassifytreeLayer) -> MlclassifytreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_layer_copy(s : MlclassifytreeLayer) -> MlclassifytreeLayer {
  let result = ml_classify_tree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_layer_fill(s : MlclassifytreeLayer, v : Double) -> MlclassifytreeLayer {
  let result = ml_classify_tree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_layer_min(s : MlclassifytreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_layer_max(s : MlclassifytreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_layer_to_string(s : MlclassifytreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_buffer_make(size : Int) -> MlclassifytreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_buffer_len(s : MlclassifytreeBuffer) -> Int { s.size }

pub fn ml_classify_tree_buffer_get(s : MlclassifytreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_buffer_set(s : MlclassifytreeBuffer, i : Int, v : Double) -> MlclassifytreeBuffer {
  let result = ml_classify_tree_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_buffer_sum(s : MlclassifytreeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_buffer_mean(s : MlclassifytreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_buffer_scale(s : MlclassifytreeBuffer, f : Double) -> MlclassifytreeBuffer {
  let result = ml_classify_tree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_buffer_add(a : MlclassifytreeBuffer, b : MlclassifytreeBuffer) -> MlclassifytreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_buffer_copy(s : MlclassifytreeBuffer) -> MlclassifytreeBuffer {
  let result = ml_classify_tree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_buffer_fill(s : MlclassifytreeBuffer, v : Double) -> MlclassifytreeBuffer {
  let result = ml_classify_tree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_buffer_min(s : MlclassifytreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_buffer_max(s : MlclassifytreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_buffer_to_string(s : MlclassifytreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_cursor_make(size : Int) -> MlclassifytreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_cursor_len(s : MlclassifytreeCursor) -> Int { s.size }

pub fn ml_classify_tree_cursor_get(s : MlclassifytreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_cursor_set(s : MlclassifytreeCursor, i : Int, v : Double) -> MlclassifytreeCursor {
  let result = ml_classify_tree_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_cursor_sum(s : MlclassifytreeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_cursor_mean(s : MlclassifytreeCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_cursor_scale(s : MlclassifytreeCursor, f : Double) -> MlclassifytreeCursor {
  let result = ml_classify_tree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_cursor_add(a : MlclassifytreeCursor, b : MlclassifytreeCursor) -> MlclassifytreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_cursor_copy(s : MlclassifytreeCursor) -> MlclassifytreeCursor {
  let result = ml_classify_tree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_cursor_fill(s : MlclassifytreeCursor, v : Double) -> MlclassifytreeCursor {
  let result = ml_classify_tree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_cursor_min(s : MlclassifytreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_cursor_max(s : MlclassifytreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_cursor_to_string(s : MlclassifytreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_view_make(size : Int) -> MlclassifytreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_view_len(s : MlclassifytreeView) -> Int { s.size }

pub fn ml_classify_tree_view_get(s : MlclassifytreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_view_set(s : MlclassifytreeView, i : Int, v : Double) -> MlclassifytreeView {
  let result = ml_classify_tree_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_view_sum(s : MlclassifytreeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_view_mean(s : MlclassifytreeView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_view_scale(s : MlclassifytreeView, f : Double) -> MlclassifytreeView {
  let result = ml_classify_tree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_view_add(a : MlclassifytreeView, b : MlclassifytreeView) -> MlclassifytreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_view_copy(s : MlclassifytreeView) -> MlclassifytreeView {
  let result = ml_classify_tree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_view_fill(s : MlclassifytreeView, v : Double) -> MlclassifytreeView {
  let result = ml_classify_tree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_view_min(s : MlclassifytreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_view_max(s : MlclassifytreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_view_to_string(s : MlclassifytreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_range_make(size : Int) -> MlclassifytreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_range_len(s : MlclassifytreeRange) -> Int { s.size }

pub fn ml_classify_tree_range_get(s : MlclassifytreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_range_set(s : MlclassifytreeRange, i : Int, v : Double) -> MlclassifytreeRange {
  let result = ml_classify_tree_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_range_sum(s : MlclassifytreeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_range_mean(s : MlclassifytreeRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_range_scale(s : MlclassifytreeRange, f : Double) -> MlclassifytreeRange {
  let result = ml_classify_tree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_range_add(a : MlclassifytreeRange, b : MlclassifytreeRange) -> MlclassifytreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_range_copy(s : MlclassifytreeRange) -> MlclassifytreeRange {
  let result = ml_classify_tree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_range_fill(s : MlclassifytreeRange, v : Double) -> MlclassifytreeRange {
  let result = ml_classify_tree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_range_min(s : MlclassifytreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_range_max(s : MlclassifytreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_range_to_string(s : MlclassifytreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifytreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_tree_slice_make(size : Int) -> MlclassifytreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_tree_slice_len(s : MlclassifytreeSlice) -> Int { s.size }

pub fn ml_classify_tree_slice_get(s : MlclassifytreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_tree_slice_set(s : MlclassifytreeSlice, i : Int, v : Double) -> MlclassifytreeSlice {
  let result = ml_classify_tree_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_slice_sum(s : MlclassifytreeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_tree_slice_mean(s : MlclassifytreeSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_tree_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_tree_slice_scale(s : MlclassifytreeSlice, f : Double) -> MlclassifytreeSlice {
  let result = ml_classify_tree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_tree_slice_add(a : MlclassifytreeSlice, b : MlclassifytreeSlice) -> MlclassifytreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_tree_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_tree_slice_copy(s : MlclassifytreeSlice) -> MlclassifytreeSlice {
  let result = ml_classify_tree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_tree_slice_fill(s : MlclassifytreeSlice, v : Double) -> MlclassifytreeSlice {
  let result = ml_classify_tree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_tree_slice_min(s : MlclassifytreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_slice_max(s : MlclassifytreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_tree_slice_to_string(s : MlclassifytreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


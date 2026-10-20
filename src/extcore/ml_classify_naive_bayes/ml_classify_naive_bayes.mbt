///===
/// extcore/ml_classify_naive_bayes

pub(all) struct MlclassifynaivebayesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_naive_bayes_make_point(x : Double, y : Double) -> MlclassifynaivebayesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_naive_bayes_make_point3(x : Double, y : Double, z : Double) -> MlclassifynaivebayesPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_naive_bayes_point_x(pt : MlclassifynaivebayesPoint) -> Double { pt.x }

pub fn ml_classify_naive_bayes_point_y(pt : MlclassifynaivebayesPoint) -> Double { pt.y }

pub fn ml_classify_naive_bayes_point_z(pt : MlclassifynaivebayesPoint) -> Double { pt.z }

pub fn ml_classify_naive_bayes_point_label(pt : MlclassifynaivebayesPoint) -> Int { pt.label }

pub fn ml_classify_naive_bayes_point_dist(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_naive_bayes_point_add(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_naive_bayes_point_sub(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_naive_bayes_point_scale(pt : MlclassifynaivebayesPoint, s : Double) -> MlclassifynaivebayesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_naive_bayes_point_dot(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_naive_bayes_point_cross(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_naive_bayes_point_norm(pt : MlclassifynaivebayesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_naive_bayes_point_normalize(pt : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  let n = ml_classify_naive_bayes_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_naive_bayes_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_naive_bayes_point_negate(pt : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_naive_bayes_point_mid(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint) -> MlclassifynaivebayesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_naive_bayes_point_lerp(a : MlclassifynaivebayesPoint, b : MlclassifynaivebayesPoint, t : Double) -> MlclassifynaivebayesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_naive_bayes_point_to_string(pt : MlclassifynaivebayesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_naive_bayes_make_series(vals : Array[Double], name : String) -> MlclassifynaivebayesSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_naive_bayes_series_len(s : MlclassifynaivebayesSeries) -> Int { s.vals.length() }

pub fn ml_classify_naive_bayes_series_sum(s : MlclassifynaivebayesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_naive_bayes_series_mean(s : MlclassifynaivebayesSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_classify_naive_bayes_series_min(s : MlclassifynaivebayesSeries) -> Double { @_common.min(s.vals) }

pub fn ml_classify_naive_bayes_series_max(s : MlclassifynaivebayesSeries) -> Double { @_common.max(s.vals) }

pub fn ml_classify_naive_bayes_series_range(s : MlclassifynaivebayesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_classify_naive_bayes_series_var(s : MlclassifynaivebayesSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_classify_naive_bayes_series_std(s : MlclassifynaivebayesSeries) -> Double { @_common.std(s.vals) }

pub fn ml_classify_naive_bayes_series_median(s : MlclassifynaivebayesSeries) -> Double { @_common.median(s.vals) }

pub fn ml_classify_naive_bayes_series_scale(s : MlclassifynaivebayesSeries, f : Double) -> MlclassifynaivebayesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_naive_bayes_series_add(a : MlclassifynaivebayesSeries, b : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_naive_bayes_series_sub(a : MlclassifynaivebayesSeries, b : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_naive_bayes_series_normalize(s : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  let mn = ml_classify_naive_bayes_series_min(s)
  let mx = ml_classify_naive_bayes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_naive_bayes_series_cumsum(s : MlclassifynaivebayesSeries) -> MlclassifynaivebayesSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_naive_bayes_series_to_string(s : MlclassifynaivebayesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifynaivebayesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_naive_bayes_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifynaivebayesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_naive_bayes_matrix_identity(n : Int) -> MlclassifynaivebayesMatrix {
  let m = ml_classify_naive_bayes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_naive_bayes_matrix_get(m : MlclassifynaivebayesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_naive_bayes_matrix_transpose(m : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_naive_bayes_matrix_add(a : MlclassifynaivebayesMatrix, b : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_naive_bayes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_naive_bayes_matrix_scale(m : MlclassifynaivebayesMatrix, s : Double) -> MlclassifynaivebayesMatrix {
  let result = ml_classify_naive_bayes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_naive_bayes_matrix_multiply(a : MlclassifynaivebayesMatrix, b : MlclassifynaivebayesMatrix) -> MlclassifynaivebayesMatrix {
  if a.cols != b.rows { return ml_classify_naive_bayes_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_naive_bayes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_naive_bayes_matrix_trace(m : MlclassifynaivebayesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_naive_bayes_matrix_det(m : MlclassifynaivebayesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_naive_bayes_matrix_norm(m : MlclassifynaivebayesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_naive_bayes_matrix_to_string(m : MlclassifynaivebayesMatrix) -> String {
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

pub(all) struct MlclassifynaivebayesVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_naive_bayes_make_vector(comps : Array[Double]) -> MlclassifynaivebayesVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_naive_bayes_vector_zero(dim : Int) -> MlclassifynaivebayesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_naive_bayes_vector_add(a : MlclassifynaivebayesVector, b : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_naive_bayes_vector_sub(a : MlclassifynaivebayesVector, b : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_naive_bayes_vector_scale(v : MlclassifynaivebayesVector, s : Double) -> MlclassifynaivebayesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_naive_bayes_vector_dot(a : MlclassifynaivebayesVector, b : MlclassifynaivebayesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_naive_bayes_vector_norm(v : MlclassifynaivebayesVector) -> Double { @_common.sqrt(ml_classify_naive_bayes_vector_dot(v, v)) }

pub fn ml_classify_naive_bayes_vector_normalize(v : MlclassifynaivebayesVector) -> MlclassifynaivebayesVector {
  let n = ml_classify_naive_bayes_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_naive_bayes_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_naive_bayes_vector_dist(a : MlclassifynaivebayesVector, b : MlclassifynaivebayesVector) -> Double {
  ml_classify_naive_bayes_vector_norm(ml_classify_naive_bayes_vector_sub(a, b))
}

pub fn ml_classify_naive_bayes_vector_to_string(v : MlclassifynaivebayesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_naive_bayes_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_naive_bayes_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_naive_bayes_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_naive_bayes_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_naive_bayes_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_naive_bayes_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_naive_bayes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_naive_bayes_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_naive_bayes_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_naive_bayes_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_naive_bayes_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_naive_bayes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_naive_bayes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_naive_bayes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_naive_bayes_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_naive_bayes_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_naive_bayes_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_naive_bayes_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_naive_bayes_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_naive_bayes_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_naive_bayes_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_naive_bayes_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_naive_bayes_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_naive_bayes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_naive_bayes_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_naive_bayes_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_naive_bayes_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_naive_bayes_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_naive_bayes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifynaivebayesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_frame_make(size : Int) -> MlclassifynaivebayesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_frame_len(s : MlclassifynaivebayesFrame) -> Int { s.size }

pub fn ml_classify_naive_bayes_frame_get(s : MlclassifynaivebayesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_frame_set(s : MlclassifynaivebayesFrame, i : Int, v : Double) -> MlclassifynaivebayesFrame {
  let result = ml_classify_naive_bayes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_frame_sum(s : MlclassifynaivebayesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_frame_mean(s : MlclassifynaivebayesFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_frame_scale(s : MlclassifynaivebayesFrame, f : Double) -> MlclassifynaivebayesFrame {
  let result = ml_classify_naive_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_frame_add(a : MlclassifynaivebayesFrame, b : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_frame_copy(s : MlclassifynaivebayesFrame) -> MlclassifynaivebayesFrame {
  let result = ml_classify_naive_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_frame_fill(s : MlclassifynaivebayesFrame, v : Double) -> MlclassifynaivebayesFrame {
  let result = ml_classify_naive_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_frame_min(s : MlclassifynaivebayesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_frame_max(s : MlclassifynaivebayesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_frame_to_string(s : MlclassifynaivebayesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_table_make(size : Int) -> MlclassifynaivebayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_table_len(s : MlclassifynaivebayesTable) -> Int { s.size }

pub fn ml_classify_naive_bayes_table_get(s : MlclassifynaivebayesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_table_set(s : MlclassifynaivebayesTable, i : Int, v : Double) -> MlclassifynaivebayesTable {
  let result = ml_classify_naive_bayes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_table_sum(s : MlclassifynaivebayesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_table_mean(s : MlclassifynaivebayesTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_table_scale(s : MlclassifynaivebayesTable, f : Double) -> MlclassifynaivebayesTable {
  let result = ml_classify_naive_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_table_add(a : MlclassifynaivebayesTable, b : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_table_copy(s : MlclassifynaivebayesTable) -> MlclassifynaivebayesTable {
  let result = ml_classify_naive_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_table_fill(s : MlclassifynaivebayesTable, v : Double) -> MlclassifynaivebayesTable {
  let result = ml_classify_naive_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_table_min(s : MlclassifynaivebayesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_table_max(s : MlclassifynaivebayesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_table_to_string(s : MlclassifynaivebayesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_graphn_make(size : Int) -> MlclassifynaivebayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_graphn_len(s : MlclassifynaivebayesGraphN) -> Int { s.size }

pub fn ml_classify_naive_bayes_graphn_get(s : MlclassifynaivebayesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_graphn_set(s : MlclassifynaivebayesGraphN, i : Int, v : Double) -> MlclassifynaivebayesGraphN {
  let result = ml_classify_naive_bayes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_graphn_sum(s : MlclassifynaivebayesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_graphn_mean(s : MlclassifynaivebayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_graphn_scale(s : MlclassifynaivebayesGraphN, f : Double) -> MlclassifynaivebayesGraphN {
  let result = ml_classify_naive_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_graphn_add(a : MlclassifynaivebayesGraphN, b : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_graphn_copy(s : MlclassifynaivebayesGraphN) -> MlclassifynaivebayesGraphN {
  let result = ml_classify_naive_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_graphn_fill(s : MlclassifynaivebayesGraphN, v : Double) -> MlclassifynaivebayesGraphN {
  let result = ml_classify_naive_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_graphn_min(s : MlclassifynaivebayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_graphn_max(s : MlclassifynaivebayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_graphn_to_string(s : MlclassifynaivebayesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_node_make(size : Int) -> MlclassifynaivebayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_node_len(s : MlclassifynaivebayesNode) -> Int { s.size }

pub fn ml_classify_naive_bayes_node_get(s : MlclassifynaivebayesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_node_set(s : MlclassifynaivebayesNode, i : Int, v : Double) -> MlclassifynaivebayesNode {
  let result = ml_classify_naive_bayes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_node_sum(s : MlclassifynaivebayesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_node_mean(s : MlclassifynaivebayesNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_node_scale(s : MlclassifynaivebayesNode, f : Double) -> MlclassifynaivebayesNode {
  let result = ml_classify_naive_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_node_add(a : MlclassifynaivebayesNode, b : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_node_copy(s : MlclassifynaivebayesNode) -> MlclassifynaivebayesNode {
  let result = ml_classify_naive_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_node_fill(s : MlclassifynaivebayesNode, v : Double) -> MlclassifynaivebayesNode {
  let result = ml_classify_naive_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_node_min(s : MlclassifynaivebayesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_node_max(s : MlclassifynaivebayesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_node_to_string(s : MlclassifynaivebayesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_edge_make(size : Int) -> MlclassifynaivebayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_edge_len(s : MlclassifynaivebayesEdge) -> Int { s.size }

pub fn ml_classify_naive_bayes_edge_get(s : MlclassifynaivebayesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_edge_set(s : MlclassifynaivebayesEdge, i : Int, v : Double) -> MlclassifynaivebayesEdge {
  let result = ml_classify_naive_bayes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_edge_sum(s : MlclassifynaivebayesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_edge_mean(s : MlclassifynaivebayesEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_edge_scale(s : MlclassifynaivebayesEdge, f : Double) -> MlclassifynaivebayesEdge {
  let result = ml_classify_naive_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_edge_add(a : MlclassifynaivebayesEdge, b : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_edge_copy(s : MlclassifynaivebayesEdge) -> MlclassifynaivebayesEdge {
  let result = ml_classify_naive_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_edge_fill(s : MlclassifynaivebayesEdge, v : Double) -> MlclassifynaivebayesEdge {
  let result = ml_classify_naive_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_edge_min(s : MlclassifynaivebayesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_edge_max(s : MlclassifynaivebayesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_edge_to_string(s : MlclassifynaivebayesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_path_make(size : Int) -> MlclassifynaivebayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_path_len(s : MlclassifynaivebayesPath) -> Int { s.size }

pub fn ml_classify_naive_bayes_path_get(s : MlclassifynaivebayesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_path_set(s : MlclassifynaivebayesPath, i : Int, v : Double) -> MlclassifynaivebayesPath {
  let result = ml_classify_naive_bayes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_path_sum(s : MlclassifynaivebayesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_path_mean(s : MlclassifynaivebayesPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_path_scale(s : MlclassifynaivebayesPath, f : Double) -> MlclassifynaivebayesPath {
  let result = ml_classify_naive_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_path_add(a : MlclassifynaivebayesPath, b : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_path_copy(s : MlclassifynaivebayesPath) -> MlclassifynaivebayesPath {
  let result = ml_classify_naive_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_path_fill(s : MlclassifynaivebayesPath, v : Double) -> MlclassifynaivebayesPath {
  let result = ml_classify_naive_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_path_min(s : MlclassifynaivebayesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_path_max(s : MlclassifynaivebayesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_path_to_string(s : MlclassifynaivebayesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cluster_make(size : Int) -> MlclassifynaivebayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_cluster_len(s : MlclassifynaivebayesCluster) -> Int { s.size }

pub fn ml_classify_naive_bayes_cluster_get(s : MlclassifynaivebayesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_cluster_set(s : MlclassifynaivebayesCluster, i : Int, v : Double) -> MlclassifynaivebayesCluster {
  let result = ml_classify_naive_bayes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_cluster_sum(s : MlclassifynaivebayesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_cluster_mean(s : MlclassifynaivebayesCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_cluster_scale(s : MlclassifynaivebayesCluster, f : Double) -> MlclassifynaivebayesCluster {
  let result = ml_classify_naive_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_cluster_add(a : MlclassifynaivebayesCluster, b : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_cluster_copy(s : MlclassifynaivebayesCluster) -> MlclassifynaivebayesCluster {
  let result = ml_classify_naive_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_cluster_fill(s : MlclassifynaivebayesCluster, v : Double) -> MlclassifynaivebayesCluster {
  let result = ml_classify_naive_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_cluster_min(s : MlclassifynaivebayesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_cluster_max(s : MlclassifynaivebayesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_cluster_to_string(s : MlclassifynaivebayesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_model_make(size : Int) -> MlclassifynaivebayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_model_len(s : MlclassifynaivebayesModel) -> Int { s.size }

pub fn ml_classify_naive_bayes_model_get(s : MlclassifynaivebayesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_model_set(s : MlclassifynaivebayesModel, i : Int, v : Double) -> MlclassifynaivebayesModel {
  let result = ml_classify_naive_bayes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_model_sum(s : MlclassifynaivebayesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_model_mean(s : MlclassifynaivebayesModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_model_scale(s : MlclassifynaivebayesModel, f : Double) -> MlclassifynaivebayesModel {
  let result = ml_classify_naive_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_model_add(a : MlclassifynaivebayesModel, b : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_model_copy(s : MlclassifynaivebayesModel) -> MlclassifynaivebayesModel {
  let result = ml_classify_naive_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_model_fill(s : MlclassifynaivebayesModel, v : Double) -> MlclassifynaivebayesModel {
  let result = ml_classify_naive_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_model_min(s : MlclassifynaivebayesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_model_max(s : MlclassifynaivebayesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_model_to_string(s : MlclassifynaivebayesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_layer_make(size : Int) -> MlclassifynaivebayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_layer_len(s : MlclassifynaivebayesLayer) -> Int { s.size }

pub fn ml_classify_naive_bayes_layer_get(s : MlclassifynaivebayesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_layer_set(s : MlclassifynaivebayesLayer, i : Int, v : Double) -> MlclassifynaivebayesLayer {
  let result = ml_classify_naive_bayes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_layer_sum(s : MlclassifynaivebayesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_layer_mean(s : MlclassifynaivebayesLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_layer_scale(s : MlclassifynaivebayesLayer, f : Double) -> MlclassifynaivebayesLayer {
  let result = ml_classify_naive_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_layer_add(a : MlclassifynaivebayesLayer, b : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_layer_copy(s : MlclassifynaivebayesLayer) -> MlclassifynaivebayesLayer {
  let result = ml_classify_naive_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_layer_fill(s : MlclassifynaivebayesLayer, v : Double) -> MlclassifynaivebayesLayer {
  let result = ml_classify_naive_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_layer_min(s : MlclassifynaivebayesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_layer_max(s : MlclassifynaivebayesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_layer_to_string(s : MlclassifynaivebayesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_buffer_make(size : Int) -> MlclassifynaivebayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_buffer_len(s : MlclassifynaivebayesBuffer) -> Int { s.size }

pub fn ml_classify_naive_bayes_buffer_get(s : MlclassifynaivebayesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_buffer_set(s : MlclassifynaivebayesBuffer, i : Int, v : Double) -> MlclassifynaivebayesBuffer {
  let result = ml_classify_naive_bayes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_buffer_sum(s : MlclassifynaivebayesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_buffer_mean(s : MlclassifynaivebayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_buffer_scale(s : MlclassifynaivebayesBuffer, f : Double) -> MlclassifynaivebayesBuffer {
  let result = ml_classify_naive_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_buffer_add(a : MlclassifynaivebayesBuffer, b : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_buffer_copy(s : MlclassifynaivebayesBuffer) -> MlclassifynaivebayesBuffer {
  let result = ml_classify_naive_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_buffer_fill(s : MlclassifynaivebayesBuffer, v : Double) -> MlclassifynaivebayesBuffer {
  let result = ml_classify_naive_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_buffer_min(s : MlclassifynaivebayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_buffer_max(s : MlclassifynaivebayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_buffer_to_string(s : MlclassifynaivebayesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_cursor_make(size : Int) -> MlclassifynaivebayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_cursor_len(s : MlclassifynaivebayesCursor) -> Int { s.size }

pub fn ml_classify_naive_bayes_cursor_get(s : MlclassifynaivebayesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_cursor_set(s : MlclassifynaivebayesCursor, i : Int, v : Double) -> MlclassifynaivebayesCursor {
  let result = ml_classify_naive_bayes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_cursor_sum(s : MlclassifynaivebayesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_cursor_mean(s : MlclassifynaivebayesCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_cursor_scale(s : MlclassifynaivebayesCursor, f : Double) -> MlclassifynaivebayesCursor {
  let result = ml_classify_naive_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_cursor_add(a : MlclassifynaivebayesCursor, b : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_cursor_copy(s : MlclassifynaivebayesCursor) -> MlclassifynaivebayesCursor {
  let result = ml_classify_naive_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_cursor_fill(s : MlclassifynaivebayesCursor, v : Double) -> MlclassifynaivebayesCursor {
  let result = ml_classify_naive_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_cursor_min(s : MlclassifynaivebayesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_cursor_max(s : MlclassifynaivebayesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_cursor_to_string(s : MlclassifynaivebayesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_view_make(size : Int) -> MlclassifynaivebayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_view_len(s : MlclassifynaivebayesView) -> Int { s.size }

pub fn ml_classify_naive_bayes_view_get(s : MlclassifynaivebayesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_view_set(s : MlclassifynaivebayesView, i : Int, v : Double) -> MlclassifynaivebayesView {
  let result = ml_classify_naive_bayes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_view_sum(s : MlclassifynaivebayesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_view_mean(s : MlclassifynaivebayesView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_view_scale(s : MlclassifynaivebayesView, f : Double) -> MlclassifynaivebayesView {
  let result = ml_classify_naive_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_view_add(a : MlclassifynaivebayesView, b : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_view_copy(s : MlclassifynaivebayesView) -> MlclassifynaivebayesView {
  let result = ml_classify_naive_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_view_fill(s : MlclassifynaivebayesView, v : Double) -> MlclassifynaivebayesView {
  let result = ml_classify_naive_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_view_min(s : MlclassifynaivebayesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_view_max(s : MlclassifynaivebayesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_view_to_string(s : MlclassifynaivebayesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_range_make(size : Int) -> MlclassifynaivebayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_range_len(s : MlclassifynaivebayesRange) -> Int { s.size }

pub fn ml_classify_naive_bayes_range_get(s : MlclassifynaivebayesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_range_set(s : MlclassifynaivebayesRange, i : Int, v : Double) -> MlclassifynaivebayesRange {
  let result = ml_classify_naive_bayes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_range_sum(s : MlclassifynaivebayesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_range_mean(s : MlclassifynaivebayesRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_range_scale(s : MlclassifynaivebayesRange, f : Double) -> MlclassifynaivebayesRange {
  let result = ml_classify_naive_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_range_add(a : MlclassifynaivebayesRange, b : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_range_copy(s : MlclassifynaivebayesRange) -> MlclassifynaivebayesRange {
  let result = ml_classify_naive_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_range_fill(s : MlclassifynaivebayesRange, v : Double) -> MlclassifynaivebayesRange {
  let result = ml_classify_naive_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_range_min(s : MlclassifynaivebayesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_range_max(s : MlclassifynaivebayesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_range_to_string(s : MlclassifynaivebayesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifynaivebayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_naive_bayes_slice_make(size : Int) -> MlclassifynaivebayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_naive_bayes_slice_len(s : MlclassifynaivebayesSlice) -> Int { s.size }

pub fn ml_classify_naive_bayes_slice_get(s : MlclassifynaivebayesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_naive_bayes_slice_set(s : MlclassifynaivebayesSlice, i : Int, v : Double) -> MlclassifynaivebayesSlice {
  let result = ml_classify_naive_bayes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_slice_sum(s : MlclassifynaivebayesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_naive_bayes_slice_mean(s : MlclassifynaivebayesSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_naive_bayes_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_naive_bayes_slice_scale(s : MlclassifynaivebayesSlice, f : Double) -> MlclassifynaivebayesSlice {
  let result = ml_classify_naive_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_naive_bayes_slice_add(a : MlclassifynaivebayesSlice, b : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_naive_bayes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_naive_bayes_slice_copy(s : MlclassifynaivebayesSlice) -> MlclassifynaivebayesSlice {
  let result = ml_classify_naive_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_naive_bayes_slice_fill(s : MlclassifynaivebayesSlice, v : Double) -> MlclassifynaivebayesSlice {
  let result = ml_classify_naive_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_naive_bayes_slice_min(s : MlclassifynaivebayesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_slice_max(s : MlclassifynaivebayesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_naive_bayes_slice_to_string(s : MlclassifynaivebayesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/ml_classify_perceptron

pub(all) struct MlclassifyperceptronPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_perceptron_make_point(x : Double, y : Double) -> MlclassifyperceptronPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_perceptron_make_point3(x : Double, y : Double, z : Double) -> MlclassifyperceptronPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_perceptron_point_x(pt : MlclassifyperceptronPoint) -> Double { pt.x }

pub fn ml_classify_perceptron_point_y(pt : MlclassifyperceptronPoint) -> Double { pt.y }

pub fn ml_classify_perceptron_point_z(pt : MlclassifyperceptronPoint) -> Double { pt.z }

pub fn ml_classify_perceptron_point_label(pt : MlclassifyperceptronPoint) -> Int { pt.label }

pub fn ml_classify_perceptron_point_dist(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_perceptron_point_add(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_perceptron_point_sub(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_perceptron_point_scale(pt : MlclassifyperceptronPoint, s : Double) -> MlclassifyperceptronPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_perceptron_point_dot(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_perceptron_point_cross(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_perceptron_point_norm(pt : MlclassifyperceptronPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_perceptron_point_normalize(pt : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  let n = ml_classify_perceptron_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_perceptron_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_perceptron_point_negate(pt : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_perceptron_point_mid(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint) -> MlclassifyperceptronPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_perceptron_point_lerp(a : MlclassifyperceptronPoint, b : MlclassifyperceptronPoint, t : Double) -> MlclassifyperceptronPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_perceptron_point_to_string(pt : MlclassifyperceptronPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_perceptron_make_series(vals : Array[Double], name : String) -> MlclassifyperceptronSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_perceptron_series_len(s : MlclassifyperceptronSeries) -> Int { s.vals.length() }

pub fn ml_classify_perceptron_series_sum(s : MlclassifyperceptronSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_perceptron_series_mean(s : MlclassifyperceptronSeries) -> Double {
  let n = ml_classify_perceptron_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_perceptron_series_sum(s) / n.to_double() }
}

pub fn ml_classify_perceptron_series_min(s : MlclassifyperceptronSeries) -> Double {
  let n = ml_classify_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_perceptron_series_max(s : MlclassifyperceptronSeries) -> Double {
  let n = ml_classify_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_perceptron_series_range(s : MlclassifyperceptronSeries) -> Double {
  ml_classify_perceptron_series_max(s) - ml_classify_perceptron_series_min(s)
}

pub fn ml_classify_perceptron_series_var(s : MlclassifyperceptronSeries) -> Double {
  let n = ml_classify_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_perceptron_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_perceptron_series_std(s : MlclassifyperceptronSeries) -> Double { @_common.sqrt(ml_classify_perceptron_series_var(s)) }

pub fn ml_classify_perceptron_series_median(s : MlclassifyperceptronSeries) -> Double {
  let n = ml_classify_perceptron_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_perceptron_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_perceptron_series_scale(s : MlclassifyperceptronSeries, f : Double) -> MlclassifyperceptronSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_perceptron_series_add(a : MlclassifyperceptronSeries, b : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_perceptron_series_sub(a : MlclassifyperceptronSeries, b : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_perceptron_series_normalize(s : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let mn = ml_classify_perceptron_series_min(s)
  let mx = ml_classify_perceptron_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_perceptron_series_cumsum(s : MlclassifyperceptronSeries) -> MlclassifyperceptronSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_perceptron_series_to_string(s : MlclassifyperceptronSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyperceptronMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_perceptron_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyperceptronMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_perceptron_matrix_identity(n : Int) -> MlclassifyperceptronMatrix {
  let m = ml_classify_perceptron_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_perceptron_matrix_get(m : MlclassifyperceptronMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_perceptron_matrix_transpose(m : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_perceptron_matrix_add(a : MlclassifyperceptronMatrix, b : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_perceptron_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_perceptron_matrix_scale(m : MlclassifyperceptronMatrix, s : Double) -> MlclassifyperceptronMatrix {
  let result = ml_classify_perceptron_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_perceptron_matrix_multiply(a : MlclassifyperceptronMatrix, b : MlclassifyperceptronMatrix) -> MlclassifyperceptronMatrix {
  if a.cols != b.rows { return ml_classify_perceptron_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_perceptron_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_perceptron_matrix_trace(m : MlclassifyperceptronMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_perceptron_matrix_det(m : MlclassifyperceptronMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_perceptron_matrix_norm(m : MlclassifyperceptronMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_perceptron_matrix_to_string(m : MlclassifyperceptronMatrix) -> String {
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

pub(all) struct MlclassifyperceptronVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_perceptron_make_vector(comps : Array[Double]) -> MlclassifyperceptronVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_perceptron_vector_zero(dim : Int) -> MlclassifyperceptronVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_perceptron_vector_add(a : MlclassifyperceptronVector, b : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_perceptron_vector_sub(a : MlclassifyperceptronVector, b : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_perceptron_vector_scale(v : MlclassifyperceptronVector, s : Double) -> MlclassifyperceptronVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_perceptron_vector_dot(a : MlclassifyperceptronVector, b : MlclassifyperceptronVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_perceptron_vector_norm(v : MlclassifyperceptronVector) -> Double { @_common.sqrt(ml_classify_perceptron_vector_dot(v, v)) }

pub fn ml_classify_perceptron_vector_normalize(v : MlclassifyperceptronVector) -> MlclassifyperceptronVector {
  let n = ml_classify_perceptron_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_perceptron_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_perceptron_vector_dist(a : MlclassifyperceptronVector, b : MlclassifyperceptronVector) -> Double {
  ml_classify_perceptron_vector_norm(ml_classify_perceptron_vector_sub(a, b))
}

pub fn ml_classify_perceptron_vector_to_string(v : MlclassifyperceptronVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_perceptron_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_perceptron_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_perceptron_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_perceptron_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_perceptron_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_perceptron_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_perceptron_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_perceptron_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_perceptron_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_perceptron_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_perceptron_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_perceptron_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_perceptron_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_perceptron_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_perceptron_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_perceptron_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_perceptron_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_perceptron_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_perceptron_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_perceptron_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_perceptron_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_perceptron_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_perceptron_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_perceptron_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_perceptron_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_perceptron_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_perceptron_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_perceptron_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_perceptron_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyperceptronFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_frame_make(size : Int) -> MlclassifyperceptronFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_frame_len(s : MlclassifyperceptronFrame) -> Int { s.size }

pub fn ml_classify_perceptron_frame_get(s : MlclassifyperceptronFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_frame_set(s : MlclassifyperceptronFrame, i : Int, v : Double) -> MlclassifyperceptronFrame {
  let result = ml_classify_perceptron_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_frame_sum(s : MlclassifyperceptronFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_frame_mean(s : MlclassifyperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_frame_scale(s : MlclassifyperceptronFrame, f : Double) -> MlclassifyperceptronFrame {
  let result = ml_classify_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_frame_add(a : MlclassifyperceptronFrame, b : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_frame_copy(s : MlclassifyperceptronFrame) -> MlclassifyperceptronFrame {
  let result = ml_classify_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_frame_fill(s : MlclassifyperceptronFrame, v : Double) -> MlclassifyperceptronFrame {
  let result = ml_classify_perceptron_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_frame_min(s : MlclassifyperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_frame_max(s : MlclassifyperceptronFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_frame_to_string(s : MlclassifyperceptronFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_table_make(size : Int) -> MlclassifyperceptronTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_table_len(s : MlclassifyperceptronTable) -> Int { s.size }

pub fn ml_classify_perceptron_table_get(s : MlclassifyperceptronTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_table_set(s : MlclassifyperceptronTable, i : Int, v : Double) -> MlclassifyperceptronTable {
  let result = ml_classify_perceptron_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_table_sum(s : MlclassifyperceptronTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_table_mean(s : MlclassifyperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_table_scale(s : MlclassifyperceptronTable, f : Double) -> MlclassifyperceptronTable {
  let result = ml_classify_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_table_add(a : MlclassifyperceptronTable, b : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_table_copy(s : MlclassifyperceptronTable) -> MlclassifyperceptronTable {
  let result = ml_classify_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_table_fill(s : MlclassifyperceptronTable, v : Double) -> MlclassifyperceptronTable {
  let result = ml_classify_perceptron_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_table_min(s : MlclassifyperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_table_max(s : MlclassifyperceptronTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_table_to_string(s : MlclassifyperceptronTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_graphn_make(size : Int) -> MlclassifyperceptronGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_graphn_len(s : MlclassifyperceptronGraphN) -> Int { s.size }

pub fn ml_classify_perceptron_graphn_get(s : MlclassifyperceptronGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_graphn_set(s : MlclassifyperceptronGraphN, i : Int, v : Double) -> MlclassifyperceptronGraphN {
  let result = ml_classify_perceptron_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_graphn_sum(s : MlclassifyperceptronGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_graphn_mean(s : MlclassifyperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_graphn_scale(s : MlclassifyperceptronGraphN, f : Double) -> MlclassifyperceptronGraphN {
  let result = ml_classify_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_graphn_add(a : MlclassifyperceptronGraphN, b : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_graphn_copy(s : MlclassifyperceptronGraphN) -> MlclassifyperceptronGraphN {
  let result = ml_classify_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_graphn_fill(s : MlclassifyperceptronGraphN, v : Double) -> MlclassifyperceptronGraphN {
  let result = ml_classify_perceptron_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_graphn_min(s : MlclassifyperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_graphn_max(s : MlclassifyperceptronGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_graphn_to_string(s : MlclassifyperceptronGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_node_make(size : Int) -> MlclassifyperceptronNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_node_len(s : MlclassifyperceptronNode) -> Int { s.size }

pub fn ml_classify_perceptron_node_get(s : MlclassifyperceptronNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_node_set(s : MlclassifyperceptronNode, i : Int, v : Double) -> MlclassifyperceptronNode {
  let result = ml_classify_perceptron_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_node_sum(s : MlclassifyperceptronNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_node_mean(s : MlclassifyperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_node_scale(s : MlclassifyperceptronNode, f : Double) -> MlclassifyperceptronNode {
  let result = ml_classify_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_node_add(a : MlclassifyperceptronNode, b : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_node_copy(s : MlclassifyperceptronNode) -> MlclassifyperceptronNode {
  let result = ml_classify_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_node_fill(s : MlclassifyperceptronNode, v : Double) -> MlclassifyperceptronNode {
  let result = ml_classify_perceptron_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_node_min(s : MlclassifyperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_node_max(s : MlclassifyperceptronNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_node_to_string(s : MlclassifyperceptronNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_edge_make(size : Int) -> MlclassifyperceptronEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_edge_len(s : MlclassifyperceptronEdge) -> Int { s.size }

pub fn ml_classify_perceptron_edge_get(s : MlclassifyperceptronEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_edge_set(s : MlclassifyperceptronEdge, i : Int, v : Double) -> MlclassifyperceptronEdge {
  let result = ml_classify_perceptron_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_edge_sum(s : MlclassifyperceptronEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_edge_mean(s : MlclassifyperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_edge_scale(s : MlclassifyperceptronEdge, f : Double) -> MlclassifyperceptronEdge {
  let result = ml_classify_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_edge_add(a : MlclassifyperceptronEdge, b : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_edge_copy(s : MlclassifyperceptronEdge) -> MlclassifyperceptronEdge {
  let result = ml_classify_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_edge_fill(s : MlclassifyperceptronEdge, v : Double) -> MlclassifyperceptronEdge {
  let result = ml_classify_perceptron_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_edge_min(s : MlclassifyperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_edge_max(s : MlclassifyperceptronEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_edge_to_string(s : MlclassifyperceptronEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_path_make(size : Int) -> MlclassifyperceptronPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_path_len(s : MlclassifyperceptronPath) -> Int { s.size }

pub fn ml_classify_perceptron_path_get(s : MlclassifyperceptronPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_path_set(s : MlclassifyperceptronPath, i : Int, v : Double) -> MlclassifyperceptronPath {
  let result = ml_classify_perceptron_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_path_sum(s : MlclassifyperceptronPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_path_mean(s : MlclassifyperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_path_scale(s : MlclassifyperceptronPath, f : Double) -> MlclassifyperceptronPath {
  let result = ml_classify_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_path_add(a : MlclassifyperceptronPath, b : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_path_copy(s : MlclassifyperceptronPath) -> MlclassifyperceptronPath {
  let result = ml_classify_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_path_fill(s : MlclassifyperceptronPath, v : Double) -> MlclassifyperceptronPath {
  let result = ml_classify_perceptron_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_path_min(s : MlclassifyperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_path_max(s : MlclassifyperceptronPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_path_to_string(s : MlclassifyperceptronPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cluster_make(size : Int) -> MlclassifyperceptronCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_cluster_len(s : MlclassifyperceptronCluster) -> Int { s.size }

pub fn ml_classify_perceptron_cluster_get(s : MlclassifyperceptronCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_cluster_set(s : MlclassifyperceptronCluster, i : Int, v : Double) -> MlclassifyperceptronCluster {
  let result = ml_classify_perceptron_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_cluster_sum(s : MlclassifyperceptronCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_cluster_mean(s : MlclassifyperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_cluster_scale(s : MlclassifyperceptronCluster, f : Double) -> MlclassifyperceptronCluster {
  let result = ml_classify_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_cluster_add(a : MlclassifyperceptronCluster, b : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_cluster_copy(s : MlclassifyperceptronCluster) -> MlclassifyperceptronCluster {
  let result = ml_classify_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_cluster_fill(s : MlclassifyperceptronCluster, v : Double) -> MlclassifyperceptronCluster {
  let result = ml_classify_perceptron_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_cluster_min(s : MlclassifyperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_cluster_max(s : MlclassifyperceptronCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_cluster_to_string(s : MlclassifyperceptronCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_model_make(size : Int) -> MlclassifyperceptronModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_model_len(s : MlclassifyperceptronModel) -> Int { s.size }

pub fn ml_classify_perceptron_model_get(s : MlclassifyperceptronModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_model_set(s : MlclassifyperceptronModel, i : Int, v : Double) -> MlclassifyperceptronModel {
  let result = ml_classify_perceptron_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_model_sum(s : MlclassifyperceptronModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_model_mean(s : MlclassifyperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_model_scale(s : MlclassifyperceptronModel, f : Double) -> MlclassifyperceptronModel {
  let result = ml_classify_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_model_add(a : MlclassifyperceptronModel, b : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_model_copy(s : MlclassifyperceptronModel) -> MlclassifyperceptronModel {
  let result = ml_classify_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_model_fill(s : MlclassifyperceptronModel, v : Double) -> MlclassifyperceptronModel {
  let result = ml_classify_perceptron_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_model_min(s : MlclassifyperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_model_max(s : MlclassifyperceptronModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_model_to_string(s : MlclassifyperceptronModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_layer_make(size : Int) -> MlclassifyperceptronLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_layer_len(s : MlclassifyperceptronLayer) -> Int { s.size }

pub fn ml_classify_perceptron_layer_get(s : MlclassifyperceptronLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_layer_set(s : MlclassifyperceptronLayer, i : Int, v : Double) -> MlclassifyperceptronLayer {
  let result = ml_classify_perceptron_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_layer_sum(s : MlclassifyperceptronLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_layer_mean(s : MlclassifyperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_layer_scale(s : MlclassifyperceptronLayer, f : Double) -> MlclassifyperceptronLayer {
  let result = ml_classify_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_layer_add(a : MlclassifyperceptronLayer, b : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_layer_copy(s : MlclassifyperceptronLayer) -> MlclassifyperceptronLayer {
  let result = ml_classify_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_layer_fill(s : MlclassifyperceptronLayer, v : Double) -> MlclassifyperceptronLayer {
  let result = ml_classify_perceptron_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_layer_min(s : MlclassifyperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_layer_max(s : MlclassifyperceptronLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_layer_to_string(s : MlclassifyperceptronLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_buffer_make(size : Int) -> MlclassifyperceptronBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_buffer_len(s : MlclassifyperceptronBuffer) -> Int { s.size }

pub fn ml_classify_perceptron_buffer_get(s : MlclassifyperceptronBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_buffer_set(s : MlclassifyperceptronBuffer, i : Int, v : Double) -> MlclassifyperceptronBuffer {
  let result = ml_classify_perceptron_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_buffer_sum(s : MlclassifyperceptronBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_buffer_mean(s : MlclassifyperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_buffer_scale(s : MlclassifyperceptronBuffer, f : Double) -> MlclassifyperceptronBuffer {
  let result = ml_classify_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_buffer_add(a : MlclassifyperceptronBuffer, b : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_buffer_copy(s : MlclassifyperceptronBuffer) -> MlclassifyperceptronBuffer {
  let result = ml_classify_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_buffer_fill(s : MlclassifyperceptronBuffer, v : Double) -> MlclassifyperceptronBuffer {
  let result = ml_classify_perceptron_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_buffer_min(s : MlclassifyperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_buffer_max(s : MlclassifyperceptronBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_buffer_to_string(s : MlclassifyperceptronBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_cursor_make(size : Int) -> MlclassifyperceptronCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_cursor_len(s : MlclassifyperceptronCursor) -> Int { s.size }

pub fn ml_classify_perceptron_cursor_get(s : MlclassifyperceptronCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_cursor_set(s : MlclassifyperceptronCursor, i : Int, v : Double) -> MlclassifyperceptronCursor {
  let result = ml_classify_perceptron_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_cursor_sum(s : MlclassifyperceptronCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_cursor_mean(s : MlclassifyperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_cursor_scale(s : MlclassifyperceptronCursor, f : Double) -> MlclassifyperceptronCursor {
  let result = ml_classify_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_cursor_add(a : MlclassifyperceptronCursor, b : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_cursor_copy(s : MlclassifyperceptronCursor) -> MlclassifyperceptronCursor {
  let result = ml_classify_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_cursor_fill(s : MlclassifyperceptronCursor, v : Double) -> MlclassifyperceptronCursor {
  let result = ml_classify_perceptron_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_cursor_min(s : MlclassifyperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_cursor_max(s : MlclassifyperceptronCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_cursor_to_string(s : MlclassifyperceptronCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_view_make(size : Int) -> MlclassifyperceptronView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_view_len(s : MlclassifyperceptronView) -> Int { s.size }

pub fn ml_classify_perceptron_view_get(s : MlclassifyperceptronView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_view_set(s : MlclassifyperceptronView, i : Int, v : Double) -> MlclassifyperceptronView {
  let result = ml_classify_perceptron_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_view_sum(s : MlclassifyperceptronView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_view_mean(s : MlclassifyperceptronView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_view_scale(s : MlclassifyperceptronView, f : Double) -> MlclassifyperceptronView {
  let result = ml_classify_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_view_add(a : MlclassifyperceptronView, b : MlclassifyperceptronView) -> MlclassifyperceptronView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_view_copy(s : MlclassifyperceptronView) -> MlclassifyperceptronView {
  let result = ml_classify_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_view_fill(s : MlclassifyperceptronView, v : Double) -> MlclassifyperceptronView {
  let result = ml_classify_perceptron_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_view_min(s : MlclassifyperceptronView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_view_max(s : MlclassifyperceptronView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_view_to_string(s : MlclassifyperceptronView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_range_make(size : Int) -> MlclassifyperceptronRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_range_len(s : MlclassifyperceptronRange) -> Int { s.size }

pub fn ml_classify_perceptron_range_get(s : MlclassifyperceptronRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_range_set(s : MlclassifyperceptronRange, i : Int, v : Double) -> MlclassifyperceptronRange {
  let result = ml_classify_perceptron_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_range_sum(s : MlclassifyperceptronRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_range_mean(s : MlclassifyperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_range_scale(s : MlclassifyperceptronRange, f : Double) -> MlclassifyperceptronRange {
  let result = ml_classify_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_range_add(a : MlclassifyperceptronRange, b : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_range_copy(s : MlclassifyperceptronRange) -> MlclassifyperceptronRange {
  let result = ml_classify_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_range_fill(s : MlclassifyperceptronRange, v : Double) -> MlclassifyperceptronRange {
  let result = ml_classify_perceptron_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_range_min(s : MlclassifyperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_range_max(s : MlclassifyperceptronRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_range_to_string(s : MlclassifyperceptronRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyperceptronSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_perceptron_slice_make(size : Int) -> MlclassifyperceptronSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_perceptron_slice_len(s : MlclassifyperceptronSlice) -> Int { s.size }

pub fn ml_classify_perceptron_slice_get(s : MlclassifyperceptronSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_perceptron_slice_set(s : MlclassifyperceptronSlice, i : Int, v : Double) -> MlclassifyperceptronSlice {
  let result = ml_classify_perceptron_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_slice_sum(s : MlclassifyperceptronSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_perceptron_slice_mean(s : MlclassifyperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_perceptron_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_perceptron_slice_scale(s : MlclassifyperceptronSlice, f : Double) -> MlclassifyperceptronSlice {
  let result = ml_classify_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_perceptron_slice_add(a : MlclassifyperceptronSlice, b : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_perceptron_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_perceptron_slice_copy(s : MlclassifyperceptronSlice) -> MlclassifyperceptronSlice {
  let result = ml_classify_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_perceptron_slice_fill(s : MlclassifyperceptronSlice, v : Double) -> MlclassifyperceptronSlice {
  let result = ml_classify_perceptron_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_perceptron_slice_min(s : MlclassifyperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_slice_max(s : MlclassifyperceptronSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_perceptron_slice_to_string(s : MlclassifyperceptronSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


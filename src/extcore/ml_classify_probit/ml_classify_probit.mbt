///===
/// extcore/ml_classify_probit

pub(all) struct MlclassifyprobitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_probit_make_point(x : Double, y : Double) -> MlclassifyprobitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_probit_make_point3(x : Double, y : Double, z : Double) -> MlclassifyprobitPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_probit_point_x(pt : MlclassifyprobitPoint) -> Double { pt.x }

pub fn ml_classify_probit_point_y(pt : MlclassifyprobitPoint) -> Double { pt.y }

pub fn ml_classify_probit_point_z(pt : MlclassifyprobitPoint) -> Double { pt.z }

pub fn ml_classify_probit_point_label(pt : MlclassifyprobitPoint) -> Int { pt.label }

pub fn ml_classify_probit_point_dist(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_probit_point_add(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_probit_point_sub(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_probit_point_scale(pt : MlclassifyprobitPoint, s : Double) -> MlclassifyprobitPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_probit_point_dot(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_probit_point_cross(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_probit_point_norm(pt : MlclassifyprobitPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_probit_point_normalize(pt : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  let n = ml_classify_probit_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_probit_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_probit_point_negate(pt : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_probit_point_mid(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint) -> MlclassifyprobitPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_probit_point_lerp(a : MlclassifyprobitPoint, b : MlclassifyprobitPoint, t : Double) -> MlclassifyprobitPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_probit_point_to_string(pt : MlclassifyprobitPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyprobitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_probit_make_series(vals : Array[Double], name : String) -> MlclassifyprobitSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_probit_series_len(s : MlclassifyprobitSeries) -> Int { s.vals.length() }

pub fn ml_classify_probit_series_sum(s : MlclassifyprobitSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_probit_series_mean(s : MlclassifyprobitSeries) -> Double {
  let n = ml_classify_probit_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_probit_series_sum(s) / n.to_double() }
}

pub fn ml_classify_probit_series_min(s : MlclassifyprobitSeries) -> Double {
  let n = ml_classify_probit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_probit_series_max(s : MlclassifyprobitSeries) -> Double {
  let n = ml_classify_probit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_probit_series_range(s : MlclassifyprobitSeries) -> Double {
  ml_classify_probit_series_max(s) - ml_classify_probit_series_min(s)
}

pub fn ml_classify_probit_series_var(s : MlclassifyprobitSeries) -> Double {
  let n = ml_classify_probit_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_probit_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_probit_series_std(s : MlclassifyprobitSeries) -> Double { @_common.sqrt(ml_classify_probit_series_var(s)) }

pub fn ml_classify_probit_series_median(s : MlclassifyprobitSeries) -> Double {
  let n = ml_classify_probit_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_probit_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_probit_series_scale(s : MlclassifyprobitSeries, f : Double) -> MlclassifyprobitSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_probit_series_add(a : MlclassifyprobitSeries, b : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_probit_series_sub(a : MlclassifyprobitSeries, b : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_probit_series_normalize(s : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let mn = ml_classify_probit_series_min(s)
  let mx = ml_classify_probit_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_probit_series_cumsum(s : MlclassifyprobitSeries) -> MlclassifyprobitSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_probit_series_to_string(s : MlclassifyprobitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyprobitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_probit_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyprobitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_probit_matrix_identity(n : Int) -> MlclassifyprobitMatrix {
  let m = ml_classify_probit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_probit_matrix_get(m : MlclassifyprobitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_probit_matrix_transpose(m : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_probit_matrix_add(a : MlclassifyprobitMatrix, b : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_probit_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_probit_matrix_scale(m : MlclassifyprobitMatrix, s : Double) -> MlclassifyprobitMatrix {
  let result = ml_classify_probit_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_probit_matrix_multiply(a : MlclassifyprobitMatrix, b : MlclassifyprobitMatrix) -> MlclassifyprobitMatrix {
  if a.cols != b.rows { return ml_classify_probit_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_probit_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_probit_matrix_trace(m : MlclassifyprobitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_probit_matrix_det(m : MlclassifyprobitMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_probit_matrix_norm(m : MlclassifyprobitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_probit_matrix_to_string(m : MlclassifyprobitMatrix) -> String {
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

pub(all) struct MlclassifyprobitVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_probit_make_vector(comps : Array[Double]) -> MlclassifyprobitVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_probit_vector_zero(dim : Int) -> MlclassifyprobitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_probit_vector_add(a : MlclassifyprobitVector, b : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_probit_vector_sub(a : MlclassifyprobitVector, b : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_probit_vector_scale(v : MlclassifyprobitVector, s : Double) -> MlclassifyprobitVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_probit_vector_dot(a : MlclassifyprobitVector, b : MlclassifyprobitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_probit_vector_norm(v : MlclassifyprobitVector) -> Double { @_common.sqrt(ml_classify_probit_vector_dot(v, v)) }

pub fn ml_classify_probit_vector_normalize(v : MlclassifyprobitVector) -> MlclassifyprobitVector {
  let n = ml_classify_probit_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_probit_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_probit_vector_dist(a : MlclassifyprobitVector, b : MlclassifyprobitVector) -> Double {
  ml_classify_probit_vector_norm(ml_classify_probit_vector_sub(a, b))
}

pub fn ml_classify_probit_vector_to_string(v : MlclassifyprobitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_probit_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_probit_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_probit_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_probit_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_probit_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_probit_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_probit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_probit_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_probit_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_probit_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_probit_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_probit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_probit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_probit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_probit_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_probit_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_probit_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_probit_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_probit_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_probit_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_probit_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_probit_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_probit_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_probit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_probit_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_probit_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_probit_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_probit_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_probit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyprobitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_frame_make(size : Int) -> MlclassifyprobitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_frame_len(s : MlclassifyprobitFrame) -> Int { s.size }

pub fn ml_classify_probit_frame_get(s : MlclassifyprobitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_frame_set(s : MlclassifyprobitFrame, i : Int, v : Double) -> MlclassifyprobitFrame {
  let result = ml_classify_probit_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_frame_sum(s : MlclassifyprobitFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_frame_mean(s : MlclassifyprobitFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_frame_scale(s : MlclassifyprobitFrame, f : Double) -> MlclassifyprobitFrame {
  let result = ml_classify_probit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_frame_add(a : MlclassifyprobitFrame, b : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_frame_copy(s : MlclassifyprobitFrame) -> MlclassifyprobitFrame {
  let result = ml_classify_probit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_frame_fill(s : MlclassifyprobitFrame, v : Double) -> MlclassifyprobitFrame {
  let result = ml_classify_probit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_frame_min(s : MlclassifyprobitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_frame_max(s : MlclassifyprobitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_frame_to_string(s : MlclassifyprobitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_table_make(size : Int) -> MlclassifyprobitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_table_len(s : MlclassifyprobitTable) -> Int { s.size }

pub fn ml_classify_probit_table_get(s : MlclassifyprobitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_table_set(s : MlclassifyprobitTable, i : Int, v : Double) -> MlclassifyprobitTable {
  let result = ml_classify_probit_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_table_sum(s : MlclassifyprobitTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_table_mean(s : MlclassifyprobitTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_table_scale(s : MlclassifyprobitTable, f : Double) -> MlclassifyprobitTable {
  let result = ml_classify_probit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_table_add(a : MlclassifyprobitTable, b : MlclassifyprobitTable) -> MlclassifyprobitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_table_copy(s : MlclassifyprobitTable) -> MlclassifyprobitTable {
  let result = ml_classify_probit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_table_fill(s : MlclassifyprobitTable, v : Double) -> MlclassifyprobitTable {
  let result = ml_classify_probit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_table_min(s : MlclassifyprobitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_table_max(s : MlclassifyprobitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_table_to_string(s : MlclassifyprobitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_graphn_make(size : Int) -> MlclassifyprobitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_graphn_len(s : MlclassifyprobitGraphN) -> Int { s.size }

pub fn ml_classify_probit_graphn_get(s : MlclassifyprobitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_graphn_set(s : MlclassifyprobitGraphN, i : Int, v : Double) -> MlclassifyprobitGraphN {
  let result = ml_classify_probit_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_graphn_sum(s : MlclassifyprobitGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_graphn_mean(s : MlclassifyprobitGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_graphn_scale(s : MlclassifyprobitGraphN, f : Double) -> MlclassifyprobitGraphN {
  let result = ml_classify_probit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_graphn_add(a : MlclassifyprobitGraphN, b : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_graphn_copy(s : MlclassifyprobitGraphN) -> MlclassifyprobitGraphN {
  let result = ml_classify_probit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_graphn_fill(s : MlclassifyprobitGraphN, v : Double) -> MlclassifyprobitGraphN {
  let result = ml_classify_probit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_graphn_min(s : MlclassifyprobitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_graphn_max(s : MlclassifyprobitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_graphn_to_string(s : MlclassifyprobitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_node_make(size : Int) -> MlclassifyprobitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_node_len(s : MlclassifyprobitNode) -> Int { s.size }

pub fn ml_classify_probit_node_get(s : MlclassifyprobitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_node_set(s : MlclassifyprobitNode, i : Int, v : Double) -> MlclassifyprobitNode {
  let result = ml_classify_probit_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_node_sum(s : MlclassifyprobitNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_node_mean(s : MlclassifyprobitNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_node_scale(s : MlclassifyprobitNode, f : Double) -> MlclassifyprobitNode {
  let result = ml_classify_probit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_node_add(a : MlclassifyprobitNode, b : MlclassifyprobitNode) -> MlclassifyprobitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_node_copy(s : MlclassifyprobitNode) -> MlclassifyprobitNode {
  let result = ml_classify_probit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_node_fill(s : MlclassifyprobitNode, v : Double) -> MlclassifyprobitNode {
  let result = ml_classify_probit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_node_min(s : MlclassifyprobitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_node_max(s : MlclassifyprobitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_node_to_string(s : MlclassifyprobitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_edge_make(size : Int) -> MlclassifyprobitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_edge_len(s : MlclassifyprobitEdge) -> Int { s.size }

pub fn ml_classify_probit_edge_get(s : MlclassifyprobitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_edge_set(s : MlclassifyprobitEdge, i : Int, v : Double) -> MlclassifyprobitEdge {
  let result = ml_classify_probit_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_edge_sum(s : MlclassifyprobitEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_edge_mean(s : MlclassifyprobitEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_edge_scale(s : MlclassifyprobitEdge, f : Double) -> MlclassifyprobitEdge {
  let result = ml_classify_probit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_edge_add(a : MlclassifyprobitEdge, b : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_edge_copy(s : MlclassifyprobitEdge) -> MlclassifyprobitEdge {
  let result = ml_classify_probit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_edge_fill(s : MlclassifyprobitEdge, v : Double) -> MlclassifyprobitEdge {
  let result = ml_classify_probit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_edge_min(s : MlclassifyprobitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_edge_max(s : MlclassifyprobitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_edge_to_string(s : MlclassifyprobitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_path_make(size : Int) -> MlclassifyprobitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_path_len(s : MlclassifyprobitPath) -> Int { s.size }

pub fn ml_classify_probit_path_get(s : MlclassifyprobitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_path_set(s : MlclassifyprobitPath, i : Int, v : Double) -> MlclassifyprobitPath {
  let result = ml_classify_probit_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_path_sum(s : MlclassifyprobitPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_path_mean(s : MlclassifyprobitPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_path_scale(s : MlclassifyprobitPath, f : Double) -> MlclassifyprobitPath {
  let result = ml_classify_probit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_path_add(a : MlclassifyprobitPath, b : MlclassifyprobitPath) -> MlclassifyprobitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_path_copy(s : MlclassifyprobitPath) -> MlclassifyprobitPath {
  let result = ml_classify_probit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_path_fill(s : MlclassifyprobitPath, v : Double) -> MlclassifyprobitPath {
  let result = ml_classify_probit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_path_min(s : MlclassifyprobitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_path_max(s : MlclassifyprobitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_path_to_string(s : MlclassifyprobitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cluster_make(size : Int) -> MlclassifyprobitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_cluster_len(s : MlclassifyprobitCluster) -> Int { s.size }

pub fn ml_classify_probit_cluster_get(s : MlclassifyprobitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_cluster_set(s : MlclassifyprobitCluster, i : Int, v : Double) -> MlclassifyprobitCluster {
  let result = ml_classify_probit_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_cluster_sum(s : MlclassifyprobitCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_cluster_mean(s : MlclassifyprobitCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_cluster_scale(s : MlclassifyprobitCluster, f : Double) -> MlclassifyprobitCluster {
  let result = ml_classify_probit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_cluster_add(a : MlclassifyprobitCluster, b : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_cluster_copy(s : MlclassifyprobitCluster) -> MlclassifyprobitCluster {
  let result = ml_classify_probit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_cluster_fill(s : MlclassifyprobitCluster, v : Double) -> MlclassifyprobitCluster {
  let result = ml_classify_probit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_cluster_min(s : MlclassifyprobitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_cluster_max(s : MlclassifyprobitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_cluster_to_string(s : MlclassifyprobitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_model_make(size : Int) -> MlclassifyprobitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_model_len(s : MlclassifyprobitModel) -> Int { s.size }

pub fn ml_classify_probit_model_get(s : MlclassifyprobitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_model_set(s : MlclassifyprobitModel, i : Int, v : Double) -> MlclassifyprobitModel {
  let result = ml_classify_probit_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_model_sum(s : MlclassifyprobitModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_model_mean(s : MlclassifyprobitModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_model_scale(s : MlclassifyprobitModel, f : Double) -> MlclassifyprobitModel {
  let result = ml_classify_probit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_model_add(a : MlclassifyprobitModel, b : MlclassifyprobitModel) -> MlclassifyprobitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_model_copy(s : MlclassifyprobitModel) -> MlclassifyprobitModel {
  let result = ml_classify_probit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_model_fill(s : MlclassifyprobitModel, v : Double) -> MlclassifyprobitModel {
  let result = ml_classify_probit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_model_min(s : MlclassifyprobitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_model_max(s : MlclassifyprobitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_model_to_string(s : MlclassifyprobitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_layer_make(size : Int) -> MlclassifyprobitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_layer_len(s : MlclassifyprobitLayer) -> Int { s.size }

pub fn ml_classify_probit_layer_get(s : MlclassifyprobitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_layer_set(s : MlclassifyprobitLayer, i : Int, v : Double) -> MlclassifyprobitLayer {
  let result = ml_classify_probit_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_layer_sum(s : MlclassifyprobitLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_layer_mean(s : MlclassifyprobitLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_layer_scale(s : MlclassifyprobitLayer, f : Double) -> MlclassifyprobitLayer {
  let result = ml_classify_probit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_layer_add(a : MlclassifyprobitLayer, b : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_layer_copy(s : MlclassifyprobitLayer) -> MlclassifyprobitLayer {
  let result = ml_classify_probit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_layer_fill(s : MlclassifyprobitLayer, v : Double) -> MlclassifyprobitLayer {
  let result = ml_classify_probit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_layer_min(s : MlclassifyprobitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_layer_max(s : MlclassifyprobitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_layer_to_string(s : MlclassifyprobitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_buffer_make(size : Int) -> MlclassifyprobitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_buffer_len(s : MlclassifyprobitBuffer) -> Int { s.size }

pub fn ml_classify_probit_buffer_get(s : MlclassifyprobitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_buffer_set(s : MlclassifyprobitBuffer, i : Int, v : Double) -> MlclassifyprobitBuffer {
  let result = ml_classify_probit_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_buffer_sum(s : MlclassifyprobitBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_buffer_mean(s : MlclassifyprobitBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_buffer_scale(s : MlclassifyprobitBuffer, f : Double) -> MlclassifyprobitBuffer {
  let result = ml_classify_probit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_buffer_add(a : MlclassifyprobitBuffer, b : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_buffer_copy(s : MlclassifyprobitBuffer) -> MlclassifyprobitBuffer {
  let result = ml_classify_probit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_buffer_fill(s : MlclassifyprobitBuffer, v : Double) -> MlclassifyprobitBuffer {
  let result = ml_classify_probit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_buffer_min(s : MlclassifyprobitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_buffer_max(s : MlclassifyprobitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_buffer_to_string(s : MlclassifyprobitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_cursor_make(size : Int) -> MlclassifyprobitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_cursor_len(s : MlclassifyprobitCursor) -> Int { s.size }

pub fn ml_classify_probit_cursor_get(s : MlclassifyprobitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_cursor_set(s : MlclassifyprobitCursor, i : Int, v : Double) -> MlclassifyprobitCursor {
  let result = ml_classify_probit_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_cursor_sum(s : MlclassifyprobitCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_cursor_mean(s : MlclassifyprobitCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_cursor_scale(s : MlclassifyprobitCursor, f : Double) -> MlclassifyprobitCursor {
  let result = ml_classify_probit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_cursor_add(a : MlclassifyprobitCursor, b : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_cursor_copy(s : MlclassifyprobitCursor) -> MlclassifyprobitCursor {
  let result = ml_classify_probit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_cursor_fill(s : MlclassifyprobitCursor, v : Double) -> MlclassifyprobitCursor {
  let result = ml_classify_probit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_cursor_min(s : MlclassifyprobitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_cursor_max(s : MlclassifyprobitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_cursor_to_string(s : MlclassifyprobitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_view_make(size : Int) -> MlclassifyprobitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_view_len(s : MlclassifyprobitView) -> Int { s.size }

pub fn ml_classify_probit_view_get(s : MlclassifyprobitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_view_set(s : MlclassifyprobitView, i : Int, v : Double) -> MlclassifyprobitView {
  let result = ml_classify_probit_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_view_sum(s : MlclassifyprobitView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_view_mean(s : MlclassifyprobitView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_view_scale(s : MlclassifyprobitView, f : Double) -> MlclassifyprobitView {
  let result = ml_classify_probit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_view_add(a : MlclassifyprobitView, b : MlclassifyprobitView) -> MlclassifyprobitView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_view_copy(s : MlclassifyprobitView) -> MlclassifyprobitView {
  let result = ml_classify_probit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_view_fill(s : MlclassifyprobitView, v : Double) -> MlclassifyprobitView {
  let result = ml_classify_probit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_view_min(s : MlclassifyprobitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_view_max(s : MlclassifyprobitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_view_to_string(s : MlclassifyprobitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_range_make(size : Int) -> MlclassifyprobitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_range_len(s : MlclassifyprobitRange) -> Int { s.size }

pub fn ml_classify_probit_range_get(s : MlclassifyprobitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_range_set(s : MlclassifyprobitRange, i : Int, v : Double) -> MlclassifyprobitRange {
  let result = ml_classify_probit_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_range_sum(s : MlclassifyprobitRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_range_mean(s : MlclassifyprobitRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_range_scale(s : MlclassifyprobitRange, f : Double) -> MlclassifyprobitRange {
  let result = ml_classify_probit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_range_add(a : MlclassifyprobitRange, b : MlclassifyprobitRange) -> MlclassifyprobitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_range_copy(s : MlclassifyprobitRange) -> MlclassifyprobitRange {
  let result = ml_classify_probit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_range_fill(s : MlclassifyprobitRange, v : Double) -> MlclassifyprobitRange {
  let result = ml_classify_probit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_range_min(s : MlclassifyprobitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_range_max(s : MlclassifyprobitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_range_to_string(s : MlclassifyprobitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyprobitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_probit_slice_make(size : Int) -> MlclassifyprobitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_probit_slice_len(s : MlclassifyprobitSlice) -> Int { s.size }

pub fn ml_classify_probit_slice_get(s : MlclassifyprobitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_probit_slice_set(s : MlclassifyprobitSlice, i : Int, v : Double) -> MlclassifyprobitSlice {
  let result = ml_classify_probit_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_slice_sum(s : MlclassifyprobitSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_probit_slice_mean(s : MlclassifyprobitSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_probit_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_probit_slice_scale(s : MlclassifyprobitSlice, f : Double) -> MlclassifyprobitSlice {
  let result = ml_classify_probit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_probit_slice_add(a : MlclassifyprobitSlice, b : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_probit_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_probit_slice_copy(s : MlclassifyprobitSlice) -> MlclassifyprobitSlice {
  let result = ml_classify_probit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_probit_slice_fill(s : MlclassifyprobitSlice, v : Double) -> MlclassifyprobitSlice {
  let result = ml_classify_probit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_probit_slice_min(s : MlclassifyprobitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_slice_max(s : MlclassifyprobitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_probit_slice_to_string(s : MlclassifyprobitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


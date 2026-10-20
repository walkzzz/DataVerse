///===
/// extcore/db_tx_pessimistic

pub(all) struct DbtxpessimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_pessimistic_make_point(x : Double, y : Double) -> DbtxpessimisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_pessimistic_make_point3(x : Double, y : Double, z : Double) -> DbtxpessimisticPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_pessimistic_point_x(pt : DbtxpessimisticPoint) -> Double { pt.x }

pub fn db_tx_pessimistic_point_y(pt : DbtxpessimisticPoint) -> Double { pt.y }

pub fn db_tx_pessimistic_point_z(pt : DbtxpessimisticPoint) -> Double { pt.z }

pub fn db_tx_pessimistic_point_label(pt : DbtxpessimisticPoint) -> Int { pt.label }

pub fn db_tx_pessimistic_point_dist(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_pessimistic_point_add(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_pessimistic_point_sub(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_pessimistic_point_scale(pt : DbtxpessimisticPoint, s : Double) -> DbtxpessimisticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_pessimistic_point_dot(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_pessimistic_point_cross(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_pessimistic_point_norm(pt : DbtxpessimisticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_pessimistic_point_normalize(pt : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  let n = db_tx_pessimistic_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_pessimistic_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_pessimistic_point_negate(pt : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_pessimistic_point_mid(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_pessimistic_point_lerp(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint, t : Double) -> DbtxpessimisticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_pessimistic_point_to_string(pt : DbtxpessimisticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxpessimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_pessimistic_make_series(vals : Array[Double], name : String) -> DbtxpessimisticSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_pessimistic_series_len(s : DbtxpessimisticSeries) -> Int { s.vals.length() }

pub fn db_tx_pessimistic_series_sum(s : DbtxpessimisticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_pessimistic_series_mean(s : DbtxpessimisticSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_pessimistic_series_min(s : DbtxpessimisticSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_pessimistic_series_max(s : DbtxpessimisticSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_pessimistic_series_range(s : DbtxpessimisticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_pessimistic_series_var(s : DbtxpessimisticSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_pessimistic_series_std(s : DbtxpessimisticSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_pessimistic_series_median(s : DbtxpessimisticSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_pessimistic_series_scale(s : DbtxpessimisticSeries, f : Double) -> DbtxpessimisticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_pessimistic_series_add(a : DbtxpessimisticSeries, b : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_pessimistic_series_sub(a : DbtxpessimisticSeries, b : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_pessimistic_series_normalize(s : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let mn = db_tx_pessimistic_series_min(s)
  let mx = db_tx_pessimistic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_pessimistic_series_cumsum(s : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_pessimistic_series_to_string(s : DbtxpessimisticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxpessimisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_pessimistic_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxpessimisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_pessimistic_matrix_identity(n : Int) -> DbtxpessimisticMatrix {
  let m = db_tx_pessimistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_pessimistic_matrix_get(m : DbtxpessimisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_pessimistic_matrix_transpose(m : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_pessimistic_matrix_add(a : DbtxpessimisticMatrix, b : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_pessimistic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_pessimistic_matrix_scale(m : DbtxpessimisticMatrix, s : Double) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_pessimistic_matrix_multiply(a : DbtxpessimisticMatrix, b : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if a.cols != b.rows { return db_tx_pessimistic_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_pessimistic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_pessimistic_matrix_trace(m : DbtxpessimisticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_pessimistic_matrix_det(m : DbtxpessimisticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_pessimistic_matrix_norm(m : DbtxpessimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_pessimistic_matrix_to_string(m : DbtxpessimisticMatrix) -> String {
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

pub(all) struct DbtxpessimisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_pessimistic_make_vector(comps : Array[Double]) -> DbtxpessimisticVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_pessimistic_vector_zero(dim : Int) -> DbtxpessimisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_pessimistic_vector_add(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_pessimistic_vector_sub(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_pessimistic_vector_scale(v : DbtxpessimisticVector, s : Double) -> DbtxpessimisticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_pessimistic_vector_dot(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_pessimistic_vector_norm(v : DbtxpessimisticVector) -> Double { @_common.sqrt(db_tx_pessimistic_vector_dot(v, v)) }

pub fn db_tx_pessimistic_vector_normalize(v : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = db_tx_pessimistic_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_pessimistic_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_pessimistic_vector_dist(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> Double {
  db_tx_pessimistic_vector_norm(db_tx_pessimistic_vector_sub(a, b))
}

pub fn db_tx_pessimistic_vector_to_string(v : DbtxpessimisticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_pessimistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_pessimistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_pessimistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_pessimistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_pessimistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_pessimistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_pessimistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_pessimistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_pessimistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_pessimistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_pessimistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_pessimistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_pessimistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_pessimistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_pessimistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_pessimistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_pessimistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_pessimistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_pessimistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_pessimistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_pessimistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_pessimistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_pessimistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_pessimistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_pessimistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_pessimistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_pessimistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_pessimistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_pessimistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxpessimisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_frame_make(size : Int) -> DbtxpessimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_frame_len(s : DbtxpessimisticFrame) -> Int { s.size }

pub fn db_tx_pessimistic_frame_get(s : DbtxpessimisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_frame_set(s : DbtxpessimisticFrame, i : Int, v : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_frame_sum(s : DbtxpessimisticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_frame_mean(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_frame_scale(s : DbtxpessimisticFrame, f : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_frame_add(a : DbtxpessimisticFrame, b : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_frame_copy(s : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_frame_fill(s : DbtxpessimisticFrame, v : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_frame_min(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_frame_max(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_frame_to_string(s : DbtxpessimisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_table_make(size : Int) -> DbtxpessimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_table_len(s : DbtxpessimisticTable) -> Int { s.size }

pub fn db_tx_pessimistic_table_get(s : DbtxpessimisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_table_set(s : DbtxpessimisticTable, i : Int, v : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_table_sum(s : DbtxpessimisticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_table_mean(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_table_scale(s : DbtxpessimisticTable, f : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_table_add(a : DbtxpessimisticTable, b : DbtxpessimisticTable) -> DbtxpessimisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_table_copy(s : DbtxpessimisticTable) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_table_fill(s : DbtxpessimisticTable, v : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_table_min(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_table_max(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_table_to_string(s : DbtxpessimisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_graphn_make(size : Int) -> DbtxpessimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_graphn_len(s : DbtxpessimisticGraphN) -> Int { s.size }

pub fn db_tx_pessimistic_graphn_get(s : DbtxpessimisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_graphn_set(s : DbtxpessimisticGraphN, i : Int, v : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_graphn_sum(s : DbtxpessimisticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_graphn_mean(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_graphn_scale(s : DbtxpessimisticGraphN, f : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_graphn_add(a : DbtxpessimisticGraphN, b : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_graphn_copy(s : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_graphn_fill(s : DbtxpessimisticGraphN, v : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_graphn_min(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_graphn_max(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_graphn_to_string(s : DbtxpessimisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_node_make(size : Int) -> DbtxpessimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_node_len(s : DbtxpessimisticNode) -> Int { s.size }

pub fn db_tx_pessimistic_node_get(s : DbtxpessimisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_node_set(s : DbtxpessimisticNode, i : Int, v : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_node_sum(s : DbtxpessimisticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_node_mean(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_node_scale(s : DbtxpessimisticNode, f : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_node_add(a : DbtxpessimisticNode, b : DbtxpessimisticNode) -> DbtxpessimisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_node_copy(s : DbtxpessimisticNode) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_node_fill(s : DbtxpessimisticNode, v : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_node_min(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_node_max(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_node_to_string(s : DbtxpessimisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_edge_make(size : Int) -> DbtxpessimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_edge_len(s : DbtxpessimisticEdge) -> Int { s.size }

pub fn db_tx_pessimistic_edge_get(s : DbtxpessimisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_edge_set(s : DbtxpessimisticEdge, i : Int, v : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_edge_sum(s : DbtxpessimisticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_edge_mean(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_edge_scale(s : DbtxpessimisticEdge, f : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_edge_add(a : DbtxpessimisticEdge, b : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_edge_copy(s : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_edge_fill(s : DbtxpessimisticEdge, v : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_edge_min(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_edge_max(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_edge_to_string(s : DbtxpessimisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_path_make(size : Int) -> DbtxpessimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_path_len(s : DbtxpessimisticPath) -> Int { s.size }

pub fn db_tx_pessimistic_path_get(s : DbtxpessimisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_path_set(s : DbtxpessimisticPath, i : Int, v : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_path_sum(s : DbtxpessimisticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_path_mean(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_path_scale(s : DbtxpessimisticPath, f : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_path_add(a : DbtxpessimisticPath, b : DbtxpessimisticPath) -> DbtxpessimisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_path_copy(s : DbtxpessimisticPath) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_path_fill(s : DbtxpessimisticPath, v : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_path_min(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_path_max(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_path_to_string(s : DbtxpessimisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cluster_make(size : Int) -> DbtxpessimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_cluster_len(s : DbtxpessimisticCluster) -> Int { s.size }

pub fn db_tx_pessimistic_cluster_get(s : DbtxpessimisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_cluster_set(s : DbtxpessimisticCluster, i : Int, v : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cluster_sum(s : DbtxpessimisticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_cluster_mean(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_cluster_scale(s : DbtxpessimisticCluster, f : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_cluster_add(a : DbtxpessimisticCluster, b : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_cluster_copy(s : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_cluster_fill(s : DbtxpessimisticCluster, v : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cluster_min(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cluster_max(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cluster_to_string(s : DbtxpessimisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_model_make(size : Int) -> DbtxpessimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_model_len(s : DbtxpessimisticModel) -> Int { s.size }

pub fn db_tx_pessimistic_model_get(s : DbtxpessimisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_model_set(s : DbtxpessimisticModel, i : Int, v : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_model_sum(s : DbtxpessimisticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_model_mean(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_model_scale(s : DbtxpessimisticModel, f : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_model_add(a : DbtxpessimisticModel, b : DbtxpessimisticModel) -> DbtxpessimisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_model_copy(s : DbtxpessimisticModel) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_model_fill(s : DbtxpessimisticModel, v : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_model_min(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_model_max(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_model_to_string(s : DbtxpessimisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_layer_make(size : Int) -> DbtxpessimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_layer_len(s : DbtxpessimisticLayer) -> Int { s.size }

pub fn db_tx_pessimistic_layer_get(s : DbtxpessimisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_layer_set(s : DbtxpessimisticLayer, i : Int, v : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_layer_sum(s : DbtxpessimisticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_layer_mean(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_layer_scale(s : DbtxpessimisticLayer, f : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_layer_add(a : DbtxpessimisticLayer, b : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_layer_copy(s : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_layer_fill(s : DbtxpessimisticLayer, v : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_layer_min(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_layer_max(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_layer_to_string(s : DbtxpessimisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_buffer_make(size : Int) -> DbtxpessimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_buffer_len(s : DbtxpessimisticBuffer) -> Int { s.size }

pub fn db_tx_pessimistic_buffer_get(s : DbtxpessimisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_buffer_set(s : DbtxpessimisticBuffer, i : Int, v : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_buffer_sum(s : DbtxpessimisticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_buffer_mean(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_buffer_scale(s : DbtxpessimisticBuffer, f : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_buffer_add(a : DbtxpessimisticBuffer, b : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_buffer_copy(s : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_buffer_fill(s : DbtxpessimisticBuffer, v : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_buffer_min(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_buffer_max(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_buffer_to_string(s : DbtxpessimisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cursor_make(size : Int) -> DbtxpessimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_cursor_len(s : DbtxpessimisticCursor) -> Int { s.size }

pub fn db_tx_pessimistic_cursor_get(s : DbtxpessimisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_cursor_set(s : DbtxpessimisticCursor, i : Int, v : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cursor_sum(s : DbtxpessimisticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_cursor_mean(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_cursor_scale(s : DbtxpessimisticCursor, f : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_cursor_add(a : DbtxpessimisticCursor, b : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_cursor_copy(s : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_cursor_fill(s : DbtxpessimisticCursor, v : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cursor_min(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cursor_max(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cursor_to_string(s : DbtxpessimisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_view_make(size : Int) -> DbtxpessimisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_view_len(s : DbtxpessimisticView) -> Int { s.size }

pub fn db_tx_pessimistic_view_get(s : DbtxpessimisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_view_set(s : DbtxpessimisticView, i : Int, v : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_view_sum(s : DbtxpessimisticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_view_mean(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_view_scale(s : DbtxpessimisticView, f : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_view_add(a : DbtxpessimisticView, b : DbtxpessimisticView) -> DbtxpessimisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_view_copy(s : DbtxpessimisticView) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_view_fill(s : DbtxpessimisticView, v : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_view_min(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_view_max(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_view_to_string(s : DbtxpessimisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_range_make(size : Int) -> DbtxpessimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_range_len(s : DbtxpessimisticRange) -> Int { s.size }

pub fn db_tx_pessimistic_range_get(s : DbtxpessimisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_range_set(s : DbtxpessimisticRange, i : Int, v : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_range_sum(s : DbtxpessimisticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_range_mean(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_range_scale(s : DbtxpessimisticRange, f : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_range_add(a : DbtxpessimisticRange, b : DbtxpessimisticRange) -> DbtxpessimisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_range_copy(s : DbtxpessimisticRange) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_range_fill(s : DbtxpessimisticRange, v : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_range_min(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_range_max(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_range_to_string(s : DbtxpessimisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_slice_make(size : Int) -> DbtxpessimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_slice_len(s : DbtxpessimisticSlice) -> Int { s.size }

pub fn db_tx_pessimistic_slice_get(s : DbtxpessimisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_slice_set(s : DbtxpessimisticSlice, i : Int, v : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_slice_sum(s : DbtxpessimisticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_slice_mean(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_slice_scale(s : DbtxpessimisticSlice, f : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_slice_add(a : DbtxpessimisticSlice, b : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_slice_copy(s : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_slice_fill(s : DbtxpessimisticSlice, v : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_slice_min(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_slice_max(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_slice_to_string(s : DbtxpessimisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


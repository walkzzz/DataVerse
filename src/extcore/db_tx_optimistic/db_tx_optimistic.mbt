///===
/// extcore/db_tx_optimistic

pub(all) struct DbtxoptimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_optimistic_make_point(x : Double, y : Double) -> DbtxoptimisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_optimistic_make_point3(x : Double, y : Double, z : Double) -> DbtxoptimisticPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_optimistic_point_x(pt : DbtxoptimisticPoint) -> Double { pt.x }

pub fn db_tx_optimistic_point_y(pt : DbtxoptimisticPoint) -> Double { pt.y }

pub fn db_tx_optimistic_point_z(pt : DbtxoptimisticPoint) -> Double { pt.z }

pub fn db_tx_optimistic_point_label(pt : DbtxoptimisticPoint) -> Int { pt.label }

pub fn db_tx_optimistic_point_dist(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_optimistic_point_add(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_optimistic_point_sub(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_optimistic_point_scale(pt : DbtxoptimisticPoint, s : Double) -> DbtxoptimisticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_optimistic_point_dot(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_optimistic_point_cross(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_optimistic_point_norm(pt : DbtxoptimisticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_optimistic_point_normalize(pt : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  let n = db_tx_optimistic_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_optimistic_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_optimistic_point_negate(pt : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_optimistic_point_mid(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint) -> DbtxoptimisticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_optimistic_point_lerp(a : DbtxoptimisticPoint, b : DbtxoptimisticPoint, t : Double) -> DbtxoptimisticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_optimistic_point_to_string(pt : DbtxoptimisticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxoptimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_optimistic_make_series(vals : Array[Double], name : String) -> DbtxoptimisticSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_optimistic_series_len(s : DbtxoptimisticSeries) -> Int { s.vals.length() }

pub fn db_tx_optimistic_series_sum(s : DbtxoptimisticSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_optimistic_series_mean(s : DbtxoptimisticSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_optimistic_series_min(s : DbtxoptimisticSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_optimistic_series_max(s : DbtxoptimisticSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_optimistic_series_range(s : DbtxoptimisticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_optimistic_series_var(s : DbtxoptimisticSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_optimistic_series_std(s : DbtxoptimisticSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_optimistic_series_median(s : DbtxoptimisticSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_optimistic_series_scale(s : DbtxoptimisticSeries, f : Double) -> DbtxoptimisticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_optimistic_series_add(a : DbtxoptimisticSeries, b : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_optimistic_series_sub(a : DbtxoptimisticSeries, b : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_optimistic_series_normalize(s : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  let mn = db_tx_optimistic_series_min(s)
  let mx = db_tx_optimistic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_optimistic_series_cumsum(s : DbtxoptimisticSeries) -> DbtxoptimisticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_optimistic_series_to_string(s : DbtxoptimisticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxoptimisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_optimistic_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxoptimisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_optimistic_matrix_identity(n : Int) -> DbtxoptimisticMatrix {
  let m = db_tx_optimistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_optimistic_matrix_get(m : DbtxoptimisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_optimistic_matrix_transpose(m : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_optimistic_matrix_add(a : DbtxoptimisticMatrix, b : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_optimistic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_optimistic_matrix_scale(m : DbtxoptimisticMatrix, s : Double) -> DbtxoptimisticMatrix {
  let result = db_tx_optimistic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_optimistic_matrix_multiply(a : DbtxoptimisticMatrix, b : DbtxoptimisticMatrix) -> DbtxoptimisticMatrix {
  if a.cols != b.rows { return db_tx_optimistic_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_optimistic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_optimistic_matrix_trace(m : DbtxoptimisticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_optimistic_matrix_det(m : DbtxoptimisticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_optimistic_matrix_norm(m : DbtxoptimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_optimistic_matrix_to_string(m : DbtxoptimisticMatrix) -> String {
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

pub(all) struct DbtxoptimisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_optimistic_make_vector(comps : Array[Double]) -> DbtxoptimisticVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_optimistic_vector_zero(dim : Int) -> DbtxoptimisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_optimistic_vector_add(a : DbtxoptimisticVector, b : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_optimistic_vector_sub(a : DbtxoptimisticVector, b : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_optimistic_vector_scale(v : DbtxoptimisticVector, s : Double) -> DbtxoptimisticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_optimistic_vector_dot(a : DbtxoptimisticVector, b : DbtxoptimisticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_optimistic_vector_norm(v : DbtxoptimisticVector) -> Double { @_common.sqrt(db_tx_optimistic_vector_dot(v, v)) }

pub fn db_tx_optimistic_vector_normalize(v : DbtxoptimisticVector) -> DbtxoptimisticVector {
  let n = db_tx_optimistic_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_optimistic_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_optimistic_vector_dist(a : DbtxoptimisticVector, b : DbtxoptimisticVector) -> Double {
  db_tx_optimistic_vector_norm(db_tx_optimistic_vector_sub(a, b))
}

pub fn db_tx_optimistic_vector_to_string(v : DbtxoptimisticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_optimistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_optimistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_optimistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_optimistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_optimistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_optimistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_optimistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_optimistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_optimistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_optimistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_optimistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_optimistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_optimistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_optimistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_optimistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_optimistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_optimistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_optimistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_optimistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_optimistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_optimistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_optimistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_optimistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_optimistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_optimistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_optimistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_optimistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_optimistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_optimistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxoptimisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_frame_make(size : Int) -> DbtxoptimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_frame_len(s : DbtxoptimisticFrame) -> Int { s.size }

pub fn db_tx_optimistic_frame_get(s : DbtxoptimisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_frame_set(s : DbtxoptimisticFrame, i : Int, v : Double) -> DbtxoptimisticFrame {
  let result = db_tx_optimistic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_frame_sum(s : DbtxoptimisticFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_frame_mean(s : DbtxoptimisticFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_frame_scale(s : DbtxoptimisticFrame, f : Double) -> DbtxoptimisticFrame {
  let result = db_tx_optimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_frame_add(a : DbtxoptimisticFrame, b : DbtxoptimisticFrame) -> DbtxoptimisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_frame_copy(s : DbtxoptimisticFrame) -> DbtxoptimisticFrame {
  let result = db_tx_optimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_frame_fill(s : DbtxoptimisticFrame, v : Double) -> DbtxoptimisticFrame {
  let result = db_tx_optimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_frame_min(s : DbtxoptimisticFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_frame_max(s : DbtxoptimisticFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_frame_to_string(s : DbtxoptimisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_table_make(size : Int) -> DbtxoptimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_table_len(s : DbtxoptimisticTable) -> Int { s.size }

pub fn db_tx_optimistic_table_get(s : DbtxoptimisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_table_set(s : DbtxoptimisticTable, i : Int, v : Double) -> DbtxoptimisticTable {
  let result = db_tx_optimistic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_table_sum(s : DbtxoptimisticTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_table_mean(s : DbtxoptimisticTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_table_scale(s : DbtxoptimisticTable, f : Double) -> DbtxoptimisticTable {
  let result = db_tx_optimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_table_add(a : DbtxoptimisticTable, b : DbtxoptimisticTable) -> DbtxoptimisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_table_copy(s : DbtxoptimisticTable) -> DbtxoptimisticTable {
  let result = db_tx_optimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_table_fill(s : DbtxoptimisticTable, v : Double) -> DbtxoptimisticTable {
  let result = db_tx_optimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_table_min(s : DbtxoptimisticTable) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_table_max(s : DbtxoptimisticTable) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_table_to_string(s : DbtxoptimisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_graphn_make(size : Int) -> DbtxoptimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_graphn_len(s : DbtxoptimisticGraphN) -> Int { s.size }

pub fn db_tx_optimistic_graphn_get(s : DbtxoptimisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_graphn_set(s : DbtxoptimisticGraphN, i : Int, v : Double) -> DbtxoptimisticGraphN {
  let result = db_tx_optimistic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_graphn_sum(s : DbtxoptimisticGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_graphn_mean(s : DbtxoptimisticGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_graphn_scale(s : DbtxoptimisticGraphN, f : Double) -> DbtxoptimisticGraphN {
  let result = db_tx_optimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_graphn_add(a : DbtxoptimisticGraphN, b : DbtxoptimisticGraphN) -> DbtxoptimisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_graphn_copy(s : DbtxoptimisticGraphN) -> DbtxoptimisticGraphN {
  let result = db_tx_optimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_graphn_fill(s : DbtxoptimisticGraphN, v : Double) -> DbtxoptimisticGraphN {
  let result = db_tx_optimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_graphn_min(s : DbtxoptimisticGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_graphn_max(s : DbtxoptimisticGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_graphn_to_string(s : DbtxoptimisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_node_make(size : Int) -> DbtxoptimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_node_len(s : DbtxoptimisticNode) -> Int { s.size }

pub fn db_tx_optimistic_node_get(s : DbtxoptimisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_node_set(s : DbtxoptimisticNode, i : Int, v : Double) -> DbtxoptimisticNode {
  let result = db_tx_optimistic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_node_sum(s : DbtxoptimisticNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_node_mean(s : DbtxoptimisticNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_node_scale(s : DbtxoptimisticNode, f : Double) -> DbtxoptimisticNode {
  let result = db_tx_optimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_node_add(a : DbtxoptimisticNode, b : DbtxoptimisticNode) -> DbtxoptimisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_node_copy(s : DbtxoptimisticNode) -> DbtxoptimisticNode {
  let result = db_tx_optimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_node_fill(s : DbtxoptimisticNode, v : Double) -> DbtxoptimisticNode {
  let result = db_tx_optimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_node_min(s : DbtxoptimisticNode) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_node_max(s : DbtxoptimisticNode) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_node_to_string(s : DbtxoptimisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_edge_make(size : Int) -> DbtxoptimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_edge_len(s : DbtxoptimisticEdge) -> Int { s.size }

pub fn db_tx_optimistic_edge_get(s : DbtxoptimisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_edge_set(s : DbtxoptimisticEdge, i : Int, v : Double) -> DbtxoptimisticEdge {
  let result = db_tx_optimistic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_edge_sum(s : DbtxoptimisticEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_edge_mean(s : DbtxoptimisticEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_edge_scale(s : DbtxoptimisticEdge, f : Double) -> DbtxoptimisticEdge {
  let result = db_tx_optimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_edge_add(a : DbtxoptimisticEdge, b : DbtxoptimisticEdge) -> DbtxoptimisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_edge_copy(s : DbtxoptimisticEdge) -> DbtxoptimisticEdge {
  let result = db_tx_optimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_edge_fill(s : DbtxoptimisticEdge, v : Double) -> DbtxoptimisticEdge {
  let result = db_tx_optimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_edge_min(s : DbtxoptimisticEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_edge_max(s : DbtxoptimisticEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_edge_to_string(s : DbtxoptimisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_path_make(size : Int) -> DbtxoptimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_path_len(s : DbtxoptimisticPath) -> Int { s.size }

pub fn db_tx_optimistic_path_get(s : DbtxoptimisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_path_set(s : DbtxoptimisticPath, i : Int, v : Double) -> DbtxoptimisticPath {
  let result = db_tx_optimistic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_path_sum(s : DbtxoptimisticPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_path_mean(s : DbtxoptimisticPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_path_scale(s : DbtxoptimisticPath, f : Double) -> DbtxoptimisticPath {
  let result = db_tx_optimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_path_add(a : DbtxoptimisticPath, b : DbtxoptimisticPath) -> DbtxoptimisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_path_copy(s : DbtxoptimisticPath) -> DbtxoptimisticPath {
  let result = db_tx_optimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_path_fill(s : DbtxoptimisticPath, v : Double) -> DbtxoptimisticPath {
  let result = db_tx_optimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_path_min(s : DbtxoptimisticPath) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_path_max(s : DbtxoptimisticPath) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_path_to_string(s : DbtxoptimisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_cluster_make(size : Int) -> DbtxoptimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_cluster_len(s : DbtxoptimisticCluster) -> Int { s.size }

pub fn db_tx_optimistic_cluster_get(s : DbtxoptimisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_cluster_set(s : DbtxoptimisticCluster, i : Int, v : Double) -> DbtxoptimisticCluster {
  let result = db_tx_optimistic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_cluster_sum(s : DbtxoptimisticCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_cluster_mean(s : DbtxoptimisticCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_cluster_scale(s : DbtxoptimisticCluster, f : Double) -> DbtxoptimisticCluster {
  let result = db_tx_optimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_cluster_add(a : DbtxoptimisticCluster, b : DbtxoptimisticCluster) -> DbtxoptimisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_cluster_copy(s : DbtxoptimisticCluster) -> DbtxoptimisticCluster {
  let result = db_tx_optimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_cluster_fill(s : DbtxoptimisticCluster, v : Double) -> DbtxoptimisticCluster {
  let result = db_tx_optimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_cluster_min(s : DbtxoptimisticCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_cluster_max(s : DbtxoptimisticCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_cluster_to_string(s : DbtxoptimisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_model_make(size : Int) -> DbtxoptimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_model_len(s : DbtxoptimisticModel) -> Int { s.size }

pub fn db_tx_optimistic_model_get(s : DbtxoptimisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_model_set(s : DbtxoptimisticModel, i : Int, v : Double) -> DbtxoptimisticModel {
  let result = db_tx_optimistic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_model_sum(s : DbtxoptimisticModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_model_mean(s : DbtxoptimisticModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_model_scale(s : DbtxoptimisticModel, f : Double) -> DbtxoptimisticModel {
  let result = db_tx_optimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_model_add(a : DbtxoptimisticModel, b : DbtxoptimisticModel) -> DbtxoptimisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_model_copy(s : DbtxoptimisticModel) -> DbtxoptimisticModel {
  let result = db_tx_optimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_model_fill(s : DbtxoptimisticModel, v : Double) -> DbtxoptimisticModel {
  let result = db_tx_optimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_model_min(s : DbtxoptimisticModel) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_model_max(s : DbtxoptimisticModel) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_model_to_string(s : DbtxoptimisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_layer_make(size : Int) -> DbtxoptimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_layer_len(s : DbtxoptimisticLayer) -> Int { s.size }

pub fn db_tx_optimistic_layer_get(s : DbtxoptimisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_layer_set(s : DbtxoptimisticLayer, i : Int, v : Double) -> DbtxoptimisticLayer {
  let result = db_tx_optimistic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_layer_sum(s : DbtxoptimisticLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_layer_mean(s : DbtxoptimisticLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_layer_scale(s : DbtxoptimisticLayer, f : Double) -> DbtxoptimisticLayer {
  let result = db_tx_optimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_layer_add(a : DbtxoptimisticLayer, b : DbtxoptimisticLayer) -> DbtxoptimisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_layer_copy(s : DbtxoptimisticLayer) -> DbtxoptimisticLayer {
  let result = db_tx_optimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_layer_fill(s : DbtxoptimisticLayer, v : Double) -> DbtxoptimisticLayer {
  let result = db_tx_optimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_layer_min(s : DbtxoptimisticLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_layer_max(s : DbtxoptimisticLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_layer_to_string(s : DbtxoptimisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_buffer_make(size : Int) -> DbtxoptimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_buffer_len(s : DbtxoptimisticBuffer) -> Int { s.size }

pub fn db_tx_optimistic_buffer_get(s : DbtxoptimisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_buffer_set(s : DbtxoptimisticBuffer, i : Int, v : Double) -> DbtxoptimisticBuffer {
  let result = db_tx_optimistic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_buffer_sum(s : DbtxoptimisticBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_buffer_mean(s : DbtxoptimisticBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_buffer_scale(s : DbtxoptimisticBuffer, f : Double) -> DbtxoptimisticBuffer {
  let result = db_tx_optimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_buffer_add(a : DbtxoptimisticBuffer, b : DbtxoptimisticBuffer) -> DbtxoptimisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_buffer_copy(s : DbtxoptimisticBuffer) -> DbtxoptimisticBuffer {
  let result = db_tx_optimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_buffer_fill(s : DbtxoptimisticBuffer, v : Double) -> DbtxoptimisticBuffer {
  let result = db_tx_optimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_buffer_min(s : DbtxoptimisticBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_buffer_max(s : DbtxoptimisticBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_buffer_to_string(s : DbtxoptimisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_cursor_make(size : Int) -> DbtxoptimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_cursor_len(s : DbtxoptimisticCursor) -> Int { s.size }

pub fn db_tx_optimistic_cursor_get(s : DbtxoptimisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_cursor_set(s : DbtxoptimisticCursor, i : Int, v : Double) -> DbtxoptimisticCursor {
  let result = db_tx_optimistic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_cursor_sum(s : DbtxoptimisticCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_cursor_mean(s : DbtxoptimisticCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_cursor_scale(s : DbtxoptimisticCursor, f : Double) -> DbtxoptimisticCursor {
  let result = db_tx_optimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_cursor_add(a : DbtxoptimisticCursor, b : DbtxoptimisticCursor) -> DbtxoptimisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_cursor_copy(s : DbtxoptimisticCursor) -> DbtxoptimisticCursor {
  let result = db_tx_optimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_cursor_fill(s : DbtxoptimisticCursor, v : Double) -> DbtxoptimisticCursor {
  let result = db_tx_optimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_cursor_min(s : DbtxoptimisticCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_cursor_max(s : DbtxoptimisticCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_cursor_to_string(s : DbtxoptimisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_view_make(size : Int) -> DbtxoptimisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_view_len(s : DbtxoptimisticView) -> Int { s.size }

pub fn db_tx_optimistic_view_get(s : DbtxoptimisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_view_set(s : DbtxoptimisticView, i : Int, v : Double) -> DbtxoptimisticView {
  let result = db_tx_optimistic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_view_sum(s : DbtxoptimisticView) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_view_mean(s : DbtxoptimisticView) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_view_scale(s : DbtxoptimisticView, f : Double) -> DbtxoptimisticView {
  let result = db_tx_optimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_view_add(a : DbtxoptimisticView, b : DbtxoptimisticView) -> DbtxoptimisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_view_copy(s : DbtxoptimisticView) -> DbtxoptimisticView {
  let result = db_tx_optimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_view_fill(s : DbtxoptimisticView, v : Double) -> DbtxoptimisticView {
  let result = db_tx_optimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_view_min(s : DbtxoptimisticView) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_view_max(s : DbtxoptimisticView) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_view_to_string(s : DbtxoptimisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_range_make(size : Int) -> DbtxoptimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_range_len(s : DbtxoptimisticRange) -> Int { s.size }

pub fn db_tx_optimistic_range_get(s : DbtxoptimisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_range_set(s : DbtxoptimisticRange, i : Int, v : Double) -> DbtxoptimisticRange {
  let result = db_tx_optimistic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_range_sum(s : DbtxoptimisticRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_range_mean(s : DbtxoptimisticRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_range_scale(s : DbtxoptimisticRange, f : Double) -> DbtxoptimisticRange {
  let result = db_tx_optimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_range_add(a : DbtxoptimisticRange, b : DbtxoptimisticRange) -> DbtxoptimisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_range_copy(s : DbtxoptimisticRange) -> DbtxoptimisticRange {
  let result = db_tx_optimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_range_fill(s : DbtxoptimisticRange, v : Double) -> DbtxoptimisticRange {
  let result = db_tx_optimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_range_min(s : DbtxoptimisticRange) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_range_max(s : DbtxoptimisticRange) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_range_to_string(s : DbtxoptimisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxoptimisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_optimistic_slice_make(size : Int) -> DbtxoptimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_optimistic_slice_len(s : DbtxoptimisticSlice) -> Int { s.size }

pub fn db_tx_optimistic_slice_get(s : DbtxoptimisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_optimistic_slice_set(s : DbtxoptimisticSlice, i : Int, v : Double) -> DbtxoptimisticSlice {
  let result = db_tx_optimistic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_slice_sum(s : DbtxoptimisticSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_optimistic_slice_mean(s : DbtxoptimisticSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_optimistic_slice_scale(s : DbtxoptimisticSlice, f : Double) -> DbtxoptimisticSlice {
  let result = db_tx_optimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_optimistic_slice_add(a : DbtxoptimisticSlice, b : DbtxoptimisticSlice) -> DbtxoptimisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_optimistic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_optimistic_slice_copy(s : DbtxoptimisticSlice) -> DbtxoptimisticSlice {
  let result = db_tx_optimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_optimistic_slice_fill(s : DbtxoptimisticSlice, v : Double) -> DbtxoptimisticSlice {
  let result = db_tx_optimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_optimistic_slice_min(s : DbtxoptimisticSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_optimistic_slice_max(s : DbtxoptimisticSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_optimistic_slice_to_string(s : DbtxoptimisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


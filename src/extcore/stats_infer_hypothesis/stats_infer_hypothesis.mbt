///===
/// extcore/stats_infer_hypothesis

pub(all) struct StatsinferhypothesisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_hypothesis_make_point(x : Double, y : Double) -> StatsinferhypothesisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_hypothesis_make_point3(x : Double, y : Double, z : Double) -> StatsinferhypothesisPoint {
  { x, y, z, label: 0 }
}

pub fn stats_infer_hypothesis_point_x(pt : StatsinferhypothesisPoint) -> Double { pt.x }

pub fn stats_infer_hypothesis_point_y(pt : StatsinferhypothesisPoint) -> Double { pt.y }

pub fn stats_infer_hypothesis_point_z(pt : StatsinferhypothesisPoint) -> Double { pt.z }

pub fn stats_infer_hypothesis_point_label(pt : StatsinferhypothesisPoint) -> Int { pt.label }

pub fn stats_infer_hypothesis_point_dist(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_infer_hypothesis_point_add(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_infer_hypothesis_point_sub(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_infer_hypothesis_point_scale(pt : StatsinferhypothesisPoint, s : Double) -> StatsinferhypothesisPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_infer_hypothesis_point_dot(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_infer_hypothesis_point_cross(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_infer_hypothesis_point_norm(pt : StatsinferhypothesisPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_infer_hypothesis_point_normalize(pt : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  let n = stats_infer_hypothesis_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_infer_hypothesis_point_scale(pt, 1.0 / n) }
}

pub fn stats_infer_hypothesis_point_negate(pt : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_infer_hypothesis_point_mid(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_infer_hypothesis_point_lerp(a : StatsinferhypothesisPoint, b : StatsinferhypothesisPoint, t : Double) -> StatsinferhypothesisPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_infer_hypothesis_point_to_string(pt : StatsinferhypothesisPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsinferhypothesisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_hypothesis_make_series(vals : Array[Double], name : String) -> StatsinferhypothesisSeries {
  { vals, name, meta: 0 }
}

pub fn stats_infer_hypothesis_series_len(s : StatsinferhypothesisSeries) -> Int { s.vals.length() }

pub fn stats_infer_hypothesis_series_sum(s : StatsinferhypothesisSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_infer_hypothesis_series_mean(s : StatsinferhypothesisSeries) -> Double {
  let n = stats_infer_hypothesis_series_len(s)
  if n == 0 { 0.0 } else { stats_infer_hypothesis_series_sum(s) / n.to_double() }
}

pub fn stats_infer_hypothesis_series_min(s : StatsinferhypothesisSeries) -> Double {
  let n = stats_infer_hypothesis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_series_max(s : StatsinferhypothesisSeries) -> Double {
  let n = stats_infer_hypothesis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_series_range(s : StatsinferhypothesisSeries) -> Double {
  stats_infer_hypothesis_series_max(s) - stats_infer_hypothesis_series_min(s)
}

pub fn stats_infer_hypothesis_series_var(s : StatsinferhypothesisSeries) -> Double {
  let n = stats_infer_hypothesis_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_infer_hypothesis_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_infer_hypothesis_series_std(s : StatsinferhypothesisSeries) -> Double { @_common.sqrt(stats_infer_hypothesis_series_var(s)) }

pub fn stats_infer_hypothesis_series_median(s : StatsinferhypothesisSeries) -> Double {
  let n = stats_infer_hypothesis_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_infer_hypothesis_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_infer_hypothesis_series_scale(s : StatsinferhypothesisSeries, f : Double) -> StatsinferhypothesisSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_infer_hypothesis_series_add(a : StatsinferhypothesisSeries, b : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_infer_hypothesis_series_sub(a : StatsinferhypothesisSeries, b : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_infer_hypothesis_series_normalize(s : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  let mn = stats_infer_hypothesis_series_min(s)
  let mx = stats_infer_hypothesis_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_infer_hypothesis_series_cumsum(s : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_infer_hypothesis_series_to_string(s : StatsinferhypothesisSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferhypothesisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_hypothesis_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferhypothesisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_hypothesis_matrix_identity(n : Int) -> StatsinferhypothesisMatrix {
  let m = stats_infer_hypothesis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_infer_hypothesis_matrix_get(m : StatsinferhypothesisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_infer_hypothesis_matrix_transpose(m : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  let result = stats_infer_hypothesis_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_infer_hypothesis_matrix_add(a : StatsinferhypothesisMatrix, b : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_infer_hypothesis_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_infer_hypothesis_matrix_scale(m : StatsinferhypothesisMatrix, s : Double) -> StatsinferhypothesisMatrix {
  let result = stats_infer_hypothesis_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_infer_hypothesis_matrix_multiply(a : StatsinferhypothesisMatrix, b : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  if a.cols != b.rows { return stats_infer_hypothesis_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_infer_hypothesis_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_infer_hypothesis_matrix_trace(m : StatsinferhypothesisMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_infer_hypothesis_matrix_det(m : StatsinferhypothesisMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_infer_hypothesis_matrix_norm(m : StatsinferhypothesisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_infer_hypothesis_matrix_to_string(m : StatsinferhypothesisMatrix) -> String {
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

pub(all) struct StatsinferhypothesisVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_hypothesis_make_vector(comps : Array[Double]) -> StatsinferhypothesisVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_hypothesis_vector_zero(dim : Int) -> StatsinferhypothesisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_infer_hypothesis_vector_add(a : StatsinferhypothesisVector, b : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_hypothesis_vector_sub(a : StatsinferhypothesisVector, b : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_infer_hypothesis_vector_scale(v : StatsinferhypothesisVector, s : Double) -> StatsinferhypothesisVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_infer_hypothesis_vector_dot(a : StatsinferhypothesisVector, b : StatsinferhypothesisVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_infer_hypothesis_vector_norm(v : StatsinferhypothesisVector) -> Double { @_common.sqrt(stats_infer_hypothesis_vector_dot(v, v)) }

pub fn stats_infer_hypothesis_vector_normalize(v : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = stats_infer_hypothesis_vector_norm(v)
  if n < 0.0000001 { v } else { stats_infer_hypothesis_vector_scale(v, 1.0 / n) }
}

pub fn stats_infer_hypothesis_vector_dist(a : StatsinferhypothesisVector, b : StatsinferhypothesisVector) -> Double {
  stats_infer_hypothesis_vector_norm(stats_infer_hypothesis_vector_sub(a, b))
}

pub fn stats_infer_hypothesis_vector_to_string(v : StatsinferhypothesisVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_hypothesis_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_hypothesis_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_hypothesis_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_hypothesis_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_hypothesis_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_hypothesis_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_hypothesis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_hypothesis_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_hypothesis_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_hypothesis_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_hypothesis_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_hypothesis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_hypothesis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_hypothesis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_hypothesis_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_hypothesis_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_hypothesis_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_hypothesis_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_hypothesis_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_hypothesis_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_hypothesis_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_hypothesis_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_hypothesis_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_hypothesis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_hypothesis_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_hypothesis_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_hypothesis_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_hypothesis_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_hypothesis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferhypothesisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_frame_make(size : Int) -> StatsinferhypothesisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_frame_len(s : StatsinferhypothesisFrame) -> Int { s.size }

pub fn stats_infer_hypothesis_frame_get(s : StatsinferhypothesisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_frame_set(s : StatsinferhypothesisFrame, i : Int, v : Double) -> StatsinferhypothesisFrame {
  let result = stats_infer_hypothesis_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_frame_sum(s : StatsinferhypothesisFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_frame_mean(s : StatsinferhypothesisFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_frame_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_frame_scale(s : StatsinferhypothesisFrame, f : Double) -> StatsinferhypothesisFrame {
  let result = stats_infer_hypothesis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_frame_add(a : StatsinferhypothesisFrame, b : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_frame_copy(s : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  let result = stats_infer_hypothesis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_frame_fill(s : StatsinferhypothesisFrame, v : Double) -> StatsinferhypothesisFrame {
  let result = stats_infer_hypothesis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_frame_min(s : StatsinferhypothesisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_frame_max(s : StatsinferhypothesisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_frame_to_string(s : StatsinferhypothesisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_table_make(size : Int) -> StatsinferhypothesisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_table_len(s : StatsinferhypothesisTable) -> Int { s.size }

pub fn stats_infer_hypothesis_table_get(s : StatsinferhypothesisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_table_set(s : StatsinferhypothesisTable, i : Int, v : Double) -> StatsinferhypothesisTable {
  let result = stats_infer_hypothesis_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_table_sum(s : StatsinferhypothesisTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_table_mean(s : StatsinferhypothesisTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_table_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_table_scale(s : StatsinferhypothesisTable, f : Double) -> StatsinferhypothesisTable {
  let result = stats_infer_hypothesis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_table_add(a : StatsinferhypothesisTable, b : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_table_copy(s : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  let result = stats_infer_hypothesis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_table_fill(s : StatsinferhypothesisTable, v : Double) -> StatsinferhypothesisTable {
  let result = stats_infer_hypothesis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_table_min(s : StatsinferhypothesisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_table_max(s : StatsinferhypothesisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_table_to_string(s : StatsinferhypothesisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_graphn_make(size : Int) -> StatsinferhypothesisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_graphn_len(s : StatsinferhypothesisGraphN) -> Int { s.size }

pub fn stats_infer_hypothesis_graphn_get(s : StatsinferhypothesisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_graphn_set(s : StatsinferhypothesisGraphN, i : Int, v : Double) -> StatsinferhypothesisGraphN {
  let result = stats_infer_hypothesis_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_graphn_sum(s : StatsinferhypothesisGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_graphn_mean(s : StatsinferhypothesisGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_graphn_scale(s : StatsinferhypothesisGraphN, f : Double) -> StatsinferhypothesisGraphN {
  let result = stats_infer_hypothesis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_graphn_add(a : StatsinferhypothesisGraphN, b : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_graphn_copy(s : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  let result = stats_infer_hypothesis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_graphn_fill(s : StatsinferhypothesisGraphN, v : Double) -> StatsinferhypothesisGraphN {
  let result = stats_infer_hypothesis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_graphn_min(s : StatsinferhypothesisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_graphn_max(s : StatsinferhypothesisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_graphn_to_string(s : StatsinferhypothesisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_node_make(size : Int) -> StatsinferhypothesisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_node_len(s : StatsinferhypothesisNode) -> Int { s.size }

pub fn stats_infer_hypothesis_node_get(s : StatsinferhypothesisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_node_set(s : StatsinferhypothesisNode, i : Int, v : Double) -> StatsinferhypothesisNode {
  let result = stats_infer_hypothesis_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_node_sum(s : StatsinferhypothesisNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_node_mean(s : StatsinferhypothesisNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_node_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_node_scale(s : StatsinferhypothesisNode, f : Double) -> StatsinferhypothesisNode {
  let result = stats_infer_hypothesis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_node_add(a : StatsinferhypothesisNode, b : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_node_copy(s : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  let result = stats_infer_hypothesis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_node_fill(s : StatsinferhypothesisNode, v : Double) -> StatsinferhypothesisNode {
  let result = stats_infer_hypothesis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_node_min(s : StatsinferhypothesisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_node_max(s : StatsinferhypothesisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_node_to_string(s : StatsinferhypothesisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_edge_make(size : Int) -> StatsinferhypothesisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_edge_len(s : StatsinferhypothesisEdge) -> Int { s.size }

pub fn stats_infer_hypothesis_edge_get(s : StatsinferhypothesisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_edge_set(s : StatsinferhypothesisEdge, i : Int, v : Double) -> StatsinferhypothesisEdge {
  let result = stats_infer_hypothesis_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_edge_sum(s : StatsinferhypothesisEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_edge_mean(s : StatsinferhypothesisEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_edge_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_edge_scale(s : StatsinferhypothesisEdge, f : Double) -> StatsinferhypothesisEdge {
  let result = stats_infer_hypothesis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_edge_add(a : StatsinferhypothesisEdge, b : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_edge_copy(s : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  let result = stats_infer_hypothesis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_edge_fill(s : StatsinferhypothesisEdge, v : Double) -> StatsinferhypothesisEdge {
  let result = stats_infer_hypothesis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_edge_min(s : StatsinferhypothesisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_edge_max(s : StatsinferhypothesisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_edge_to_string(s : StatsinferhypothesisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_path_make(size : Int) -> StatsinferhypothesisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_path_len(s : StatsinferhypothesisPath) -> Int { s.size }

pub fn stats_infer_hypothesis_path_get(s : StatsinferhypothesisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_path_set(s : StatsinferhypothesisPath, i : Int, v : Double) -> StatsinferhypothesisPath {
  let result = stats_infer_hypothesis_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_path_sum(s : StatsinferhypothesisPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_path_mean(s : StatsinferhypothesisPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_path_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_path_scale(s : StatsinferhypothesisPath, f : Double) -> StatsinferhypothesisPath {
  let result = stats_infer_hypothesis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_path_add(a : StatsinferhypothesisPath, b : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_path_copy(s : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  let result = stats_infer_hypothesis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_path_fill(s : StatsinferhypothesisPath, v : Double) -> StatsinferhypothesisPath {
  let result = stats_infer_hypothesis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_path_min(s : StatsinferhypothesisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_path_max(s : StatsinferhypothesisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_path_to_string(s : StatsinferhypothesisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cluster_make(size : Int) -> StatsinferhypothesisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_cluster_len(s : StatsinferhypothesisCluster) -> Int { s.size }

pub fn stats_infer_hypothesis_cluster_get(s : StatsinferhypothesisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_cluster_set(s : StatsinferhypothesisCluster, i : Int, v : Double) -> StatsinferhypothesisCluster {
  let result = stats_infer_hypothesis_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_cluster_sum(s : StatsinferhypothesisCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_cluster_mean(s : StatsinferhypothesisCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_cluster_scale(s : StatsinferhypothesisCluster, f : Double) -> StatsinferhypothesisCluster {
  let result = stats_infer_hypothesis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_cluster_add(a : StatsinferhypothesisCluster, b : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_cluster_copy(s : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  let result = stats_infer_hypothesis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_cluster_fill(s : StatsinferhypothesisCluster, v : Double) -> StatsinferhypothesisCluster {
  let result = stats_infer_hypothesis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_cluster_min(s : StatsinferhypothesisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_cluster_max(s : StatsinferhypothesisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_cluster_to_string(s : StatsinferhypothesisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_model_make(size : Int) -> StatsinferhypothesisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_model_len(s : StatsinferhypothesisModel) -> Int { s.size }

pub fn stats_infer_hypothesis_model_get(s : StatsinferhypothesisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_model_set(s : StatsinferhypothesisModel, i : Int, v : Double) -> StatsinferhypothesisModel {
  let result = stats_infer_hypothesis_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_model_sum(s : StatsinferhypothesisModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_model_mean(s : StatsinferhypothesisModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_model_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_model_scale(s : StatsinferhypothesisModel, f : Double) -> StatsinferhypothesisModel {
  let result = stats_infer_hypothesis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_model_add(a : StatsinferhypothesisModel, b : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_model_copy(s : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  let result = stats_infer_hypothesis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_model_fill(s : StatsinferhypothesisModel, v : Double) -> StatsinferhypothesisModel {
  let result = stats_infer_hypothesis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_model_min(s : StatsinferhypothesisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_model_max(s : StatsinferhypothesisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_model_to_string(s : StatsinferhypothesisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_layer_make(size : Int) -> StatsinferhypothesisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_layer_len(s : StatsinferhypothesisLayer) -> Int { s.size }

pub fn stats_infer_hypothesis_layer_get(s : StatsinferhypothesisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_layer_set(s : StatsinferhypothesisLayer, i : Int, v : Double) -> StatsinferhypothesisLayer {
  let result = stats_infer_hypothesis_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_layer_sum(s : StatsinferhypothesisLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_layer_mean(s : StatsinferhypothesisLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_layer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_layer_scale(s : StatsinferhypothesisLayer, f : Double) -> StatsinferhypothesisLayer {
  let result = stats_infer_hypothesis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_layer_add(a : StatsinferhypothesisLayer, b : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_layer_copy(s : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  let result = stats_infer_hypothesis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_layer_fill(s : StatsinferhypothesisLayer, v : Double) -> StatsinferhypothesisLayer {
  let result = stats_infer_hypothesis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_layer_min(s : StatsinferhypothesisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_layer_max(s : StatsinferhypothesisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_layer_to_string(s : StatsinferhypothesisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_buffer_make(size : Int) -> StatsinferhypothesisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_buffer_len(s : StatsinferhypothesisBuffer) -> Int { s.size }

pub fn stats_infer_hypothesis_buffer_get(s : StatsinferhypothesisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_buffer_set(s : StatsinferhypothesisBuffer, i : Int, v : Double) -> StatsinferhypothesisBuffer {
  let result = stats_infer_hypothesis_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_buffer_sum(s : StatsinferhypothesisBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_buffer_mean(s : StatsinferhypothesisBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_buffer_scale(s : StatsinferhypothesisBuffer, f : Double) -> StatsinferhypothesisBuffer {
  let result = stats_infer_hypothesis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_buffer_add(a : StatsinferhypothesisBuffer, b : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_buffer_copy(s : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  let result = stats_infer_hypothesis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_buffer_fill(s : StatsinferhypothesisBuffer, v : Double) -> StatsinferhypothesisBuffer {
  let result = stats_infer_hypothesis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_buffer_min(s : StatsinferhypothesisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_buffer_max(s : StatsinferhypothesisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_buffer_to_string(s : StatsinferhypothesisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cursor_make(size : Int) -> StatsinferhypothesisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_cursor_len(s : StatsinferhypothesisCursor) -> Int { s.size }

pub fn stats_infer_hypothesis_cursor_get(s : StatsinferhypothesisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_cursor_set(s : StatsinferhypothesisCursor, i : Int, v : Double) -> StatsinferhypothesisCursor {
  let result = stats_infer_hypothesis_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_cursor_sum(s : StatsinferhypothesisCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_cursor_mean(s : StatsinferhypothesisCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_cursor_scale(s : StatsinferhypothesisCursor, f : Double) -> StatsinferhypothesisCursor {
  let result = stats_infer_hypothesis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_cursor_add(a : StatsinferhypothesisCursor, b : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_cursor_copy(s : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  let result = stats_infer_hypothesis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_cursor_fill(s : StatsinferhypothesisCursor, v : Double) -> StatsinferhypothesisCursor {
  let result = stats_infer_hypothesis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_cursor_min(s : StatsinferhypothesisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_cursor_max(s : StatsinferhypothesisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_cursor_to_string(s : StatsinferhypothesisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_view_make(size : Int) -> StatsinferhypothesisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_view_len(s : StatsinferhypothesisView) -> Int { s.size }

pub fn stats_infer_hypothesis_view_get(s : StatsinferhypothesisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_view_set(s : StatsinferhypothesisView, i : Int, v : Double) -> StatsinferhypothesisView {
  let result = stats_infer_hypothesis_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_view_sum(s : StatsinferhypothesisView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_view_mean(s : StatsinferhypothesisView) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_view_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_view_scale(s : StatsinferhypothesisView, f : Double) -> StatsinferhypothesisView {
  let result = stats_infer_hypothesis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_view_add(a : StatsinferhypothesisView, b : StatsinferhypothesisView) -> StatsinferhypothesisView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_view_copy(s : StatsinferhypothesisView) -> StatsinferhypothesisView {
  let result = stats_infer_hypothesis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_view_fill(s : StatsinferhypothesisView, v : Double) -> StatsinferhypothesisView {
  let result = stats_infer_hypothesis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_view_min(s : StatsinferhypothesisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_view_max(s : StatsinferhypothesisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_view_to_string(s : StatsinferhypothesisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_range_make(size : Int) -> StatsinferhypothesisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_range_len(s : StatsinferhypothesisRange) -> Int { s.size }

pub fn stats_infer_hypothesis_range_get(s : StatsinferhypothesisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_range_set(s : StatsinferhypothesisRange, i : Int, v : Double) -> StatsinferhypothesisRange {
  let result = stats_infer_hypothesis_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_range_sum(s : StatsinferhypothesisRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_range_mean(s : StatsinferhypothesisRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_range_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_range_scale(s : StatsinferhypothesisRange, f : Double) -> StatsinferhypothesisRange {
  let result = stats_infer_hypothesis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_range_add(a : StatsinferhypothesisRange, b : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_range_copy(s : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  let result = stats_infer_hypothesis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_range_fill(s : StatsinferhypothesisRange, v : Double) -> StatsinferhypothesisRange {
  let result = stats_infer_hypothesis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_range_min(s : StatsinferhypothesisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_range_max(s : StatsinferhypothesisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_range_to_string(s : StatsinferhypothesisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_slice_make(size : Int) -> StatsinferhypothesisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_slice_len(s : StatsinferhypothesisSlice) -> Int { s.size }

pub fn stats_infer_hypothesis_slice_get(s : StatsinferhypothesisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_slice_set(s : StatsinferhypothesisSlice, i : Int, v : Double) -> StatsinferhypothesisSlice {
  let result = stats_infer_hypothesis_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_slice_sum(s : StatsinferhypothesisSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_infer_hypothesis_slice_mean(s : StatsinferhypothesisSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_infer_hypothesis_slice_sum(s) / s.size.to_double() }
}

pub fn stats_infer_hypothesis_slice_scale(s : StatsinferhypothesisSlice, f : Double) -> StatsinferhypothesisSlice {
  let result = stats_infer_hypothesis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_infer_hypothesis_slice_add(a : StatsinferhypothesisSlice, b : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_infer_hypothesis_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_infer_hypothesis_slice_copy(s : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  let result = stats_infer_hypothesis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_infer_hypothesis_slice_fill(s : StatsinferhypothesisSlice, v : Double) -> StatsinferhypothesisSlice {
  let result = stats_infer_hypothesis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_infer_hypothesis_slice_min(s : StatsinferhypothesisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_slice_max(s : StatsinferhypothesisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_infer_hypothesis_slice_to_string(s : StatsinferhypothesisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


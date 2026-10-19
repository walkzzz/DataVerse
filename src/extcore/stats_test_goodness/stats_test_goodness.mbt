///===
/// extcore/stats_test_goodness

pub(all) struct StatstestgoodnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_goodness_make_point(x : Double, y : Double) -> StatstestgoodnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_goodness_make_point3(x : Double, y : Double, z : Double) -> StatstestgoodnessPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_goodness_point_x(pt : StatstestgoodnessPoint) -> Double { pt.x }

pub fn stats_test_goodness_point_y(pt : StatstestgoodnessPoint) -> Double { pt.y }

pub fn stats_test_goodness_point_z(pt : StatstestgoodnessPoint) -> Double { pt.z }

pub fn stats_test_goodness_point_label(pt : StatstestgoodnessPoint) -> Int { pt.label }

pub fn stats_test_goodness_point_dist(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_goodness_point_add(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_goodness_point_sub(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_goodness_point_scale(pt : StatstestgoodnessPoint, s : Double) -> StatstestgoodnessPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_goodness_point_dot(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_goodness_point_cross(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_goodness_point_norm(pt : StatstestgoodnessPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_goodness_point_normalize(pt : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  let n = stats_test_goodness_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_goodness_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_goodness_point_negate(pt : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_goodness_point_mid(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_goodness_point_lerp(a : StatstestgoodnessPoint, b : StatstestgoodnessPoint, t : Double) -> StatstestgoodnessPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_goodness_point_to_string(pt : StatstestgoodnessPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestgoodnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_goodness_make_series(vals : Array[Double], name : String) -> StatstestgoodnessSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_goodness_series_len(s : StatstestgoodnessSeries) -> Int { s.vals.length() }

pub fn stats_test_goodness_series_sum(s : StatstestgoodnessSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_goodness_series_mean(s : StatstestgoodnessSeries) -> Double {
  let n = stats_test_goodness_series_len(s)
  if n == 0 { 0.0 } else { stats_test_goodness_series_sum(s) / n.to_double() }
}

pub fn stats_test_goodness_series_min(s : StatstestgoodnessSeries) -> Double {
  let n = stats_test_goodness_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_goodness_series_max(s : StatstestgoodnessSeries) -> Double {
  let n = stats_test_goodness_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_goodness_series_range(s : StatstestgoodnessSeries) -> Double {
  stats_test_goodness_series_max(s) - stats_test_goodness_series_min(s)
}

pub fn stats_test_goodness_series_var(s : StatstestgoodnessSeries) -> Double {
  let n = stats_test_goodness_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_goodness_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_goodness_series_std(s : StatstestgoodnessSeries) -> Double { @_common.sqrt(stats_test_goodness_series_var(s)) }

pub fn stats_test_goodness_series_median(s : StatstestgoodnessSeries) -> Double {
  let n = stats_test_goodness_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_goodness_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_goodness_series_scale(s : StatstestgoodnessSeries, f : Double) -> StatstestgoodnessSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_goodness_series_add(a : StatstestgoodnessSeries, b : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_goodness_series_sub(a : StatstestgoodnessSeries, b : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_goodness_series_normalize(s : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let mn = stats_test_goodness_series_min(s)
  let mx = stats_test_goodness_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_goodness_series_cumsum(s : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_goodness_series_to_string(s : StatstestgoodnessSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestgoodnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_goodness_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestgoodnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_goodness_matrix_identity(n : Int) -> StatstestgoodnessMatrix {
  let m = stats_test_goodness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_goodness_matrix_get(m : StatstestgoodnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_goodness_matrix_transpose(m : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_goodness_matrix_add(a : StatstestgoodnessMatrix, b : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_goodness_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_goodness_matrix_scale(m : StatstestgoodnessMatrix, s : Double) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_goodness_matrix_multiply(a : StatstestgoodnessMatrix, b : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if a.cols != b.rows { return stats_test_goodness_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_goodness_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_goodness_matrix_trace(m : StatstestgoodnessMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_goodness_matrix_det(m : StatstestgoodnessMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_goodness_matrix_norm(m : StatstestgoodnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_goodness_matrix_to_string(m : StatstestgoodnessMatrix) -> String {
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

pub(all) struct StatstestgoodnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_goodness_make_vector(comps : Array[Double]) -> StatstestgoodnessVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_goodness_vector_zero(dim : Int) -> StatstestgoodnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_goodness_vector_add(a : StatstestgoodnessVector, b : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_goodness_vector_sub(a : StatstestgoodnessVector, b : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_goodness_vector_scale(v : StatstestgoodnessVector, s : Double) -> StatstestgoodnessVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_goodness_vector_dot(a : StatstestgoodnessVector, b : StatstestgoodnessVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_goodness_vector_norm(v : StatstestgoodnessVector) -> Double { @_common.sqrt(stats_test_goodness_vector_dot(v, v)) }

pub fn stats_test_goodness_vector_normalize(v : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = stats_test_goodness_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_goodness_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_goodness_vector_dist(a : StatstestgoodnessVector, b : StatstestgoodnessVector) -> Double {
  stats_test_goodness_vector_norm(stats_test_goodness_vector_sub(a, b))
}

pub fn stats_test_goodness_vector_to_string(v : StatstestgoodnessVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_goodness_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_goodness_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_goodness_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_goodness_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_goodness_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_goodness_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_goodness_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_goodness_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_goodness_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_goodness_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_goodness_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_goodness_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_goodness_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_goodness_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_goodness_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_goodness_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_goodness_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_goodness_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_goodness_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_goodness_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_goodness_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_goodness_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_goodness_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_goodness_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_goodness_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_goodness_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_goodness_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_goodness_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_goodness_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestgoodnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_frame_make(size : Int) -> StatstestgoodnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_frame_len(s : StatstestgoodnessFrame) -> Int { s.size }

pub fn stats_test_goodness_frame_get(s : StatstestgoodnessFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_frame_set(s : StatstestgoodnessFrame, i : Int, v : Double) -> StatstestgoodnessFrame {
  let result = stats_test_goodness_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_frame_sum(s : StatstestgoodnessFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_frame_mean(s : StatstestgoodnessFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_frame_scale(s : StatstestgoodnessFrame, f : Double) -> StatstestgoodnessFrame {
  let result = stats_test_goodness_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_frame_add(a : StatstestgoodnessFrame, b : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_frame_copy(s : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  let result = stats_test_goodness_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_frame_fill(s : StatstestgoodnessFrame, v : Double) -> StatstestgoodnessFrame {
  let result = stats_test_goodness_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_frame_min(s : StatstestgoodnessFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_frame_max(s : StatstestgoodnessFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_frame_to_string(s : StatstestgoodnessFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_table_make(size : Int) -> StatstestgoodnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_table_len(s : StatstestgoodnessTable) -> Int { s.size }

pub fn stats_test_goodness_table_get(s : StatstestgoodnessTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_table_set(s : StatstestgoodnessTable, i : Int, v : Double) -> StatstestgoodnessTable {
  let result = stats_test_goodness_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_table_sum(s : StatstestgoodnessTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_table_mean(s : StatstestgoodnessTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_table_scale(s : StatstestgoodnessTable, f : Double) -> StatstestgoodnessTable {
  let result = stats_test_goodness_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_table_add(a : StatstestgoodnessTable, b : StatstestgoodnessTable) -> StatstestgoodnessTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_table_copy(s : StatstestgoodnessTable) -> StatstestgoodnessTable {
  let result = stats_test_goodness_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_table_fill(s : StatstestgoodnessTable, v : Double) -> StatstestgoodnessTable {
  let result = stats_test_goodness_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_table_min(s : StatstestgoodnessTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_table_max(s : StatstestgoodnessTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_table_to_string(s : StatstestgoodnessTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_graphn_make(size : Int) -> StatstestgoodnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_graphn_len(s : StatstestgoodnessGraphN) -> Int { s.size }

pub fn stats_test_goodness_graphn_get(s : StatstestgoodnessGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_graphn_set(s : StatstestgoodnessGraphN, i : Int, v : Double) -> StatstestgoodnessGraphN {
  let result = stats_test_goodness_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_graphn_sum(s : StatstestgoodnessGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_graphn_mean(s : StatstestgoodnessGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_graphn_scale(s : StatstestgoodnessGraphN, f : Double) -> StatstestgoodnessGraphN {
  let result = stats_test_goodness_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_graphn_add(a : StatstestgoodnessGraphN, b : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_graphn_copy(s : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  let result = stats_test_goodness_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_graphn_fill(s : StatstestgoodnessGraphN, v : Double) -> StatstestgoodnessGraphN {
  let result = stats_test_goodness_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_graphn_min(s : StatstestgoodnessGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_graphn_max(s : StatstestgoodnessGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_graphn_to_string(s : StatstestgoodnessGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_node_make(size : Int) -> StatstestgoodnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_node_len(s : StatstestgoodnessNode) -> Int { s.size }

pub fn stats_test_goodness_node_get(s : StatstestgoodnessNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_node_set(s : StatstestgoodnessNode, i : Int, v : Double) -> StatstestgoodnessNode {
  let result = stats_test_goodness_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_node_sum(s : StatstestgoodnessNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_node_mean(s : StatstestgoodnessNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_node_scale(s : StatstestgoodnessNode, f : Double) -> StatstestgoodnessNode {
  let result = stats_test_goodness_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_node_add(a : StatstestgoodnessNode, b : StatstestgoodnessNode) -> StatstestgoodnessNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_node_copy(s : StatstestgoodnessNode) -> StatstestgoodnessNode {
  let result = stats_test_goodness_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_node_fill(s : StatstestgoodnessNode, v : Double) -> StatstestgoodnessNode {
  let result = stats_test_goodness_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_node_min(s : StatstestgoodnessNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_node_max(s : StatstestgoodnessNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_node_to_string(s : StatstestgoodnessNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_edge_make(size : Int) -> StatstestgoodnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_edge_len(s : StatstestgoodnessEdge) -> Int { s.size }

pub fn stats_test_goodness_edge_get(s : StatstestgoodnessEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_edge_set(s : StatstestgoodnessEdge, i : Int, v : Double) -> StatstestgoodnessEdge {
  let result = stats_test_goodness_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_edge_sum(s : StatstestgoodnessEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_edge_mean(s : StatstestgoodnessEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_edge_scale(s : StatstestgoodnessEdge, f : Double) -> StatstestgoodnessEdge {
  let result = stats_test_goodness_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_edge_add(a : StatstestgoodnessEdge, b : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_edge_copy(s : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  let result = stats_test_goodness_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_edge_fill(s : StatstestgoodnessEdge, v : Double) -> StatstestgoodnessEdge {
  let result = stats_test_goodness_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_edge_min(s : StatstestgoodnessEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_edge_max(s : StatstestgoodnessEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_edge_to_string(s : StatstestgoodnessEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_path_make(size : Int) -> StatstestgoodnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_path_len(s : StatstestgoodnessPath) -> Int { s.size }

pub fn stats_test_goodness_path_get(s : StatstestgoodnessPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_path_set(s : StatstestgoodnessPath, i : Int, v : Double) -> StatstestgoodnessPath {
  let result = stats_test_goodness_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_path_sum(s : StatstestgoodnessPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_path_mean(s : StatstestgoodnessPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_path_scale(s : StatstestgoodnessPath, f : Double) -> StatstestgoodnessPath {
  let result = stats_test_goodness_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_path_add(a : StatstestgoodnessPath, b : StatstestgoodnessPath) -> StatstestgoodnessPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_path_copy(s : StatstestgoodnessPath) -> StatstestgoodnessPath {
  let result = stats_test_goodness_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_path_fill(s : StatstestgoodnessPath, v : Double) -> StatstestgoodnessPath {
  let result = stats_test_goodness_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_path_min(s : StatstestgoodnessPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_path_max(s : StatstestgoodnessPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_path_to_string(s : StatstestgoodnessPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cluster_make(size : Int) -> StatstestgoodnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_cluster_len(s : StatstestgoodnessCluster) -> Int { s.size }

pub fn stats_test_goodness_cluster_get(s : StatstestgoodnessCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_cluster_set(s : StatstestgoodnessCluster, i : Int, v : Double) -> StatstestgoodnessCluster {
  let result = stats_test_goodness_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_cluster_sum(s : StatstestgoodnessCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_cluster_mean(s : StatstestgoodnessCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_cluster_scale(s : StatstestgoodnessCluster, f : Double) -> StatstestgoodnessCluster {
  let result = stats_test_goodness_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_cluster_add(a : StatstestgoodnessCluster, b : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_cluster_copy(s : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  let result = stats_test_goodness_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_cluster_fill(s : StatstestgoodnessCluster, v : Double) -> StatstestgoodnessCluster {
  let result = stats_test_goodness_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_cluster_min(s : StatstestgoodnessCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_cluster_max(s : StatstestgoodnessCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_cluster_to_string(s : StatstestgoodnessCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_model_make(size : Int) -> StatstestgoodnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_model_len(s : StatstestgoodnessModel) -> Int { s.size }

pub fn stats_test_goodness_model_get(s : StatstestgoodnessModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_model_set(s : StatstestgoodnessModel, i : Int, v : Double) -> StatstestgoodnessModel {
  let result = stats_test_goodness_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_model_sum(s : StatstestgoodnessModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_model_mean(s : StatstestgoodnessModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_model_scale(s : StatstestgoodnessModel, f : Double) -> StatstestgoodnessModel {
  let result = stats_test_goodness_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_model_add(a : StatstestgoodnessModel, b : StatstestgoodnessModel) -> StatstestgoodnessModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_model_copy(s : StatstestgoodnessModel) -> StatstestgoodnessModel {
  let result = stats_test_goodness_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_model_fill(s : StatstestgoodnessModel, v : Double) -> StatstestgoodnessModel {
  let result = stats_test_goodness_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_model_min(s : StatstestgoodnessModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_model_max(s : StatstestgoodnessModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_model_to_string(s : StatstestgoodnessModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_layer_make(size : Int) -> StatstestgoodnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_layer_len(s : StatstestgoodnessLayer) -> Int { s.size }

pub fn stats_test_goodness_layer_get(s : StatstestgoodnessLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_layer_set(s : StatstestgoodnessLayer, i : Int, v : Double) -> StatstestgoodnessLayer {
  let result = stats_test_goodness_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_layer_sum(s : StatstestgoodnessLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_layer_mean(s : StatstestgoodnessLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_layer_scale(s : StatstestgoodnessLayer, f : Double) -> StatstestgoodnessLayer {
  let result = stats_test_goodness_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_layer_add(a : StatstestgoodnessLayer, b : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_layer_copy(s : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  let result = stats_test_goodness_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_layer_fill(s : StatstestgoodnessLayer, v : Double) -> StatstestgoodnessLayer {
  let result = stats_test_goodness_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_layer_min(s : StatstestgoodnessLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_layer_max(s : StatstestgoodnessLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_layer_to_string(s : StatstestgoodnessLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_buffer_make(size : Int) -> StatstestgoodnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_buffer_len(s : StatstestgoodnessBuffer) -> Int { s.size }

pub fn stats_test_goodness_buffer_get(s : StatstestgoodnessBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_buffer_set(s : StatstestgoodnessBuffer, i : Int, v : Double) -> StatstestgoodnessBuffer {
  let result = stats_test_goodness_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_buffer_sum(s : StatstestgoodnessBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_buffer_mean(s : StatstestgoodnessBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_buffer_scale(s : StatstestgoodnessBuffer, f : Double) -> StatstestgoodnessBuffer {
  let result = stats_test_goodness_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_buffer_add(a : StatstestgoodnessBuffer, b : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_buffer_copy(s : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  let result = stats_test_goodness_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_buffer_fill(s : StatstestgoodnessBuffer, v : Double) -> StatstestgoodnessBuffer {
  let result = stats_test_goodness_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_buffer_min(s : StatstestgoodnessBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_buffer_max(s : StatstestgoodnessBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_buffer_to_string(s : StatstestgoodnessBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cursor_make(size : Int) -> StatstestgoodnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_cursor_len(s : StatstestgoodnessCursor) -> Int { s.size }

pub fn stats_test_goodness_cursor_get(s : StatstestgoodnessCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_cursor_set(s : StatstestgoodnessCursor, i : Int, v : Double) -> StatstestgoodnessCursor {
  let result = stats_test_goodness_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_cursor_sum(s : StatstestgoodnessCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_cursor_mean(s : StatstestgoodnessCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_cursor_scale(s : StatstestgoodnessCursor, f : Double) -> StatstestgoodnessCursor {
  let result = stats_test_goodness_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_cursor_add(a : StatstestgoodnessCursor, b : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_cursor_copy(s : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  let result = stats_test_goodness_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_cursor_fill(s : StatstestgoodnessCursor, v : Double) -> StatstestgoodnessCursor {
  let result = stats_test_goodness_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_cursor_min(s : StatstestgoodnessCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_cursor_max(s : StatstestgoodnessCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_cursor_to_string(s : StatstestgoodnessCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_view_make(size : Int) -> StatstestgoodnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_view_len(s : StatstestgoodnessView) -> Int { s.size }

pub fn stats_test_goodness_view_get(s : StatstestgoodnessView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_view_set(s : StatstestgoodnessView, i : Int, v : Double) -> StatstestgoodnessView {
  let result = stats_test_goodness_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_view_sum(s : StatstestgoodnessView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_view_mean(s : StatstestgoodnessView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_view_scale(s : StatstestgoodnessView, f : Double) -> StatstestgoodnessView {
  let result = stats_test_goodness_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_view_add(a : StatstestgoodnessView, b : StatstestgoodnessView) -> StatstestgoodnessView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_view_copy(s : StatstestgoodnessView) -> StatstestgoodnessView {
  let result = stats_test_goodness_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_view_fill(s : StatstestgoodnessView, v : Double) -> StatstestgoodnessView {
  let result = stats_test_goodness_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_view_min(s : StatstestgoodnessView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_view_max(s : StatstestgoodnessView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_view_to_string(s : StatstestgoodnessView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_range_make(size : Int) -> StatstestgoodnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_range_len(s : StatstestgoodnessRange) -> Int { s.size }

pub fn stats_test_goodness_range_get(s : StatstestgoodnessRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_range_set(s : StatstestgoodnessRange, i : Int, v : Double) -> StatstestgoodnessRange {
  let result = stats_test_goodness_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_range_sum(s : StatstestgoodnessRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_range_mean(s : StatstestgoodnessRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_range_scale(s : StatstestgoodnessRange, f : Double) -> StatstestgoodnessRange {
  let result = stats_test_goodness_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_range_add(a : StatstestgoodnessRange, b : StatstestgoodnessRange) -> StatstestgoodnessRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_range_copy(s : StatstestgoodnessRange) -> StatstestgoodnessRange {
  let result = stats_test_goodness_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_range_fill(s : StatstestgoodnessRange, v : Double) -> StatstestgoodnessRange {
  let result = stats_test_goodness_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_range_min(s : StatstestgoodnessRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_range_max(s : StatstestgoodnessRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_range_to_string(s : StatstestgoodnessRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_slice_make(size : Int) -> StatstestgoodnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_slice_len(s : StatstestgoodnessSlice) -> Int { s.size }

pub fn stats_test_goodness_slice_get(s : StatstestgoodnessSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_slice_set(s : StatstestgoodnessSlice, i : Int, v : Double) -> StatstestgoodnessSlice {
  let result = stats_test_goodness_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_slice_sum(s : StatstestgoodnessSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_goodness_slice_mean(s : StatstestgoodnessSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_goodness_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_goodness_slice_scale(s : StatstestgoodnessSlice, f : Double) -> StatstestgoodnessSlice {
  let result = stats_test_goodness_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_goodness_slice_add(a : StatstestgoodnessSlice, b : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_goodness_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_goodness_slice_copy(s : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  let result = stats_test_goodness_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_goodness_slice_fill(s : StatstestgoodnessSlice, v : Double) -> StatstestgoodnessSlice {
  let result = stats_test_goodness_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_goodness_slice_min(s : StatstestgoodnessSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_slice_max(s : StatstestgoodnessSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_goodness_slice_to_string(s : StatstestgoodnessSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


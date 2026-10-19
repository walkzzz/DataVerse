///===
/// extcore/opt_meta_pso

pub(all) struct OptmetapsoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_pso_make_point(x : Double, y : Double) -> OptmetapsoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_pso_make_point3(x : Double, y : Double, z : Double) -> OptmetapsoPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_pso_point_x(pt : OptmetapsoPoint) -> Double { pt.x }

pub fn opt_meta_pso_point_y(pt : OptmetapsoPoint) -> Double { pt.y }

pub fn opt_meta_pso_point_z(pt : OptmetapsoPoint) -> Double { pt.z }

pub fn opt_meta_pso_point_label(pt : OptmetapsoPoint) -> Int { pt.label }

pub fn opt_meta_pso_point_dist(a : OptmetapsoPoint, b : OptmetapsoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_pso_point_add(a : OptmetapsoPoint, b : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_pso_point_sub(a : OptmetapsoPoint, b : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_pso_point_scale(pt : OptmetapsoPoint, s : Double) -> OptmetapsoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_pso_point_dot(a : OptmetapsoPoint, b : OptmetapsoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_pso_point_cross(a : OptmetapsoPoint, b : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_pso_point_norm(pt : OptmetapsoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_pso_point_normalize(pt : OptmetapsoPoint) -> OptmetapsoPoint {
  let n = opt_meta_pso_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_pso_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_pso_point_negate(pt : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_pso_point_mid(a : OptmetapsoPoint, b : OptmetapsoPoint) -> OptmetapsoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_pso_point_lerp(a : OptmetapsoPoint, b : OptmetapsoPoint, t : Double) -> OptmetapsoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_pso_point_to_string(pt : OptmetapsoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetapsoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_pso_make_series(vals : Array[Double], name : String) -> OptmetapsoSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_pso_series_len(s : OptmetapsoSeries) -> Int { s.vals.length() }

pub fn opt_meta_pso_series_sum(s : OptmetapsoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_pso_series_mean(s : OptmetapsoSeries) -> Double {
  let n = opt_meta_pso_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_pso_series_sum(s) / n.to_double() }
}

pub fn opt_meta_pso_series_min(s : OptmetapsoSeries) -> Double {
  let n = opt_meta_pso_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_pso_series_max(s : OptmetapsoSeries) -> Double {
  let n = opt_meta_pso_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_pso_series_range(s : OptmetapsoSeries) -> Double {
  opt_meta_pso_series_max(s) - opt_meta_pso_series_min(s)
}

pub fn opt_meta_pso_series_var(s : OptmetapsoSeries) -> Double {
  let n = opt_meta_pso_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_pso_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_pso_series_std(s : OptmetapsoSeries) -> Double { @_common.sqrt(opt_meta_pso_series_var(s)) }

pub fn opt_meta_pso_series_median(s : OptmetapsoSeries) -> Double {
  let n = opt_meta_pso_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_pso_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_pso_series_scale(s : OptmetapsoSeries, f : Double) -> OptmetapsoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_pso_series_add(a : OptmetapsoSeries, b : OptmetapsoSeries) -> OptmetapsoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_pso_series_sub(a : OptmetapsoSeries, b : OptmetapsoSeries) -> OptmetapsoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_pso_series_normalize(s : OptmetapsoSeries) -> OptmetapsoSeries {
  let mn = opt_meta_pso_series_min(s)
  let mx = opt_meta_pso_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_pso_series_cumsum(s : OptmetapsoSeries) -> OptmetapsoSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_pso_series_to_string(s : OptmetapsoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetapsoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_pso_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetapsoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_pso_matrix_identity(n : Int) -> OptmetapsoMatrix {
  let m = opt_meta_pso_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_pso_matrix_get(m : OptmetapsoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_pso_matrix_transpose(m : OptmetapsoMatrix) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_pso_matrix_add(a : OptmetapsoMatrix, b : OptmetapsoMatrix) -> OptmetapsoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_pso_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_pso_matrix_scale(m : OptmetapsoMatrix, s : Double) -> OptmetapsoMatrix {
  let result = opt_meta_pso_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_pso_matrix_multiply(a : OptmetapsoMatrix, b : OptmetapsoMatrix) -> OptmetapsoMatrix {
  if a.cols != b.rows { return opt_meta_pso_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_pso_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_pso_matrix_trace(m : OptmetapsoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_pso_matrix_det(m : OptmetapsoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_pso_matrix_norm(m : OptmetapsoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_pso_matrix_to_string(m : OptmetapsoMatrix) -> String {
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

pub(all) struct OptmetapsoVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_pso_make_vector(comps : Array[Double]) -> OptmetapsoVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_pso_vector_zero(dim : Int) -> OptmetapsoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_pso_vector_add(a : OptmetapsoVector, b : OptmetapsoVector) -> OptmetapsoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_pso_vector_sub(a : OptmetapsoVector, b : OptmetapsoVector) -> OptmetapsoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_pso_vector_scale(v : OptmetapsoVector, s : Double) -> OptmetapsoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_pso_vector_dot(a : OptmetapsoVector, b : OptmetapsoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_pso_vector_norm(v : OptmetapsoVector) -> Double { @_common.sqrt(opt_meta_pso_vector_dot(v, v)) }

pub fn opt_meta_pso_vector_normalize(v : OptmetapsoVector) -> OptmetapsoVector {
  let n = opt_meta_pso_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_pso_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_pso_vector_dist(a : OptmetapsoVector, b : OptmetapsoVector) -> Double {
  opt_meta_pso_vector_norm(opt_meta_pso_vector_sub(a, b))
}

pub fn opt_meta_pso_vector_to_string(v : OptmetapsoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_pso_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_pso_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_pso_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_pso_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_pso_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_pso_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_pso_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_pso_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_pso_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_pso_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_pso_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_pso_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_pso_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_pso_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_pso_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_pso_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_pso_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_pso_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_pso_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_pso_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_pso_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_pso_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_pso_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_pso_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_pso_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_pso_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_pso_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_pso_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_pso_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetapsoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_frame_make(size : Int) -> OptmetapsoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_frame_len(s : OptmetapsoFrame) -> Int { s.size }

pub fn opt_meta_pso_frame_get(s : OptmetapsoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_frame_set(s : OptmetapsoFrame, i : Int, v : Double) -> OptmetapsoFrame {
  let result = opt_meta_pso_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_frame_sum(s : OptmetapsoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_frame_mean(s : OptmetapsoFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_frame_scale(s : OptmetapsoFrame, f : Double) -> OptmetapsoFrame {
  let result = opt_meta_pso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_frame_add(a : OptmetapsoFrame, b : OptmetapsoFrame) -> OptmetapsoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_frame_copy(s : OptmetapsoFrame) -> OptmetapsoFrame {
  let result = opt_meta_pso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_frame_fill(s : OptmetapsoFrame, v : Double) -> OptmetapsoFrame {
  let result = opt_meta_pso_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_frame_min(s : OptmetapsoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_frame_max(s : OptmetapsoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_frame_to_string(s : OptmetapsoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_table_make(size : Int) -> OptmetapsoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_table_len(s : OptmetapsoTable) -> Int { s.size }

pub fn opt_meta_pso_table_get(s : OptmetapsoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_table_set(s : OptmetapsoTable, i : Int, v : Double) -> OptmetapsoTable {
  let result = opt_meta_pso_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_table_sum(s : OptmetapsoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_table_mean(s : OptmetapsoTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_table_scale(s : OptmetapsoTable, f : Double) -> OptmetapsoTable {
  let result = opt_meta_pso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_table_add(a : OptmetapsoTable, b : OptmetapsoTable) -> OptmetapsoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_table_copy(s : OptmetapsoTable) -> OptmetapsoTable {
  let result = opt_meta_pso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_table_fill(s : OptmetapsoTable, v : Double) -> OptmetapsoTable {
  let result = opt_meta_pso_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_table_min(s : OptmetapsoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_table_max(s : OptmetapsoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_table_to_string(s : OptmetapsoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_graphn_make(size : Int) -> OptmetapsoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_graphn_len(s : OptmetapsoGraphN) -> Int { s.size }

pub fn opt_meta_pso_graphn_get(s : OptmetapsoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_graphn_set(s : OptmetapsoGraphN, i : Int, v : Double) -> OptmetapsoGraphN {
  let result = opt_meta_pso_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_graphn_sum(s : OptmetapsoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_graphn_mean(s : OptmetapsoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_graphn_scale(s : OptmetapsoGraphN, f : Double) -> OptmetapsoGraphN {
  let result = opt_meta_pso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_graphn_add(a : OptmetapsoGraphN, b : OptmetapsoGraphN) -> OptmetapsoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_graphn_copy(s : OptmetapsoGraphN) -> OptmetapsoGraphN {
  let result = opt_meta_pso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_graphn_fill(s : OptmetapsoGraphN, v : Double) -> OptmetapsoGraphN {
  let result = opt_meta_pso_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_graphn_min(s : OptmetapsoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_graphn_max(s : OptmetapsoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_graphn_to_string(s : OptmetapsoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_node_make(size : Int) -> OptmetapsoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_node_len(s : OptmetapsoNode) -> Int { s.size }

pub fn opt_meta_pso_node_get(s : OptmetapsoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_node_set(s : OptmetapsoNode, i : Int, v : Double) -> OptmetapsoNode {
  let result = opt_meta_pso_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_node_sum(s : OptmetapsoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_node_mean(s : OptmetapsoNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_node_scale(s : OptmetapsoNode, f : Double) -> OptmetapsoNode {
  let result = opt_meta_pso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_node_add(a : OptmetapsoNode, b : OptmetapsoNode) -> OptmetapsoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_node_copy(s : OptmetapsoNode) -> OptmetapsoNode {
  let result = opt_meta_pso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_node_fill(s : OptmetapsoNode, v : Double) -> OptmetapsoNode {
  let result = opt_meta_pso_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_node_min(s : OptmetapsoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_node_max(s : OptmetapsoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_node_to_string(s : OptmetapsoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_edge_make(size : Int) -> OptmetapsoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_edge_len(s : OptmetapsoEdge) -> Int { s.size }

pub fn opt_meta_pso_edge_get(s : OptmetapsoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_edge_set(s : OptmetapsoEdge, i : Int, v : Double) -> OptmetapsoEdge {
  let result = opt_meta_pso_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_edge_sum(s : OptmetapsoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_edge_mean(s : OptmetapsoEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_edge_scale(s : OptmetapsoEdge, f : Double) -> OptmetapsoEdge {
  let result = opt_meta_pso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_edge_add(a : OptmetapsoEdge, b : OptmetapsoEdge) -> OptmetapsoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_edge_copy(s : OptmetapsoEdge) -> OptmetapsoEdge {
  let result = opt_meta_pso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_edge_fill(s : OptmetapsoEdge, v : Double) -> OptmetapsoEdge {
  let result = opt_meta_pso_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_edge_min(s : OptmetapsoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_edge_max(s : OptmetapsoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_edge_to_string(s : OptmetapsoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_path_make(size : Int) -> OptmetapsoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_path_len(s : OptmetapsoPath) -> Int { s.size }

pub fn opt_meta_pso_path_get(s : OptmetapsoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_path_set(s : OptmetapsoPath, i : Int, v : Double) -> OptmetapsoPath {
  let result = opt_meta_pso_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_path_sum(s : OptmetapsoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_path_mean(s : OptmetapsoPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_path_scale(s : OptmetapsoPath, f : Double) -> OptmetapsoPath {
  let result = opt_meta_pso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_path_add(a : OptmetapsoPath, b : OptmetapsoPath) -> OptmetapsoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_path_copy(s : OptmetapsoPath) -> OptmetapsoPath {
  let result = opt_meta_pso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_path_fill(s : OptmetapsoPath, v : Double) -> OptmetapsoPath {
  let result = opt_meta_pso_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_path_min(s : OptmetapsoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_path_max(s : OptmetapsoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_path_to_string(s : OptmetapsoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_cluster_make(size : Int) -> OptmetapsoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_cluster_len(s : OptmetapsoCluster) -> Int { s.size }

pub fn opt_meta_pso_cluster_get(s : OptmetapsoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_cluster_set(s : OptmetapsoCluster, i : Int, v : Double) -> OptmetapsoCluster {
  let result = opt_meta_pso_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_cluster_sum(s : OptmetapsoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_cluster_mean(s : OptmetapsoCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_cluster_scale(s : OptmetapsoCluster, f : Double) -> OptmetapsoCluster {
  let result = opt_meta_pso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_cluster_add(a : OptmetapsoCluster, b : OptmetapsoCluster) -> OptmetapsoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_cluster_copy(s : OptmetapsoCluster) -> OptmetapsoCluster {
  let result = opt_meta_pso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_cluster_fill(s : OptmetapsoCluster, v : Double) -> OptmetapsoCluster {
  let result = opt_meta_pso_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_cluster_min(s : OptmetapsoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_cluster_max(s : OptmetapsoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_cluster_to_string(s : OptmetapsoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_model_make(size : Int) -> OptmetapsoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_model_len(s : OptmetapsoModel) -> Int { s.size }

pub fn opt_meta_pso_model_get(s : OptmetapsoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_model_set(s : OptmetapsoModel, i : Int, v : Double) -> OptmetapsoModel {
  let result = opt_meta_pso_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_model_sum(s : OptmetapsoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_model_mean(s : OptmetapsoModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_model_scale(s : OptmetapsoModel, f : Double) -> OptmetapsoModel {
  let result = opt_meta_pso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_model_add(a : OptmetapsoModel, b : OptmetapsoModel) -> OptmetapsoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_model_copy(s : OptmetapsoModel) -> OptmetapsoModel {
  let result = opt_meta_pso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_model_fill(s : OptmetapsoModel, v : Double) -> OptmetapsoModel {
  let result = opt_meta_pso_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_model_min(s : OptmetapsoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_model_max(s : OptmetapsoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_model_to_string(s : OptmetapsoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_layer_make(size : Int) -> OptmetapsoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_layer_len(s : OptmetapsoLayer) -> Int { s.size }

pub fn opt_meta_pso_layer_get(s : OptmetapsoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_layer_set(s : OptmetapsoLayer, i : Int, v : Double) -> OptmetapsoLayer {
  let result = opt_meta_pso_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_layer_sum(s : OptmetapsoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_layer_mean(s : OptmetapsoLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_layer_scale(s : OptmetapsoLayer, f : Double) -> OptmetapsoLayer {
  let result = opt_meta_pso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_layer_add(a : OptmetapsoLayer, b : OptmetapsoLayer) -> OptmetapsoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_layer_copy(s : OptmetapsoLayer) -> OptmetapsoLayer {
  let result = opt_meta_pso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_layer_fill(s : OptmetapsoLayer, v : Double) -> OptmetapsoLayer {
  let result = opt_meta_pso_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_layer_min(s : OptmetapsoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_layer_max(s : OptmetapsoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_layer_to_string(s : OptmetapsoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_buffer_make(size : Int) -> OptmetapsoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_buffer_len(s : OptmetapsoBuffer) -> Int { s.size }

pub fn opt_meta_pso_buffer_get(s : OptmetapsoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_buffer_set(s : OptmetapsoBuffer, i : Int, v : Double) -> OptmetapsoBuffer {
  let result = opt_meta_pso_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_buffer_sum(s : OptmetapsoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_buffer_mean(s : OptmetapsoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_buffer_scale(s : OptmetapsoBuffer, f : Double) -> OptmetapsoBuffer {
  let result = opt_meta_pso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_buffer_add(a : OptmetapsoBuffer, b : OptmetapsoBuffer) -> OptmetapsoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_buffer_copy(s : OptmetapsoBuffer) -> OptmetapsoBuffer {
  let result = opt_meta_pso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_buffer_fill(s : OptmetapsoBuffer, v : Double) -> OptmetapsoBuffer {
  let result = opt_meta_pso_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_buffer_min(s : OptmetapsoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_buffer_max(s : OptmetapsoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_buffer_to_string(s : OptmetapsoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_cursor_make(size : Int) -> OptmetapsoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_cursor_len(s : OptmetapsoCursor) -> Int { s.size }

pub fn opt_meta_pso_cursor_get(s : OptmetapsoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_cursor_set(s : OptmetapsoCursor, i : Int, v : Double) -> OptmetapsoCursor {
  let result = opt_meta_pso_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_cursor_sum(s : OptmetapsoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_cursor_mean(s : OptmetapsoCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_cursor_scale(s : OptmetapsoCursor, f : Double) -> OptmetapsoCursor {
  let result = opt_meta_pso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_cursor_add(a : OptmetapsoCursor, b : OptmetapsoCursor) -> OptmetapsoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_cursor_copy(s : OptmetapsoCursor) -> OptmetapsoCursor {
  let result = opt_meta_pso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_cursor_fill(s : OptmetapsoCursor, v : Double) -> OptmetapsoCursor {
  let result = opt_meta_pso_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_cursor_min(s : OptmetapsoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_cursor_max(s : OptmetapsoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_cursor_to_string(s : OptmetapsoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_view_make(size : Int) -> OptmetapsoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_view_len(s : OptmetapsoView) -> Int { s.size }

pub fn opt_meta_pso_view_get(s : OptmetapsoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_view_set(s : OptmetapsoView, i : Int, v : Double) -> OptmetapsoView {
  let result = opt_meta_pso_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_view_sum(s : OptmetapsoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_view_mean(s : OptmetapsoView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_view_scale(s : OptmetapsoView, f : Double) -> OptmetapsoView {
  let result = opt_meta_pso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_view_add(a : OptmetapsoView, b : OptmetapsoView) -> OptmetapsoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_view_copy(s : OptmetapsoView) -> OptmetapsoView {
  let result = opt_meta_pso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_view_fill(s : OptmetapsoView, v : Double) -> OptmetapsoView {
  let result = opt_meta_pso_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_view_min(s : OptmetapsoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_view_max(s : OptmetapsoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_view_to_string(s : OptmetapsoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_range_make(size : Int) -> OptmetapsoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_range_len(s : OptmetapsoRange) -> Int { s.size }

pub fn opt_meta_pso_range_get(s : OptmetapsoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_range_set(s : OptmetapsoRange, i : Int, v : Double) -> OptmetapsoRange {
  let result = opt_meta_pso_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_range_sum(s : OptmetapsoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_range_mean(s : OptmetapsoRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_range_scale(s : OptmetapsoRange, f : Double) -> OptmetapsoRange {
  let result = opt_meta_pso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_range_add(a : OptmetapsoRange, b : OptmetapsoRange) -> OptmetapsoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_range_copy(s : OptmetapsoRange) -> OptmetapsoRange {
  let result = opt_meta_pso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_range_fill(s : OptmetapsoRange, v : Double) -> OptmetapsoRange {
  let result = opt_meta_pso_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_range_min(s : OptmetapsoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_range_max(s : OptmetapsoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_range_to_string(s : OptmetapsoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetapsoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_pso_slice_make(size : Int) -> OptmetapsoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_pso_slice_len(s : OptmetapsoSlice) -> Int { s.size }

pub fn opt_meta_pso_slice_get(s : OptmetapsoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_pso_slice_set(s : OptmetapsoSlice, i : Int, v : Double) -> OptmetapsoSlice {
  let result = opt_meta_pso_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_slice_sum(s : OptmetapsoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_pso_slice_mean(s : OptmetapsoSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_pso_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_pso_slice_scale(s : OptmetapsoSlice, f : Double) -> OptmetapsoSlice {
  let result = opt_meta_pso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_pso_slice_add(a : OptmetapsoSlice, b : OptmetapsoSlice) -> OptmetapsoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_pso_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_pso_slice_copy(s : OptmetapsoSlice) -> OptmetapsoSlice {
  let result = opt_meta_pso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_pso_slice_fill(s : OptmetapsoSlice, v : Double) -> OptmetapsoSlice {
  let result = opt_meta_pso_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_pso_slice_min(s : OptmetapsoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_slice_max(s : OptmetapsoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_pso_slice_to_string(s : OptmetapsoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


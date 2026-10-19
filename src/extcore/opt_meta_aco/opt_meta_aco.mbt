///===
/// extcore/opt_meta_aco

pub(all) struct OptmetaacoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_aco_make_point(x : Double, y : Double) -> OptmetaacoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_aco_make_point3(x : Double, y : Double, z : Double) -> OptmetaacoPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_aco_point_x(pt : OptmetaacoPoint) -> Double { pt.x }

pub fn opt_meta_aco_point_y(pt : OptmetaacoPoint) -> Double { pt.y }

pub fn opt_meta_aco_point_z(pt : OptmetaacoPoint) -> Double { pt.z }

pub fn opt_meta_aco_point_label(pt : OptmetaacoPoint) -> Int { pt.label }

pub fn opt_meta_aco_point_dist(a : OptmetaacoPoint, b : OptmetaacoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_aco_point_add(a : OptmetaacoPoint, b : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_aco_point_sub(a : OptmetaacoPoint, b : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_aco_point_scale(pt : OptmetaacoPoint, s : Double) -> OptmetaacoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_aco_point_dot(a : OptmetaacoPoint, b : OptmetaacoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_aco_point_cross(a : OptmetaacoPoint, b : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_aco_point_norm(pt : OptmetaacoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_aco_point_normalize(pt : OptmetaacoPoint) -> OptmetaacoPoint {
  let n = opt_meta_aco_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_aco_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_aco_point_negate(pt : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_aco_point_mid(a : OptmetaacoPoint, b : OptmetaacoPoint) -> OptmetaacoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_aco_point_lerp(a : OptmetaacoPoint, b : OptmetaacoPoint, t : Double) -> OptmetaacoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_aco_point_to_string(pt : OptmetaacoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetaacoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_aco_make_series(vals : Array[Double], name : String) -> OptmetaacoSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_aco_series_len(s : OptmetaacoSeries) -> Int { s.vals.length() }

pub fn opt_meta_aco_series_sum(s : OptmetaacoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_aco_series_mean(s : OptmetaacoSeries) -> Double {
  let n = opt_meta_aco_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_aco_series_sum(s) / n.to_double() }
}

pub fn opt_meta_aco_series_min(s : OptmetaacoSeries) -> Double {
  let n = opt_meta_aco_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_aco_series_max(s : OptmetaacoSeries) -> Double {
  let n = opt_meta_aco_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_aco_series_range(s : OptmetaacoSeries) -> Double {
  opt_meta_aco_series_max(s) - opt_meta_aco_series_min(s)
}

pub fn opt_meta_aco_series_var(s : OptmetaacoSeries) -> Double {
  let n = opt_meta_aco_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_aco_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_aco_series_std(s : OptmetaacoSeries) -> Double { @_common.sqrt(opt_meta_aco_series_var(s)) }

pub fn opt_meta_aco_series_median(s : OptmetaacoSeries) -> Double {
  let n = opt_meta_aco_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_aco_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_aco_series_scale(s : OptmetaacoSeries, f : Double) -> OptmetaacoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_aco_series_add(a : OptmetaacoSeries, b : OptmetaacoSeries) -> OptmetaacoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_aco_series_sub(a : OptmetaacoSeries, b : OptmetaacoSeries) -> OptmetaacoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_aco_series_normalize(s : OptmetaacoSeries) -> OptmetaacoSeries {
  let mn = opt_meta_aco_series_min(s)
  let mx = opt_meta_aco_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_aco_series_cumsum(s : OptmetaacoSeries) -> OptmetaacoSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_aco_series_to_string(s : OptmetaacoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetaacoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_aco_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetaacoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_aco_matrix_identity(n : Int) -> OptmetaacoMatrix {
  let m = opt_meta_aco_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_aco_matrix_get(m : OptmetaacoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_aco_matrix_transpose(m : OptmetaacoMatrix) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_aco_matrix_add(a : OptmetaacoMatrix, b : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_aco_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_aco_matrix_scale(m : OptmetaacoMatrix, s : Double) -> OptmetaacoMatrix {
  let result = opt_meta_aco_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_aco_matrix_multiply(a : OptmetaacoMatrix, b : OptmetaacoMatrix) -> OptmetaacoMatrix {
  if a.cols != b.rows { return opt_meta_aco_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_aco_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_aco_matrix_trace(m : OptmetaacoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_aco_matrix_det(m : OptmetaacoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_aco_matrix_norm(m : OptmetaacoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_aco_matrix_to_string(m : OptmetaacoMatrix) -> String {
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

pub(all) struct OptmetaacoVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_aco_make_vector(comps : Array[Double]) -> OptmetaacoVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_aco_vector_zero(dim : Int) -> OptmetaacoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_aco_vector_add(a : OptmetaacoVector, b : OptmetaacoVector) -> OptmetaacoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_aco_vector_sub(a : OptmetaacoVector, b : OptmetaacoVector) -> OptmetaacoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_aco_vector_scale(v : OptmetaacoVector, s : Double) -> OptmetaacoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_aco_vector_dot(a : OptmetaacoVector, b : OptmetaacoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_aco_vector_norm(v : OptmetaacoVector) -> Double { @_common.sqrt(opt_meta_aco_vector_dot(v, v)) }

pub fn opt_meta_aco_vector_normalize(v : OptmetaacoVector) -> OptmetaacoVector {
  let n = opt_meta_aco_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_aco_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_aco_vector_dist(a : OptmetaacoVector, b : OptmetaacoVector) -> Double {
  opt_meta_aco_vector_norm(opt_meta_aco_vector_sub(a, b))
}

pub fn opt_meta_aco_vector_to_string(v : OptmetaacoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_aco_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_aco_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_aco_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_aco_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_aco_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_aco_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_aco_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_aco_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_aco_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_aco_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_aco_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_aco_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_aco_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_aco_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_aco_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_aco_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_aco_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_aco_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_aco_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_aco_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_aco_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_aco_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_aco_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_aco_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_aco_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_aco_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_aco_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_aco_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_aco_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetaacoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_frame_make(size : Int) -> OptmetaacoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_frame_len(s : OptmetaacoFrame) -> Int { s.size }

pub fn opt_meta_aco_frame_get(s : OptmetaacoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_frame_set(s : OptmetaacoFrame, i : Int, v : Double) -> OptmetaacoFrame {
  let result = opt_meta_aco_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_frame_sum(s : OptmetaacoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_frame_mean(s : OptmetaacoFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_frame_scale(s : OptmetaacoFrame, f : Double) -> OptmetaacoFrame {
  let result = opt_meta_aco_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_frame_add(a : OptmetaacoFrame, b : OptmetaacoFrame) -> OptmetaacoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_frame_copy(s : OptmetaacoFrame) -> OptmetaacoFrame {
  let result = opt_meta_aco_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_frame_fill(s : OptmetaacoFrame, v : Double) -> OptmetaacoFrame {
  let result = opt_meta_aco_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_frame_min(s : OptmetaacoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_frame_max(s : OptmetaacoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_frame_to_string(s : OptmetaacoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_table_make(size : Int) -> OptmetaacoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_table_len(s : OptmetaacoTable) -> Int { s.size }

pub fn opt_meta_aco_table_get(s : OptmetaacoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_table_set(s : OptmetaacoTable, i : Int, v : Double) -> OptmetaacoTable {
  let result = opt_meta_aco_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_table_sum(s : OptmetaacoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_table_mean(s : OptmetaacoTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_table_scale(s : OptmetaacoTable, f : Double) -> OptmetaacoTable {
  let result = opt_meta_aco_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_table_add(a : OptmetaacoTable, b : OptmetaacoTable) -> OptmetaacoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_table_copy(s : OptmetaacoTable) -> OptmetaacoTable {
  let result = opt_meta_aco_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_table_fill(s : OptmetaacoTable, v : Double) -> OptmetaacoTable {
  let result = opt_meta_aco_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_table_min(s : OptmetaacoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_table_max(s : OptmetaacoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_table_to_string(s : OptmetaacoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_graphn_make(size : Int) -> OptmetaacoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_graphn_len(s : OptmetaacoGraphN) -> Int { s.size }

pub fn opt_meta_aco_graphn_get(s : OptmetaacoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_graphn_set(s : OptmetaacoGraphN, i : Int, v : Double) -> OptmetaacoGraphN {
  let result = opt_meta_aco_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_graphn_sum(s : OptmetaacoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_graphn_mean(s : OptmetaacoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_graphn_scale(s : OptmetaacoGraphN, f : Double) -> OptmetaacoGraphN {
  let result = opt_meta_aco_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_graphn_add(a : OptmetaacoGraphN, b : OptmetaacoGraphN) -> OptmetaacoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_graphn_copy(s : OptmetaacoGraphN) -> OptmetaacoGraphN {
  let result = opt_meta_aco_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_graphn_fill(s : OptmetaacoGraphN, v : Double) -> OptmetaacoGraphN {
  let result = opt_meta_aco_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_graphn_min(s : OptmetaacoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_graphn_max(s : OptmetaacoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_graphn_to_string(s : OptmetaacoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_node_make(size : Int) -> OptmetaacoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_node_len(s : OptmetaacoNode) -> Int { s.size }

pub fn opt_meta_aco_node_get(s : OptmetaacoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_node_set(s : OptmetaacoNode, i : Int, v : Double) -> OptmetaacoNode {
  let result = opt_meta_aco_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_node_sum(s : OptmetaacoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_node_mean(s : OptmetaacoNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_node_scale(s : OptmetaacoNode, f : Double) -> OptmetaacoNode {
  let result = opt_meta_aco_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_node_add(a : OptmetaacoNode, b : OptmetaacoNode) -> OptmetaacoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_node_copy(s : OptmetaacoNode) -> OptmetaacoNode {
  let result = opt_meta_aco_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_node_fill(s : OptmetaacoNode, v : Double) -> OptmetaacoNode {
  let result = opt_meta_aco_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_node_min(s : OptmetaacoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_node_max(s : OptmetaacoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_node_to_string(s : OptmetaacoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_edge_make(size : Int) -> OptmetaacoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_edge_len(s : OptmetaacoEdge) -> Int { s.size }

pub fn opt_meta_aco_edge_get(s : OptmetaacoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_edge_set(s : OptmetaacoEdge, i : Int, v : Double) -> OptmetaacoEdge {
  let result = opt_meta_aco_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_edge_sum(s : OptmetaacoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_edge_mean(s : OptmetaacoEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_edge_scale(s : OptmetaacoEdge, f : Double) -> OptmetaacoEdge {
  let result = opt_meta_aco_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_edge_add(a : OptmetaacoEdge, b : OptmetaacoEdge) -> OptmetaacoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_edge_copy(s : OptmetaacoEdge) -> OptmetaacoEdge {
  let result = opt_meta_aco_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_edge_fill(s : OptmetaacoEdge, v : Double) -> OptmetaacoEdge {
  let result = opt_meta_aco_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_edge_min(s : OptmetaacoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_edge_max(s : OptmetaacoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_edge_to_string(s : OptmetaacoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_path_make(size : Int) -> OptmetaacoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_path_len(s : OptmetaacoPath) -> Int { s.size }

pub fn opt_meta_aco_path_get(s : OptmetaacoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_path_set(s : OptmetaacoPath, i : Int, v : Double) -> OptmetaacoPath {
  let result = opt_meta_aco_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_path_sum(s : OptmetaacoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_path_mean(s : OptmetaacoPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_path_scale(s : OptmetaacoPath, f : Double) -> OptmetaacoPath {
  let result = opt_meta_aco_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_path_add(a : OptmetaacoPath, b : OptmetaacoPath) -> OptmetaacoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_path_copy(s : OptmetaacoPath) -> OptmetaacoPath {
  let result = opt_meta_aco_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_path_fill(s : OptmetaacoPath, v : Double) -> OptmetaacoPath {
  let result = opt_meta_aco_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_path_min(s : OptmetaacoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_path_max(s : OptmetaacoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_path_to_string(s : OptmetaacoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cluster_make(size : Int) -> OptmetaacoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_cluster_len(s : OptmetaacoCluster) -> Int { s.size }

pub fn opt_meta_aco_cluster_get(s : OptmetaacoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_cluster_set(s : OptmetaacoCluster, i : Int, v : Double) -> OptmetaacoCluster {
  let result = opt_meta_aco_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_cluster_sum(s : OptmetaacoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_cluster_mean(s : OptmetaacoCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_cluster_scale(s : OptmetaacoCluster, f : Double) -> OptmetaacoCluster {
  let result = opt_meta_aco_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_cluster_add(a : OptmetaacoCluster, b : OptmetaacoCluster) -> OptmetaacoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_cluster_copy(s : OptmetaacoCluster) -> OptmetaacoCluster {
  let result = opt_meta_aco_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_cluster_fill(s : OptmetaacoCluster, v : Double) -> OptmetaacoCluster {
  let result = opt_meta_aco_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_cluster_min(s : OptmetaacoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_cluster_max(s : OptmetaacoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_cluster_to_string(s : OptmetaacoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_model_make(size : Int) -> OptmetaacoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_model_len(s : OptmetaacoModel) -> Int { s.size }

pub fn opt_meta_aco_model_get(s : OptmetaacoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_model_set(s : OptmetaacoModel, i : Int, v : Double) -> OptmetaacoModel {
  let result = opt_meta_aco_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_model_sum(s : OptmetaacoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_model_mean(s : OptmetaacoModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_model_scale(s : OptmetaacoModel, f : Double) -> OptmetaacoModel {
  let result = opt_meta_aco_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_model_add(a : OptmetaacoModel, b : OptmetaacoModel) -> OptmetaacoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_model_copy(s : OptmetaacoModel) -> OptmetaacoModel {
  let result = opt_meta_aco_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_model_fill(s : OptmetaacoModel, v : Double) -> OptmetaacoModel {
  let result = opt_meta_aco_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_model_min(s : OptmetaacoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_model_max(s : OptmetaacoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_model_to_string(s : OptmetaacoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_layer_make(size : Int) -> OptmetaacoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_layer_len(s : OptmetaacoLayer) -> Int { s.size }

pub fn opt_meta_aco_layer_get(s : OptmetaacoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_layer_set(s : OptmetaacoLayer, i : Int, v : Double) -> OptmetaacoLayer {
  let result = opt_meta_aco_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_layer_sum(s : OptmetaacoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_layer_mean(s : OptmetaacoLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_layer_scale(s : OptmetaacoLayer, f : Double) -> OptmetaacoLayer {
  let result = opt_meta_aco_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_layer_add(a : OptmetaacoLayer, b : OptmetaacoLayer) -> OptmetaacoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_layer_copy(s : OptmetaacoLayer) -> OptmetaacoLayer {
  let result = opt_meta_aco_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_layer_fill(s : OptmetaacoLayer, v : Double) -> OptmetaacoLayer {
  let result = opt_meta_aco_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_layer_min(s : OptmetaacoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_layer_max(s : OptmetaacoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_layer_to_string(s : OptmetaacoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_buffer_make(size : Int) -> OptmetaacoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_buffer_len(s : OptmetaacoBuffer) -> Int { s.size }

pub fn opt_meta_aco_buffer_get(s : OptmetaacoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_buffer_set(s : OptmetaacoBuffer, i : Int, v : Double) -> OptmetaacoBuffer {
  let result = opt_meta_aco_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_buffer_sum(s : OptmetaacoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_buffer_mean(s : OptmetaacoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_buffer_scale(s : OptmetaacoBuffer, f : Double) -> OptmetaacoBuffer {
  let result = opt_meta_aco_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_buffer_add(a : OptmetaacoBuffer, b : OptmetaacoBuffer) -> OptmetaacoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_buffer_copy(s : OptmetaacoBuffer) -> OptmetaacoBuffer {
  let result = opt_meta_aco_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_buffer_fill(s : OptmetaacoBuffer, v : Double) -> OptmetaacoBuffer {
  let result = opt_meta_aco_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_buffer_min(s : OptmetaacoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_buffer_max(s : OptmetaacoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_buffer_to_string(s : OptmetaacoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_cursor_make(size : Int) -> OptmetaacoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_cursor_len(s : OptmetaacoCursor) -> Int { s.size }

pub fn opt_meta_aco_cursor_get(s : OptmetaacoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_cursor_set(s : OptmetaacoCursor, i : Int, v : Double) -> OptmetaacoCursor {
  let result = opt_meta_aco_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_cursor_sum(s : OptmetaacoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_cursor_mean(s : OptmetaacoCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_cursor_scale(s : OptmetaacoCursor, f : Double) -> OptmetaacoCursor {
  let result = opt_meta_aco_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_cursor_add(a : OptmetaacoCursor, b : OptmetaacoCursor) -> OptmetaacoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_cursor_copy(s : OptmetaacoCursor) -> OptmetaacoCursor {
  let result = opt_meta_aco_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_cursor_fill(s : OptmetaacoCursor, v : Double) -> OptmetaacoCursor {
  let result = opt_meta_aco_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_cursor_min(s : OptmetaacoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_cursor_max(s : OptmetaacoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_cursor_to_string(s : OptmetaacoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_view_make(size : Int) -> OptmetaacoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_view_len(s : OptmetaacoView) -> Int { s.size }

pub fn opt_meta_aco_view_get(s : OptmetaacoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_view_set(s : OptmetaacoView, i : Int, v : Double) -> OptmetaacoView {
  let result = opt_meta_aco_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_view_sum(s : OptmetaacoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_view_mean(s : OptmetaacoView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_view_scale(s : OptmetaacoView, f : Double) -> OptmetaacoView {
  let result = opt_meta_aco_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_view_add(a : OptmetaacoView, b : OptmetaacoView) -> OptmetaacoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_view_copy(s : OptmetaacoView) -> OptmetaacoView {
  let result = opt_meta_aco_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_view_fill(s : OptmetaacoView, v : Double) -> OptmetaacoView {
  let result = opt_meta_aco_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_view_min(s : OptmetaacoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_view_max(s : OptmetaacoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_view_to_string(s : OptmetaacoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_range_make(size : Int) -> OptmetaacoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_range_len(s : OptmetaacoRange) -> Int { s.size }

pub fn opt_meta_aco_range_get(s : OptmetaacoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_range_set(s : OptmetaacoRange, i : Int, v : Double) -> OptmetaacoRange {
  let result = opt_meta_aco_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_range_sum(s : OptmetaacoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_range_mean(s : OptmetaacoRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_range_scale(s : OptmetaacoRange, f : Double) -> OptmetaacoRange {
  let result = opt_meta_aco_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_range_add(a : OptmetaacoRange, b : OptmetaacoRange) -> OptmetaacoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_range_copy(s : OptmetaacoRange) -> OptmetaacoRange {
  let result = opt_meta_aco_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_range_fill(s : OptmetaacoRange, v : Double) -> OptmetaacoRange {
  let result = opt_meta_aco_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_range_min(s : OptmetaacoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_range_max(s : OptmetaacoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_range_to_string(s : OptmetaacoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetaacoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_aco_slice_make(size : Int) -> OptmetaacoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_aco_slice_len(s : OptmetaacoSlice) -> Int { s.size }

pub fn opt_meta_aco_slice_get(s : OptmetaacoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_aco_slice_set(s : OptmetaacoSlice, i : Int, v : Double) -> OptmetaacoSlice {
  let result = opt_meta_aco_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_slice_sum(s : OptmetaacoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_aco_slice_mean(s : OptmetaacoSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_aco_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_aco_slice_scale(s : OptmetaacoSlice, f : Double) -> OptmetaacoSlice {
  let result = opt_meta_aco_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_aco_slice_add(a : OptmetaacoSlice, b : OptmetaacoSlice) -> OptmetaacoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_aco_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_aco_slice_copy(s : OptmetaacoSlice) -> OptmetaacoSlice {
  let result = opt_meta_aco_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_aco_slice_fill(s : OptmetaacoSlice, v : Double) -> OptmetaacoSlice {
  let result = opt_meta_aco_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_aco_slice_min(s : OptmetaacoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_slice_max(s : OptmetaacoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_aco_slice_to_string(s : OptmetaacoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


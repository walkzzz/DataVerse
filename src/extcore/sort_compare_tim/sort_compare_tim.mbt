///===
/// extcore/sort_compare_tim

pub(all) struct SortcomparetimPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_tim_make_point(x : Double, y : Double) -> SortcomparetimPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_tim_make_point3(x : Double, y : Double, z : Double) -> SortcomparetimPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_tim_point_x(pt : SortcomparetimPoint) -> Double { pt.x }

pub fn sort_compare_tim_point_y(pt : SortcomparetimPoint) -> Double { pt.y }

pub fn sort_compare_tim_point_z(pt : SortcomparetimPoint) -> Double { pt.z }

pub fn sort_compare_tim_point_label(pt : SortcomparetimPoint) -> Int { pt.label }

pub fn sort_compare_tim_point_dist(a : SortcomparetimPoint, b : SortcomparetimPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_tim_point_add(a : SortcomparetimPoint, b : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_tim_point_sub(a : SortcomparetimPoint, b : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_tim_point_scale(pt : SortcomparetimPoint, s : Double) -> SortcomparetimPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_tim_point_dot(a : SortcomparetimPoint, b : SortcomparetimPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_tim_point_cross(a : SortcomparetimPoint, b : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_tim_point_norm(pt : SortcomparetimPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_tim_point_normalize(pt : SortcomparetimPoint) -> SortcomparetimPoint {
  let n = sort_compare_tim_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_tim_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_tim_point_negate(pt : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_tim_point_mid(a : SortcomparetimPoint, b : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_tim_point_lerp(a : SortcomparetimPoint, b : SortcomparetimPoint, t : Double) -> SortcomparetimPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_tim_point_to_string(pt : SortcomparetimPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparetimSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_tim_make_series(vals : Array[Double], name : String) -> SortcomparetimSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_tim_series_len(s : SortcomparetimSeries) -> Int { s.vals.length() }

pub fn sort_compare_tim_series_sum(s : SortcomparetimSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_tim_series_mean(s : SortcomparetimSeries) -> Double {
  let n = sort_compare_tim_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_tim_series_sum(s) / n.to_double() }
}

pub fn sort_compare_tim_series_min(s : SortcomparetimSeries) -> Double {
  let n = sort_compare_tim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_tim_series_max(s : SortcomparetimSeries) -> Double {
  let n = sort_compare_tim_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_tim_series_range(s : SortcomparetimSeries) -> Double {
  sort_compare_tim_series_max(s) - sort_compare_tim_series_min(s)
}

pub fn sort_compare_tim_series_var(s : SortcomparetimSeries) -> Double {
  let n = sort_compare_tim_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_tim_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_tim_series_std(s : SortcomparetimSeries) -> Double { @_common.sqrt(sort_compare_tim_series_var(s)) }

pub fn sort_compare_tim_series_median(s : SortcomparetimSeries) -> Double {
  let n = sort_compare_tim_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_tim_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_tim_series_scale(s : SortcomparetimSeries, f : Double) -> SortcomparetimSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_tim_series_add(a : SortcomparetimSeries, b : SortcomparetimSeries) -> SortcomparetimSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_tim_series_sub(a : SortcomparetimSeries, b : SortcomparetimSeries) -> SortcomparetimSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_tim_series_normalize(s : SortcomparetimSeries) -> SortcomparetimSeries {
  let mn = sort_compare_tim_series_min(s)
  let mx = sort_compare_tim_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_tim_series_cumsum(s : SortcomparetimSeries) -> SortcomparetimSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_tim_series_to_string(s : SortcomparetimSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparetimMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_tim_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparetimMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_tim_matrix_identity(n : Int) -> SortcomparetimMatrix {
  let m = sort_compare_tim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_tim_matrix_get(m : SortcomparetimMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_tim_matrix_transpose(m : SortcomparetimMatrix) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_tim_matrix_add(a : SortcomparetimMatrix, b : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_tim_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_tim_matrix_scale(m : SortcomparetimMatrix, s : Double) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_tim_matrix_multiply(a : SortcomparetimMatrix, b : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if a.cols != b.rows { return sort_compare_tim_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_tim_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_tim_matrix_trace(m : SortcomparetimMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_tim_matrix_det(m : SortcomparetimMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_tim_matrix_norm(m : SortcomparetimMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_tim_matrix_to_string(m : SortcomparetimMatrix) -> String {
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

pub(all) struct SortcomparetimVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_tim_make_vector(comps : Array[Double]) -> SortcomparetimVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_tim_vector_zero(dim : Int) -> SortcomparetimVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_tim_vector_add(a : SortcomparetimVector, b : SortcomparetimVector) -> SortcomparetimVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_tim_vector_sub(a : SortcomparetimVector, b : SortcomparetimVector) -> SortcomparetimVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_tim_vector_scale(v : SortcomparetimVector, s : Double) -> SortcomparetimVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_tim_vector_dot(a : SortcomparetimVector, b : SortcomparetimVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_tim_vector_norm(v : SortcomparetimVector) -> Double { @_common.sqrt(sort_compare_tim_vector_dot(v, v)) }

pub fn sort_compare_tim_vector_normalize(v : SortcomparetimVector) -> SortcomparetimVector {
  let n = sort_compare_tim_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_tim_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_tim_vector_dist(a : SortcomparetimVector, b : SortcomparetimVector) -> Double {
  sort_compare_tim_vector_norm(sort_compare_tim_vector_sub(a, b))
}

pub fn sort_compare_tim_vector_to_string(v : SortcomparetimVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_tim_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_tim_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_tim_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_tim_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_tim_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_tim_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_tim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_tim_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_tim_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_tim_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_tim_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_tim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_tim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_tim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_tim_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_tim_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_tim_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_tim_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_tim_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_tim_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_tim_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_tim_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_tim_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_tim_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_tim_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_tim_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_tim_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_tim_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_tim_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparetimFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_frame_make(size : Int) -> SortcomparetimFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_frame_len(s : SortcomparetimFrame) -> Int { s.size }

pub fn sort_compare_tim_frame_get(s : SortcomparetimFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_frame_set(s : SortcomparetimFrame, i : Int, v : Double) -> SortcomparetimFrame {
  let result = sort_compare_tim_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_frame_sum(s : SortcomparetimFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_frame_mean(s : SortcomparetimFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_frame_scale(s : SortcomparetimFrame, f : Double) -> SortcomparetimFrame {
  let result = sort_compare_tim_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_frame_add(a : SortcomparetimFrame, b : SortcomparetimFrame) -> SortcomparetimFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_frame_copy(s : SortcomparetimFrame) -> SortcomparetimFrame {
  let result = sort_compare_tim_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_frame_fill(s : SortcomparetimFrame, v : Double) -> SortcomparetimFrame {
  let result = sort_compare_tim_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_frame_min(s : SortcomparetimFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_frame_max(s : SortcomparetimFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_frame_to_string(s : SortcomparetimFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_table_make(size : Int) -> SortcomparetimTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_table_len(s : SortcomparetimTable) -> Int { s.size }

pub fn sort_compare_tim_table_get(s : SortcomparetimTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_table_set(s : SortcomparetimTable, i : Int, v : Double) -> SortcomparetimTable {
  let result = sort_compare_tim_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_table_sum(s : SortcomparetimTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_table_mean(s : SortcomparetimTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_table_scale(s : SortcomparetimTable, f : Double) -> SortcomparetimTable {
  let result = sort_compare_tim_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_table_add(a : SortcomparetimTable, b : SortcomparetimTable) -> SortcomparetimTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_table_copy(s : SortcomparetimTable) -> SortcomparetimTable {
  let result = sort_compare_tim_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_table_fill(s : SortcomparetimTable, v : Double) -> SortcomparetimTable {
  let result = sort_compare_tim_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_table_min(s : SortcomparetimTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_table_max(s : SortcomparetimTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_table_to_string(s : SortcomparetimTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_graphn_make(size : Int) -> SortcomparetimGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_graphn_len(s : SortcomparetimGraphN) -> Int { s.size }

pub fn sort_compare_tim_graphn_get(s : SortcomparetimGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_graphn_set(s : SortcomparetimGraphN, i : Int, v : Double) -> SortcomparetimGraphN {
  let result = sort_compare_tim_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_graphn_sum(s : SortcomparetimGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_graphn_mean(s : SortcomparetimGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_graphn_scale(s : SortcomparetimGraphN, f : Double) -> SortcomparetimGraphN {
  let result = sort_compare_tim_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_graphn_add(a : SortcomparetimGraphN, b : SortcomparetimGraphN) -> SortcomparetimGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_graphn_copy(s : SortcomparetimGraphN) -> SortcomparetimGraphN {
  let result = sort_compare_tim_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_graphn_fill(s : SortcomparetimGraphN, v : Double) -> SortcomparetimGraphN {
  let result = sort_compare_tim_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_graphn_min(s : SortcomparetimGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_graphn_max(s : SortcomparetimGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_graphn_to_string(s : SortcomparetimGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_node_make(size : Int) -> SortcomparetimNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_node_len(s : SortcomparetimNode) -> Int { s.size }

pub fn sort_compare_tim_node_get(s : SortcomparetimNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_node_set(s : SortcomparetimNode, i : Int, v : Double) -> SortcomparetimNode {
  let result = sort_compare_tim_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_node_sum(s : SortcomparetimNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_node_mean(s : SortcomparetimNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_node_scale(s : SortcomparetimNode, f : Double) -> SortcomparetimNode {
  let result = sort_compare_tim_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_node_add(a : SortcomparetimNode, b : SortcomparetimNode) -> SortcomparetimNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_node_copy(s : SortcomparetimNode) -> SortcomparetimNode {
  let result = sort_compare_tim_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_node_fill(s : SortcomparetimNode, v : Double) -> SortcomparetimNode {
  let result = sort_compare_tim_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_node_min(s : SortcomparetimNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_node_max(s : SortcomparetimNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_node_to_string(s : SortcomparetimNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_edge_make(size : Int) -> SortcomparetimEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_edge_len(s : SortcomparetimEdge) -> Int { s.size }

pub fn sort_compare_tim_edge_get(s : SortcomparetimEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_edge_set(s : SortcomparetimEdge, i : Int, v : Double) -> SortcomparetimEdge {
  let result = sort_compare_tim_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_edge_sum(s : SortcomparetimEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_edge_mean(s : SortcomparetimEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_edge_scale(s : SortcomparetimEdge, f : Double) -> SortcomparetimEdge {
  let result = sort_compare_tim_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_edge_add(a : SortcomparetimEdge, b : SortcomparetimEdge) -> SortcomparetimEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_edge_copy(s : SortcomparetimEdge) -> SortcomparetimEdge {
  let result = sort_compare_tim_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_edge_fill(s : SortcomparetimEdge, v : Double) -> SortcomparetimEdge {
  let result = sort_compare_tim_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_edge_min(s : SortcomparetimEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_edge_max(s : SortcomparetimEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_edge_to_string(s : SortcomparetimEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_path_make(size : Int) -> SortcomparetimPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_path_len(s : SortcomparetimPath) -> Int { s.size }

pub fn sort_compare_tim_path_get(s : SortcomparetimPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_path_set(s : SortcomparetimPath, i : Int, v : Double) -> SortcomparetimPath {
  let result = sort_compare_tim_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_path_sum(s : SortcomparetimPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_path_mean(s : SortcomparetimPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_path_scale(s : SortcomparetimPath, f : Double) -> SortcomparetimPath {
  let result = sort_compare_tim_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_path_add(a : SortcomparetimPath, b : SortcomparetimPath) -> SortcomparetimPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_path_copy(s : SortcomparetimPath) -> SortcomparetimPath {
  let result = sort_compare_tim_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_path_fill(s : SortcomparetimPath, v : Double) -> SortcomparetimPath {
  let result = sort_compare_tim_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_path_min(s : SortcomparetimPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_path_max(s : SortcomparetimPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_path_to_string(s : SortcomparetimPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cluster_make(size : Int) -> SortcomparetimCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_cluster_len(s : SortcomparetimCluster) -> Int { s.size }

pub fn sort_compare_tim_cluster_get(s : SortcomparetimCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_cluster_set(s : SortcomparetimCluster, i : Int, v : Double) -> SortcomparetimCluster {
  let result = sort_compare_tim_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_cluster_sum(s : SortcomparetimCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_cluster_mean(s : SortcomparetimCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_cluster_scale(s : SortcomparetimCluster, f : Double) -> SortcomparetimCluster {
  let result = sort_compare_tim_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_cluster_add(a : SortcomparetimCluster, b : SortcomparetimCluster) -> SortcomparetimCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_cluster_copy(s : SortcomparetimCluster) -> SortcomparetimCluster {
  let result = sort_compare_tim_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_cluster_fill(s : SortcomparetimCluster, v : Double) -> SortcomparetimCluster {
  let result = sort_compare_tim_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_cluster_min(s : SortcomparetimCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_cluster_max(s : SortcomparetimCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_cluster_to_string(s : SortcomparetimCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_model_make(size : Int) -> SortcomparetimModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_model_len(s : SortcomparetimModel) -> Int { s.size }

pub fn sort_compare_tim_model_get(s : SortcomparetimModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_model_set(s : SortcomparetimModel, i : Int, v : Double) -> SortcomparetimModel {
  let result = sort_compare_tim_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_model_sum(s : SortcomparetimModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_model_mean(s : SortcomparetimModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_model_scale(s : SortcomparetimModel, f : Double) -> SortcomparetimModel {
  let result = sort_compare_tim_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_model_add(a : SortcomparetimModel, b : SortcomparetimModel) -> SortcomparetimModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_model_copy(s : SortcomparetimModel) -> SortcomparetimModel {
  let result = sort_compare_tim_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_model_fill(s : SortcomparetimModel, v : Double) -> SortcomparetimModel {
  let result = sort_compare_tim_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_model_min(s : SortcomparetimModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_model_max(s : SortcomparetimModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_model_to_string(s : SortcomparetimModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_layer_make(size : Int) -> SortcomparetimLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_layer_len(s : SortcomparetimLayer) -> Int { s.size }

pub fn sort_compare_tim_layer_get(s : SortcomparetimLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_layer_set(s : SortcomparetimLayer, i : Int, v : Double) -> SortcomparetimLayer {
  let result = sort_compare_tim_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_layer_sum(s : SortcomparetimLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_layer_mean(s : SortcomparetimLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_layer_scale(s : SortcomparetimLayer, f : Double) -> SortcomparetimLayer {
  let result = sort_compare_tim_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_layer_add(a : SortcomparetimLayer, b : SortcomparetimLayer) -> SortcomparetimLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_layer_copy(s : SortcomparetimLayer) -> SortcomparetimLayer {
  let result = sort_compare_tim_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_layer_fill(s : SortcomparetimLayer, v : Double) -> SortcomparetimLayer {
  let result = sort_compare_tim_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_layer_min(s : SortcomparetimLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_layer_max(s : SortcomparetimLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_layer_to_string(s : SortcomparetimLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_buffer_make(size : Int) -> SortcomparetimBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_buffer_len(s : SortcomparetimBuffer) -> Int { s.size }

pub fn sort_compare_tim_buffer_get(s : SortcomparetimBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_buffer_set(s : SortcomparetimBuffer, i : Int, v : Double) -> SortcomparetimBuffer {
  let result = sort_compare_tim_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_buffer_sum(s : SortcomparetimBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_buffer_mean(s : SortcomparetimBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_buffer_scale(s : SortcomparetimBuffer, f : Double) -> SortcomparetimBuffer {
  let result = sort_compare_tim_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_buffer_add(a : SortcomparetimBuffer, b : SortcomparetimBuffer) -> SortcomparetimBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_buffer_copy(s : SortcomparetimBuffer) -> SortcomparetimBuffer {
  let result = sort_compare_tim_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_buffer_fill(s : SortcomparetimBuffer, v : Double) -> SortcomparetimBuffer {
  let result = sort_compare_tim_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_buffer_min(s : SortcomparetimBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_buffer_max(s : SortcomparetimBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_buffer_to_string(s : SortcomparetimBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cursor_make(size : Int) -> SortcomparetimCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_cursor_len(s : SortcomparetimCursor) -> Int { s.size }

pub fn sort_compare_tim_cursor_get(s : SortcomparetimCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_cursor_set(s : SortcomparetimCursor, i : Int, v : Double) -> SortcomparetimCursor {
  let result = sort_compare_tim_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_cursor_sum(s : SortcomparetimCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_cursor_mean(s : SortcomparetimCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_cursor_scale(s : SortcomparetimCursor, f : Double) -> SortcomparetimCursor {
  let result = sort_compare_tim_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_cursor_add(a : SortcomparetimCursor, b : SortcomparetimCursor) -> SortcomparetimCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_cursor_copy(s : SortcomparetimCursor) -> SortcomparetimCursor {
  let result = sort_compare_tim_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_cursor_fill(s : SortcomparetimCursor, v : Double) -> SortcomparetimCursor {
  let result = sort_compare_tim_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_cursor_min(s : SortcomparetimCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_cursor_max(s : SortcomparetimCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_cursor_to_string(s : SortcomparetimCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_view_make(size : Int) -> SortcomparetimView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_view_len(s : SortcomparetimView) -> Int { s.size }

pub fn sort_compare_tim_view_get(s : SortcomparetimView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_view_set(s : SortcomparetimView, i : Int, v : Double) -> SortcomparetimView {
  let result = sort_compare_tim_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_view_sum(s : SortcomparetimView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_view_mean(s : SortcomparetimView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_view_scale(s : SortcomparetimView, f : Double) -> SortcomparetimView {
  let result = sort_compare_tim_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_view_add(a : SortcomparetimView, b : SortcomparetimView) -> SortcomparetimView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_view_copy(s : SortcomparetimView) -> SortcomparetimView {
  let result = sort_compare_tim_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_view_fill(s : SortcomparetimView, v : Double) -> SortcomparetimView {
  let result = sort_compare_tim_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_view_min(s : SortcomparetimView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_view_max(s : SortcomparetimView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_view_to_string(s : SortcomparetimView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_range_make(size : Int) -> SortcomparetimRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_range_len(s : SortcomparetimRange) -> Int { s.size }

pub fn sort_compare_tim_range_get(s : SortcomparetimRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_range_set(s : SortcomparetimRange, i : Int, v : Double) -> SortcomparetimRange {
  let result = sort_compare_tim_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_range_sum(s : SortcomparetimRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_range_mean(s : SortcomparetimRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_range_scale(s : SortcomparetimRange, f : Double) -> SortcomparetimRange {
  let result = sort_compare_tim_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_range_add(a : SortcomparetimRange, b : SortcomparetimRange) -> SortcomparetimRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_range_copy(s : SortcomparetimRange) -> SortcomparetimRange {
  let result = sort_compare_tim_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_range_fill(s : SortcomparetimRange, v : Double) -> SortcomparetimRange {
  let result = sort_compare_tim_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_range_min(s : SortcomparetimRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_range_max(s : SortcomparetimRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_range_to_string(s : SortcomparetimRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_slice_make(size : Int) -> SortcomparetimSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_slice_len(s : SortcomparetimSlice) -> Int { s.size }

pub fn sort_compare_tim_slice_get(s : SortcomparetimSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_slice_set(s : SortcomparetimSlice, i : Int, v : Double) -> SortcomparetimSlice {
  let result = sort_compare_tim_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_slice_sum(s : SortcomparetimSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_tim_slice_mean(s : SortcomparetimSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_tim_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_tim_slice_scale(s : SortcomparetimSlice, f : Double) -> SortcomparetimSlice {
  let result = sort_compare_tim_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_tim_slice_add(a : SortcomparetimSlice, b : SortcomparetimSlice) -> SortcomparetimSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_tim_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_tim_slice_copy(s : SortcomparetimSlice) -> SortcomparetimSlice {
  let result = sort_compare_tim_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_tim_slice_fill(s : SortcomparetimSlice, v : Double) -> SortcomparetimSlice {
  let result = sort_compare_tim_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_tim_slice_min(s : SortcomparetimSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_slice_max(s : SortcomparetimSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_tim_slice_to_string(s : SortcomparetimSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


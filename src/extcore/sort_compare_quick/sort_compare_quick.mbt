///===
/// extcore/sort_compare_quick

pub(all) struct SortcomparequickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_quick_make_point(x : Double, y : Double) -> SortcomparequickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_quick_make_point3(x : Double, y : Double, z : Double) -> SortcomparequickPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_quick_point_x(pt : SortcomparequickPoint) -> Double { pt.x }

pub fn sort_compare_quick_point_y(pt : SortcomparequickPoint) -> Double { pt.y }

pub fn sort_compare_quick_point_z(pt : SortcomparequickPoint) -> Double { pt.z }

pub fn sort_compare_quick_point_label(pt : SortcomparequickPoint) -> Int { pt.label }

pub fn sort_compare_quick_point_dist(a : SortcomparequickPoint, b : SortcomparequickPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_quick_point_add(a : SortcomparequickPoint, b : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_quick_point_sub(a : SortcomparequickPoint, b : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_quick_point_scale(pt : SortcomparequickPoint, s : Double) -> SortcomparequickPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_quick_point_dot(a : SortcomparequickPoint, b : SortcomparequickPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_quick_point_cross(a : SortcomparequickPoint, b : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_quick_point_norm(pt : SortcomparequickPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_quick_point_normalize(pt : SortcomparequickPoint) -> SortcomparequickPoint {
  let n = sort_compare_quick_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_quick_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_quick_point_negate(pt : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_quick_point_mid(a : SortcomparequickPoint, b : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_quick_point_lerp(a : SortcomparequickPoint, b : SortcomparequickPoint, t : Double) -> SortcomparequickPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_quick_point_to_string(pt : SortcomparequickPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparequickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_quick_make_series(vals : Array[Double], name : String) -> SortcomparequickSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_quick_series_len(s : SortcomparequickSeries) -> Int { s.vals.length() }

pub fn sort_compare_quick_series_sum(s : SortcomparequickSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_quick_series_mean(s : SortcomparequickSeries) -> Double {
  let n = sort_compare_quick_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_quick_series_sum(s) / n.to_double() }
}

pub fn sort_compare_quick_series_min(s : SortcomparequickSeries) -> Double {
  let n = sort_compare_quick_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_quick_series_max(s : SortcomparequickSeries) -> Double {
  let n = sort_compare_quick_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_quick_series_range(s : SortcomparequickSeries) -> Double {
  sort_compare_quick_series_max(s) - sort_compare_quick_series_min(s)
}

pub fn sort_compare_quick_series_var(s : SortcomparequickSeries) -> Double {
  let n = sort_compare_quick_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_quick_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_quick_series_std(s : SortcomparequickSeries) -> Double { @_common.sqrt(sort_compare_quick_series_var(s)) }

pub fn sort_compare_quick_series_median(s : SortcomparequickSeries) -> Double {
  let n = sort_compare_quick_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_quick_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_quick_series_scale(s : SortcomparequickSeries, f : Double) -> SortcomparequickSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_quick_series_add(a : SortcomparequickSeries, b : SortcomparequickSeries) -> SortcomparequickSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_quick_series_sub(a : SortcomparequickSeries, b : SortcomparequickSeries) -> SortcomparequickSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_quick_series_normalize(s : SortcomparequickSeries) -> SortcomparequickSeries {
  let mn = sort_compare_quick_series_min(s)
  let mx = sort_compare_quick_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_quick_series_cumsum(s : SortcomparequickSeries) -> SortcomparequickSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_quick_series_to_string(s : SortcomparequickSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparequickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_quick_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparequickMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_quick_matrix_identity(n : Int) -> SortcomparequickMatrix {
  let m = sort_compare_quick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_quick_matrix_get(m : SortcomparequickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_quick_matrix_transpose(m : SortcomparequickMatrix) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_quick_matrix_add(a : SortcomparequickMatrix, b : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_quick_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_quick_matrix_scale(m : SortcomparequickMatrix, s : Double) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_quick_matrix_multiply(a : SortcomparequickMatrix, b : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if a.cols != b.rows { return sort_compare_quick_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_quick_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_quick_matrix_trace(m : SortcomparequickMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_quick_matrix_det(m : SortcomparequickMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_quick_matrix_norm(m : SortcomparequickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_quick_matrix_to_string(m : SortcomparequickMatrix) -> String {
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

pub(all) struct SortcomparequickVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_quick_make_vector(comps : Array[Double]) -> SortcomparequickVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_quick_vector_zero(dim : Int) -> SortcomparequickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_quick_vector_add(a : SortcomparequickVector, b : SortcomparequickVector) -> SortcomparequickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_quick_vector_sub(a : SortcomparequickVector, b : SortcomparequickVector) -> SortcomparequickVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_quick_vector_scale(v : SortcomparequickVector, s : Double) -> SortcomparequickVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_quick_vector_dot(a : SortcomparequickVector, b : SortcomparequickVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_quick_vector_norm(v : SortcomparequickVector) -> Double { @_common.sqrt(sort_compare_quick_vector_dot(v, v)) }

pub fn sort_compare_quick_vector_normalize(v : SortcomparequickVector) -> SortcomparequickVector {
  let n = sort_compare_quick_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_quick_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_quick_vector_dist(a : SortcomparequickVector, b : SortcomparequickVector) -> Double {
  sort_compare_quick_vector_norm(sort_compare_quick_vector_sub(a, b))
}

pub fn sort_compare_quick_vector_to_string(v : SortcomparequickVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_quick_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_quick_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_quick_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_quick_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_quick_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_quick_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_quick_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_quick_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_quick_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_quick_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_quick_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_quick_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_quick_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_quick_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_quick_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_quick_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_quick_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_quick_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_quick_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_quick_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_quick_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_quick_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_quick_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_quick_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_quick_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_quick_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_quick_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_quick_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_quick_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparequickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_frame_make(size : Int) -> SortcomparequickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_frame_len(s : SortcomparequickFrame) -> Int { s.size }

pub fn sort_compare_quick_frame_get(s : SortcomparequickFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_frame_set(s : SortcomparequickFrame, i : Int, v : Double) -> SortcomparequickFrame {
  let result = sort_compare_quick_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_frame_sum(s : SortcomparequickFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_frame_mean(s : SortcomparequickFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_frame_scale(s : SortcomparequickFrame, f : Double) -> SortcomparequickFrame {
  let result = sort_compare_quick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_frame_add(a : SortcomparequickFrame, b : SortcomparequickFrame) -> SortcomparequickFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_frame_copy(s : SortcomparequickFrame) -> SortcomparequickFrame {
  let result = sort_compare_quick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_frame_fill(s : SortcomparequickFrame, v : Double) -> SortcomparequickFrame {
  let result = sort_compare_quick_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_frame_min(s : SortcomparequickFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_frame_max(s : SortcomparequickFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_frame_to_string(s : SortcomparequickFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_table_make(size : Int) -> SortcomparequickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_table_len(s : SortcomparequickTable) -> Int { s.size }

pub fn sort_compare_quick_table_get(s : SortcomparequickTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_table_set(s : SortcomparequickTable, i : Int, v : Double) -> SortcomparequickTable {
  let result = sort_compare_quick_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_table_sum(s : SortcomparequickTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_table_mean(s : SortcomparequickTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_table_scale(s : SortcomparequickTable, f : Double) -> SortcomparequickTable {
  let result = sort_compare_quick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_table_add(a : SortcomparequickTable, b : SortcomparequickTable) -> SortcomparequickTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_table_copy(s : SortcomparequickTable) -> SortcomparequickTable {
  let result = sort_compare_quick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_table_fill(s : SortcomparequickTable, v : Double) -> SortcomparequickTable {
  let result = sort_compare_quick_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_table_min(s : SortcomparequickTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_table_max(s : SortcomparequickTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_table_to_string(s : SortcomparequickTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_graphn_make(size : Int) -> SortcomparequickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_graphn_len(s : SortcomparequickGraphN) -> Int { s.size }

pub fn sort_compare_quick_graphn_get(s : SortcomparequickGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_graphn_set(s : SortcomparequickGraphN, i : Int, v : Double) -> SortcomparequickGraphN {
  let result = sort_compare_quick_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_graphn_sum(s : SortcomparequickGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_graphn_mean(s : SortcomparequickGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_graphn_scale(s : SortcomparequickGraphN, f : Double) -> SortcomparequickGraphN {
  let result = sort_compare_quick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_graphn_add(a : SortcomparequickGraphN, b : SortcomparequickGraphN) -> SortcomparequickGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_graphn_copy(s : SortcomparequickGraphN) -> SortcomparequickGraphN {
  let result = sort_compare_quick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_graphn_fill(s : SortcomparequickGraphN, v : Double) -> SortcomparequickGraphN {
  let result = sort_compare_quick_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_graphn_min(s : SortcomparequickGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_graphn_max(s : SortcomparequickGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_graphn_to_string(s : SortcomparequickGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_node_make(size : Int) -> SortcomparequickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_node_len(s : SortcomparequickNode) -> Int { s.size }

pub fn sort_compare_quick_node_get(s : SortcomparequickNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_node_set(s : SortcomparequickNode, i : Int, v : Double) -> SortcomparequickNode {
  let result = sort_compare_quick_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_node_sum(s : SortcomparequickNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_node_mean(s : SortcomparequickNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_node_scale(s : SortcomparequickNode, f : Double) -> SortcomparequickNode {
  let result = sort_compare_quick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_node_add(a : SortcomparequickNode, b : SortcomparequickNode) -> SortcomparequickNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_node_copy(s : SortcomparequickNode) -> SortcomparequickNode {
  let result = sort_compare_quick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_node_fill(s : SortcomparequickNode, v : Double) -> SortcomparequickNode {
  let result = sort_compare_quick_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_node_min(s : SortcomparequickNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_node_max(s : SortcomparequickNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_node_to_string(s : SortcomparequickNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_edge_make(size : Int) -> SortcomparequickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_edge_len(s : SortcomparequickEdge) -> Int { s.size }

pub fn sort_compare_quick_edge_get(s : SortcomparequickEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_edge_set(s : SortcomparequickEdge, i : Int, v : Double) -> SortcomparequickEdge {
  let result = sort_compare_quick_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_edge_sum(s : SortcomparequickEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_edge_mean(s : SortcomparequickEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_edge_scale(s : SortcomparequickEdge, f : Double) -> SortcomparequickEdge {
  let result = sort_compare_quick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_edge_add(a : SortcomparequickEdge, b : SortcomparequickEdge) -> SortcomparequickEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_edge_copy(s : SortcomparequickEdge) -> SortcomparequickEdge {
  let result = sort_compare_quick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_edge_fill(s : SortcomparequickEdge, v : Double) -> SortcomparequickEdge {
  let result = sort_compare_quick_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_edge_min(s : SortcomparequickEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_edge_max(s : SortcomparequickEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_edge_to_string(s : SortcomparequickEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_path_make(size : Int) -> SortcomparequickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_path_len(s : SortcomparequickPath) -> Int { s.size }

pub fn sort_compare_quick_path_get(s : SortcomparequickPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_path_set(s : SortcomparequickPath, i : Int, v : Double) -> SortcomparequickPath {
  let result = sort_compare_quick_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_path_sum(s : SortcomparequickPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_path_mean(s : SortcomparequickPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_path_scale(s : SortcomparequickPath, f : Double) -> SortcomparequickPath {
  let result = sort_compare_quick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_path_add(a : SortcomparequickPath, b : SortcomparequickPath) -> SortcomparequickPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_path_copy(s : SortcomparequickPath) -> SortcomparequickPath {
  let result = sort_compare_quick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_path_fill(s : SortcomparequickPath, v : Double) -> SortcomparequickPath {
  let result = sort_compare_quick_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_path_min(s : SortcomparequickPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_path_max(s : SortcomparequickPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_path_to_string(s : SortcomparequickPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cluster_make(size : Int) -> SortcomparequickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_cluster_len(s : SortcomparequickCluster) -> Int { s.size }

pub fn sort_compare_quick_cluster_get(s : SortcomparequickCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_cluster_set(s : SortcomparequickCluster, i : Int, v : Double) -> SortcomparequickCluster {
  let result = sort_compare_quick_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_cluster_sum(s : SortcomparequickCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_cluster_mean(s : SortcomparequickCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_cluster_scale(s : SortcomparequickCluster, f : Double) -> SortcomparequickCluster {
  let result = sort_compare_quick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_cluster_add(a : SortcomparequickCluster, b : SortcomparequickCluster) -> SortcomparequickCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_cluster_copy(s : SortcomparequickCluster) -> SortcomparequickCluster {
  let result = sort_compare_quick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_cluster_fill(s : SortcomparequickCluster, v : Double) -> SortcomparequickCluster {
  let result = sort_compare_quick_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_cluster_min(s : SortcomparequickCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_cluster_max(s : SortcomparequickCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_cluster_to_string(s : SortcomparequickCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_model_make(size : Int) -> SortcomparequickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_model_len(s : SortcomparequickModel) -> Int { s.size }

pub fn sort_compare_quick_model_get(s : SortcomparequickModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_model_set(s : SortcomparequickModel, i : Int, v : Double) -> SortcomparequickModel {
  let result = sort_compare_quick_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_model_sum(s : SortcomparequickModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_model_mean(s : SortcomparequickModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_model_scale(s : SortcomparequickModel, f : Double) -> SortcomparequickModel {
  let result = sort_compare_quick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_model_add(a : SortcomparequickModel, b : SortcomparequickModel) -> SortcomparequickModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_model_copy(s : SortcomparequickModel) -> SortcomparequickModel {
  let result = sort_compare_quick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_model_fill(s : SortcomparequickModel, v : Double) -> SortcomparequickModel {
  let result = sort_compare_quick_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_model_min(s : SortcomparequickModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_model_max(s : SortcomparequickModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_model_to_string(s : SortcomparequickModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_layer_make(size : Int) -> SortcomparequickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_layer_len(s : SortcomparequickLayer) -> Int { s.size }

pub fn sort_compare_quick_layer_get(s : SortcomparequickLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_layer_set(s : SortcomparequickLayer, i : Int, v : Double) -> SortcomparequickLayer {
  let result = sort_compare_quick_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_layer_sum(s : SortcomparequickLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_layer_mean(s : SortcomparequickLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_layer_scale(s : SortcomparequickLayer, f : Double) -> SortcomparequickLayer {
  let result = sort_compare_quick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_layer_add(a : SortcomparequickLayer, b : SortcomparequickLayer) -> SortcomparequickLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_layer_copy(s : SortcomparequickLayer) -> SortcomparequickLayer {
  let result = sort_compare_quick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_layer_fill(s : SortcomparequickLayer, v : Double) -> SortcomparequickLayer {
  let result = sort_compare_quick_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_layer_min(s : SortcomparequickLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_layer_max(s : SortcomparequickLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_layer_to_string(s : SortcomparequickLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_buffer_make(size : Int) -> SortcomparequickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_buffer_len(s : SortcomparequickBuffer) -> Int { s.size }

pub fn sort_compare_quick_buffer_get(s : SortcomparequickBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_buffer_set(s : SortcomparequickBuffer, i : Int, v : Double) -> SortcomparequickBuffer {
  let result = sort_compare_quick_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_buffer_sum(s : SortcomparequickBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_buffer_mean(s : SortcomparequickBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_buffer_scale(s : SortcomparequickBuffer, f : Double) -> SortcomparequickBuffer {
  let result = sort_compare_quick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_buffer_add(a : SortcomparequickBuffer, b : SortcomparequickBuffer) -> SortcomparequickBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_buffer_copy(s : SortcomparequickBuffer) -> SortcomparequickBuffer {
  let result = sort_compare_quick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_buffer_fill(s : SortcomparequickBuffer, v : Double) -> SortcomparequickBuffer {
  let result = sort_compare_quick_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_buffer_min(s : SortcomparequickBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_buffer_max(s : SortcomparequickBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_buffer_to_string(s : SortcomparequickBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cursor_make(size : Int) -> SortcomparequickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_cursor_len(s : SortcomparequickCursor) -> Int { s.size }

pub fn sort_compare_quick_cursor_get(s : SortcomparequickCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_cursor_set(s : SortcomparequickCursor, i : Int, v : Double) -> SortcomparequickCursor {
  let result = sort_compare_quick_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_cursor_sum(s : SortcomparequickCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_cursor_mean(s : SortcomparequickCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_cursor_scale(s : SortcomparequickCursor, f : Double) -> SortcomparequickCursor {
  let result = sort_compare_quick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_cursor_add(a : SortcomparequickCursor, b : SortcomparequickCursor) -> SortcomparequickCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_cursor_copy(s : SortcomparequickCursor) -> SortcomparequickCursor {
  let result = sort_compare_quick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_cursor_fill(s : SortcomparequickCursor, v : Double) -> SortcomparequickCursor {
  let result = sort_compare_quick_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_cursor_min(s : SortcomparequickCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_cursor_max(s : SortcomparequickCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_cursor_to_string(s : SortcomparequickCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_view_make(size : Int) -> SortcomparequickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_view_len(s : SortcomparequickView) -> Int { s.size }

pub fn sort_compare_quick_view_get(s : SortcomparequickView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_view_set(s : SortcomparequickView, i : Int, v : Double) -> SortcomparequickView {
  let result = sort_compare_quick_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_view_sum(s : SortcomparequickView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_view_mean(s : SortcomparequickView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_view_scale(s : SortcomparequickView, f : Double) -> SortcomparequickView {
  let result = sort_compare_quick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_view_add(a : SortcomparequickView, b : SortcomparequickView) -> SortcomparequickView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_view_copy(s : SortcomparequickView) -> SortcomparequickView {
  let result = sort_compare_quick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_view_fill(s : SortcomparequickView, v : Double) -> SortcomparequickView {
  let result = sort_compare_quick_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_view_min(s : SortcomparequickView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_view_max(s : SortcomparequickView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_view_to_string(s : SortcomparequickView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_range_make(size : Int) -> SortcomparequickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_range_len(s : SortcomparequickRange) -> Int { s.size }

pub fn sort_compare_quick_range_get(s : SortcomparequickRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_range_set(s : SortcomparequickRange, i : Int, v : Double) -> SortcomparequickRange {
  let result = sort_compare_quick_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_range_sum(s : SortcomparequickRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_range_mean(s : SortcomparequickRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_range_scale(s : SortcomparequickRange, f : Double) -> SortcomparequickRange {
  let result = sort_compare_quick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_range_add(a : SortcomparequickRange, b : SortcomparequickRange) -> SortcomparequickRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_range_copy(s : SortcomparequickRange) -> SortcomparequickRange {
  let result = sort_compare_quick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_range_fill(s : SortcomparequickRange, v : Double) -> SortcomparequickRange {
  let result = sort_compare_quick_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_range_min(s : SortcomparequickRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_range_max(s : SortcomparequickRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_range_to_string(s : SortcomparequickRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_slice_make(size : Int) -> SortcomparequickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_slice_len(s : SortcomparequickSlice) -> Int { s.size }

pub fn sort_compare_quick_slice_get(s : SortcomparequickSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_slice_set(s : SortcomparequickSlice, i : Int, v : Double) -> SortcomparequickSlice {
  let result = sort_compare_quick_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_slice_sum(s : SortcomparequickSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_quick_slice_mean(s : SortcomparequickSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_quick_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_quick_slice_scale(s : SortcomparequickSlice, f : Double) -> SortcomparequickSlice {
  let result = sort_compare_quick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_quick_slice_add(a : SortcomparequickSlice, b : SortcomparequickSlice) -> SortcomparequickSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_quick_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_quick_slice_copy(s : SortcomparequickSlice) -> SortcomparequickSlice {
  let result = sort_compare_quick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_quick_slice_fill(s : SortcomparequickSlice, v : Double) -> SortcomparequickSlice {
  let result = sort_compare_quick_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_quick_slice_min(s : SortcomparequickSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_slice_max(s : SortcomparequickSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_quick_slice_to_string(s : SortcomparequickSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


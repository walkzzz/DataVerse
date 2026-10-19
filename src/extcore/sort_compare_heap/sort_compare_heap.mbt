///===
/// extcore/sort_compare_heap

pub(all) struct SortcompareheapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_heap_make_point(x : Double, y : Double) -> SortcompareheapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_heap_make_point3(x : Double, y : Double, z : Double) -> SortcompareheapPoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_heap_point_x(pt : SortcompareheapPoint) -> Double { pt.x }

pub fn sort_compare_heap_point_y(pt : SortcompareheapPoint) -> Double { pt.y }

pub fn sort_compare_heap_point_z(pt : SortcompareheapPoint) -> Double { pt.z }

pub fn sort_compare_heap_point_label(pt : SortcompareheapPoint) -> Int { pt.label }

pub fn sort_compare_heap_point_dist(a : SortcompareheapPoint, b : SortcompareheapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_heap_point_add(a : SortcompareheapPoint, b : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_heap_point_sub(a : SortcompareheapPoint, b : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_heap_point_scale(pt : SortcompareheapPoint, s : Double) -> SortcompareheapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_heap_point_dot(a : SortcompareheapPoint, b : SortcompareheapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_heap_point_cross(a : SortcompareheapPoint, b : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_heap_point_norm(pt : SortcompareheapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_heap_point_normalize(pt : SortcompareheapPoint) -> SortcompareheapPoint {
  let n = sort_compare_heap_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_heap_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_heap_point_negate(pt : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_heap_point_mid(a : SortcompareheapPoint, b : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_heap_point_lerp(a : SortcompareheapPoint, b : SortcompareheapPoint, t : Double) -> SortcompareheapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_heap_point_to_string(pt : SortcompareheapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcompareheapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_heap_make_series(vals : Array[Double], name : String) -> SortcompareheapSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_heap_series_len(s : SortcompareheapSeries) -> Int { s.vals.length() }

pub fn sort_compare_heap_series_sum(s : SortcompareheapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_heap_series_mean(s : SortcompareheapSeries) -> Double {
  let n = sort_compare_heap_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_heap_series_sum(s) / n.to_double() }
}

pub fn sort_compare_heap_series_min(s : SortcompareheapSeries) -> Double {
  let n = sort_compare_heap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_heap_series_max(s : SortcompareheapSeries) -> Double {
  let n = sort_compare_heap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_heap_series_range(s : SortcompareheapSeries) -> Double {
  sort_compare_heap_series_max(s) - sort_compare_heap_series_min(s)
}

pub fn sort_compare_heap_series_var(s : SortcompareheapSeries) -> Double {
  let n = sort_compare_heap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_heap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_heap_series_std(s : SortcompareheapSeries) -> Double { @_common.sqrt(sort_compare_heap_series_var(s)) }

pub fn sort_compare_heap_series_median(s : SortcompareheapSeries) -> Double {
  let n = sort_compare_heap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_heap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_heap_series_scale(s : SortcompareheapSeries, f : Double) -> SortcompareheapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_heap_series_add(a : SortcompareheapSeries, b : SortcompareheapSeries) -> SortcompareheapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_heap_series_sub(a : SortcompareheapSeries, b : SortcompareheapSeries) -> SortcompareheapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_heap_series_normalize(s : SortcompareheapSeries) -> SortcompareheapSeries {
  let mn = sort_compare_heap_series_min(s)
  let mx = sort_compare_heap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_heap_series_cumsum(s : SortcompareheapSeries) -> SortcompareheapSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_heap_series_to_string(s : SortcompareheapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareheapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_heap_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareheapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_heap_matrix_identity(n : Int) -> SortcompareheapMatrix {
  let m = sort_compare_heap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_heap_matrix_get(m : SortcompareheapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_heap_matrix_transpose(m : SortcompareheapMatrix) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_heap_matrix_add(a : SortcompareheapMatrix, b : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_heap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_heap_matrix_scale(m : SortcompareheapMatrix, s : Double) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_heap_matrix_multiply(a : SortcompareheapMatrix, b : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if a.cols != b.rows { return sort_compare_heap_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_heap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_heap_matrix_trace(m : SortcompareheapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_heap_matrix_det(m : SortcompareheapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_heap_matrix_norm(m : SortcompareheapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_heap_matrix_to_string(m : SortcompareheapMatrix) -> String {
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

pub(all) struct SortcompareheapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_heap_make_vector(comps : Array[Double]) -> SortcompareheapVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_heap_vector_zero(dim : Int) -> SortcompareheapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_heap_vector_add(a : SortcompareheapVector, b : SortcompareheapVector) -> SortcompareheapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_heap_vector_sub(a : SortcompareheapVector, b : SortcompareheapVector) -> SortcompareheapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_heap_vector_scale(v : SortcompareheapVector, s : Double) -> SortcompareheapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_heap_vector_dot(a : SortcompareheapVector, b : SortcompareheapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_heap_vector_norm(v : SortcompareheapVector) -> Double { @_common.sqrt(sort_compare_heap_vector_dot(v, v)) }

pub fn sort_compare_heap_vector_normalize(v : SortcompareheapVector) -> SortcompareheapVector {
  let n = sort_compare_heap_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_heap_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_heap_vector_dist(a : SortcompareheapVector, b : SortcompareheapVector) -> Double {
  sort_compare_heap_vector_norm(sort_compare_heap_vector_sub(a, b))
}

pub fn sort_compare_heap_vector_to_string(v : SortcompareheapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_heap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_heap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_heap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_heap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_heap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_heap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_heap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_heap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_heap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_heap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_heap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_heap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_heap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_heap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_heap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_heap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_heap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_heap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_heap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_heap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_heap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_heap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_heap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_heap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_heap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_heap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_heap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_heap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_heap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareheapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_frame_make(size : Int) -> SortcompareheapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_frame_len(s : SortcompareheapFrame) -> Int { s.size }

pub fn sort_compare_heap_frame_get(s : SortcompareheapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_frame_set(s : SortcompareheapFrame, i : Int, v : Double) -> SortcompareheapFrame {
  let result = sort_compare_heap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_frame_sum(s : SortcompareheapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_frame_mean(s : SortcompareheapFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_frame_scale(s : SortcompareheapFrame, f : Double) -> SortcompareheapFrame {
  let result = sort_compare_heap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_frame_add(a : SortcompareheapFrame, b : SortcompareheapFrame) -> SortcompareheapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_frame_copy(s : SortcompareheapFrame) -> SortcompareheapFrame {
  let result = sort_compare_heap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_frame_fill(s : SortcompareheapFrame, v : Double) -> SortcompareheapFrame {
  let result = sort_compare_heap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_frame_min(s : SortcompareheapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_frame_max(s : SortcompareheapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_frame_to_string(s : SortcompareheapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_table_make(size : Int) -> SortcompareheapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_table_len(s : SortcompareheapTable) -> Int { s.size }

pub fn sort_compare_heap_table_get(s : SortcompareheapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_table_set(s : SortcompareheapTable, i : Int, v : Double) -> SortcompareheapTable {
  let result = sort_compare_heap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_table_sum(s : SortcompareheapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_table_mean(s : SortcompareheapTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_table_scale(s : SortcompareheapTable, f : Double) -> SortcompareheapTable {
  let result = sort_compare_heap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_table_add(a : SortcompareheapTable, b : SortcompareheapTable) -> SortcompareheapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_table_copy(s : SortcompareheapTable) -> SortcompareheapTable {
  let result = sort_compare_heap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_table_fill(s : SortcompareheapTable, v : Double) -> SortcompareheapTable {
  let result = sort_compare_heap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_table_min(s : SortcompareheapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_table_max(s : SortcompareheapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_table_to_string(s : SortcompareheapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_graphn_make(size : Int) -> SortcompareheapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_graphn_len(s : SortcompareheapGraphN) -> Int { s.size }

pub fn sort_compare_heap_graphn_get(s : SortcompareheapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_graphn_set(s : SortcompareheapGraphN, i : Int, v : Double) -> SortcompareheapGraphN {
  let result = sort_compare_heap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_graphn_sum(s : SortcompareheapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_graphn_mean(s : SortcompareheapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_graphn_scale(s : SortcompareheapGraphN, f : Double) -> SortcompareheapGraphN {
  let result = sort_compare_heap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_graphn_add(a : SortcompareheapGraphN, b : SortcompareheapGraphN) -> SortcompareheapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_graphn_copy(s : SortcompareheapGraphN) -> SortcompareheapGraphN {
  let result = sort_compare_heap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_graphn_fill(s : SortcompareheapGraphN, v : Double) -> SortcompareheapGraphN {
  let result = sort_compare_heap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_graphn_min(s : SortcompareheapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_graphn_max(s : SortcompareheapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_graphn_to_string(s : SortcompareheapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_node_make(size : Int) -> SortcompareheapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_node_len(s : SortcompareheapNode) -> Int { s.size }

pub fn sort_compare_heap_node_get(s : SortcompareheapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_node_set(s : SortcompareheapNode, i : Int, v : Double) -> SortcompareheapNode {
  let result = sort_compare_heap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_node_sum(s : SortcompareheapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_node_mean(s : SortcompareheapNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_node_scale(s : SortcompareheapNode, f : Double) -> SortcompareheapNode {
  let result = sort_compare_heap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_node_add(a : SortcompareheapNode, b : SortcompareheapNode) -> SortcompareheapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_node_copy(s : SortcompareheapNode) -> SortcompareheapNode {
  let result = sort_compare_heap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_node_fill(s : SortcompareheapNode, v : Double) -> SortcompareheapNode {
  let result = sort_compare_heap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_node_min(s : SortcompareheapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_node_max(s : SortcompareheapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_node_to_string(s : SortcompareheapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_edge_make(size : Int) -> SortcompareheapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_edge_len(s : SortcompareheapEdge) -> Int { s.size }

pub fn sort_compare_heap_edge_get(s : SortcompareheapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_edge_set(s : SortcompareheapEdge, i : Int, v : Double) -> SortcompareheapEdge {
  let result = sort_compare_heap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_edge_sum(s : SortcompareheapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_edge_mean(s : SortcompareheapEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_edge_scale(s : SortcompareheapEdge, f : Double) -> SortcompareheapEdge {
  let result = sort_compare_heap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_edge_add(a : SortcompareheapEdge, b : SortcompareheapEdge) -> SortcompareheapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_edge_copy(s : SortcompareheapEdge) -> SortcompareheapEdge {
  let result = sort_compare_heap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_edge_fill(s : SortcompareheapEdge, v : Double) -> SortcompareheapEdge {
  let result = sort_compare_heap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_edge_min(s : SortcompareheapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_edge_max(s : SortcompareheapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_edge_to_string(s : SortcompareheapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_path_make(size : Int) -> SortcompareheapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_path_len(s : SortcompareheapPath) -> Int { s.size }

pub fn sort_compare_heap_path_get(s : SortcompareheapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_path_set(s : SortcompareheapPath, i : Int, v : Double) -> SortcompareheapPath {
  let result = sort_compare_heap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_path_sum(s : SortcompareheapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_path_mean(s : SortcompareheapPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_path_scale(s : SortcompareheapPath, f : Double) -> SortcompareheapPath {
  let result = sort_compare_heap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_path_add(a : SortcompareheapPath, b : SortcompareheapPath) -> SortcompareheapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_path_copy(s : SortcompareheapPath) -> SortcompareheapPath {
  let result = sort_compare_heap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_path_fill(s : SortcompareheapPath, v : Double) -> SortcompareheapPath {
  let result = sort_compare_heap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_path_min(s : SortcompareheapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_path_max(s : SortcompareheapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_path_to_string(s : SortcompareheapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cluster_make(size : Int) -> SortcompareheapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_cluster_len(s : SortcompareheapCluster) -> Int { s.size }

pub fn sort_compare_heap_cluster_get(s : SortcompareheapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_cluster_set(s : SortcompareheapCluster, i : Int, v : Double) -> SortcompareheapCluster {
  let result = sort_compare_heap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_cluster_sum(s : SortcompareheapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_cluster_mean(s : SortcompareheapCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_cluster_scale(s : SortcompareheapCluster, f : Double) -> SortcompareheapCluster {
  let result = sort_compare_heap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_cluster_add(a : SortcompareheapCluster, b : SortcompareheapCluster) -> SortcompareheapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_cluster_copy(s : SortcompareheapCluster) -> SortcompareheapCluster {
  let result = sort_compare_heap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_cluster_fill(s : SortcompareheapCluster, v : Double) -> SortcompareheapCluster {
  let result = sort_compare_heap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_cluster_min(s : SortcompareheapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_cluster_max(s : SortcompareheapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_cluster_to_string(s : SortcompareheapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_model_make(size : Int) -> SortcompareheapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_model_len(s : SortcompareheapModel) -> Int { s.size }

pub fn sort_compare_heap_model_get(s : SortcompareheapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_model_set(s : SortcompareheapModel, i : Int, v : Double) -> SortcompareheapModel {
  let result = sort_compare_heap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_model_sum(s : SortcompareheapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_model_mean(s : SortcompareheapModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_model_scale(s : SortcompareheapModel, f : Double) -> SortcompareheapModel {
  let result = sort_compare_heap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_model_add(a : SortcompareheapModel, b : SortcompareheapModel) -> SortcompareheapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_model_copy(s : SortcompareheapModel) -> SortcompareheapModel {
  let result = sort_compare_heap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_model_fill(s : SortcompareheapModel, v : Double) -> SortcompareheapModel {
  let result = sort_compare_heap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_model_min(s : SortcompareheapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_model_max(s : SortcompareheapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_model_to_string(s : SortcompareheapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_layer_make(size : Int) -> SortcompareheapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_layer_len(s : SortcompareheapLayer) -> Int { s.size }

pub fn sort_compare_heap_layer_get(s : SortcompareheapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_layer_set(s : SortcompareheapLayer, i : Int, v : Double) -> SortcompareheapLayer {
  let result = sort_compare_heap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_layer_sum(s : SortcompareheapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_layer_mean(s : SortcompareheapLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_layer_scale(s : SortcompareheapLayer, f : Double) -> SortcompareheapLayer {
  let result = sort_compare_heap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_layer_add(a : SortcompareheapLayer, b : SortcompareheapLayer) -> SortcompareheapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_layer_copy(s : SortcompareheapLayer) -> SortcompareheapLayer {
  let result = sort_compare_heap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_layer_fill(s : SortcompareheapLayer, v : Double) -> SortcompareheapLayer {
  let result = sort_compare_heap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_layer_min(s : SortcompareheapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_layer_max(s : SortcompareheapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_layer_to_string(s : SortcompareheapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_buffer_make(size : Int) -> SortcompareheapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_buffer_len(s : SortcompareheapBuffer) -> Int { s.size }

pub fn sort_compare_heap_buffer_get(s : SortcompareheapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_buffer_set(s : SortcompareheapBuffer, i : Int, v : Double) -> SortcompareheapBuffer {
  let result = sort_compare_heap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_buffer_sum(s : SortcompareheapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_buffer_mean(s : SortcompareheapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_buffer_scale(s : SortcompareheapBuffer, f : Double) -> SortcompareheapBuffer {
  let result = sort_compare_heap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_buffer_add(a : SortcompareheapBuffer, b : SortcompareheapBuffer) -> SortcompareheapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_buffer_copy(s : SortcompareheapBuffer) -> SortcompareheapBuffer {
  let result = sort_compare_heap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_buffer_fill(s : SortcompareheapBuffer, v : Double) -> SortcompareheapBuffer {
  let result = sort_compare_heap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_buffer_min(s : SortcompareheapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_buffer_max(s : SortcompareheapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_buffer_to_string(s : SortcompareheapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cursor_make(size : Int) -> SortcompareheapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_cursor_len(s : SortcompareheapCursor) -> Int { s.size }

pub fn sort_compare_heap_cursor_get(s : SortcompareheapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_cursor_set(s : SortcompareheapCursor, i : Int, v : Double) -> SortcompareheapCursor {
  let result = sort_compare_heap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_cursor_sum(s : SortcompareheapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_cursor_mean(s : SortcompareheapCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_cursor_scale(s : SortcompareheapCursor, f : Double) -> SortcompareheapCursor {
  let result = sort_compare_heap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_cursor_add(a : SortcompareheapCursor, b : SortcompareheapCursor) -> SortcompareheapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_cursor_copy(s : SortcompareheapCursor) -> SortcompareheapCursor {
  let result = sort_compare_heap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_cursor_fill(s : SortcompareheapCursor, v : Double) -> SortcompareheapCursor {
  let result = sort_compare_heap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_cursor_min(s : SortcompareheapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_cursor_max(s : SortcompareheapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_cursor_to_string(s : SortcompareheapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_view_make(size : Int) -> SortcompareheapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_view_len(s : SortcompareheapView) -> Int { s.size }

pub fn sort_compare_heap_view_get(s : SortcompareheapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_view_set(s : SortcompareheapView, i : Int, v : Double) -> SortcompareheapView {
  let result = sort_compare_heap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_view_sum(s : SortcompareheapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_view_mean(s : SortcompareheapView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_view_scale(s : SortcompareheapView, f : Double) -> SortcompareheapView {
  let result = sort_compare_heap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_view_add(a : SortcompareheapView, b : SortcompareheapView) -> SortcompareheapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_view_copy(s : SortcompareheapView) -> SortcompareheapView {
  let result = sort_compare_heap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_view_fill(s : SortcompareheapView, v : Double) -> SortcompareheapView {
  let result = sort_compare_heap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_view_min(s : SortcompareheapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_view_max(s : SortcompareheapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_view_to_string(s : SortcompareheapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_range_make(size : Int) -> SortcompareheapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_range_len(s : SortcompareheapRange) -> Int { s.size }

pub fn sort_compare_heap_range_get(s : SortcompareheapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_range_set(s : SortcompareheapRange, i : Int, v : Double) -> SortcompareheapRange {
  let result = sort_compare_heap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_range_sum(s : SortcompareheapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_range_mean(s : SortcompareheapRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_range_scale(s : SortcompareheapRange, f : Double) -> SortcompareheapRange {
  let result = sort_compare_heap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_range_add(a : SortcompareheapRange, b : SortcompareheapRange) -> SortcompareheapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_range_copy(s : SortcompareheapRange) -> SortcompareheapRange {
  let result = sort_compare_heap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_range_fill(s : SortcompareheapRange, v : Double) -> SortcompareheapRange {
  let result = sort_compare_heap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_range_min(s : SortcompareheapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_range_max(s : SortcompareheapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_range_to_string(s : SortcompareheapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_slice_make(size : Int) -> SortcompareheapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_slice_len(s : SortcompareheapSlice) -> Int { s.size }

pub fn sort_compare_heap_slice_get(s : SortcompareheapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_slice_set(s : SortcompareheapSlice, i : Int, v : Double) -> SortcompareheapSlice {
  let result = sort_compare_heap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_slice_sum(s : SortcompareheapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_heap_slice_mean(s : SortcompareheapSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_heap_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_heap_slice_scale(s : SortcompareheapSlice, f : Double) -> SortcompareheapSlice {
  let result = sort_compare_heap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_heap_slice_add(a : SortcompareheapSlice, b : SortcompareheapSlice) -> SortcompareheapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_heap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_heap_slice_copy(s : SortcompareheapSlice) -> SortcompareheapSlice {
  let result = sort_compare_heap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_heap_slice_fill(s : SortcompareheapSlice, v : Double) -> SortcompareheapSlice {
  let result = sort_compare_heap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_heap_slice_min(s : SortcompareheapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_slice_max(s : SortcompareheapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_heap_slice_to_string(s : SortcompareheapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


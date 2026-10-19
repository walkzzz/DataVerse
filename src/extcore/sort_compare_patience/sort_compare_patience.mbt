///===
/// extcore/sort_compare_patience

pub(all) struct SortcomparepatiencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_patience_make_point(x : Double, y : Double) -> SortcomparepatiencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_patience_make_point3(x : Double, y : Double, z : Double) -> SortcomparepatiencePoint {
  { x, y, z, label: 0 }
}

pub fn sort_compare_patience_point_x(pt : SortcomparepatiencePoint) -> Double { pt.x }

pub fn sort_compare_patience_point_y(pt : SortcomparepatiencePoint) -> Double { pt.y }

pub fn sort_compare_patience_point_z(pt : SortcomparepatiencePoint) -> Double { pt.z }

pub fn sort_compare_patience_point_label(pt : SortcomparepatiencePoint) -> Int { pt.label }

pub fn sort_compare_patience_point_dist(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_compare_patience_point_add(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_compare_patience_point_sub(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_compare_patience_point_scale(pt : SortcomparepatiencePoint, s : Double) -> SortcomparepatiencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_compare_patience_point_dot(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_compare_patience_point_cross(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_compare_patience_point_norm(pt : SortcomparepatiencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_compare_patience_point_normalize(pt : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  let n = sort_compare_patience_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_compare_patience_point_scale(pt, 1.0 / n) }
}

pub fn sort_compare_patience_point_negate(pt : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_compare_patience_point_mid(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_compare_patience_point_lerp(a : SortcomparepatiencePoint, b : SortcomparepatiencePoint, t : Double) -> SortcomparepatiencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_compare_patience_point_to_string(pt : SortcomparepatiencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortcomparepatienceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_patience_make_series(vals : Array[Double], name : String) -> SortcomparepatienceSeries {
  { vals, name, meta: 0 }
}

pub fn sort_compare_patience_series_len(s : SortcomparepatienceSeries) -> Int { s.vals.length() }

pub fn sort_compare_patience_series_sum(s : SortcomparepatienceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_compare_patience_series_mean(s : SortcomparepatienceSeries) -> Double {
  let n = sort_compare_patience_series_len(s)
  if n == 0 { 0.0 } else { sort_compare_patience_series_sum(s) / n.to_double() }
}

pub fn sort_compare_patience_series_min(s : SortcomparepatienceSeries) -> Double {
  let n = sort_compare_patience_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_patience_series_max(s : SortcomparepatienceSeries) -> Double {
  let n = sort_compare_patience_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_compare_patience_series_range(s : SortcomparepatienceSeries) -> Double {
  sort_compare_patience_series_max(s) - sort_compare_patience_series_min(s)
}

pub fn sort_compare_patience_series_var(s : SortcomparepatienceSeries) -> Double {
  let n = sort_compare_patience_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_compare_patience_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_compare_patience_series_std(s : SortcomparepatienceSeries) -> Double { @_common.sqrt(sort_compare_patience_series_var(s)) }

pub fn sort_compare_patience_series_median(s : SortcomparepatienceSeries) -> Double {
  let n = sort_compare_patience_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_compare_patience_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_compare_patience_series_scale(s : SortcomparepatienceSeries, f : Double) -> SortcomparepatienceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_compare_patience_series_add(a : SortcomparepatienceSeries, b : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_compare_patience_series_sub(a : SortcomparepatienceSeries, b : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_compare_patience_series_normalize(s : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let mn = sort_compare_patience_series_min(s)
  let mx = sort_compare_patience_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_compare_patience_series_cumsum(s : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_compare_patience_series_to_string(s : SortcomparepatienceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparepatienceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_patience_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparepatienceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_patience_matrix_identity(n : Int) -> SortcomparepatienceMatrix {
  let m = sort_compare_patience_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_compare_patience_matrix_get(m : SortcomparepatienceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_compare_patience_matrix_transpose(m : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_compare_patience_matrix_add(a : SortcomparepatienceMatrix, b : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_compare_patience_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_compare_patience_matrix_scale(m : SortcomparepatienceMatrix, s : Double) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_compare_patience_matrix_multiply(a : SortcomparepatienceMatrix, b : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if a.cols != b.rows { return sort_compare_patience_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_compare_patience_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_compare_patience_matrix_trace(m : SortcomparepatienceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_compare_patience_matrix_det(m : SortcomparepatienceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_compare_patience_matrix_norm(m : SortcomparepatienceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_compare_patience_matrix_to_string(m : SortcomparepatienceMatrix) -> String {
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

pub(all) struct SortcomparepatienceVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_patience_make_vector(comps : Array[Double]) -> SortcomparepatienceVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_patience_vector_zero(dim : Int) -> SortcomparepatienceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_compare_patience_vector_add(a : SortcomparepatienceVector, b : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_patience_vector_sub(a : SortcomparepatienceVector, b : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_compare_patience_vector_scale(v : SortcomparepatienceVector, s : Double) -> SortcomparepatienceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_compare_patience_vector_dot(a : SortcomparepatienceVector, b : SortcomparepatienceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_compare_patience_vector_norm(v : SortcomparepatienceVector) -> Double { @_common.sqrt(sort_compare_patience_vector_dot(v, v)) }

pub fn sort_compare_patience_vector_normalize(v : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = sort_compare_patience_vector_norm(v)
  if n < 0.0000001 { v } else { sort_compare_patience_vector_scale(v, 1.0 / n) }
}

pub fn sort_compare_patience_vector_dist(a : SortcomparepatienceVector, b : SortcomparepatienceVector) -> Double {
  sort_compare_patience_vector_norm(sort_compare_patience_vector_sub(a, b))
}

pub fn sort_compare_patience_vector_to_string(v : SortcomparepatienceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_patience_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_patience_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_patience_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_patience_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_patience_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_patience_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_patience_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_patience_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_patience_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_patience_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_patience_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_patience_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_patience_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_patience_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_patience_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_patience_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_patience_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_patience_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_patience_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_patience_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_patience_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_patience_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_patience_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_patience_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_patience_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_patience_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_patience_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_patience_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_patience_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparepatienceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_frame_make(size : Int) -> SortcomparepatienceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_frame_len(s : SortcomparepatienceFrame) -> Int { s.size }

pub fn sort_compare_patience_frame_get(s : SortcomparepatienceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_frame_set(s : SortcomparepatienceFrame, i : Int, v : Double) -> SortcomparepatienceFrame {
  let result = sort_compare_patience_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_frame_sum(s : SortcomparepatienceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_frame_mean(s : SortcomparepatienceFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_frame_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_frame_scale(s : SortcomparepatienceFrame, f : Double) -> SortcomparepatienceFrame {
  let result = sort_compare_patience_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_frame_add(a : SortcomparepatienceFrame, b : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_frame_copy(s : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  let result = sort_compare_patience_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_frame_fill(s : SortcomparepatienceFrame, v : Double) -> SortcomparepatienceFrame {
  let result = sort_compare_patience_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_frame_min(s : SortcomparepatienceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_frame_max(s : SortcomparepatienceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_frame_to_string(s : SortcomparepatienceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_table_make(size : Int) -> SortcomparepatienceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_table_len(s : SortcomparepatienceTable) -> Int { s.size }

pub fn sort_compare_patience_table_get(s : SortcomparepatienceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_table_set(s : SortcomparepatienceTable, i : Int, v : Double) -> SortcomparepatienceTable {
  let result = sort_compare_patience_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_table_sum(s : SortcomparepatienceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_table_mean(s : SortcomparepatienceTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_table_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_table_scale(s : SortcomparepatienceTable, f : Double) -> SortcomparepatienceTable {
  let result = sort_compare_patience_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_table_add(a : SortcomparepatienceTable, b : SortcomparepatienceTable) -> SortcomparepatienceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_table_copy(s : SortcomparepatienceTable) -> SortcomparepatienceTable {
  let result = sort_compare_patience_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_table_fill(s : SortcomparepatienceTable, v : Double) -> SortcomparepatienceTable {
  let result = sort_compare_patience_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_table_min(s : SortcomparepatienceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_table_max(s : SortcomparepatienceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_table_to_string(s : SortcomparepatienceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_graphn_make(size : Int) -> SortcomparepatienceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_graphn_len(s : SortcomparepatienceGraphN) -> Int { s.size }

pub fn sort_compare_patience_graphn_get(s : SortcomparepatienceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_graphn_set(s : SortcomparepatienceGraphN, i : Int, v : Double) -> SortcomparepatienceGraphN {
  let result = sort_compare_patience_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_graphn_sum(s : SortcomparepatienceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_graphn_mean(s : SortcomparepatienceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_graphn_scale(s : SortcomparepatienceGraphN, f : Double) -> SortcomparepatienceGraphN {
  let result = sort_compare_patience_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_graphn_add(a : SortcomparepatienceGraphN, b : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_graphn_copy(s : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  let result = sort_compare_patience_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_graphn_fill(s : SortcomparepatienceGraphN, v : Double) -> SortcomparepatienceGraphN {
  let result = sort_compare_patience_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_graphn_min(s : SortcomparepatienceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_graphn_max(s : SortcomparepatienceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_graphn_to_string(s : SortcomparepatienceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_node_make(size : Int) -> SortcomparepatienceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_node_len(s : SortcomparepatienceNode) -> Int { s.size }

pub fn sort_compare_patience_node_get(s : SortcomparepatienceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_node_set(s : SortcomparepatienceNode, i : Int, v : Double) -> SortcomparepatienceNode {
  let result = sort_compare_patience_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_node_sum(s : SortcomparepatienceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_node_mean(s : SortcomparepatienceNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_node_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_node_scale(s : SortcomparepatienceNode, f : Double) -> SortcomparepatienceNode {
  let result = sort_compare_patience_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_node_add(a : SortcomparepatienceNode, b : SortcomparepatienceNode) -> SortcomparepatienceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_node_copy(s : SortcomparepatienceNode) -> SortcomparepatienceNode {
  let result = sort_compare_patience_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_node_fill(s : SortcomparepatienceNode, v : Double) -> SortcomparepatienceNode {
  let result = sort_compare_patience_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_node_min(s : SortcomparepatienceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_node_max(s : SortcomparepatienceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_node_to_string(s : SortcomparepatienceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_edge_make(size : Int) -> SortcomparepatienceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_edge_len(s : SortcomparepatienceEdge) -> Int { s.size }

pub fn sort_compare_patience_edge_get(s : SortcomparepatienceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_edge_set(s : SortcomparepatienceEdge, i : Int, v : Double) -> SortcomparepatienceEdge {
  let result = sort_compare_patience_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_edge_sum(s : SortcomparepatienceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_edge_mean(s : SortcomparepatienceEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_edge_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_edge_scale(s : SortcomparepatienceEdge, f : Double) -> SortcomparepatienceEdge {
  let result = sort_compare_patience_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_edge_add(a : SortcomparepatienceEdge, b : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_edge_copy(s : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  let result = sort_compare_patience_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_edge_fill(s : SortcomparepatienceEdge, v : Double) -> SortcomparepatienceEdge {
  let result = sort_compare_patience_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_edge_min(s : SortcomparepatienceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_edge_max(s : SortcomparepatienceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_edge_to_string(s : SortcomparepatienceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatiencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_path_make(size : Int) -> SortcomparepatiencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_path_len(s : SortcomparepatiencePath) -> Int { s.size }

pub fn sort_compare_patience_path_get(s : SortcomparepatiencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_path_set(s : SortcomparepatiencePath, i : Int, v : Double) -> SortcomparepatiencePath {
  let result = sort_compare_patience_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_path_sum(s : SortcomparepatiencePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_path_mean(s : SortcomparepatiencePath) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_path_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_path_scale(s : SortcomparepatiencePath, f : Double) -> SortcomparepatiencePath {
  let result = sort_compare_patience_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_path_add(a : SortcomparepatiencePath, b : SortcomparepatiencePath) -> SortcomparepatiencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_path_copy(s : SortcomparepatiencePath) -> SortcomparepatiencePath {
  let result = sort_compare_patience_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_path_fill(s : SortcomparepatiencePath, v : Double) -> SortcomparepatiencePath {
  let result = sort_compare_patience_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_path_min(s : SortcomparepatiencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_path_max(s : SortcomparepatiencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_path_to_string(s : SortcomparepatiencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cluster_make(size : Int) -> SortcomparepatienceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_cluster_len(s : SortcomparepatienceCluster) -> Int { s.size }

pub fn sort_compare_patience_cluster_get(s : SortcomparepatienceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_cluster_set(s : SortcomparepatienceCluster, i : Int, v : Double) -> SortcomparepatienceCluster {
  let result = sort_compare_patience_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_cluster_sum(s : SortcomparepatienceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_cluster_mean(s : SortcomparepatienceCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_cluster_scale(s : SortcomparepatienceCluster, f : Double) -> SortcomparepatienceCluster {
  let result = sort_compare_patience_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_cluster_add(a : SortcomparepatienceCluster, b : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_cluster_copy(s : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  let result = sort_compare_patience_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_cluster_fill(s : SortcomparepatienceCluster, v : Double) -> SortcomparepatienceCluster {
  let result = sort_compare_patience_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_cluster_min(s : SortcomparepatienceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_cluster_max(s : SortcomparepatienceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_cluster_to_string(s : SortcomparepatienceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_model_make(size : Int) -> SortcomparepatienceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_model_len(s : SortcomparepatienceModel) -> Int { s.size }

pub fn sort_compare_patience_model_get(s : SortcomparepatienceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_model_set(s : SortcomparepatienceModel, i : Int, v : Double) -> SortcomparepatienceModel {
  let result = sort_compare_patience_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_model_sum(s : SortcomparepatienceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_model_mean(s : SortcomparepatienceModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_model_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_model_scale(s : SortcomparepatienceModel, f : Double) -> SortcomparepatienceModel {
  let result = sort_compare_patience_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_model_add(a : SortcomparepatienceModel, b : SortcomparepatienceModel) -> SortcomparepatienceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_model_copy(s : SortcomparepatienceModel) -> SortcomparepatienceModel {
  let result = sort_compare_patience_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_model_fill(s : SortcomparepatienceModel, v : Double) -> SortcomparepatienceModel {
  let result = sort_compare_patience_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_model_min(s : SortcomparepatienceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_model_max(s : SortcomparepatienceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_model_to_string(s : SortcomparepatienceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_layer_make(size : Int) -> SortcomparepatienceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_layer_len(s : SortcomparepatienceLayer) -> Int { s.size }

pub fn sort_compare_patience_layer_get(s : SortcomparepatienceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_layer_set(s : SortcomparepatienceLayer, i : Int, v : Double) -> SortcomparepatienceLayer {
  let result = sort_compare_patience_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_layer_sum(s : SortcomparepatienceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_layer_mean(s : SortcomparepatienceLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_layer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_layer_scale(s : SortcomparepatienceLayer, f : Double) -> SortcomparepatienceLayer {
  let result = sort_compare_patience_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_layer_add(a : SortcomparepatienceLayer, b : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_layer_copy(s : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  let result = sort_compare_patience_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_layer_fill(s : SortcomparepatienceLayer, v : Double) -> SortcomparepatienceLayer {
  let result = sort_compare_patience_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_layer_min(s : SortcomparepatienceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_layer_max(s : SortcomparepatienceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_layer_to_string(s : SortcomparepatienceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_buffer_make(size : Int) -> SortcomparepatienceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_buffer_len(s : SortcomparepatienceBuffer) -> Int { s.size }

pub fn sort_compare_patience_buffer_get(s : SortcomparepatienceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_buffer_set(s : SortcomparepatienceBuffer, i : Int, v : Double) -> SortcomparepatienceBuffer {
  let result = sort_compare_patience_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_buffer_sum(s : SortcomparepatienceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_buffer_mean(s : SortcomparepatienceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_buffer_scale(s : SortcomparepatienceBuffer, f : Double) -> SortcomparepatienceBuffer {
  let result = sort_compare_patience_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_buffer_add(a : SortcomparepatienceBuffer, b : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_buffer_copy(s : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  let result = sort_compare_patience_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_buffer_fill(s : SortcomparepatienceBuffer, v : Double) -> SortcomparepatienceBuffer {
  let result = sort_compare_patience_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_buffer_min(s : SortcomparepatienceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_buffer_max(s : SortcomparepatienceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_buffer_to_string(s : SortcomparepatienceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cursor_make(size : Int) -> SortcomparepatienceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_cursor_len(s : SortcomparepatienceCursor) -> Int { s.size }

pub fn sort_compare_patience_cursor_get(s : SortcomparepatienceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_cursor_set(s : SortcomparepatienceCursor, i : Int, v : Double) -> SortcomparepatienceCursor {
  let result = sort_compare_patience_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_cursor_sum(s : SortcomparepatienceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_cursor_mean(s : SortcomparepatienceCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_cursor_scale(s : SortcomparepatienceCursor, f : Double) -> SortcomparepatienceCursor {
  let result = sort_compare_patience_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_cursor_add(a : SortcomparepatienceCursor, b : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_cursor_copy(s : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  let result = sort_compare_patience_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_cursor_fill(s : SortcomparepatienceCursor, v : Double) -> SortcomparepatienceCursor {
  let result = sort_compare_patience_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_cursor_min(s : SortcomparepatienceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_cursor_max(s : SortcomparepatienceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_cursor_to_string(s : SortcomparepatienceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_view_make(size : Int) -> SortcomparepatienceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_view_len(s : SortcomparepatienceView) -> Int { s.size }

pub fn sort_compare_patience_view_get(s : SortcomparepatienceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_view_set(s : SortcomparepatienceView, i : Int, v : Double) -> SortcomparepatienceView {
  let result = sort_compare_patience_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_view_sum(s : SortcomparepatienceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_view_mean(s : SortcomparepatienceView) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_view_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_view_scale(s : SortcomparepatienceView, f : Double) -> SortcomparepatienceView {
  let result = sort_compare_patience_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_view_add(a : SortcomparepatienceView, b : SortcomparepatienceView) -> SortcomparepatienceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_view_copy(s : SortcomparepatienceView) -> SortcomparepatienceView {
  let result = sort_compare_patience_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_view_fill(s : SortcomparepatienceView, v : Double) -> SortcomparepatienceView {
  let result = sort_compare_patience_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_view_min(s : SortcomparepatienceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_view_max(s : SortcomparepatienceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_view_to_string(s : SortcomparepatienceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_range_make(size : Int) -> SortcomparepatienceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_range_len(s : SortcomparepatienceRange) -> Int { s.size }

pub fn sort_compare_patience_range_get(s : SortcomparepatienceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_range_set(s : SortcomparepatienceRange, i : Int, v : Double) -> SortcomparepatienceRange {
  let result = sort_compare_patience_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_range_sum(s : SortcomparepatienceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_range_mean(s : SortcomparepatienceRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_range_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_range_scale(s : SortcomparepatienceRange, f : Double) -> SortcomparepatienceRange {
  let result = sort_compare_patience_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_range_add(a : SortcomparepatienceRange, b : SortcomparepatienceRange) -> SortcomparepatienceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_range_copy(s : SortcomparepatienceRange) -> SortcomparepatienceRange {
  let result = sort_compare_patience_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_range_fill(s : SortcomparepatienceRange, v : Double) -> SortcomparepatienceRange {
  let result = sort_compare_patience_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_range_min(s : SortcomparepatienceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_range_max(s : SortcomparepatienceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_range_to_string(s : SortcomparepatienceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_slice_make(size : Int) -> SortcomparepatienceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_slice_len(s : SortcomparepatienceSlice) -> Int { s.size }

pub fn sort_compare_patience_slice_get(s : SortcomparepatienceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_slice_set(s : SortcomparepatienceSlice, i : Int, v : Double) -> SortcomparepatienceSlice {
  let result = sort_compare_patience_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_slice_sum(s : SortcomparepatienceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_compare_patience_slice_mean(s : SortcomparepatienceSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_compare_patience_slice_sum(s) / s.size.to_double() }
}

pub fn sort_compare_patience_slice_scale(s : SortcomparepatienceSlice, f : Double) -> SortcomparepatienceSlice {
  let result = sort_compare_patience_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_compare_patience_slice_add(a : SortcomparepatienceSlice, b : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_compare_patience_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_compare_patience_slice_copy(s : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  let result = sort_compare_patience_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_compare_patience_slice_fill(s : SortcomparepatienceSlice, v : Double) -> SortcomparepatienceSlice {
  let result = sort_compare_patience_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_compare_patience_slice_min(s : SortcomparepatienceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_slice_max(s : SortcomparepatienceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_compare_patience_slice_to_string(s : SortcomparepatienceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/sort_dist_bucket

pub(all) struct SortdistbucketPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_bucket_make_point(x : Double, y : Double) -> SortdistbucketPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_bucket_make_point3(x : Double, y : Double, z : Double) -> SortdistbucketPoint {
  { x, y, z, label: 0 }
}

pub fn sort_dist_bucket_point_x(pt : SortdistbucketPoint) -> Double { pt.x }

pub fn sort_dist_bucket_point_y(pt : SortdistbucketPoint) -> Double { pt.y }

pub fn sort_dist_bucket_point_z(pt : SortdistbucketPoint) -> Double { pt.z }

pub fn sort_dist_bucket_point_label(pt : SortdistbucketPoint) -> Int { pt.label }

pub fn sort_dist_bucket_point_dist(a : SortdistbucketPoint, b : SortdistbucketPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_dist_bucket_point_add(a : SortdistbucketPoint, b : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_dist_bucket_point_sub(a : SortdistbucketPoint, b : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_dist_bucket_point_scale(pt : SortdistbucketPoint, s : Double) -> SortdistbucketPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_dist_bucket_point_dot(a : SortdistbucketPoint, b : SortdistbucketPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_dist_bucket_point_cross(a : SortdistbucketPoint, b : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_dist_bucket_point_norm(pt : SortdistbucketPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_dist_bucket_point_normalize(pt : SortdistbucketPoint) -> SortdistbucketPoint {
  let n = sort_dist_bucket_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_dist_bucket_point_scale(pt, 1.0 / n) }
}

pub fn sort_dist_bucket_point_negate(pt : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_dist_bucket_point_mid(a : SortdistbucketPoint, b : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_dist_bucket_point_lerp(a : SortdistbucketPoint, b : SortdistbucketPoint, t : Double) -> SortdistbucketPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_dist_bucket_point_to_string(pt : SortdistbucketPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortdistbucketSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_bucket_make_series(vals : Array[Double], name : String) -> SortdistbucketSeries {
  { vals, name, meta: 0 }
}

pub fn sort_dist_bucket_series_len(s : SortdistbucketSeries) -> Int { s.vals.length() }

pub fn sort_dist_bucket_series_sum(s : SortdistbucketSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_dist_bucket_series_mean(s : SortdistbucketSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_dist_bucket_series_min(s : SortdistbucketSeries) -> Double { @_common.min(s.vals) }

pub fn sort_dist_bucket_series_max(s : SortdistbucketSeries) -> Double { @_common.max(s.vals) }

pub fn sort_dist_bucket_series_range(s : SortdistbucketSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_dist_bucket_series_var(s : SortdistbucketSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_dist_bucket_series_std(s : SortdistbucketSeries) -> Double { @_common.std(s.vals) }

pub fn sort_dist_bucket_series_median(s : SortdistbucketSeries) -> Double { @_common.median(s.vals) }

pub fn sort_dist_bucket_series_scale(s : SortdistbucketSeries, f : Double) -> SortdistbucketSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_dist_bucket_series_add(a : SortdistbucketSeries, b : SortdistbucketSeries) -> SortdistbucketSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_dist_bucket_series_sub(a : SortdistbucketSeries, b : SortdistbucketSeries) -> SortdistbucketSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_dist_bucket_series_normalize(s : SortdistbucketSeries) -> SortdistbucketSeries {
  let mn = sort_dist_bucket_series_min(s)
  let mx = sort_dist_bucket_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_dist_bucket_series_cumsum(s : SortdistbucketSeries) -> SortdistbucketSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_dist_bucket_series_to_string(s : SortdistbucketSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistbucketMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_bucket_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistbucketMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_bucket_matrix_identity(n : Int) -> SortdistbucketMatrix {
  let m = sort_dist_bucket_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_dist_bucket_matrix_get(m : SortdistbucketMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_dist_bucket_matrix_transpose(m : SortdistbucketMatrix) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_dist_bucket_matrix_add(a : SortdistbucketMatrix, b : SortdistbucketMatrix) -> SortdistbucketMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_dist_bucket_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_dist_bucket_matrix_scale(m : SortdistbucketMatrix, s : Double) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_dist_bucket_matrix_multiply(a : SortdistbucketMatrix, b : SortdistbucketMatrix) -> SortdistbucketMatrix {
  if a.cols != b.rows { return sort_dist_bucket_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_dist_bucket_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_dist_bucket_matrix_trace(m : SortdistbucketMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_dist_bucket_matrix_det(m : SortdistbucketMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_dist_bucket_matrix_norm(m : SortdistbucketMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_dist_bucket_matrix_to_string(m : SortdistbucketMatrix) -> String {
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

pub(all) struct SortdistbucketVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_bucket_make_vector(comps : Array[Double]) -> SortdistbucketVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_bucket_vector_zero(dim : Int) -> SortdistbucketVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_dist_bucket_vector_add(a : SortdistbucketVector, b : SortdistbucketVector) -> SortdistbucketVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_bucket_vector_sub(a : SortdistbucketVector, b : SortdistbucketVector) -> SortdistbucketVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_dist_bucket_vector_scale(v : SortdistbucketVector, s : Double) -> SortdistbucketVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_dist_bucket_vector_dot(a : SortdistbucketVector, b : SortdistbucketVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_dist_bucket_vector_norm(v : SortdistbucketVector) -> Double { @_common.sqrt(sort_dist_bucket_vector_dot(v, v)) }

pub fn sort_dist_bucket_vector_normalize(v : SortdistbucketVector) -> SortdistbucketVector {
  let n = sort_dist_bucket_vector_norm(v)
  if n < 0.0000001 { v } else { sort_dist_bucket_vector_scale(v, 1.0 / n) }
}

pub fn sort_dist_bucket_vector_dist(a : SortdistbucketVector, b : SortdistbucketVector) -> Double {
  sort_dist_bucket_vector_norm(sort_dist_bucket_vector_sub(a, b))
}

pub fn sort_dist_bucket_vector_to_string(v : SortdistbucketVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_bucket_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_bucket_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_bucket_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_bucket_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_bucket_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_bucket_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_bucket_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_bucket_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_bucket_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_bucket_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_bucket_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_bucket_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_bucket_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_bucket_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_bucket_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_bucket_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_bucket_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_bucket_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_bucket_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_bucket_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_bucket_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_bucket_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_bucket_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_bucket_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_bucket_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_bucket_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_bucket_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_bucket_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_bucket_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistbucketFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_frame_make(size : Int) -> SortdistbucketFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_frame_len(s : SortdistbucketFrame) -> Int { s.size }

pub fn sort_dist_bucket_frame_get(s : SortdistbucketFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_frame_set(s : SortdistbucketFrame, i : Int, v : Double) -> SortdistbucketFrame {
  let result = sort_dist_bucket_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_frame_sum(s : SortdistbucketFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_frame_mean(s : SortdistbucketFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_frame_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_frame_scale(s : SortdistbucketFrame, f : Double) -> SortdistbucketFrame {
  let result = sort_dist_bucket_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_frame_add(a : SortdistbucketFrame, b : SortdistbucketFrame) -> SortdistbucketFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_frame_copy(s : SortdistbucketFrame) -> SortdistbucketFrame {
  let result = sort_dist_bucket_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_frame_fill(s : SortdistbucketFrame, v : Double) -> SortdistbucketFrame {
  let result = sort_dist_bucket_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_frame_min(s : SortdistbucketFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_frame_max(s : SortdistbucketFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_frame_to_string(s : SortdistbucketFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_table_make(size : Int) -> SortdistbucketTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_table_len(s : SortdistbucketTable) -> Int { s.size }

pub fn sort_dist_bucket_table_get(s : SortdistbucketTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_table_set(s : SortdistbucketTable, i : Int, v : Double) -> SortdistbucketTable {
  let result = sort_dist_bucket_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_table_sum(s : SortdistbucketTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_table_mean(s : SortdistbucketTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_table_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_table_scale(s : SortdistbucketTable, f : Double) -> SortdistbucketTable {
  let result = sort_dist_bucket_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_table_add(a : SortdistbucketTable, b : SortdistbucketTable) -> SortdistbucketTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_table_copy(s : SortdistbucketTable) -> SortdistbucketTable {
  let result = sort_dist_bucket_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_table_fill(s : SortdistbucketTable, v : Double) -> SortdistbucketTable {
  let result = sort_dist_bucket_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_table_min(s : SortdistbucketTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_table_max(s : SortdistbucketTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_table_to_string(s : SortdistbucketTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_graphn_make(size : Int) -> SortdistbucketGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_graphn_len(s : SortdistbucketGraphN) -> Int { s.size }

pub fn sort_dist_bucket_graphn_get(s : SortdistbucketGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_graphn_set(s : SortdistbucketGraphN, i : Int, v : Double) -> SortdistbucketGraphN {
  let result = sort_dist_bucket_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_graphn_sum(s : SortdistbucketGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_graphn_mean(s : SortdistbucketGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_graphn_scale(s : SortdistbucketGraphN, f : Double) -> SortdistbucketGraphN {
  let result = sort_dist_bucket_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_graphn_add(a : SortdistbucketGraphN, b : SortdistbucketGraphN) -> SortdistbucketGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_graphn_copy(s : SortdistbucketGraphN) -> SortdistbucketGraphN {
  let result = sort_dist_bucket_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_graphn_fill(s : SortdistbucketGraphN, v : Double) -> SortdistbucketGraphN {
  let result = sort_dist_bucket_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_graphn_min(s : SortdistbucketGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_graphn_max(s : SortdistbucketGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_graphn_to_string(s : SortdistbucketGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_node_make(size : Int) -> SortdistbucketNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_node_len(s : SortdistbucketNode) -> Int { s.size }

pub fn sort_dist_bucket_node_get(s : SortdistbucketNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_node_set(s : SortdistbucketNode, i : Int, v : Double) -> SortdistbucketNode {
  let result = sort_dist_bucket_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_node_sum(s : SortdistbucketNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_node_mean(s : SortdistbucketNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_node_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_node_scale(s : SortdistbucketNode, f : Double) -> SortdistbucketNode {
  let result = sort_dist_bucket_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_node_add(a : SortdistbucketNode, b : SortdistbucketNode) -> SortdistbucketNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_node_copy(s : SortdistbucketNode) -> SortdistbucketNode {
  let result = sort_dist_bucket_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_node_fill(s : SortdistbucketNode, v : Double) -> SortdistbucketNode {
  let result = sort_dist_bucket_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_node_min(s : SortdistbucketNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_node_max(s : SortdistbucketNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_node_to_string(s : SortdistbucketNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_edge_make(size : Int) -> SortdistbucketEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_edge_len(s : SortdistbucketEdge) -> Int { s.size }

pub fn sort_dist_bucket_edge_get(s : SortdistbucketEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_edge_set(s : SortdistbucketEdge, i : Int, v : Double) -> SortdistbucketEdge {
  let result = sort_dist_bucket_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_edge_sum(s : SortdistbucketEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_edge_mean(s : SortdistbucketEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_edge_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_edge_scale(s : SortdistbucketEdge, f : Double) -> SortdistbucketEdge {
  let result = sort_dist_bucket_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_edge_add(a : SortdistbucketEdge, b : SortdistbucketEdge) -> SortdistbucketEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_edge_copy(s : SortdistbucketEdge) -> SortdistbucketEdge {
  let result = sort_dist_bucket_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_edge_fill(s : SortdistbucketEdge, v : Double) -> SortdistbucketEdge {
  let result = sort_dist_bucket_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_edge_min(s : SortdistbucketEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_edge_max(s : SortdistbucketEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_edge_to_string(s : SortdistbucketEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_path_make(size : Int) -> SortdistbucketPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_path_len(s : SortdistbucketPath) -> Int { s.size }

pub fn sort_dist_bucket_path_get(s : SortdistbucketPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_path_set(s : SortdistbucketPath, i : Int, v : Double) -> SortdistbucketPath {
  let result = sort_dist_bucket_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_path_sum(s : SortdistbucketPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_path_mean(s : SortdistbucketPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_path_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_path_scale(s : SortdistbucketPath, f : Double) -> SortdistbucketPath {
  let result = sort_dist_bucket_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_path_add(a : SortdistbucketPath, b : SortdistbucketPath) -> SortdistbucketPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_path_copy(s : SortdistbucketPath) -> SortdistbucketPath {
  let result = sort_dist_bucket_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_path_fill(s : SortdistbucketPath, v : Double) -> SortdistbucketPath {
  let result = sort_dist_bucket_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_path_min(s : SortdistbucketPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_path_max(s : SortdistbucketPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_path_to_string(s : SortdistbucketPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_cluster_make(size : Int) -> SortdistbucketCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_cluster_len(s : SortdistbucketCluster) -> Int { s.size }

pub fn sort_dist_bucket_cluster_get(s : SortdistbucketCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_cluster_set(s : SortdistbucketCluster, i : Int, v : Double) -> SortdistbucketCluster {
  let result = sort_dist_bucket_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_cluster_sum(s : SortdistbucketCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_cluster_mean(s : SortdistbucketCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_cluster_scale(s : SortdistbucketCluster, f : Double) -> SortdistbucketCluster {
  let result = sort_dist_bucket_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_cluster_add(a : SortdistbucketCluster, b : SortdistbucketCluster) -> SortdistbucketCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_cluster_copy(s : SortdistbucketCluster) -> SortdistbucketCluster {
  let result = sort_dist_bucket_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_cluster_fill(s : SortdistbucketCluster, v : Double) -> SortdistbucketCluster {
  let result = sort_dist_bucket_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_cluster_min(s : SortdistbucketCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_cluster_max(s : SortdistbucketCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_cluster_to_string(s : SortdistbucketCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_model_make(size : Int) -> SortdistbucketModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_model_len(s : SortdistbucketModel) -> Int { s.size }

pub fn sort_dist_bucket_model_get(s : SortdistbucketModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_model_set(s : SortdistbucketModel, i : Int, v : Double) -> SortdistbucketModel {
  let result = sort_dist_bucket_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_model_sum(s : SortdistbucketModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_model_mean(s : SortdistbucketModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_model_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_model_scale(s : SortdistbucketModel, f : Double) -> SortdistbucketModel {
  let result = sort_dist_bucket_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_model_add(a : SortdistbucketModel, b : SortdistbucketModel) -> SortdistbucketModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_model_copy(s : SortdistbucketModel) -> SortdistbucketModel {
  let result = sort_dist_bucket_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_model_fill(s : SortdistbucketModel, v : Double) -> SortdistbucketModel {
  let result = sort_dist_bucket_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_model_min(s : SortdistbucketModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_model_max(s : SortdistbucketModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_model_to_string(s : SortdistbucketModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_layer_make(size : Int) -> SortdistbucketLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_layer_len(s : SortdistbucketLayer) -> Int { s.size }

pub fn sort_dist_bucket_layer_get(s : SortdistbucketLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_layer_set(s : SortdistbucketLayer, i : Int, v : Double) -> SortdistbucketLayer {
  let result = sort_dist_bucket_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_layer_sum(s : SortdistbucketLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_layer_mean(s : SortdistbucketLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_layer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_layer_scale(s : SortdistbucketLayer, f : Double) -> SortdistbucketLayer {
  let result = sort_dist_bucket_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_layer_add(a : SortdistbucketLayer, b : SortdistbucketLayer) -> SortdistbucketLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_layer_copy(s : SortdistbucketLayer) -> SortdistbucketLayer {
  let result = sort_dist_bucket_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_layer_fill(s : SortdistbucketLayer, v : Double) -> SortdistbucketLayer {
  let result = sort_dist_bucket_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_layer_min(s : SortdistbucketLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_layer_max(s : SortdistbucketLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_layer_to_string(s : SortdistbucketLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_buffer_make(size : Int) -> SortdistbucketBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_buffer_len(s : SortdistbucketBuffer) -> Int { s.size }

pub fn sort_dist_bucket_buffer_get(s : SortdistbucketBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_buffer_set(s : SortdistbucketBuffer, i : Int, v : Double) -> SortdistbucketBuffer {
  let result = sort_dist_bucket_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_buffer_sum(s : SortdistbucketBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_buffer_mean(s : SortdistbucketBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_buffer_scale(s : SortdistbucketBuffer, f : Double) -> SortdistbucketBuffer {
  let result = sort_dist_bucket_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_buffer_add(a : SortdistbucketBuffer, b : SortdistbucketBuffer) -> SortdistbucketBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_buffer_copy(s : SortdistbucketBuffer) -> SortdistbucketBuffer {
  let result = sort_dist_bucket_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_buffer_fill(s : SortdistbucketBuffer, v : Double) -> SortdistbucketBuffer {
  let result = sort_dist_bucket_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_buffer_min(s : SortdistbucketBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_buffer_max(s : SortdistbucketBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_buffer_to_string(s : SortdistbucketBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_cursor_make(size : Int) -> SortdistbucketCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_cursor_len(s : SortdistbucketCursor) -> Int { s.size }

pub fn sort_dist_bucket_cursor_get(s : SortdistbucketCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_cursor_set(s : SortdistbucketCursor, i : Int, v : Double) -> SortdistbucketCursor {
  let result = sort_dist_bucket_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_cursor_sum(s : SortdistbucketCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_cursor_mean(s : SortdistbucketCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_cursor_scale(s : SortdistbucketCursor, f : Double) -> SortdistbucketCursor {
  let result = sort_dist_bucket_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_cursor_add(a : SortdistbucketCursor, b : SortdistbucketCursor) -> SortdistbucketCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_cursor_copy(s : SortdistbucketCursor) -> SortdistbucketCursor {
  let result = sort_dist_bucket_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_cursor_fill(s : SortdistbucketCursor, v : Double) -> SortdistbucketCursor {
  let result = sort_dist_bucket_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_cursor_min(s : SortdistbucketCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_cursor_max(s : SortdistbucketCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_cursor_to_string(s : SortdistbucketCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_view_make(size : Int) -> SortdistbucketView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_view_len(s : SortdistbucketView) -> Int { s.size }

pub fn sort_dist_bucket_view_get(s : SortdistbucketView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_view_set(s : SortdistbucketView, i : Int, v : Double) -> SortdistbucketView {
  let result = sort_dist_bucket_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_view_sum(s : SortdistbucketView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_view_mean(s : SortdistbucketView) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_view_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_view_scale(s : SortdistbucketView, f : Double) -> SortdistbucketView {
  let result = sort_dist_bucket_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_view_add(a : SortdistbucketView, b : SortdistbucketView) -> SortdistbucketView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_view_copy(s : SortdistbucketView) -> SortdistbucketView {
  let result = sort_dist_bucket_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_view_fill(s : SortdistbucketView, v : Double) -> SortdistbucketView {
  let result = sort_dist_bucket_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_view_min(s : SortdistbucketView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_view_max(s : SortdistbucketView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_view_to_string(s : SortdistbucketView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_range_make(size : Int) -> SortdistbucketRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_range_len(s : SortdistbucketRange) -> Int { s.size }

pub fn sort_dist_bucket_range_get(s : SortdistbucketRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_range_set(s : SortdistbucketRange, i : Int, v : Double) -> SortdistbucketRange {
  let result = sort_dist_bucket_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_range_sum(s : SortdistbucketRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_range_mean(s : SortdistbucketRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_range_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_range_scale(s : SortdistbucketRange, f : Double) -> SortdistbucketRange {
  let result = sort_dist_bucket_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_range_add(a : SortdistbucketRange, b : SortdistbucketRange) -> SortdistbucketRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_range_copy(s : SortdistbucketRange) -> SortdistbucketRange {
  let result = sort_dist_bucket_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_range_fill(s : SortdistbucketRange, v : Double) -> SortdistbucketRange {
  let result = sort_dist_bucket_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_range_min(s : SortdistbucketRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_range_max(s : SortdistbucketRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_range_to_string(s : SortdistbucketRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_slice_make(size : Int) -> SortdistbucketSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_slice_len(s : SortdistbucketSlice) -> Int { s.size }

pub fn sort_dist_bucket_slice_get(s : SortdistbucketSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_slice_set(s : SortdistbucketSlice, i : Int, v : Double) -> SortdistbucketSlice {
  let result = sort_dist_bucket_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_slice_sum(s : SortdistbucketSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_dist_bucket_slice_mean(s : SortdistbucketSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_dist_bucket_slice_sum(s) / s.size.to_double() }
}

pub fn sort_dist_bucket_slice_scale(s : SortdistbucketSlice, f : Double) -> SortdistbucketSlice {
  let result = sort_dist_bucket_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_dist_bucket_slice_add(a : SortdistbucketSlice, b : SortdistbucketSlice) -> SortdistbucketSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_dist_bucket_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_dist_bucket_slice_copy(s : SortdistbucketSlice) -> SortdistbucketSlice {
  let result = sort_dist_bucket_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_dist_bucket_slice_fill(s : SortdistbucketSlice, v : Double) -> SortdistbucketSlice {
  let result = sort_dist_bucket_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_dist_bucket_slice_min(s : SortdistbucketSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_slice_max(s : SortdistbucketSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_dist_bucket_slice_to_string(s : SortdistbucketSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


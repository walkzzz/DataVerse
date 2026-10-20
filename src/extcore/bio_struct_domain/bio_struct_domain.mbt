///===
/// extcore/bio_struct_domain

pub(all) struct BiostructdomainPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_domain_make_point(x : Double, y : Double) -> BiostructdomainPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_domain_make_point3(x : Double, y : Double, z : Double) -> BiostructdomainPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_domain_point_x(pt : BiostructdomainPoint) -> Double { pt.x }

pub fn bio_struct_domain_point_y(pt : BiostructdomainPoint) -> Double { pt.y }

pub fn bio_struct_domain_point_z(pt : BiostructdomainPoint) -> Double { pt.z }

pub fn bio_struct_domain_point_label(pt : BiostructdomainPoint) -> Int { pt.label }

pub fn bio_struct_domain_point_dist(a : BiostructdomainPoint, b : BiostructdomainPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_domain_point_add(a : BiostructdomainPoint, b : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_domain_point_sub(a : BiostructdomainPoint, b : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_domain_point_scale(pt : BiostructdomainPoint, s : Double) -> BiostructdomainPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_domain_point_dot(a : BiostructdomainPoint, b : BiostructdomainPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_domain_point_cross(a : BiostructdomainPoint, b : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_domain_point_norm(pt : BiostructdomainPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_domain_point_normalize(pt : BiostructdomainPoint) -> BiostructdomainPoint {
  let n = bio_struct_domain_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_domain_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_domain_point_negate(pt : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_domain_point_mid(a : BiostructdomainPoint, b : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_domain_point_lerp(a : BiostructdomainPoint, b : BiostructdomainPoint, t : Double) -> BiostructdomainPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_domain_point_to_string(pt : BiostructdomainPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructdomainSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_domain_make_series(vals : Array[Double], name : String) -> BiostructdomainSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_domain_series_len(s : BiostructdomainSeries) -> Int { s.vals.length() }

pub fn bio_struct_domain_series_sum(s : BiostructdomainSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_struct_domain_series_mean(s : BiostructdomainSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_domain_series_min(s : BiostructdomainSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_domain_series_max(s : BiostructdomainSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_domain_series_range(s : BiostructdomainSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_domain_series_var(s : BiostructdomainSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_domain_series_std(s : BiostructdomainSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_domain_series_median(s : BiostructdomainSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_domain_series_scale(s : BiostructdomainSeries, f : Double) -> BiostructdomainSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_domain_series_add(a : BiostructdomainSeries, b : BiostructdomainSeries) -> BiostructdomainSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_domain_series_sub(a : BiostructdomainSeries, b : BiostructdomainSeries) -> BiostructdomainSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_domain_series_normalize(s : BiostructdomainSeries) -> BiostructdomainSeries {
  let mn = bio_struct_domain_series_min(s)
  let mx = bio_struct_domain_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_domain_series_cumsum(s : BiostructdomainSeries) -> BiostructdomainSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_domain_series_to_string(s : BiostructdomainSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdomainMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_domain_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructdomainMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_domain_matrix_identity(n : Int) -> BiostructdomainMatrix {
  let m = bio_struct_domain_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_domain_matrix_get(m : BiostructdomainMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_domain_matrix_transpose(m : BiostructdomainMatrix) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_domain_matrix_add(a : BiostructdomainMatrix, b : BiostructdomainMatrix) -> BiostructdomainMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_domain_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_domain_matrix_scale(m : BiostructdomainMatrix, s : Double) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_domain_matrix_multiply(a : BiostructdomainMatrix, b : BiostructdomainMatrix) -> BiostructdomainMatrix {
  if a.cols != b.rows { return bio_struct_domain_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_domain_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_domain_matrix_trace(m : BiostructdomainMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_domain_matrix_det(m : BiostructdomainMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_domain_matrix_norm(m : BiostructdomainMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_domain_matrix_to_string(m : BiostructdomainMatrix) -> String {
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

pub(all) struct BiostructdomainVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_domain_make_vector(comps : Array[Double]) -> BiostructdomainVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_domain_vector_zero(dim : Int) -> BiostructdomainVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_domain_vector_add(a : BiostructdomainVector, b : BiostructdomainVector) -> BiostructdomainVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_domain_vector_sub(a : BiostructdomainVector, b : BiostructdomainVector) -> BiostructdomainVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_domain_vector_scale(v : BiostructdomainVector, s : Double) -> BiostructdomainVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_domain_vector_dot(a : BiostructdomainVector, b : BiostructdomainVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_domain_vector_norm(v : BiostructdomainVector) -> Double { @_common.sqrt(bio_struct_domain_vector_dot(v, v)) }

pub fn bio_struct_domain_vector_normalize(v : BiostructdomainVector) -> BiostructdomainVector {
  let n = bio_struct_domain_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_domain_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_domain_vector_dist(a : BiostructdomainVector, b : BiostructdomainVector) -> Double {
  bio_struct_domain_vector_norm(bio_struct_domain_vector_sub(a, b))
}

pub fn bio_struct_domain_vector_to_string(v : BiostructdomainVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_domain_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_domain_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_domain_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_domain_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_domain_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_domain_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_domain_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_domain_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_domain_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_domain_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_domain_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_domain_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_domain_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_domain_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_domain_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_domain_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_domain_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_domain_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_domain_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_domain_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_domain_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_domain_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_domain_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_domain_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_domain_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_domain_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_domain_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_domain_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_domain_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructdomainFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_frame_make(size : Int) -> BiostructdomainFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_frame_len(s : BiostructdomainFrame) -> Int { s.size }

pub fn bio_struct_domain_frame_get(s : BiostructdomainFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_frame_set(s : BiostructdomainFrame, i : Int, v : Double) -> BiostructdomainFrame {
  let result = bio_struct_domain_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_frame_sum(s : BiostructdomainFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_frame_mean(s : BiostructdomainFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_frame_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_frame_scale(s : BiostructdomainFrame, f : Double) -> BiostructdomainFrame {
  let result = bio_struct_domain_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_frame_add(a : BiostructdomainFrame, b : BiostructdomainFrame) -> BiostructdomainFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_frame_copy(s : BiostructdomainFrame) -> BiostructdomainFrame {
  let result = bio_struct_domain_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_frame_fill(s : BiostructdomainFrame, v : Double) -> BiostructdomainFrame {
  let result = bio_struct_domain_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_frame_min(s : BiostructdomainFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_frame_max(s : BiostructdomainFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_frame_to_string(s : BiostructdomainFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_table_make(size : Int) -> BiostructdomainTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_table_len(s : BiostructdomainTable) -> Int { s.size }

pub fn bio_struct_domain_table_get(s : BiostructdomainTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_table_set(s : BiostructdomainTable, i : Int, v : Double) -> BiostructdomainTable {
  let result = bio_struct_domain_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_table_sum(s : BiostructdomainTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_table_mean(s : BiostructdomainTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_table_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_table_scale(s : BiostructdomainTable, f : Double) -> BiostructdomainTable {
  let result = bio_struct_domain_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_table_add(a : BiostructdomainTable, b : BiostructdomainTable) -> BiostructdomainTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_table_copy(s : BiostructdomainTable) -> BiostructdomainTable {
  let result = bio_struct_domain_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_table_fill(s : BiostructdomainTable, v : Double) -> BiostructdomainTable {
  let result = bio_struct_domain_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_table_min(s : BiostructdomainTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_table_max(s : BiostructdomainTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_table_to_string(s : BiostructdomainTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_graphn_make(size : Int) -> BiostructdomainGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_graphn_len(s : BiostructdomainGraphN) -> Int { s.size }

pub fn bio_struct_domain_graphn_get(s : BiostructdomainGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_graphn_set(s : BiostructdomainGraphN, i : Int, v : Double) -> BiostructdomainGraphN {
  let result = bio_struct_domain_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_graphn_sum(s : BiostructdomainGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_graphn_mean(s : BiostructdomainGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_graphn_scale(s : BiostructdomainGraphN, f : Double) -> BiostructdomainGraphN {
  let result = bio_struct_domain_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_graphn_add(a : BiostructdomainGraphN, b : BiostructdomainGraphN) -> BiostructdomainGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_graphn_copy(s : BiostructdomainGraphN) -> BiostructdomainGraphN {
  let result = bio_struct_domain_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_graphn_fill(s : BiostructdomainGraphN, v : Double) -> BiostructdomainGraphN {
  let result = bio_struct_domain_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_graphn_min(s : BiostructdomainGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_graphn_max(s : BiostructdomainGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_graphn_to_string(s : BiostructdomainGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_node_make(size : Int) -> BiostructdomainNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_node_len(s : BiostructdomainNode) -> Int { s.size }

pub fn bio_struct_domain_node_get(s : BiostructdomainNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_node_set(s : BiostructdomainNode, i : Int, v : Double) -> BiostructdomainNode {
  let result = bio_struct_domain_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_node_sum(s : BiostructdomainNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_node_mean(s : BiostructdomainNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_node_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_node_scale(s : BiostructdomainNode, f : Double) -> BiostructdomainNode {
  let result = bio_struct_domain_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_node_add(a : BiostructdomainNode, b : BiostructdomainNode) -> BiostructdomainNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_node_copy(s : BiostructdomainNode) -> BiostructdomainNode {
  let result = bio_struct_domain_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_node_fill(s : BiostructdomainNode, v : Double) -> BiostructdomainNode {
  let result = bio_struct_domain_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_node_min(s : BiostructdomainNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_node_max(s : BiostructdomainNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_node_to_string(s : BiostructdomainNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_edge_make(size : Int) -> BiostructdomainEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_edge_len(s : BiostructdomainEdge) -> Int { s.size }

pub fn bio_struct_domain_edge_get(s : BiostructdomainEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_edge_set(s : BiostructdomainEdge, i : Int, v : Double) -> BiostructdomainEdge {
  let result = bio_struct_domain_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_edge_sum(s : BiostructdomainEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_edge_mean(s : BiostructdomainEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_edge_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_edge_scale(s : BiostructdomainEdge, f : Double) -> BiostructdomainEdge {
  let result = bio_struct_domain_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_edge_add(a : BiostructdomainEdge, b : BiostructdomainEdge) -> BiostructdomainEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_edge_copy(s : BiostructdomainEdge) -> BiostructdomainEdge {
  let result = bio_struct_domain_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_edge_fill(s : BiostructdomainEdge, v : Double) -> BiostructdomainEdge {
  let result = bio_struct_domain_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_edge_min(s : BiostructdomainEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_edge_max(s : BiostructdomainEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_edge_to_string(s : BiostructdomainEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_path_make(size : Int) -> BiostructdomainPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_path_len(s : BiostructdomainPath) -> Int { s.size }

pub fn bio_struct_domain_path_get(s : BiostructdomainPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_path_set(s : BiostructdomainPath, i : Int, v : Double) -> BiostructdomainPath {
  let result = bio_struct_domain_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_path_sum(s : BiostructdomainPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_path_mean(s : BiostructdomainPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_path_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_path_scale(s : BiostructdomainPath, f : Double) -> BiostructdomainPath {
  let result = bio_struct_domain_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_path_add(a : BiostructdomainPath, b : BiostructdomainPath) -> BiostructdomainPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_path_copy(s : BiostructdomainPath) -> BiostructdomainPath {
  let result = bio_struct_domain_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_path_fill(s : BiostructdomainPath, v : Double) -> BiostructdomainPath {
  let result = bio_struct_domain_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_path_min(s : BiostructdomainPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_path_max(s : BiostructdomainPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_path_to_string(s : BiostructdomainPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_cluster_make(size : Int) -> BiostructdomainCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_cluster_len(s : BiostructdomainCluster) -> Int { s.size }

pub fn bio_struct_domain_cluster_get(s : BiostructdomainCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_cluster_set(s : BiostructdomainCluster, i : Int, v : Double) -> BiostructdomainCluster {
  let result = bio_struct_domain_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_cluster_sum(s : BiostructdomainCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_cluster_mean(s : BiostructdomainCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_cluster_scale(s : BiostructdomainCluster, f : Double) -> BiostructdomainCluster {
  let result = bio_struct_domain_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_cluster_add(a : BiostructdomainCluster, b : BiostructdomainCluster) -> BiostructdomainCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_cluster_copy(s : BiostructdomainCluster) -> BiostructdomainCluster {
  let result = bio_struct_domain_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_cluster_fill(s : BiostructdomainCluster, v : Double) -> BiostructdomainCluster {
  let result = bio_struct_domain_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_cluster_min(s : BiostructdomainCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_cluster_max(s : BiostructdomainCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_cluster_to_string(s : BiostructdomainCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_model_make(size : Int) -> BiostructdomainModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_model_len(s : BiostructdomainModel) -> Int { s.size }

pub fn bio_struct_domain_model_get(s : BiostructdomainModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_model_set(s : BiostructdomainModel, i : Int, v : Double) -> BiostructdomainModel {
  let result = bio_struct_domain_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_model_sum(s : BiostructdomainModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_model_mean(s : BiostructdomainModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_model_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_model_scale(s : BiostructdomainModel, f : Double) -> BiostructdomainModel {
  let result = bio_struct_domain_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_model_add(a : BiostructdomainModel, b : BiostructdomainModel) -> BiostructdomainModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_model_copy(s : BiostructdomainModel) -> BiostructdomainModel {
  let result = bio_struct_domain_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_model_fill(s : BiostructdomainModel, v : Double) -> BiostructdomainModel {
  let result = bio_struct_domain_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_model_min(s : BiostructdomainModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_model_max(s : BiostructdomainModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_model_to_string(s : BiostructdomainModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_layer_make(size : Int) -> BiostructdomainLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_layer_len(s : BiostructdomainLayer) -> Int { s.size }

pub fn bio_struct_domain_layer_get(s : BiostructdomainLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_layer_set(s : BiostructdomainLayer, i : Int, v : Double) -> BiostructdomainLayer {
  let result = bio_struct_domain_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_layer_sum(s : BiostructdomainLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_layer_mean(s : BiostructdomainLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_layer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_layer_scale(s : BiostructdomainLayer, f : Double) -> BiostructdomainLayer {
  let result = bio_struct_domain_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_layer_add(a : BiostructdomainLayer, b : BiostructdomainLayer) -> BiostructdomainLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_layer_copy(s : BiostructdomainLayer) -> BiostructdomainLayer {
  let result = bio_struct_domain_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_layer_fill(s : BiostructdomainLayer, v : Double) -> BiostructdomainLayer {
  let result = bio_struct_domain_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_layer_min(s : BiostructdomainLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_layer_max(s : BiostructdomainLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_layer_to_string(s : BiostructdomainLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_buffer_make(size : Int) -> BiostructdomainBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_buffer_len(s : BiostructdomainBuffer) -> Int { s.size }

pub fn bio_struct_domain_buffer_get(s : BiostructdomainBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_buffer_set(s : BiostructdomainBuffer, i : Int, v : Double) -> BiostructdomainBuffer {
  let result = bio_struct_domain_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_buffer_sum(s : BiostructdomainBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_buffer_mean(s : BiostructdomainBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_buffer_scale(s : BiostructdomainBuffer, f : Double) -> BiostructdomainBuffer {
  let result = bio_struct_domain_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_buffer_add(a : BiostructdomainBuffer, b : BiostructdomainBuffer) -> BiostructdomainBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_buffer_copy(s : BiostructdomainBuffer) -> BiostructdomainBuffer {
  let result = bio_struct_domain_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_buffer_fill(s : BiostructdomainBuffer, v : Double) -> BiostructdomainBuffer {
  let result = bio_struct_domain_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_buffer_min(s : BiostructdomainBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_buffer_max(s : BiostructdomainBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_buffer_to_string(s : BiostructdomainBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_cursor_make(size : Int) -> BiostructdomainCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_cursor_len(s : BiostructdomainCursor) -> Int { s.size }

pub fn bio_struct_domain_cursor_get(s : BiostructdomainCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_cursor_set(s : BiostructdomainCursor, i : Int, v : Double) -> BiostructdomainCursor {
  let result = bio_struct_domain_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_cursor_sum(s : BiostructdomainCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_cursor_mean(s : BiostructdomainCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_cursor_scale(s : BiostructdomainCursor, f : Double) -> BiostructdomainCursor {
  let result = bio_struct_domain_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_cursor_add(a : BiostructdomainCursor, b : BiostructdomainCursor) -> BiostructdomainCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_cursor_copy(s : BiostructdomainCursor) -> BiostructdomainCursor {
  let result = bio_struct_domain_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_cursor_fill(s : BiostructdomainCursor, v : Double) -> BiostructdomainCursor {
  let result = bio_struct_domain_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_cursor_min(s : BiostructdomainCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_cursor_max(s : BiostructdomainCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_cursor_to_string(s : BiostructdomainCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_view_make(size : Int) -> BiostructdomainView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_view_len(s : BiostructdomainView) -> Int { s.size }

pub fn bio_struct_domain_view_get(s : BiostructdomainView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_view_set(s : BiostructdomainView, i : Int, v : Double) -> BiostructdomainView {
  let result = bio_struct_domain_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_view_sum(s : BiostructdomainView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_view_mean(s : BiostructdomainView) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_view_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_view_scale(s : BiostructdomainView, f : Double) -> BiostructdomainView {
  let result = bio_struct_domain_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_view_add(a : BiostructdomainView, b : BiostructdomainView) -> BiostructdomainView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_view_copy(s : BiostructdomainView) -> BiostructdomainView {
  let result = bio_struct_domain_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_view_fill(s : BiostructdomainView, v : Double) -> BiostructdomainView {
  let result = bio_struct_domain_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_view_min(s : BiostructdomainView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_view_max(s : BiostructdomainView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_view_to_string(s : BiostructdomainView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_range_make(size : Int) -> BiostructdomainRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_range_len(s : BiostructdomainRange) -> Int { s.size }

pub fn bio_struct_domain_range_get(s : BiostructdomainRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_range_set(s : BiostructdomainRange, i : Int, v : Double) -> BiostructdomainRange {
  let result = bio_struct_domain_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_range_sum(s : BiostructdomainRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_range_mean(s : BiostructdomainRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_range_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_range_scale(s : BiostructdomainRange, f : Double) -> BiostructdomainRange {
  let result = bio_struct_domain_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_range_add(a : BiostructdomainRange, b : BiostructdomainRange) -> BiostructdomainRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_range_copy(s : BiostructdomainRange) -> BiostructdomainRange {
  let result = bio_struct_domain_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_range_fill(s : BiostructdomainRange, v : Double) -> BiostructdomainRange {
  let result = bio_struct_domain_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_range_min(s : BiostructdomainRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_range_max(s : BiostructdomainRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_range_to_string(s : BiostructdomainRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_slice_make(size : Int) -> BiostructdomainSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_slice_len(s : BiostructdomainSlice) -> Int { s.size }

pub fn bio_struct_domain_slice_get(s : BiostructdomainSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_slice_set(s : BiostructdomainSlice, i : Int, v : Double) -> BiostructdomainSlice {
  let result = bio_struct_domain_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_slice_sum(s : BiostructdomainSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_domain_slice_mean(s : BiostructdomainSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_domain_slice_sum(s) / s.size.to_double() }
}

pub fn bio_struct_domain_slice_scale(s : BiostructdomainSlice, f : Double) -> BiostructdomainSlice {
  let result = bio_struct_domain_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_domain_slice_add(a : BiostructdomainSlice, b : BiostructdomainSlice) -> BiostructdomainSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_domain_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_domain_slice_copy(s : BiostructdomainSlice) -> BiostructdomainSlice {
  let result = bio_struct_domain_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_domain_slice_fill(s : BiostructdomainSlice, v : Double) -> BiostructdomainSlice {
  let result = bio_struct_domain_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_domain_slice_min(s : BiostructdomainSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_slice_max(s : BiostructdomainSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_domain_slice_to_string(s : BiostructdomainSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


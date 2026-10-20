///===
/// extcore/bio_struct_contact

pub(all) struct BiostructcontactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_contact_make_point(x : Double, y : Double) -> BiostructcontactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_contact_make_point3(x : Double, y : Double, z : Double) -> BiostructcontactPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_contact_point_x(pt : BiostructcontactPoint) -> Double { pt.x }

pub fn bio_struct_contact_point_y(pt : BiostructcontactPoint) -> Double { pt.y }

pub fn bio_struct_contact_point_z(pt : BiostructcontactPoint) -> Double { pt.z }

pub fn bio_struct_contact_point_label(pt : BiostructcontactPoint) -> Int { pt.label }

pub fn bio_struct_contact_point_dist(a : BiostructcontactPoint, b : BiostructcontactPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_contact_point_add(a : BiostructcontactPoint, b : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_contact_point_sub(a : BiostructcontactPoint, b : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_contact_point_scale(pt : BiostructcontactPoint, s : Double) -> BiostructcontactPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_contact_point_dot(a : BiostructcontactPoint, b : BiostructcontactPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_contact_point_cross(a : BiostructcontactPoint, b : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_contact_point_norm(pt : BiostructcontactPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_contact_point_normalize(pt : BiostructcontactPoint) -> BiostructcontactPoint {
  let n = bio_struct_contact_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_contact_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_contact_point_negate(pt : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_contact_point_mid(a : BiostructcontactPoint, b : BiostructcontactPoint) -> BiostructcontactPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_contact_point_lerp(a : BiostructcontactPoint, b : BiostructcontactPoint, t : Double) -> BiostructcontactPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_contact_point_to_string(pt : BiostructcontactPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructcontactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_contact_make_series(vals : Array[Double], name : String) -> BiostructcontactSeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_contact_series_len(s : BiostructcontactSeries) -> Int { s.vals.length() }

pub fn bio_struct_contact_series_sum(s : BiostructcontactSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_struct_contact_series_mean(s : BiostructcontactSeries) -> Double { @_common.mean(s.vals) }

pub fn bio_struct_contact_series_min(s : BiostructcontactSeries) -> Double { @_common.min(s.vals) }

pub fn bio_struct_contact_series_max(s : BiostructcontactSeries) -> Double { @_common.max(s.vals) }

pub fn bio_struct_contact_series_range(s : BiostructcontactSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn bio_struct_contact_series_var(s : BiostructcontactSeries) -> Double { @_common.variance(s.vals) }

pub fn bio_struct_contact_series_std(s : BiostructcontactSeries) -> Double { @_common.std(s.vals) }

pub fn bio_struct_contact_series_median(s : BiostructcontactSeries) -> Double { @_common.median(s.vals) }

pub fn bio_struct_contact_series_scale(s : BiostructcontactSeries, f : Double) -> BiostructcontactSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_contact_series_add(a : BiostructcontactSeries, b : BiostructcontactSeries) -> BiostructcontactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_contact_series_sub(a : BiostructcontactSeries, b : BiostructcontactSeries) -> BiostructcontactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_contact_series_normalize(s : BiostructcontactSeries) -> BiostructcontactSeries {
  let mn = bio_struct_contact_series_min(s)
  let mx = bio_struct_contact_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_contact_series_cumsum(s : BiostructcontactSeries) -> BiostructcontactSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_contact_series_to_string(s : BiostructcontactSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructcontactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_contact_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructcontactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_contact_matrix_identity(n : Int) -> BiostructcontactMatrix {
  let m = bio_struct_contact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_contact_matrix_get(m : BiostructcontactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_contact_matrix_transpose(m : BiostructcontactMatrix) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_contact_matrix_add(a : BiostructcontactMatrix, b : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_contact_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_contact_matrix_scale(m : BiostructcontactMatrix, s : Double) -> BiostructcontactMatrix {
  let result = bio_struct_contact_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_contact_matrix_multiply(a : BiostructcontactMatrix, b : BiostructcontactMatrix) -> BiostructcontactMatrix {
  if a.cols != b.rows { return bio_struct_contact_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_contact_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_contact_matrix_trace(m : BiostructcontactMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_contact_matrix_det(m : BiostructcontactMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_contact_matrix_norm(m : BiostructcontactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_contact_matrix_to_string(m : BiostructcontactMatrix) -> String {
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

pub(all) struct BiostructcontactVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_contact_make_vector(comps : Array[Double]) -> BiostructcontactVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_contact_vector_zero(dim : Int) -> BiostructcontactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_contact_vector_add(a : BiostructcontactVector, b : BiostructcontactVector) -> BiostructcontactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_contact_vector_sub(a : BiostructcontactVector, b : BiostructcontactVector) -> BiostructcontactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_contact_vector_scale(v : BiostructcontactVector, s : Double) -> BiostructcontactVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_contact_vector_dot(a : BiostructcontactVector, b : BiostructcontactVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_contact_vector_norm(v : BiostructcontactVector) -> Double { @_common.sqrt(bio_struct_contact_vector_dot(v, v)) }

pub fn bio_struct_contact_vector_normalize(v : BiostructcontactVector) -> BiostructcontactVector {
  let n = bio_struct_contact_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_contact_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_contact_vector_dist(a : BiostructcontactVector, b : BiostructcontactVector) -> Double {
  bio_struct_contact_vector_norm(bio_struct_contact_vector_sub(a, b))
}

pub fn bio_struct_contact_vector_to_string(v : BiostructcontactVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_contact_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_contact_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_contact_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_contact_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_contact_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_contact_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_contact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_contact_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_contact_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_contact_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_contact_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_contact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_contact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_contact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_contact_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_contact_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_contact_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_contact_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_contact_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_contact_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_contact_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_contact_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_contact_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_contact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_contact_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_contact_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_contact_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_contact_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_contact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructcontactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_frame_make(size : Int) -> BiostructcontactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_frame_len(s : BiostructcontactFrame) -> Int { s.size }

pub fn bio_struct_contact_frame_get(s : BiostructcontactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_frame_set(s : BiostructcontactFrame, i : Int, v : Double) -> BiostructcontactFrame {
  let result = bio_struct_contact_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_frame_sum(s : BiostructcontactFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_frame_mean(s : BiostructcontactFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_frame_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_frame_scale(s : BiostructcontactFrame, f : Double) -> BiostructcontactFrame {
  let result = bio_struct_contact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_frame_add(a : BiostructcontactFrame, b : BiostructcontactFrame) -> BiostructcontactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_frame_copy(s : BiostructcontactFrame) -> BiostructcontactFrame {
  let result = bio_struct_contact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_frame_fill(s : BiostructcontactFrame, v : Double) -> BiostructcontactFrame {
  let result = bio_struct_contact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_frame_min(s : BiostructcontactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_frame_max(s : BiostructcontactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_frame_to_string(s : BiostructcontactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_table_make(size : Int) -> BiostructcontactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_table_len(s : BiostructcontactTable) -> Int { s.size }

pub fn bio_struct_contact_table_get(s : BiostructcontactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_table_set(s : BiostructcontactTable, i : Int, v : Double) -> BiostructcontactTable {
  let result = bio_struct_contact_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_table_sum(s : BiostructcontactTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_table_mean(s : BiostructcontactTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_table_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_table_scale(s : BiostructcontactTable, f : Double) -> BiostructcontactTable {
  let result = bio_struct_contact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_table_add(a : BiostructcontactTable, b : BiostructcontactTable) -> BiostructcontactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_table_copy(s : BiostructcontactTable) -> BiostructcontactTable {
  let result = bio_struct_contact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_table_fill(s : BiostructcontactTable, v : Double) -> BiostructcontactTable {
  let result = bio_struct_contact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_table_min(s : BiostructcontactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_table_max(s : BiostructcontactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_table_to_string(s : BiostructcontactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_graphn_make(size : Int) -> BiostructcontactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_graphn_len(s : BiostructcontactGraphN) -> Int { s.size }

pub fn bio_struct_contact_graphn_get(s : BiostructcontactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_graphn_set(s : BiostructcontactGraphN, i : Int, v : Double) -> BiostructcontactGraphN {
  let result = bio_struct_contact_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_graphn_sum(s : BiostructcontactGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_graphn_mean(s : BiostructcontactGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_graphn_scale(s : BiostructcontactGraphN, f : Double) -> BiostructcontactGraphN {
  let result = bio_struct_contact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_graphn_add(a : BiostructcontactGraphN, b : BiostructcontactGraphN) -> BiostructcontactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_graphn_copy(s : BiostructcontactGraphN) -> BiostructcontactGraphN {
  let result = bio_struct_contact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_graphn_fill(s : BiostructcontactGraphN, v : Double) -> BiostructcontactGraphN {
  let result = bio_struct_contact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_graphn_min(s : BiostructcontactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_graphn_max(s : BiostructcontactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_graphn_to_string(s : BiostructcontactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_node_make(size : Int) -> BiostructcontactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_node_len(s : BiostructcontactNode) -> Int { s.size }

pub fn bio_struct_contact_node_get(s : BiostructcontactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_node_set(s : BiostructcontactNode, i : Int, v : Double) -> BiostructcontactNode {
  let result = bio_struct_contact_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_node_sum(s : BiostructcontactNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_node_mean(s : BiostructcontactNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_node_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_node_scale(s : BiostructcontactNode, f : Double) -> BiostructcontactNode {
  let result = bio_struct_contact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_node_add(a : BiostructcontactNode, b : BiostructcontactNode) -> BiostructcontactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_node_copy(s : BiostructcontactNode) -> BiostructcontactNode {
  let result = bio_struct_contact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_node_fill(s : BiostructcontactNode, v : Double) -> BiostructcontactNode {
  let result = bio_struct_contact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_node_min(s : BiostructcontactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_node_max(s : BiostructcontactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_node_to_string(s : BiostructcontactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_edge_make(size : Int) -> BiostructcontactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_edge_len(s : BiostructcontactEdge) -> Int { s.size }

pub fn bio_struct_contact_edge_get(s : BiostructcontactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_edge_set(s : BiostructcontactEdge, i : Int, v : Double) -> BiostructcontactEdge {
  let result = bio_struct_contact_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_edge_sum(s : BiostructcontactEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_edge_mean(s : BiostructcontactEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_edge_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_edge_scale(s : BiostructcontactEdge, f : Double) -> BiostructcontactEdge {
  let result = bio_struct_contact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_edge_add(a : BiostructcontactEdge, b : BiostructcontactEdge) -> BiostructcontactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_edge_copy(s : BiostructcontactEdge) -> BiostructcontactEdge {
  let result = bio_struct_contact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_edge_fill(s : BiostructcontactEdge, v : Double) -> BiostructcontactEdge {
  let result = bio_struct_contact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_edge_min(s : BiostructcontactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_edge_max(s : BiostructcontactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_edge_to_string(s : BiostructcontactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_path_make(size : Int) -> BiostructcontactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_path_len(s : BiostructcontactPath) -> Int { s.size }

pub fn bio_struct_contact_path_get(s : BiostructcontactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_path_set(s : BiostructcontactPath, i : Int, v : Double) -> BiostructcontactPath {
  let result = bio_struct_contact_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_path_sum(s : BiostructcontactPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_path_mean(s : BiostructcontactPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_path_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_path_scale(s : BiostructcontactPath, f : Double) -> BiostructcontactPath {
  let result = bio_struct_contact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_path_add(a : BiostructcontactPath, b : BiostructcontactPath) -> BiostructcontactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_path_copy(s : BiostructcontactPath) -> BiostructcontactPath {
  let result = bio_struct_contact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_path_fill(s : BiostructcontactPath, v : Double) -> BiostructcontactPath {
  let result = bio_struct_contact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_path_min(s : BiostructcontactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_path_max(s : BiostructcontactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_path_to_string(s : BiostructcontactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cluster_make(size : Int) -> BiostructcontactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_cluster_len(s : BiostructcontactCluster) -> Int { s.size }

pub fn bio_struct_contact_cluster_get(s : BiostructcontactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_cluster_set(s : BiostructcontactCluster, i : Int, v : Double) -> BiostructcontactCluster {
  let result = bio_struct_contact_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_cluster_sum(s : BiostructcontactCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_cluster_mean(s : BiostructcontactCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_cluster_scale(s : BiostructcontactCluster, f : Double) -> BiostructcontactCluster {
  let result = bio_struct_contact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_cluster_add(a : BiostructcontactCluster, b : BiostructcontactCluster) -> BiostructcontactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_cluster_copy(s : BiostructcontactCluster) -> BiostructcontactCluster {
  let result = bio_struct_contact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_cluster_fill(s : BiostructcontactCluster, v : Double) -> BiostructcontactCluster {
  let result = bio_struct_contact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_cluster_min(s : BiostructcontactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_cluster_max(s : BiostructcontactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_cluster_to_string(s : BiostructcontactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_model_make(size : Int) -> BiostructcontactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_model_len(s : BiostructcontactModel) -> Int { s.size }

pub fn bio_struct_contact_model_get(s : BiostructcontactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_model_set(s : BiostructcontactModel, i : Int, v : Double) -> BiostructcontactModel {
  let result = bio_struct_contact_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_model_sum(s : BiostructcontactModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_model_mean(s : BiostructcontactModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_model_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_model_scale(s : BiostructcontactModel, f : Double) -> BiostructcontactModel {
  let result = bio_struct_contact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_model_add(a : BiostructcontactModel, b : BiostructcontactModel) -> BiostructcontactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_model_copy(s : BiostructcontactModel) -> BiostructcontactModel {
  let result = bio_struct_contact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_model_fill(s : BiostructcontactModel, v : Double) -> BiostructcontactModel {
  let result = bio_struct_contact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_model_min(s : BiostructcontactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_model_max(s : BiostructcontactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_model_to_string(s : BiostructcontactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_layer_make(size : Int) -> BiostructcontactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_layer_len(s : BiostructcontactLayer) -> Int { s.size }

pub fn bio_struct_contact_layer_get(s : BiostructcontactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_layer_set(s : BiostructcontactLayer, i : Int, v : Double) -> BiostructcontactLayer {
  let result = bio_struct_contact_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_layer_sum(s : BiostructcontactLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_layer_mean(s : BiostructcontactLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_layer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_layer_scale(s : BiostructcontactLayer, f : Double) -> BiostructcontactLayer {
  let result = bio_struct_contact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_layer_add(a : BiostructcontactLayer, b : BiostructcontactLayer) -> BiostructcontactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_layer_copy(s : BiostructcontactLayer) -> BiostructcontactLayer {
  let result = bio_struct_contact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_layer_fill(s : BiostructcontactLayer, v : Double) -> BiostructcontactLayer {
  let result = bio_struct_contact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_layer_min(s : BiostructcontactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_layer_max(s : BiostructcontactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_layer_to_string(s : BiostructcontactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_buffer_make(size : Int) -> BiostructcontactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_buffer_len(s : BiostructcontactBuffer) -> Int { s.size }

pub fn bio_struct_contact_buffer_get(s : BiostructcontactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_buffer_set(s : BiostructcontactBuffer, i : Int, v : Double) -> BiostructcontactBuffer {
  let result = bio_struct_contact_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_buffer_sum(s : BiostructcontactBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_buffer_mean(s : BiostructcontactBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_buffer_scale(s : BiostructcontactBuffer, f : Double) -> BiostructcontactBuffer {
  let result = bio_struct_contact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_buffer_add(a : BiostructcontactBuffer, b : BiostructcontactBuffer) -> BiostructcontactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_buffer_copy(s : BiostructcontactBuffer) -> BiostructcontactBuffer {
  let result = bio_struct_contact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_buffer_fill(s : BiostructcontactBuffer, v : Double) -> BiostructcontactBuffer {
  let result = bio_struct_contact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_buffer_min(s : BiostructcontactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_buffer_max(s : BiostructcontactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_buffer_to_string(s : BiostructcontactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_cursor_make(size : Int) -> BiostructcontactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_cursor_len(s : BiostructcontactCursor) -> Int { s.size }

pub fn bio_struct_contact_cursor_get(s : BiostructcontactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_cursor_set(s : BiostructcontactCursor, i : Int, v : Double) -> BiostructcontactCursor {
  let result = bio_struct_contact_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_cursor_sum(s : BiostructcontactCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_cursor_mean(s : BiostructcontactCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_cursor_scale(s : BiostructcontactCursor, f : Double) -> BiostructcontactCursor {
  let result = bio_struct_contact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_cursor_add(a : BiostructcontactCursor, b : BiostructcontactCursor) -> BiostructcontactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_cursor_copy(s : BiostructcontactCursor) -> BiostructcontactCursor {
  let result = bio_struct_contact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_cursor_fill(s : BiostructcontactCursor, v : Double) -> BiostructcontactCursor {
  let result = bio_struct_contact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_cursor_min(s : BiostructcontactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_cursor_max(s : BiostructcontactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_cursor_to_string(s : BiostructcontactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_view_make(size : Int) -> BiostructcontactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_view_len(s : BiostructcontactView) -> Int { s.size }

pub fn bio_struct_contact_view_get(s : BiostructcontactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_view_set(s : BiostructcontactView, i : Int, v : Double) -> BiostructcontactView {
  let result = bio_struct_contact_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_view_sum(s : BiostructcontactView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_view_mean(s : BiostructcontactView) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_view_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_view_scale(s : BiostructcontactView, f : Double) -> BiostructcontactView {
  let result = bio_struct_contact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_view_add(a : BiostructcontactView, b : BiostructcontactView) -> BiostructcontactView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_view_copy(s : BiostructcontactView) -> BiostructcontactView {
  let result = bio_struct_contact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_view_fill(s : BiostructcontactView, v : Double) -> BiostructcontactView {
  let result = bio_struct_contact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_view_min(s : BiostructcontactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_view_max(s : BiostructcontactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_view_to_string(s : BiostructcontactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_range_make(size : Int) -> BiostructcontactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_range_len(s : BiostructcontactRange) -> Int { s.size }

pub fn bio_struct_contact_range_get(s : BiostructcontactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_range_set(s : BiostructcontactRange, i : Int, v : Double) -> BiostructcontactRange {
  let result = bio_struct_contact_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_range_sum(s : BiostructcontactRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_range_mean(s : BiostructcontactRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_range_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_range_scale(s : BiostructcontactRange, f : Double) -> BiostructcontactRange {
  let result = bio_struct_contact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_range_add(a : BiostructcontactRange, b : BiostructcontactRange) -> BiostructcontactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_range_copy(s : BiostructcontactRange) -> BiostructcontactRange {
  let result = bio_struct_contact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_range_fill(s : BiostructcontactRange, v : Double) -> BiostructcontactRange {
  let result = bio_struct_contact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_range_min(s : BiostructcontactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_range_max(s : BiostructcontactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_range_to_string(s : BiostructcontactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructcontactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_contact_slice_make(size : Int) -> BiostructcontactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_contact_slice_len(s : BiostructcontactSlice) -> Int { s.size }

pub fn bio_struct_contact_slice_get(s : BiostructcontactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_contact_slice_set(s : BiostructcontactSlice, i : Int, v : Double) -> BiostructcontactSlice {
  let result = bio_struct_contact_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_slice_sum(s : BiostructcontactSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_contact_slice_mean(s : BiostructcontactSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_contact_slice_sum(s) / s.size.to_double() }
}

pub fn bio_struct_contact_slice_scale(s : BiostructcontactSlice, f : Double) -> BiostructcontactSlice {
  let result = bio_struct_contact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_contact_slice_add(a : BiostructcontactSlice, b : BiostructcontactSlice) -> BiostructcontactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_contact_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_contact_slice_copy(s : BiostructcontactSlice) -> BiostructcontactSlice {
  let result = bio_struct_contact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_contact_slice_fill(s : BiostructcontactSlice, v : Double) -> BiostructcontactSlice {
  let result = bio_struct_contact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_contact_slice_min(s : BiostructcontactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_slice_max(s : BiostructcontactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_contact_slice_to_string(s : BiostructcontactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


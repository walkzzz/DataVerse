///===
/// extcore/bio_struct_tertiary

pub(all) struct BiostructtertiaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_tertiary_make_point(x : Double, y : Double) -> BiostructtertiaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_tertiary_make_point3(x : Double, y : Double, z : Double) -> BiostructtertiaryPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_tertiary_point_x(pt : BiostructtertiaryPoint) -> Double { pt.x }

pub fn bio_struct_tertiary_point_y(pt : BiostructtertiaryPoint) -> Double { pt.y }

pub fn bio_struct_tertiary_point_z(pt : BiostructtertiaryPoint) -> Double { pt.z }

pub fn bio_struct_tertiary_point_label(pt : BiostructtertiaryPoint) -> Int { pt.label }

pub fn bio_struct_tertiary_point_dist(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_tertiary_point_add(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_tertiary_point_sub(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_tertiary_point_scale(pt : BiostructtertiaryPoint, s : Double) -> BiostructtertiaryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_tertiary_point_dot(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_tertiary_point_cross(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_tertiary_point_norm(pt : BiostructtertiaryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_tertiary_point_normalize(pt : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  let n = bio_struct_tertiary_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_tertiary_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_tertiary_point_negate(pt : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_tertiary_point_mid(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint) -> BiostructtertiaryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_tertiary_point_lerp(a : BiostructtertiaryPoint, b : BiostructtertiaryPoint, t : Double) -> BiostructtertiaryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_tertiary_point_to_string(pt : BiostructtertiaryPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructtertiarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_tertiary_make_series(vals : Array[Double], name : String) -> BiostructtertiarySeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_tertiary_series_len(s : BiostructtertiarySeries) -> Int { s.vals.length() }

pub fn bio_struct_tertiary_series_sum(s : BiostructtertiarySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_struct_tertiary_series_mean(s : BiostructtertiarySeries) -> Double {
  let n = bio_struct_tertiary_series_len(s)
  if n == 0 { 0.0 } else { bio_struct_tertiary_series_sum(s) / n.to_double() }
}

pub fn bio_struct_tertiary_series_min(s : BiostructtertiarySeries) -> Double {
  let n = bio_struct_tertiary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_tertiary_series_max(s : BiostructtertiarySeries) -> Double {
  let n = bio_struct_tertiary_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_tertiary_series_range(s : BiostructtertiarySeries) -> Double {
  bio_struct_tertiary_series_max(s) - bio_struct_tertiary_series_min(s)
}

pub fn bio_struct_tertiary_series_var(s : BiostructtertiarySeries) -> Double {
  let n = bio_struct_tertiary_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_struct_tertiary_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_struct_tertiary_series_std(s : BiostructtertiarySeries) -> Double { @_common.sqrt(bio_struct_tertiary_series_var(s)) }

pub fn bio_struct_tertiary_series_median(s : BiostructtertiarySeries) -> Double {
  let n = bio_struct_tertiary_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_struct_tertiary_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_struct_tertiary_series_scale(s : BiostructtertiarySeries, f : Double) -> BiostructtertiarySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_tertiary_series_add(a : BiostructtertiarySeries, b : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_tertiary_series_sub(a : BiostructtertiarySeries, b : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_tertiary_series_normalize(s : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let mn = bio_struct_tertiary_series_min(s)
  let mx = bio_struct_tertiary_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_tertiary_series_cumsum(s : BiostructtertiarySeries) -> BiostructtertiarySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_tertiary_series_to_string(s : BiostructtertiarySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructtertiaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_tertiary_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructtertiaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_tertiary_matrix_identity(n : Int) -> BiostructtertiaryMatrix {
  let m = bio_struct_tertiary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_tertiary_matrix_get(m : BiostructtertiaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_tertiary_matrix_transpose(m : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_tertiary_matrix_add(a : BiostructtertiaryMatrix, b : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_tertiary_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_tertiary_matrix_scale(m : BiostructtertiaryMatrix, s : Double) -> BiostructtertiaryMatrix {
  let result = bio_struct_tertiary_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_tertiary_matrix_multiply(a : BiostructtertiaryMatrix, b : BiostructtertiaryMatrix) -> BiostructtertiaryMatrix {
  if a.cols != b.rows { return bio_struct_tertiary_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_tertiary_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_tertiary_matrix_trace(m : BiostructtertiaryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_tertiary_matrix_det(m : BiostructtertiaryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_tertiary_matrix_norm(m : BiostructtertiaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_tertiary_matrix_to_string(m : BiostructtertiaryMatrix) -> String {
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

pub(all) struct BiostructtertiaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_tertiary_make_vector(comps : Array[Double]) -> BiostructtertiaryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_tertiary_vector_zero(dim : Int) -> BiostructtertiaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_tertiary_vector_add(a : BiostructtertiaryVector, b : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_tertiary_vector_sub(a : BiostructtertiaryVector, b : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_tertiary_vector_scale(v : BiostructtertiaryVector, s : Double) -> BiostructtertiaryVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_tertiary_vector_dot(a : BiostructtertiaryVector, b : BiostructtertiaryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_tertiary_vector_norm(v : BiostructtertiaryVector) -> Double { @_common.sqrt(bio_struct_tertiary_vector_dot(v, v)) }

pub fn bio_struct_tertiary_vector_normalize(v : BiostructtertiaryVector) -> BiostructtertiaryVector {
  let n = bio_struct_tertiary_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_tertiary_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_tertiary_vector_dist(a : BiostructtertiaryVector, b : BiostructtertiaryVector) -> Double {
  bio_struct_tertiary_vector_norm(bio_struct_tertiary_vector_sub(a, b))
}

pub fn bio_struct_tertiary_vector_to_string(v : BiostructtertiaryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_tertiary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_tertiary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_tertiary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_tertiary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_tertiary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_tertiary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_tertiary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_tertiary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_tertiary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_tertiary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_tertiary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_tertiary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_tertiary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_tertiary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_tertiary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_tertiary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_tertiary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_tertiary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_tertiary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_tertiary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_tertiary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_tertiary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_tertiary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_tertiary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_tertiary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_tertiary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_tertiary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_tertiary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_tertiary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructtertiaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_frame_make(size : Int) -> BiostructtertiaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_frame_len(s : BiostructtertiaryFrame) -> Int { s.size }

pub fn bio_struct_tertiary_frame_get(s : BiostructtertiaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_frame_set(s : BiostructtertiaryFrame, i : Int, v : Double) -> BiostructtertiaryFrame {
  let result = bio_struct_tertiary_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_frame_sum(s : BiostructtertiaryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_frame_mean(s : BiostructtertiaryFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_frame_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_frame_scale(s : BiostructtertiaryFrame, f : Double) -> BiostructtertiaryFrame {
  let result = bio_struct_tertiary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_frame_add(a : BiostructtertiaryFrame, b : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_frame_copy(s : BiostructtertiaryFrame) -> BiostructtertiaryFrame {
  let result = bio_struct_tertiary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_frame_fill(s : BiostructtertiaryFrame, v : Double) -> BiostructtertiaryFrame {
  let result = bio_struct_tertiary_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_frame_min(s : BiostructtertiaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_frame_max(s : BiostructtertiaryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_frame_to_string(s : BiostructtertiaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_table_make(size : Int) -> BiostructtertiaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_table_len(s : BiostructtertiaryTable) -> Int { s.size }

pub fn bio_struct_tertiary_table_get(s : BiostructtertiaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_table_set(s : BiostructtertiaryTable, i : Int, v : Double) -> BiostructtertiaryTable {
  let result = bio_struct_tertiary_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_table_sum(s : BiostructtertiaryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_table_mean(s : BiostructtertiaryTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_table_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_table_scale(s : BiostructtertiaryTable, f : Double) -> BiostructtertiaryTable {
  let result = bio_struct_tertiary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_table_add(a : BiostructtertiaryTable, b : BiostructtertiaryTable) -> BiostructtertiaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_table_copy(s : BiostructtertiaryTable) -> BiostructtertiaryTable {
  let result = bio_struct_tertiary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_table_fill(s : BiostructtertiaryTable, v : Double) -> BiostructtertiaryTable {
  let result = bio_struct_tertiary_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_table_min(s : BiostructtertiaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_table_max(s : BiostructtertiaryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_table_to_string(s : BiostructtertiaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_graphn_make(size : Int) -> BiostructtertiaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_graphn_len(s : BiostructtertiaryGraphN) -> Int { s.size }

pub fn bio_struct_tertiary_graphn_get(s : BiostructtertiaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_graphn_set(s : BiostructtertiaryGraphN, i : Int, v : Double) -> BiostructtertiaryGraphN {
  let result = bio_struct_tertiary_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_graphn_sum(s : BiostructtertiaryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_graphn_mean(s : BiostructtertiaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_graphn_scale(s : BiostructtertiaryGraphN, f : Double) -> BiostructtertiaryGraphN {
  let result = bio_struct_tertiary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_graphn_add(a : BiostructtertiaryGraphN, b : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_graphn_copy(s : BiostructtertiaryGraphN) -> BiostructtertiaryGraphN {
  let result = bio_struct_tertiary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_graphn_fill(s : BiostructtertiaryGraphN, v : Double) -> BiostructtertiaryGraphN {
  let result = bio_struct_tertiary_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_graphn_min(s : BiostructtertiaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_graphn_max(s : BiostructtertiaryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_graphn_to_string(s : BiostructtertiaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_node_make(size : Int) -> BiostructtertiaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_node_len(s : BiostructtertiaryNode) -> Int { s.size }

pub fn bio_struct_tertiary_node_get(s : BiostructtertiaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_node_set(s : BiostructtertiaryNode, i : Int, v : Double) -> BiostructtertiaryNode {
  let result = bio_struct_tertiary_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_node_sum(s : BiostructtertiaryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_node_mean(s : BiostructtertiaryNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_node_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_node_scale(s : BiostructtertiaryNode, f : Double) -> BiostructtertiaryNode {
  let result = bio_struct_tertiary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_node_add(a : BiostructtertiaryNode, b : BiostructtertiaryNode) -> BiostructtertiaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_node_copy(s : BiostructtertiaryNode) -> BiostructtertiaryNode {
  let result = bio_struct_tertiary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_node_fill(s : BiostructtertiaryNode, v : Double) -> BiostructtertiaryNode {
  let result = bio_struct_tertiary_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_node_min(s : BiostructtertiaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_node_max(s : BiostructtertiaryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_node_to_string(s : BiostructtertiaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_edge_make(size : Int) -> BiostructtertiaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_edge_len(s : BiostructtertiaryEdge) -> Int { s.size }

pub fn bio_struct_tertiary_edge_get(s : BiostructtertiaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_edge_set(s : BiostructtertiaryEdge, i : Int, v : Double) -> BiostructtertiaryEdge {
  let result = bio_struct_tertiary_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_edge_sum(s : BiostructtertiaryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_edge_mean(s : BiostructtertiaryEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_edge_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_edge_scale(s : BiostructtertiaryEdge, f : Double) -> BiostructtertiaryEdge {
  let result = bio_struct_tertiary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_edge_add(a : BiostructtertiaryEdge, b : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_edge_copy(s : BiostructtertiaryEdge) -> BiostructtertiaryEdge {
  let result = bio_struct_tertiary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_edge_fill(s : BiostructtertiaryEdge, v : Double) -> BiostructtertiaryEdge {
  let result = bio_struct_tertiary_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_edge_min(s : BiostructtertiaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_edge_max(s : BiostructtertiaryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_edge_to_string(s : BiostructtertiaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_path_make(size : Int) -> BiostructtertiaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_path_len(s : BiostructtertiaryPath) -> Int { s.size }

pub fn bio_struct_tertiary_path_get(s : BiostructtertiaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_path_set(s : BiostructtertiaryPath, i : Int, v : Double) -> BiostructtertiaryPath {
  let result = bio_struct_tertiary_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_path_sum(s : BiostructtertiaryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_path_mean(s : BiostructtertiaryPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_path_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_path_scale(s : BiostructtertiaryPath, f : Double) -> BiostructtertiaryPath {
  let result = bio_struct_tertiary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_path_add(a : BiostructtertiaryPath, b : BiostructtertiaryPath) -> BiostructtertiaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_path_copy(s : BiostructtertiaryPath) -> BiostructtertiaryPath {
  let result = bio_struct_tertiary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_path_fill(s : BiostructtertiaryPath, v : Double) -> BiostructtertiaryPath {
  let result = bio_struct_tertiary_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_path_min(s : BiostructtertiaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_path_max(s : BiostructtertiaryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_path_to_string(s : BiostructtertiaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cluster_make(size : Int) -> BiostructtertiaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_cluster_len(s : BiostructtertiaryCluster) -> Int { s.size }

pub fn bio_struct_tertiary_cluster_get(s : BiostructtertiaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_cluster_set(s : BiostructtertiaryCluster, i : Int, v : Double) -> BiostructtertiaryCluster {
  let result = bio_struct_tertiary_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_cluster_sum(s : BiostructtertiaryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_cluster_mean(s : BiostructtertiaryCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_cluster_scale(s : BiostructtertiaryCluster, f : Double) -> BiostructtertiaryCluster {
  let result = bio_struct_tertiary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_cluster_add(a : BiostructtertiaryCluster, b : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_cluster_copy(s : BiostructtertiaryCluster) -> BiostructtertiaryCluster {
  let result = bio_struct_tertiary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_cluster_fill(s : BiostructtertiaryCluster, v : Double) -> BiostructtertiaryCluster {
  let result = bio_struct_tertiary_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_cluster_min(s : BiostructtertiaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_cluster_max(s : BiostructtertiaryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_cluster_to_string(s : BiostructtertiaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_model_make(size : Int) -> BiostructtertiaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_model_len(s : BiostructtertiaryModel) -> Int { s.size }

pub fn bio_struct_tertiary_model_get(s : BiostructtertiaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_model_set(s : BiostructtertiaryModel, i : Int, v : Double) -> BiostructtertiaryModel {
  let result = bio_struct_tertiary_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_model_sum(s : BiostructtertiaryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_model_mean(s : BiostructtertiaryModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_model_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_model_scale(s : BiostructtertiaryModel, f : Double) -> BiostructtertiaryModel {
  let result = bio_struct_tertiary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_model_add(a : BiostructtertiaryModel, b : BiostructtertiaryModel) -> BiostructtertiaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_model_copy(s : BiostructtertiaryModel) -> BiostructtertiaryModel {
  let result = bio_struct_tertiary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_model_fill(s : BiostructtertiaryModel, v : Double) -> BiostructtertiaryModel {
  let result = bio_struct_tertiary_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_model_min(s : BiostructtertiaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_model_max(s : BiostructtertiaryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_model_to_string(s : BiostructtertiaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_layer_make(size : Int) -> BiostructtertiaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_layer_len(s : BiostructtertiaryLayer) -> Int { s.size }

pub fn bio_struct_tertiary_layer_get(s : BiostructtertiaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_layer_set(s : BiostructtertiaryLayer, i : Int, v : Double) -> BiostructtertiaryLayer {
  let result = bio_struct_tertiary_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_layer_sum(s : BiostructtertiaryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_layer_mean(s : BiostructtertiaryLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_layer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_layer_scale(s : BiostructtertiaryLayer, f : Double) -> BiostructtertiaryLayer {
  let result = bio_struct_tertiary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_layer_add(a : BiostructtertiaryLayer, b : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_layer_copy(s : BiostructtertiaryLayer) -> BiostructtertiaryLayer {
  let result = bio_struct_tertiary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_layer_fill(s : BiostructtertiaryLayer, v : Double) -> BiostructtertiaryLayer {
  let result = bio_struct_tertiary_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_layer_min(s : BiostructtertiaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_layer_max(s : BiostructtertiaryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_layer_to_string(s : BiostructtertiaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_buffer_make(size : Int) -> BiostructtertiaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_buffer_len(s : BiostructtertiaryBuffer) -> Int { s.size }

pub fn bio_struct_tertiary_buffer_get(s : BiostructtertiaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_buffer_set(s : BiostructtertiaryBuffer, i : Int, v : Double) -> BiostructtertiaryBuffer {
  let result = bio_struct_tertiary_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_buffer_sum(s : BiostructtertiaryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_buffer_mean(s : BiostructtertiaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_buffer_scale(s : BiostructtertiaryBuffer, f : Double) -> BiostructtertiaryBuffer {
  let result = bio_struct_tertiary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_buffer_add(a : BiostructtertiaryBuffer, b : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_buffer_copy(s : BiostructtertiaryBuffer) -> BiostructtertiaryBuffer {
  let result = bio_struct_tertiary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_buffer_fill(s : BiostructtertiaryBuffer, v : Double) -> BiostructtertiaryBuffer {
  let result = bio_struct_tertiary_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_buffer_min(s : BiostructtertiaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_buffer_max(s : BiostructtertiaryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_buffer_to_string(s : BiostructtertiaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_cursor_make(size : Int) -> BiostructtertiaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_cursor_len(s : BiostructtertiaryCursor) -> Int { s.size }

pub fn bio_struct_tertiary_cursor_get(s : BiostructtertiaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_cursor_set(s : BiostructtertiaryCursor, i : Int, v : Double) -> BiostructtertiaryCursor {
  let result = bio_struct_tertiary_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_cursor_sum(s : BiostructtertiaryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_cursor_mean(s : BiostructtertiaryCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_cursor_scale(s : BiostructtertiaryCursor, f : Double) -> BiostructtertiaryCursor {
  let result = bio_struct_tertiary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_cursor_add(a : BiostructtertiaryCursor, b : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_cursor_copy(s : BiostructtertiaryCursor) -> BiostructtertiaryCursor {
  let result = bio_struct_tertiary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_cursor_fill(s : BiostructtertiaryCursor, v : Double) -> BiostructtertiaryCursor {
  let result = bio_struct_tertiary_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_cursor_min(s : BiostructtertiaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_cursor_max(s : BiostructtertiaryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_cursor_to_string(s : BiostructtertiaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_view_make(size : Int) -> BiostructtertiaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_view_len(s : BiostructtertiaryView) -> Int { s.size }

pub fn bio_struct_tertiary_view_get(s : BiostructtertiaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_view_set(s : BiostructtertiaryView, i : Int, v : Double) -> BiostructtertiaryView {
  let result = bio_struct_tertiary_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_view_sum(s : BiostructtertiaryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_view_mean(s : BiostructtertiaryView) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_view_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_view_scale(s : BiostructtertiaryView, f : Double) -> BiostructtertiaryView {
  let result = bio_struct_tertiary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_view_add(a : BiostructtertiaryView, b : BiostructtertiaryView) -> BiostructtertiaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_view_copy(s : BiostructtertiaryView) -> BiostructtertiaryView {
  let result = bio_struct_tertiary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_view_fill(s : BiostructtertiaryView, v : Double) -> BiostructtertiaryView {
  let result = bio_struct_tertiary_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_view_min(s : BiostructtertiaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_view_max(s : BiostructtertiaryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_view_to_string(s : BiostructtertiaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_range_make(size : Int) -> BiostructtertiaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_range_len(s : BiostructtertiaryRange) -> Int { s.size }

pub fn bio_struct_tertiary_range_get(s : BiostructtertiaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_range_set(s : BiostructtertiaryRange, i : Int, v : Double) -> BiostructtertiaryRange {
  let result = bio_struct_tertiary_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_range_sum(s : BiostructtertiaryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_range_mean(s : BiostructtertiaryRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_range_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_range_scale(s : BiostructtertiaryRange, f : Double) -> BiostructtertiaryRange {
  let result = bio_struct_tertiary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_range_add(a : BiostructtertiaryRange, b : BiostructtertiaryRange) -> BiostructtertiaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_range_copy(s : BiostructtertiaryRange) -> BiostructtertiaryRange {
  let result = bio_struct_tertiary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_range_fill(s : BiostructtertiaryRange, v : Double) -> BiostructtertiaryRange {
  let result = bio_struct_tertiary_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_range_min(s : BiostructtertiaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_range_max(s : BiostructtertiaryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_range_to_string(s : BiostructtertiaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructtertiarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_tertiary_slice_make(size : Int) -> BiostructtertiarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_tertiary_slice_len(s : BiostructtertiarySlice) -> Int { s.size }

pub fn bio_struct_tertiary_slice_get(s : BiostructtertiarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_tertiary_slice_set(s : BiostructtertiarySlice, i : Int, v : Double) -> BiostructtertiarySlice {
  let result = bio_struct_tertiary_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_slice_sum(s : BiostructtertiarySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_tertiary_slice_mean(s : BiostructtertiarySlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_tertiary_slice_sum(s) / s.size.to_double() }
}

pub fn bio_struct_tertiary_slice_scale(s : BiostructtertiarySlice, f : Double) -> BiostructtertiarySlice {
  let result = bio_struct_tertiary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_tertiary_slice_add(a : BiostructtertiarySlice, b : BiostructtertiarySlice) -> BiostructtertiarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_tertiary_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_tertiary_slice_copy(s : BiostructtertiarySlice) -> BiostructtertiarySlice {
  let result = bio_struct_tertiary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_tertiary_slice_fill(s : BiostructtertiarySlice, v : Double) -> BiostructtertiarySlice {
  let result = bio_struct_tertiary_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_tertiary_slice_min(s : BiostructtertiarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_slice_max(s : BiostructtertiarySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_tertiary_slice_to_string(s : BiostructtertiarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


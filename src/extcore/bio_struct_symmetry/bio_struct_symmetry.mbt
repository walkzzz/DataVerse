///===
/// extcore/bio_struct_symmetry

pub(all) struct BiostructsymmetryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_symmetry_make_point(x : Double, y : Double) -> BiostructsymmetryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_symmetry_make_point3(x : Double, y : Double, z : Double) -> BiostructsymmetryPoint {
  { x, y, z, label: 0 }
}

pub fn bio_struct_symmetry_point_x(pt : BiostructsymmetryPoint) -> Double { pt.x }

pub fn bio_struct_symmetry_point_y(pt : BiostructsymmetryPoint) -> Double { pt.y }

pub fn bio_struct_symmetry_point_z(pt : BiostructsymmetryPoint) -> Double { pt.z }

pub fn bio_struct_symmetry_point_label(pt : BiostructsymmetryPoint) -> Int { pt.label }

pub fn bio_struct_symmetry_point_dist(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_struct_symmetry_point_add(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_struct_symmetry_point_sub(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_struct_symmetry_point_scale(pt : BiostructsymmetryPoint, s : Double) -> BiostructsymmetryPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_struct_symmetry_point_dot(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_struct_symmetry_point_cross(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_struct_symmetry_point_norm(pt : BiostructsymmetryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_struct_symmetry_point_normalize(pt : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  let n = bio_struct_symmetry_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_struct_symmetry_point_scale(pt, 1.0 / n) }
}

pub fn bio_struct_symmetry_point_negate(pt : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_struct_symmetry_point_mid(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint) -> BiostructsymmetryPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_struct_symmetry_point_lerp(a : BiostructsymmetryPoint, b : BiostructsymmetryPoint, t : Double) -> BiostructsymmetryPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_struct_symmetry_point_to_string(pt : BiostructsymmetryPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiostructsymmetrySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_symmetry_make_series(vals : Array[Double], name : String) -> BiostructsymmetrySeries {
  { vals, name, meta: 0 }
}

pub fn bio_struct_symmetry_series_len(s : BiostructsymmetrySeries) -> Int { s.vals.length() }

pub fn bio_struct_symmetry_series_sum(s : BiostructsymmetrySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_struct_symmetry_series_mean(s : BiostructsymmetrySeries) -> Double {
  let n = bio_struct_symmetry_series_len(s)
  if n == 0 { 0.0 } else { bio_struct_symmetry_series_sum(s) / n.to_double() }
}

pub fn bio_struct_symmetry_series_min(s : BiostructsymmetrySeries) -> Double {
  let n = bio_struct_symmetry_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_symmetry_series_max(s : BiostructsymmetrySeries) -> Double {
  let n = bio_struct_symmetry_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_struct_symmetry_series_range(s : BiostructsymmetrySeries) -> Double {
  bio_struct_symmetry_series_max(s) - bio_struct_symmetry_series_min(s)
}

pub fn bio_struct_symmetry_series_var(s : BiostructsymmetrySeries) -> Double {
  let n = bio_struct_symmetry_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_struct_symmetry_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_struct_symmetry_series_std(s : BiostructsymmetrySeries) -> Double { @_common.sqrt(bio_struct_symmetry_series_var(s)) }

pub fn bio_struct_symmetry_series_median(s : BiostructsymmetrySeries) -> Double {
  let n = bio_struct_symmetry_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_struct_symmetry_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_struct_symmetry_series_scale(s : BiostructsymmetrySeries, f : Double) -> BiostructsymmetrySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_struct_symmetry_series_add(a : BiostructsymmetrySeries, b : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_struct_symmetry_series_sub(a : BiostructsymmetrySeries, b : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_struct_symmetry_series_normalize(s : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  let mn = bio_struct_symmetry_series_min(s)
  let mx = bio_struct_symmetry_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_struct_symmetry_series_cumsum(s : BiostructsymmetrySeries) -> BiostructsymmetrySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_struct_symmetry_series_to_string(s : BiostructsymmetrySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructsymmetryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_symmetry_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructsymmetryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_symmetry_matrix_identity(n : Int) -> BiostructsymmetryMatrix {
  let m = bio_struct_symmetry_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_struct_symmetry_matrix_get(m : BiostructsymmetryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_struct_symmetry_matrix_transpose(m : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  let result = bio_struct_symmetry_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_struct_symmetry_matrix_add(a : BiostructsymmetryMatrix, b : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_struct_symmetry_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_struct_symmetry_matrix_scale(m : BiostructsymmetryMatrix, s : Double) -> BiostructsymmetryMatrix {
  let result = bio_struct_symmetry_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_struct_symmetry_matrix_multiply(a : BiostructsymmetryMatrix, b : BiostructsymmetryMatrix) -> BiostructsymmetryMatrix {
  if a.cols != b.rows { return bio_struct_symmetry_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_struct_symmetry_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_struct_symmetry_matrix_trace(m : BiostructsymmetryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_struct_symmetry_matrix_det(m : BiostructsymmetryMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_struct_symmetry_matrix_norm(m : BiostructsymmetryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_struct_symmetry_matrix_to_string(m : BiostructsymmetryMatrix) -> String {
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

pub(all) struct BiostructsymmetryVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_symmetry_make_vector(comps : Array[Double]) -> BiostructsymmetryVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_symmetry_vector_zero(dim : Int) -> BiostructsymmetryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_struct_symmetry_vector_add(a : BiostructsymmetryVector, b : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_symmetry_vector_sub(a : BiostructsymmetryVector, b : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_struct_symmetry_vector_scale(v : BiostructsymmetryVector, s : Double) -> BiostructsymmetryVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_struct_symmetry_vector_dot(a : BiostructsymmetryVector, b : BiostructsymmetryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_struct_symmetry_vector_norm(v : BiostructsymmetryVector) -> Double { @_common.sqrt(bio_struct_symmetry_vector_dot(v, v)) }

pub fn bio_struct_symmetry_vector_normalize(v : BiostructsymmetryVector) -> BiostructsymmetryVector {
  let n = bio_struct_symmetry_vector_norm(v)
  if n < 0.0000001 { v } else { bio_struct_symmetry_vector_scale(v, 1.0 / n) }
}

pub fn bio_struct_symmetry_vector_dist(a : BiostructsymmetryVector, b : BiostructsymmetryVector) -> Double {
  bio_struct_symmetry_vector_norm(bio_struct_symmetry_vector_sub(a, b))
}

pub fn bio_struct_symmetry_vector_to_string(v : BiostructsymmetryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_symmetry_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_symmetry_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_symmetry_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_symmetry_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_symmetry_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_symmetry_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_symmetry_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_symmetry_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_symmetry_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_symmetry_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_symmetry_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_symmetry_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_symmetry_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_symmetry_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_symmetry_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_symmetry_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_symmetry_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_symmetry_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_symmetry_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_symmetry_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_symmetry_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_symmetry_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_symmetry_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_symmetry_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_symmetry_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_symmetry_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_symmetry_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_symmetry_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_symmetry_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructsymmetryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_frame_make(size : Int) -> BiostructsymmetryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_frame_len(s : BiostructsymmetryFrame) -> Int { s.size }

pub fn bio_struct_symmetry_frame_get(s : BiostructsymmetryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_frame_set(s : BiostructsymmetryFrame, i : Int, v : Double) -> BiostructsymmetryFrame {
  let result = bio_struct_symmetry_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_frame_sum(s : BiostructsymmetryFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_frame_mean(s : BiostructsymmetryFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_frame_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_frame_scale(s : BiostructsymmetryFrame, f : Double) -> BiostructsymmetryFrame {
  let result = bio_struct_symmetry_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_frame_add(a : BiostructsymmetryFrame, b : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_frame_copy(s : BiostructsymmetryFrame) -> BiostructsymmetryFrame {
  let result = bio_struct_symmetry_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_frame_fill(s : BiostructsymmetryFrame, v : Double) -> BiostructsymmetryFrame {
  let result = bio_struct_symmetry_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_frame_min(s : BiostructsymmetryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_frame_max(s : BiostructsymmetryFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_frame_to_string(s : BiostructsymmetryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_table_make(size : Int) -> BiostructsymmetryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_table_len(s : BiostructsymmetryTable) -> Int { s.size }

pub fn bio_struct_symmetry_table_get(s : BiostructsymmetryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_table_set(s : BiostructsymmetryTable, i : Int, v : Double) -> BiostructsymmetryTable {
  let result = bio_struct_symmetry_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_table_sum(s : BiostructsymmetryTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_table_mean(s : BiostructsymmetryTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_table_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_table_scale(s : BiostructsymmetryTable, f : Double) -> BiostructsymmetryTable {
  let result = bio_struct_symmetry_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_table_add(a : BiostructsymmetryTable, b : BiostructsymmetryTable) -> BiostructsymmetryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_table_copy(s : BiostructsymmetryTable) -> BiostructsymmetryTable {
  let result = bio_struct_symmetry_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_table_fill(s : BiostructsymmetryTable, v : Double) -> BiostructsymmetryTable {
  let result = bio_struct_symmetry_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_table_min(s : BiostructsymmetryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_table_max(s : BiostructsymmetryTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_table_to_string(s : BiostructsymmetryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_graphn_make(size : Int) -> BiostructsymmetryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_graphn_len(s : BiostructsymmetryGraphN) -> Int { s.size }

pub fn bio_struct_symmetry_graphn_get(s : BiostructsymmetryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_graphn_set(s : BiostructsymmetryGraphN, i : Int, v : Double) -> BiostructsymmetryGraphN {
  let result = bio_struct_symmetry_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_graphn_sum(s : BiostructsymmetryGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_graphn_mean(s : BiostructsymmetryGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_graphn_scale(s : BiostructsymmetryGraphN, f : Double) -> BiostructsymmetryGraphN {
  let result = bio_struct_symmetry_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_graphn_add(a : BiostructsymmetryGraphN, b : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_graphn_copy(s : BiostructsymmetryGraphN) -> BiostructsymmetryGraphN {
  let result = bio_struct_symmetry_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_graphn_fill(s : BiostructsymmetryGraphN, v : Double) -> BiostructsymmetryGraphN {
  let result = bio_struct_symmetry_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_graphn_min(s : BiostructsymmetryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_graphn_max(s : BiostructsymmetryGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_graphn_to_string(s : BiostructsymmetryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_node_make(size : Int) -> BiostructsymmetryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_node_len(s : BiostructsymmetryNode) -> Int { s.size }

pub fn bio_struct_symmetry_node_get(s : BiostructsymmetryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_node_set(s : BiostructsymmetryNode, i : Int, v : Double) -> BiostructsymmetryNode {
  let result = bio_struct_symmetry_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_node_sum(s : BiostructsymmetryNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_node_mean(s : BiostructsymmetryNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_node_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_node_scale(s : BiostructsymmetryNode, f : Double) -> BiostructsymmetryNode {
  let result = bio_struct_symmetry_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_node_add(a : BiostructsymmetryNode, b : BiostructsymmetryNode) -> BiostructsymmetryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_node_copy(s : BiostructsymmetryNode) -> BiostructsymmetryNode {
  let result = bio_struct_symmetry_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_node_fill(s : BiostructsymmetryNode, v : Double) -> BiostructsymmetryNode {
  let result = bio_struct_symmetry_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_node_min(s : BiostructsymmetryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_node_max(s : BiostructsymmetryNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_node_to_string(s : BiostructsymmetryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_edge_make(size : Int) -> BiostructsymmetryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_edge_len(s : BiostructsymmetryEdge) -> Int { s.size }

pub fn bio_struct_symmetry_edge_get(s : BiostructsymmetryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_edge_set(s : BiostructsymmetryEdge, i : Int, v : Double) -> BiostructsymmetryEdge {
  let result = bio_struct_symmetry_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_edge_sum(s : BiostructsymmetryEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_edge_mean(s : BiostructsymmetryEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_edge_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_edge_scale(s : BiostructsymmetryEdge, f : Double) -> BiostructsymmetryEdge {
  let result = bio_struct_symmetry_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_edge_add(a : BiostructsymmetryEdge, b : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_edge_copy(s : BiostructsymmetryEdge) -> BiostructsymmetryEdge {
  let result = bio_struct_symmetry_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_edge_fill(s : BiostructsymmetryEdge, v : Double) -> BiostructsymmetryEdge {
  let result = bio_struct_symmetry_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_edge_min(s : BiostructsymmetryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_edge_max(s : BiostructsymmetryEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_edge_to_string(s : BiostructsymmetryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_path_make(size : Int) -> BiostructsymmetryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_path_len(s : BiostructsymmetryPath) -> Int { s.size }

pub fn bio_struct_symmetry_path_get(s : BiostructsymmetryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_path_set(s : BiostructsymmetryPath, i : Int, v : Double) -> BiostructsymmetryPath {
  let result = bio_struct_symmetry_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_path_sum(s : BiostructsymmetryPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_path_mean(s : BiostructsymmetryPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_path_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_path_scale(s : BiostructsymmetryPath, f : Double) -> BiostructsymmetryPath {
  let result = bio_struct_symmetry_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_path_add(a : BiostructsymmetryPath, b : BiostructsymmetryPath) -> BiostructsymmetryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_path_copy(s : BiostructsymmetryPath) -> BiostructsymmetryPath {
  let result = bio_struct_symmetry_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_path_fill(s : BiostructsymmetryPath, v : Double) -> BiostructsymmetryPath {
  let result = bio_struct_symmetry_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_path_min(s : BiostructsymmetryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_path_max(s : BiostructsymmetryPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_path_to_string(s : BiostructsymmetryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cluster_make(size : Int) -> BiostructsymmetryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_cluster_len(s : BiostructsymmetryCluster) -> Int { s.size }

pub fn bio_struct_symmetry_cluster_get(s : BiostructsymmetryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_cluster_set(s : BiostructsymmetryCluster, i : Int, v : Double) -> BiostructsymmetryCluster {
  let result = bio_struct_symmetry_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_cluster_sum(s : BiostructsymmetryCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_cluster_mean(s : BiostructsymmetryCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_cluster_scale(s : BiostructsymmetryCluster, f : Double) -> BiostructsymmetryCluster {
  let result = bio_struct_symmetry_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_cluster_add(a : BiostructsymmetryCluster, b : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_cluster_copy(s : BiostructsymmetryCluster) -> BiostructsymmetryCluster {
  let result = bio_struct_symmetry_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_cluster_fill(s : BiostructsymmetryCluster, v : Double) -> BiostructsymmetryCluster {
  let result = bio_struct_symmetry_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_cluster_min(s : BiostructsymmetryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_cluster_max(s : BiostructsymmetryCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_cluster_to_string(s : BiostructsymmetryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_model_make(size : Int) -> BiostructsymmetryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_model_len(s : BiostructsymmetryModel) -> Int { s.size }

pub fn bio_struct_symmetry_model_get(s : BiostructsymmetryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_model_set(s : BiostructsymmetryModel, i : Int, v : Double) -> BiostructsymmetryModel {
  let result = bio_struct_symmetry_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_model_sum(s : BiostructsymmetryModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_model_mean(s : BiostructsymmetryModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_model_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_model_scale(s : BiostructsymmetryModel, f : Double) -> BiostructsymmetryModel {
  let result = bio_struct_symmetry_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_model_add(a : BiostructsymmetryModel, b : BiostructsymmetryModel) -> BiostructsymmetryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_model_copy(s : BiostructsymmetryModel) -> BiostructsymmetryModel {
  let result = bio_struct_symmetry_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_model_fill(s : BiostructsymmetryModel, v : Double) -> BiostructsymmetryModel {
  let result = bio_struct_symmetry_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_model_min(s : BiostructsymmetryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_model_max(s : BiostructsymmetryModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_model_to_string(s : BiostructsymmetryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_layer_make(size : Int) -> BiostructsymmetryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_layer_len(s : BiostructsymmetryLayer) -> Int { s.size }

pub fn bio_struct_symmetry_layer_get(s : BiostructsymmetryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_layer_set(s : BiostructsymmetryLayer, i : Int, v : Double) -> BiostructsymmetryLayer {
  let result = bio_struct_symmetry_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_layer_sum(s : BiostructsymmetryLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_layer_mean(s : BiostructsymmetryLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_layer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_layer_scale(s : BiostructsymmetryLayer, f : Double) -> BiostructsymmetryLayer {
  let result = bio_struct_symmetry_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_layer_add(a : BiostructsymmetryLayer, b : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_layer_copy(s : BiostructsymmetryLayer) -> BiostructsymmetryLayer {
  let result = bio_struct_symmetry_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_layer_fill(s : BiostructsymmetryLayer, v : Double) -> BiostructsymmetryLayer {
  let result = bio_struct_symmetry_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_layer_min(s : BiostructsymmetryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_layer_max(s : BiostructsymmetryLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_layer_to_string(s : BiostructsymmetryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_buffer_make(size : Int) -> BiostructsymmetryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_buffer_len(s : BiostructsymmetryBuffer) -> Int { s.size }

pub fn bio_struct_symmetry_buffer_get(s : BiostructsymmetryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_buffer_set(s : BiostructsymmetryBuffer, i : Int, v : Double) -> BiostructsymmetryBuffer {
  let result = bio_struct_symmetry_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_buffer_sum(s : BiostructsymmetryBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_buffer_mean(s : BiostructsymmetryBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_buffer_scale(s : BiostructsymmetryBuffer, f : Double) -> BiostructsymmetryBuffer {
  let result = bio_struct_symmetry_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_buffer_add(a : BiostructsymmetryBuffer, b : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_buffer_copy(s : BiostructsymmetryBuffer) -> BiostructsymmetryBuffer {
  let result = bio_struct_symmetry_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_buffer_fill(s : BiostructsymmetryBuffer, v : Double) -> BiostructsymmetryBuffer {
  let result = bio_struct_symmetry_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_buffer_min(s : BiostructsymmetryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_buffer_max(s : BiostructsymmetryBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_buffer_to_string(s : BiostructsymmetryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_cursor_make(size : Int) -> BiostructsymmetryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_cursor_len(s : BiostructsymmetryCursor) -> Int { s.size }

pub fn bio_struct_symmetry_cursor_get(s : BiostructsymmetryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_cursor_set(s : BiostructsymmetryCursor, i : Int, v : Double) -> BiostructsymmetryCursor {
  let result = bio_struct_symmetry_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_cursor_sum(s : BiostructsymmetryCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_cursor_mean(s : BiostructsymmetryCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_cursor_scale(s : BiostructsymmetryCursor, f : Double) -> BiostructsymmetryCursor {
  let result = bio_struct_symmetry_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_cursor_add(a : BiostructsymmetryCursor, b : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_cursor_copy(s : BiostructsymmetryCursor) -> BiostructsymmetryCursor {
  let result = bio_struct_symmetry_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_cursor_fill(s : BiostructsymmetryCursor, v : Double) -> BiostructsymmetryCursor {
  let result = bio_struct_symmetry_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_cursor_min(s : BiostructsymmetryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_cursor_max(s : BiostructsymmetryCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_cursor_to_string(s : BiostructsymmetryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_view_make(size : Int) -> BiostructsymmetryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_view_len(s : BiostructsymmetryView) -> Int { s.size }

pub fn bio_struct_symmetry_view_get(s : BiostructsymmetryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_view_set(s : BiostructsymmetryView, i : Int, v : Double) -> BiostructsymmetryView {
  let result = bio_struct_symmetry_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_view_sum(s : BiostructsymmetryView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_view_mean(s : BiostructsymmetryView) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_view_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_view_scale(s : BiostructsymmetryView, f : Double) -> BiostructsymmetryView {
  let result = bio_struct_symmetry_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_view_add(a : BiostructsymmetryView, b : BiostructsymmetryView) -> BiostructsymmetryView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_view_copy(s : BiostructsymmetryView) -> BiostructsymmetryView {
  let result = bio_struct_symmetry_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_view_fill(s : BiostructsymmetryView, v : Double) -> BiostructsymmetryView {
  let result = bio_struct_symmetry_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_view_min(s : BiostructsymmetryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_view_max(s : BiostructsymmetryView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_view_to_string(s : BiostructsymmetryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_range_make(size : Int) -> BiostructsymmetryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_range_len(s : BiostructsymmetryRange) -> Int { s.size }

pub fn bio_struct_symmetry_range_get(s : BiostructsymmetryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_range_set(s : BiostructsymmetryRange, i : Int, v : Double) -> BiostructsymmetryRange {
  let result = bio_struct_symmetry_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_range_sum(s : BiostructsymmetryRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_range_mean(s : BiostructsymmetryRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_range_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_range_scale(s : BiostructsymmetryRange, f : Double) -> BiostructsymmetryRange {
  let result = bio_struct_symmetry_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_range_add(a : BiostructsymmetryRange, b : BiostructsymmetryRange) -> BiostructsymmetryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_range_copy(s : BiostructsymmetryRange) -> BiostructsymmetryRange {
  let result = bio_struct_symmetry_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_range_fill(s : BiostructsymmetryRange, v : Double) -> BiostructsymmetryRange {
  let result = bio_struct_symmetry_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_range_min(s : BiostructsymmetryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_range_max(s : BiostructsymmetryRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_range_to_string(s : BiostructsymmetryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructsymmetrySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_symmetry_slice_make(size : Int) -> BiostructsymmetrySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_symmetry_slice_len(s : BiostructsymmetrySlice) -> Int { s.size }

pub fn bio_struct_symmetry_slice_get(s : BiostructsymmetrySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_symmetry_slice_set(s : BiostructsymmetrySlice, i : Int, v : Double) -> BiostructsymmetrySlice {
  let result = bio_struct_symmetry_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_slice_sum(s : BiostructsymmetrySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_struct_symmetry_slice_mean(s : BiostructsymmetrySlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_struct_symmetry_slice_sum(s) / s.size.to_double() }
}

pub fn bio_struct_symmetry_slice_scale(s : BiostructsymmetrySlice, f : Double) -> BiostructsymmetrySlice {
  let result = bio_struct_symmetry_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_struct_symmetry_slice_add(a : BiostructsymmetrySlice, b : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_struct_symmetry_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_struct_symmetry_slice_copy(s : BiostructsymmetrySlice) -> BiostructsymmetrySlice {
  let result = bio_struct_symmetry_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_struct_symmetry_slice_fill(s : BiostructsymmetrySlice, v : Double) -> BiostructsymmetrySlice {
  let result = bio_struct_symmetry_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_struct_symmetry_slice_min(s : BiostructsymmetrySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_slice_max(s : BiostructsymmetrySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_struct_symmetry_slice_to_string(s : BiostructsymmetrySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


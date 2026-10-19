///===
/// extcore/chem_desc_geometric

pub(all) struct ChemdescgeometricPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_geometric_make_point(x : Double, y : Double) -> ChemdescgeometricPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_geometric_make_point3(x : Double, y : Double, z : Double) -> ChemdescgeometricPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_geometric_point_x(pt : ChemdescgeometricPoint) -> Double { pt.x }

pub fn chem_desc_geometric_point_y(pt : ChemdescgeometricPoint) -> Double { pt.y }

pub fn chem_desc_geometric_point_z(pt : ChemdescgeometricPoint) -> Double { pt.z }

pub fn chem_desc_geometric_point_label(pt : ChemdescgeometricPoint) -> Int { pt.label }

pub fn chem_desc_geometric_point_dist(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_geometric_point_add(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_geometric_point_sub(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_geometric_point_scale(pt : ChemdescgeometricPoint, s : Double) -> ChemdescgeometricPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_geometric_point_dot(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_geometric_point_cross(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_geometric_point_norm(pt : ChemdescgeometricPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_geometric_point_normalize(pt : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  let n = chem_desc_geometric_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_geometric_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_geometric_point_negate(pt : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_geometric_point_mid(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint) -> ChemdescgeometricPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_geometric_point_lerp(a : ChemdescgeometricPoint, b : ChemdescgeometricPoint, t : Double) -> ChemdescgeometricPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_geometric_point_to_string(pt : ChemdescgeometricPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescgeometricSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_geometric_make_series(vals : Array[Double], name : String) -> ChemdescgeometricSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_geometric_series_len(s : ChemdescgeometricSeries) -> Int { s.vals.length() }

pub fn chem_desc_geometric_series_sum(s : ChemdescgeometricSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_geometric_series_mean(s : ChemdescgeometricSeries) -> Double {
  let n = chem_desc_geometric_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_geometric_series_sum(s) / n.to_double() }
}

pub fn chem_desc_geometric_series_min(s : ChemdescgeometricSeries) -> Double {
  let n = chem_desc_geometric_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_geometric_series_max(s : ChemdescgeometricSeries) -> Double {
  let n = chem_desc_geometric_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_geometric_series_range(s : ChemdescgeometricSeries) -> Double {
  chem_desc_geometric_series_max(s) - chem_desc_geometric_series_min(s)
}

pub fn chem_desc_geometric_series_var(s : ChemdescgeometricSeries) -> Double {
  let n = chem_desc_geometric_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_geometric_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_geometric_series_std(s : ChemdescgeometricSeries) -> Double { @_common.sqrt(chem_desc_geometric_series_var(s)) }

pub fn chem_desc_geometric_series_median(s : ChemdescgeometricSeries) -> Double {
  let n = chem_desc_geometric_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_geometric_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_geometric_series_scale(s : ChemdescgeometricSeries, f : Double) -> ChemdescgeometricSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_geometric_series_add(a : ChemdescgeometricSeries, b : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_geometric_series_sub(a : ChemdescgeometricSeries, b : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_geometric_series_normalize(s : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let mn = chem_desc_geometric_series_min(s)
  let mx = chem_desc_geometric_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_geometric_series_cumsum(s : ChemdescgeometricSeries) -> ChemdescgeometricSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_geometric_series_to_string(s : ChemdescgeometricSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescgeometricMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_geometric_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescgeometricMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_geometric_matrix_identity(n : Int) -> ChemdescgeometricMatrix {
  let m = chem_desc_geometric_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_geometric_matrix_get(m : ChemdescgeometricMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_geometric_matrix_transpose(m : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_geometric_matrix_add(a : ChemdescgeometricMatrix, b : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_geometric_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_geometric_matrix_scale(m : ChemdescgeometricMatrix, s : Double) -> ChemdescgeometricMatrix {
  let result = chem_desc_geometric_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_geometric_matrix_multiply(a : ChemdescgeometricMatrix, b : ChemdescgeometricMatrix) -> ChemdescgeometricMatrix {
  if a.cols != b.rows { return chem_desc_geometric_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_geometric_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_geometric_matrix_trace(m : ChemdescgeometricMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_geometric_matrix_det(m : ChemdescgeometricMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_geometric_matrix_norm(m : ChemdescgeometricMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_geometric_matrix_to_string(m : ChemdescgeometricMatrix) -> String {
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

pub(all) struct ChemdescgeometricVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_geometric_make_vector(comps : Array[Double]) -> ChemdescgeometricVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_geometric_vector_zero(dim : Int) -> ChemdescgeometricVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_geometric_vector_add(a : ChemdescgeometricVector, b : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_geometric_vector_sub(a : ChemdescgeometricVector, b : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_geometric_vector_scale(v : ChemdescgeometricVector, s : Double) -> ChemdescgeometricVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_geometric_vector_dot(a : ChemdescgeometricVector, b : ChemdescgeometricVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_geometric_vector_norm(v : ChemdescgeometricVector) -> Double { @_common.sqrt(chem_desc_geometric_vector_dot(v, v)) }

pub fn chem_desc_geometric_vector_normalize(v : ChemdescgeometricVector) -> ChemdescgeometricVector {
  let n = chem_desc_geometric_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_geometric_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_geometric_vector_dist(a : ChemdescgeometricVector, b : ChemdescgeometricVector) -> Double {
  chem_desc_geometric_vector_norm(chem_desc_geometric_vector_sub(a, b))
}

pub fn chem_desc_geometric_vector_to_string(v : ChemdescgeometricVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_geometric_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_geometric_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_geometric_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_geometric_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_geometric_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_geometric_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_geometric_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_geometric_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_geometric_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_geometric_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_geometric_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_geometric_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_geometric_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_geometric_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_geometric_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_geometric_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_geometric_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_geometric_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_geometric_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_geometric_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_geometric_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_geometric_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_geometric_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_geometric_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_geometric_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_geometric_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_geometric_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_geometric_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_geometric_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescgeometricFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_frame_make(size : Int) -> ChemdescgeometricFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_frame_len(s : ChemdescgeometricFrame) -> Int { s.size }

pub fn chem_desc_geometric_frame_get(s : ChemdescgeometricFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_frame_set(s : ChemdescgeometricFrame, i : Int, v : Double) -> ChemdescgeometricFrame {
  let result = chem_desc_geometric_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_frame_sum(s : ChemdescgeometricFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_frame_mean(s : ChemdescgeometricFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_frame_scale(s : ChemdescgeometricFrame, f : Double) -> ChemdescgeometricFrame {
  let result = chem_desc_geometric_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_frame_add(a : ChemdescgeometricFrame, b : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_frame_copy(s : ChemdescgeometricFrame) -> ChemdescgeometricFrame {
  let result = chem_desc_geometric_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_frame_fill(s : ChemdescgeometricFrame, v : Double) -> ChemdescgeometricFrame {
  let result = chem_desc_geometric_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_frame_min(s : ChemdescgeometricFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_frame_max(s : ChemdescgeometricFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_frame_to_string(s : ChemdescgeometricFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_table_make(size : Int) -> ChemdescgeometricTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_table_len(s : ChemdescgeometricTable) -> Int { s.size }

pub fn chem_desc_geometric_table_get(s : ChemdescgeometricTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_table_set(s : ChemdescgeometricTable, i : Int, v : Double) -> ChemdescgeometricTable {
  let result = chem_desc_geometric_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_table_sum(s : ChemdescgeometricTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_table_mean(s : ChemdescgeometricTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_table_scale(s : ChemdescgeometricTable, f : Double) -> ChemdescgeometricTable {
  let result = chem_desc_geometric_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_table_add(a : ChemdescgeometricTable, b : ChemdescgeometricTable) -> ChemdescgeometricTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_table_copy(s : ChemdescgeometricTable) -> ChemdescgeometricTable {
  let result = chem_desc_geometric_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_table_fill(s : ChemdescgeometricTable, v : Double) -> ChemdescgeometricTable {
  let result = chem_desc_geometric_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_table_min(s : ChemdescgeometricTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_table_max(s : ChemdescgeometricTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_table_to_string(s : ChemdescgeometricTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_graphn_make(size : Int) -> ChemdescgeometricGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_graphn_len(s : ChemdescgeometricGraphN) -> Int { s.size }

pub fn chem_desc_geometric_graphn_get(s : ChemdescgeometricGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_graphn_set(s : ChemdescgeometricGraphN, i : Int, v : Double) -> ChemdescgeometricGraphN {
  let result = chem_desc_geometric_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_graphn_sum(s : ChemdescgeometricGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_graphn_mean(s : ChemdescgeometricGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_graphn_scale(s : ChemdescgeometricGraphN, f : Double) -> ChemdescgeometricGraphN {
  let result = chem_desc_geometric_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_graphn_add(a : ChemdescgeometricGraphN, b : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_graphn_copy(s : ChemdescgeometricGraphN) -> ChemdescgeometricGraphN {
  let result = chem_desc_geometric_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_graphn_fill(s : ChemdescgeometricGraphN, v : Double) -> ChemdescgeometricGraphN {
  let result = chem_desc_geometric_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_graphn_min(s : ChemdescgeometricGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_graphn_max(s : ChemdescgeometricGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_graphn_to_string(s : ChemdescgeometricGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_node_make(size : Int) -> ChemdescgeometricNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_node_len(s : ChemdescgeometricNode) -> Int { s.size }

pub fn chem_desc_geometric_node_get(s : ChemdescgeometricNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_node_set(s : ChemdescgeometricNode, i : Int, v : Double) -> ChemdescgeometricNode {
  let result = chem_desc_geometric_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_node_sum(s : ChemdescgeometricNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_node_mean(s : ChemdescgeometricNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_node_scale(s : ChemdescgeometricNode, f : Double) -> ChemdescgeometricNode {
  let result = chem_desc_geometric_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_node_add(a : ChemdescgeometricNode, b : ChemdescgeometricNode) -> ChemdescgeometricNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_node_copy(s : ChemdescgeometricNode) -> ChemdescgeometricNode {
  let result = chem_desc_geometric_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_node_fill(s : ChemdescgeometricNode, v : Double) -> ChemdescgeometricNode {
  let result = chem_desc_geometric_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_node_min(s : ChemdescgeometricNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_node_max(s : ChemdescgeometricNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_node_to_string(s : ChemdescgeometricNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_edge_make(size : Int) -> ChemdescgeometricEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_edge_len(s : ChemdescgeometricEdge) -> Int { s.size }

pub fn chem_desc_geometric_edge_get(s : ChemdescgeometricEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_edge_set(s : ChemdescgeometricEdge, i : Int, v : Double) -> ChemdescgeometricEdge {
  let result = chem_desc_geometric_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_edge_sum(s : ChemdescgeometricEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_edge_mean(s : ChemdescgeometricEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_edge_scale(s : ChemdescgeometricEdge, f : Double) -> ChemdescgeometricEdge {
  let result = chem_desc_geometric_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_edge_add(a : ChemdescgeometricEdge, b : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_edge_copy(s : ChemdescgeometricEdge) -> ChemdescgeometricEdge {
  let result = chem_desc_geometric_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_edge_fill(s : ChemdescgeometricEdge, v : Double) -> ChemdescgeometricEdge {
  let result = chem_desc_geometric_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_edge_min(s : ChemdescgeometricEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_edge_max(s : ChemdescgeometricEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_edge_to_string(s : ChemdescgeometricEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_path_make(size : Int) -> ChemdescgeometricPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_path_len(s : ChemdescgeometricPath) -> Int { s.size }

pub fn chem_desc_geometric_path_get(s : ChemdescgeometricPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_path_set(s : ChemdescgeometricPath, i : Int, v : Double) -> ChemdescgeometricPath {
  let result = chem_desc_geometric_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_path_sum(s : ChemdescgeometricPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_path_mean(s : ChemdescgeometricPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_path_scale(s : ChemdescgeometricPath, f : Double) -> ChemdescgeometricPath {
  let result = chem_desc_geometric_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_path_add(a : ChemdescgeometricPath, b : ChemdescgeometricPath) -> ChemdescgeometricPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_path_copy(s : ChemdescgeometricPath) -> ChemdescgeometricPath {
  let result = chem_desc_geometric_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_path_fill(s : ChemdescgeometricPath, v : Double) -> ChemdescgeometricPath {
  let result = chem_desc_geometric_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_path_min(s : ChemdescgeometricPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_path_max(s : ChemdescgeometricPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_path_to_string(s : ChemdescgeometricPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cluster_make(size : Int) -> ChemdescgeometricCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_cluster_len(s : ChemdescgeometricCluster) -> Int { s.size }

pub fn chem_desc_geometric_cluster_get(s : ChemdescgeometricCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_cluster_set(s : ChemdescgeometricCluster, i : Int, v : Double) -> ChemdescgeometricCluster {
  let result = chem_desc_geometric_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_cluster_sum(s : ChemdescgeometricCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_cluster_mean(s : ChemdescgeometricCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_cluster_scale(s : ChemdescgeometricCluster, f : Double) -> ChemdescgeometricCluster {
  let result = chem_desc_geometric_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_cluster_add(a : ChemdescgeometricCluster, b : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_cluster_copy(s : ChemdescgeometricCluster) -> ChemdescgeometricCluster {
  let result = chem_desc_geometric_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_cluster_fill(s : ChemdescgeometricCluster, v : Double) -> ChemdescgeometricCluster {
  let result = chem_desc_geometric_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_cluster_min(s : ChemdescgeometricCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_cluster_max(s : ChemdescgeometricCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_cluster_to_string(s : ChemdescgeometricCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_model_make(size : Int) -> ChemdescgeometricModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_model_len(s : ChemdescgeometricModel) -> Int { s.size }

pub fn chem_desc_geometric_model_get(s : ChemdescgeometricModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_model_set(s : ChemdescgeometricModel, i : Int, v : Double) -> ChemdescgeometricModel {
  let result = chem_desc_geometric_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_model_sum(s : ChemdescgeometricModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_model_mean(s : ChemdescgeometricModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_model_scale(s : ChemdescgeometricModel, f : Double) -> ChemdescgeometricModel {
  let result = chem_desc_geometric_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_model_add(a : ChemdescgeometricModel, b : ChemdescgeometricModel) -> ChemdescgeometricModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_model_copy(s : ChemdescgeometricModel) -> ChemdescgeometricModel {
  let result = chem_desc_geometric_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_model_fill(s : ChemdescgeometricModel, v : Double) -> ChemdescgeometricModel {
  let result = chem_desc_geometric_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_model_min(s : ChemdescgeometricModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_model_max(s : ChemdescgeometricModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_model_to_string(s : ChemdescgeometricModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_layer_make(size : Int) -> ChemdescgeometricLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_layer_len(s : ChemdescgeometricLayer) -> Int { s.size }

pub fn chem_desc_geometric_layer_get(s : ChemdescgeometricLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_layer_set(s : ChemdescgeometricLayer, i : Int, v : Double) -> ChemdescgeometricLayer {
  let result = chem_desc_geometric_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_layer_sum(s : ChemdescgeometricLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_layer_mean(s : ChemdescgeometricLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_layer_scale(s : ChemdescgeometricLayer, f : Double) -> ChemdescgeometricLayer {
  let result = chem_desc_geometric_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_layer_add(a : ChemdescgeometricLayer, b : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_layer_copy(s : ChemdescgeometricLayer) -> ChemdescgeometricLayer {
  let result = chem_desc_geometric_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_layer_fill(s : ChemdescgeometricLayer, v : Double) -> ChemdescgeometricLayer {
  let result = chem_desc_geometric_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_layer_min(s : ChemdescgeometricLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_layer_max(s : ChemdescgeometricLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_layer_to_string(s : ChemdescgeometricLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_buffer_make(size : Int) -> ChemdescgeometricBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_buffer_len(s : ChemdescgeometricBuffer) -> Int { s.size }

pub fn chem_desc_geometric_buffer_get(s : ChemdescgeometricBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_buffer_set(s : ChemdescgeometricBuffer, i : Int, v : Double) -> ChemdescgeometricBuffer {
  let result = chem_desc_geometric_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_buffer_sum(s : ChemdescgeometricBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_buffer_mean(s : ChemdescgeometricBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_buffer_scale(s : ChemdescgeometricBuffer, f : Double) -> ChemdescgeometricBuffer {
  let result = chem_desc_geometric_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_buffer_add(a : ChemdescgeometricBuffer, b : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_buffer_copy(s : ChemdescgeometricBuffer) -> ChemdescgeometricBuffer {
  let result = chem_desc_geometric_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_buffer_fill(s : ChemdescgeometricBuffer, v : Double) -> ChemdescgeometricBuffer {
  let result = chem_desc_geometric_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_buffer_min(s : ChemdescgeometricBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_buffer_max(s : ChemdescgeometricBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_buffer_to_string(s : ChemdescgeometricBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_cursor_make(size : Int) -> ChemdescgeometricCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_cursor_len(s : ChemdescgeometricCursor) -> Int { s.size }

pub fn chem_desc_geometric_cursor_get(s : ChemdescgeometricCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_cursor_set(s : ChemdescgeometricCursor, i : Int, v : Double) -> ChemdescgeometricCursor {
  let result = chem_desc_geometric_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_cursor_sum(s : ChemdescgeometricCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_cursor_mean(s : ChemdescgeometricCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_cursor_scale(s : ChemdescgeometricCursor, f : Double) -> ChemdescgeometricCursor {
  let result = chem_desc_geometric_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_cursor_add(a : ChemdescgeometricCursor, b : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_cursor_copy(s : ChemdescgeometricCursor) -> ChemdescgeometricCursor {
  let result = chem_desc_geometric_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_cursor_fill(s : ChemdescgeometricCursor, v : Double) -> ChemdescgeometricCursor {
  let result = chem_desc_geometric_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_cursor_min(s : ChemdescgeometricCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_cursor_max(s : ChemdescgeometricCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_cursor_to_string(s : ChemdescgeometricCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_view_make(size : Int) -> ChemdescgeometricView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_view_len(s : ChemdescgeometricView) -> Int { s.size }

pub fn chem_desc_geometric_view_get(s : ChemdescgeometricView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_view_set(s : ChemdescgeometricView, i : Int, v : Double) -> ChemdescgeometricView {
  let result = chem_desc_geometric_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_view_sum(s : ChemdescgeometricView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_view_mean(s : ChemdescgeometricView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_view_scale(s : ChemdescgeometricView, f : Double) -> ChemdescgeometricView {
  let result = chem_desc_geometric_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_view_add(a : ChemdescgeometricView, b : ChemdescgeometricView) -> ChemdescgeometricView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_view_copy(s : ChemdescgeometricView) -> ChemdescgeometricView {
  let result = chem_desc_geometric_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_view_fill(s : ChemdescgeometricView, v : Double) -> ChemdescgeometricView {
  let result = chem_desc_geometric_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_view_min(s : ChemdescgeometricView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_view_max(s : ChemdescgeometricView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_view_to_string(s : ChemdescgeometricView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_range_make(size : Int) -> ChemdescgeometricRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_range_len(s : ChemdescgeometricRange) -> Int { s.size }

pub fn chem_desc_geometric_range_get(s : ChemdescgeometricRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_range_set(s : ChemdescgeometricRange, i : Int, v : Double) -> ChemdescgeometricRange {
  let result = chem_desc_geometric_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_range_sum(s : ChemdescgeometricRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_range_mean(s : ChemdescgeometricRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_range_scale(s : ChemdescgeometricRange, f : Double) -> ChemdescgeometricRange {
  let result = chem_desc_geometric_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_range_add(a : ChemdescgeometricRange, b : ChemdescgeometricRange) -> ChemdescgeometricRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_range_copy(s : ChemdescgeometricRange) -> ChemdescgeometricRange {
  let result = chem_desc_geometric_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_range_fill(s : ChemdescgeometricRange, v : Double) -> ChemdescgeometricRange {
  let result = chem_desc_geometric_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_range_min(s : ChemdescgeometricRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_range_max(s : ChemdescgeometricRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_range_to_string(s : ChemdescgeometricRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescgeometricSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_geometric_slice_make(size : Int) -> ChemdescgeometricSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_geometric_slice_len(s : ChemdescgeometricSlice) -> Int { s.size }

pub fn chem_desc_geometric_slice_get(s : ChemdescgeometricSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_geometric_slice_set(s : ChemdescgeometricSlice, i : Int, v : Double) -> ChemdescgeometricSlice {
  let result = chem_desc_geometric_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_slice_sum(s : ChemdescgeometricSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_geometric_slice_mean(s : ChemdescgeometricSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_geometric_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_geometric_slice_scale(s : ChemdescgeometricSlice, f : Double) -> ChemdescgeometricSlice {
  let result = chem_desc_geometric_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_geometric_slice_add(a : ChemdescgeometricSlice, b : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_geometric_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_geometric_slice_copy(s : ChemdescgeometricSlice) -> ChemdescgeometricSlice {
  let result = chem_desc_geometric_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_geometric_slice_fill(s : ChemdescgeometricSlice, v : Double) -> ChemdescgeometricSlice {
  let result = chem_desc_geometric_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_geometric_slice_min(s : ChemdescgeometricSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_slice_max(s : ChemdescgeometricSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_geometric_slice_to_string(s : ChemdescgeometricSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


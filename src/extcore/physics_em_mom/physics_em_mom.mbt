///===
/// extcore/physics_em_mom

pub(all) struct PhysicsemmomPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_mom_make_point(x : Double, y : Double) -> PhysicsemmomPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_mom_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmomPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_mom_point_x(pt : PhysicsemmomPoint) -> Double { pt.x }

pub fn physics_em_mom_point_y(pt : PhysicsemmomPoint) -> Double { pt.y }

pub fn physics_em_mom_point_z(pt : PhysicsemmomPoint) -> Double { pt.z }

pub fn physics_em_mom_point_label(pt : PhysicsemmomPoint) -> Int { pt.label }

pub fn physics_em_mom_point_dist(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_mom_point_add(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_mom_point_sub(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_mom_point_scale(pt : PhysicsemmomPoint, s : Double) -> PhysicsemmomPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_mom_point_dot(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_mom_point_cross(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_mom_point_norm(pt : PhysicsemmomPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_mom_point_normalize(pt : PhysicsemmomPoint) -> PhysicsemmomPoint {
  let n = physics_em_mom_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_mom_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_mom_point_negate(pt : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_mom_point_mid(a : PhysicsemmomPoint, b : PhysicsemmomPoint) -> PhysicsemmomPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_mom_point_lerp(a : PhysicsemmomPoint, b : PhysicsemmomPoint, t : Double) -> PhysicsemmomPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_mom_point_to_string(pt : PhysicsemmomPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemmomSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_mom_make_series(vals : Array[Double], name : String) -> PhysicsemmomSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_mom_series_len(s : PhysicsemmomSeries) -> Int { s.vals.length() }

pub fn physics_em_mom_series_sum(s : PhysicsemmomSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_mom_series_mean(s : PhysicsemmomSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_mom_series_min(s : PhysicsemmomSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_mom_series_max(s : PhysicsemmomSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_mom_series_range(s : PhysicsemmomSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_mom_series_var(s : PhysicsemmomSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_mom_series_std(s : PhysicsemmomSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_mom_series_median(s : PhysicsemmomSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_mom_series_scale(s : PhysicsemmomSeries, f : Double) -> PhysicsemmomSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_mom_series_add(a : PhysicsemmomSeries, b : PhysicsemmomSeries) -> PhysicsemmomSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_mom_series_sub(a : PhysicsemmomSeries, b : PhysicsemmomSeries) -> PhysicsemmomSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_mom_series_normalize(s : PhysicsemmomSeries) -> PhysicsemmomSeries {
  let mn = physics_em_mom_series_min(s)
  let mx = physics_em_mom_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_mom_series_cumsum(s : PhysicsemmomSeries) -> PhysicsemmomSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_mom_series_to_string(s : PhysicsemmomSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmomMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_mom_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmomMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_mom_matrix_identity(n : Int) -> PhysicsemmomMatrix {
  let m = physics_em_mom_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_mom_matrix_get(m : PhysicsemmomMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_mom_matrix_transpose(m : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_mom_matrix_add(a : PhysicsemmomMatrix, b : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_mom_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_mom_matrix_scale(m : PhysicsemmomMatrix, s : Double) -> PhysicsemmomMatrix {
  let result = physics_em_mom_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_mom_matrix_multiply(a : PhysicsemmomMatrix, b : PhysicsemmomMatrix) -> PhysicsemmomMatrix {
  if a.cols != b.rows { return physics_em_mom_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_mom_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_mom_matrix_trace(m : PhysicsemmomMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_mom_matrix_det(m : PhysicsemmomMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_mom_matrix_norm(m : PhysicsemmomMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_mom_matrix_to_string(m : PhysicsemmomMatrix) -> String {
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

pub(all) struct PhysicsemmomVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_mom_make_vector(comps : Array[Double]) -> PhysicsemmomVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_mom_vector_zero(dim : Int) -> PhysicsemmomVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_mom_vector_add(a : PhysicsemmomVector, b : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_mom_vector_sub(a : PhysicsemmomVector, b : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_mom_vector_scale(v : PhysicsemmomVector, s : Double) -> PhysicsemmomVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_mom_vector_dot(a : PhysicsemmomVector, b : PhysicsemmomVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_mom_vector_norm(v : PhysicsemmomVector) -> Double { @_common.sqrt(physics_em_mom_vector_dot(v, v)) }

pub fn physics_em_mom_vector_normalize(v : PhysicsemmomVector) -> PhysicsemmomVector {
  let n = physics_em_mom_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_mom_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_mom_vector_dist(a : PhysicsemmomVector, b : PhysicsemmomVector) -> Double {
  physics_em_mom_vector_norm(physics_em_mom_vector_sub(a, b))
}

pub fn physics_em_mom_vector_to_string(v : PhysicsemmomVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_mom_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_mom_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_mom_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_mom_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_mom_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_mom_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_mom_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_mom_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_mom_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_mom_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_mom_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_mom_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_mom_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_mom_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_mom_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_mom_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_mom_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_mom_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_mom_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_mom_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_mom_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_mom_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_mom_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_mom_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_mom_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_mom_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_mom_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_mom_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_mom_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemmomFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_frame_make(size : Int) -> PhysicsemmomFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_frame_len(s : PhysicsemmomFrame) -> Int { s.size }

pub fn physics_em_mom_frame_get(s : PhysicsemmomFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_frame_set(s : PhysicsemmomFrame, i : Int, v : Double) -> PhysicsemmomFrame {
  let result = physics_em_mom_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_frame_sum(s : PhysicsemmomFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_frame_mean(s : PhysicsemmomFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_frame_scale(s : PhysicsemmomFrame, f : Double) -> PhysicsemmomFrame {
  let result = physics_em_mom_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_frame_add(a : PhysicsemmomFrame, b : PhysicsemmomFrame) -> PhysicsemmomFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_frame_copy(s : PhysicsemmomFrame) -> PhysicsemmomFrame {
  let result = physics_em_mom_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_frame_fill(s : PhysicsemmomFrame, v : Double) -> PhysicsemmomFrame {
  let result = physics_em_mom_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_frame_min(s : PhysicsemmomFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_frame_max(s : PhysicsemmomFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_frame_to_string(s : PhysicsemmomFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_table_make(size : Int) -> PhysicsemmomTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_table_len(s : PhysicsemmomTable) -> Int { s.size }

pub fn physics_em_mom_table_get(s : PhysicsemmomTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_table_set(s : PhysicsemmomTable, i : Int, v : Double) -> PhysicsemmomTable {
  let result = physics_em_mom_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_table_sum(s : PhysicsemmomTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_table_mean(s : PhysicsemmomTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_table_scale(s : PhysicsemmomTable, f : Double) -> PhysicsemmomTable {
  let result = physics_em_mom_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_table_add(a : PhysicsemmomTable, b : PhysicsemmomTable) -> PhysicsemmomTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_table_copy(s : PhysicsemmomTable) -> PhysicsemmomTable {
  let result = physics_em_mom_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_table_fill(s : PhysicsemmomTable, v : Double) -> PhysicsemmomTable {
  let result = physics_em_mom_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_table_min(s : PhysicsemmomTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_table_max(s : PhysicsemmomTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_table_to_string(s : PhysicsemmomTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_graphn_make(size : Int) -> PhysicsemmomGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_graphn_len(s : PhysicsemmomGraphN) -> Int { s.size }

pub fn physics_em_mom_graphn_get(s : PhysicsemmomGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_graphn_set(s : PhysicsemmomGraphN, i : Int, v : Double) -> PhysicsemmomGraphN {
  let result = physics_em_mom_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_graphn_sum(s : PhysicsemmomGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_graphn_mean(s : PhysicsemmomGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_graphn_scale(s : PhysicsemmomGraphN, f : Double) -> PhysicsemmomGraphN {
  let result = physics_em_mom_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_graphn_add(a : PhysicsemmomGraphN, b : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_graphn_copy(s : PhysicsemmomGraphN) -> PhysicsemmomGraphN {
  let result = physics_em_mom_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_graphn_fill(s : PhysicsemmomGraphN, v : Double) -> PhysicsemmomGraphN {
  let result = physics_em_mom_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_graphn_min(s : PhysicsemmomGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_graphn_max(s : PhysicsemmomGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_graphn_to_string(s : PhysicsemmomGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_node_make(size : Int) -> PhysicsemmomNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_node_len(s : PhysicsemmomNode) -> Int { s.size }

pub fn physics_em_mom_node_get(s : PhysicsemmomNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_node_set(s : PhysicsemmomNode, i : Int, v : Double) -> PhysicsemmomNode {
  let result = physics_em_mom_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_node_sum(s : PhysicsemmomNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_node_mean(s : PhysicsemmomNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_node_scale(s : PhysicsemmomNode, f : Double) -> PhysicsemmomNode {
  let result = physics_em_mom_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_node_add(a : PhysicsemmomNode, b : PhysicsemmomNode) -> PhysicsemmomNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_node_copy(s : PhysicsemmomNode) -> PhysicsemmomNode {
  let result = physics_em_mom_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_node_fill(s : PhysicsemmomNode, v : Double) -> PhysicsemmomNode {
  let result = physics_em_mom_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_node_min(s : PhysicsemmomNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_node_max(s : PhysicsemmomNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_node_to_string(s : PhysicsemmomNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_edge_make(size : Int) -> PhysicsemmomEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_edge_len(s : PhysicsemmomEdge) -> Int { s.size }

pub fn physics_em_mom_edge_get(s : PhysicsemmomEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_edge_set(s : PhysicsemmomEdge, i : Int, v : Double) -> PhysicsemmomEdge {
  let result = physics_em_mom_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_edge_sum(s : PhysicsemmomEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_edge_mean(s : PhysicsemmomEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_edge_scale(s : PhysicsemmomEdge, f : Double) -> PhysicsemmomEdge {
  let result = physics_em_mom_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_edge_add(a : PhysicsemmomEdge, b : PhysicsemmomEdge) -> PhysicsemmomEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_edge_copy(s : PhysicsemmomEdge) -> PhysicsemmomEdge {
  let result = physics_em_mom_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_edge_fill(s : PhysicsemmomEdge, v : Double) -> PhysicsemmomEdge {
  let result = physics_em_mom_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_edge_min(s : PhysicsemmomEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_edge_max(s : PhysicsemmomEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_edge_to_string(s : PhysicsemmomEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_path_make(size : Int) -> PhysicsemmomPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_path_len(s : PhysicsemmomPath) -> Int { s.size }

pub fn physics_em_mom_path_get(s : PhysicsemmomPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_path_set(s : PhysicsemmomPath, i : Int, v : Double) -> PhysicsemmomPath {
  let result = physics_em_mom_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_path_sum(s : PhysicsemmomPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_path_mean(s : PhysicsemmomPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_path_scale(s : PhysicsemmomPath, f : Double) -> PhysicsemmomPath {
  let result = physics_em_mom_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_path_add(a : PhysicsemmomPath, b : PhysicsemmomPath) -> PhysicsemmomPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_path_copy(s : PhysicsemmomPath) -> PhysicsemmomPath {
  let result = physics_em_mom_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_path_fill(s : PhysicsemmomPath, v : Double) -> PhysicsemmomPath {
  let result = physics_em_mom_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_path_min(s : PhysicsemmomPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_path_max(s : PhysicsemmomPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_path_to_string(s : PhysicsemmomPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cluster_make(size : Int) -> PhysicsemmomCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_cluster_len(s : PhysicsemmomCluster) -> Int { s.size }

pub fn physics_em_mom_cluster_get(s : PhysicsemmomCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_cluster_set(s : PhysicsemmomCluster, i : Int, v : Double) -> PhysicsemmomCluster {
  let result = physics_em_mom_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_cluster_sum(s : PhysicsemmomCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_cluster_mean(s : PhysicsemmomCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_cluster_scale(s : PhysicsemmomCluster, f : Double) -> PhysicsemmomCluster {
  let result = physics_em_mom_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_cluster_add(a : PhysicsemmomCluster, b : PhysicsemmomCluster) -> PhysicsemmomCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_cluster_copy(s : PhysicsemmomCluster) -> PhysicsemmomCluster {
  let result = physics_em_mom_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_cluster_fill(s : PhysicsemmomCluster, v : Double) -> PhysicsemmomCluster {
  let result = physics_em_mom_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_cluster_min(s : PhysicsemmomCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_cluster_max(s : PhysicsemmomCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_cluster_to_string(s : PhysicsemmomCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_model_make(size : Int) -> PhysicsemmomModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_model_len(s : PhysicsemmomModel) -> Int { s.size }

pub fn physics_em_mom_model_get(s : PhysicsemmomModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_model_set(s : PhysicsemmomModel, i : Int, v : Double) -> PhysicsemmomModel {
  let result = physics_em_mom_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_model_sum(s : PhysicsemmomModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_model_mean(s : PhysicsemmomModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_model_scale(s : PhysicsemmomModel, f : Double) -> PhysicsemmomModel {
  let result = physics_em_mom_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_model_add(a : PhysicsemmomModel, b : PhysicsemmomModel) -> PhysicsemmomModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_model_copy(s : PhysicsemmomModel) -> PhysicsemmomModel {
  let result = physics_em_mom_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_model_fill(s : PhysicsemmomModel, v : Double) -> PhysicsemmomModel {
  let result = physics_em_mom_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_model_min(s : PhysicsemmomModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_model_max(s : PhysicsemmomModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_model_to_string(s : PhysicsemmomModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_layer_make(size : Int) -> PhysicsemmomLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_layer_len(s : PhysicsemmomLayer) -> Int { s.size }

pub fn physics_em_mom_layer_get(s : PhysicsemmomLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_layer_set(s : PhysicsemmomLayer, i : Int, v : Double) -> PhysicsemmomLayer {
  let result = physics_em_mom_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_layer_sum(s : PhysicsemmomLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_layer_mean(s : PhysicsemmomLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_layer_scale(s : PhysicsemmomLayer, f : Double) -> PhysicsemmomLayer {
  let result = physics_em_mom_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_layer_add(a : PhysicsemmomLayer, b : PhysicsemmomLayer) -> PhysicsemmomLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_layer_copy(s : PhysicsemmomLayer) -> PhysicsemmomLayer {
  let result = physics_em_mom_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_layer_fill(s : PhysicsemmomLayer, v : Double) -> PhysicsemmomLayer {
  let result = physics_em_mom_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_layer_min(s : PhysicsemmomLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_layer_max(s : PhysicsemmomLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_layer_to_string(s : PhysicsemmomLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_buffer_make(size : Int) -> PhysicsemmomBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_buffer_len(s : PhysicsemmomBuffer) -> Int { s.size }

pub fn physics_em_mom_buffer_get(s : PhysicsemmomBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_buffer_set(s : PhysicsemmomBuffer, i : Int, v : Double) -> PhysicsemmomBuffer {
  let result = physics_em_mom_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_buffer_sum(s : PhysicsemmomBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_buffer_mean(s : PhysicsemmomBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_buffer_scale(s : PhysicsemmomBuffer, f : Double) -> PhysicsemmomBuffer {
  let result = physics_em_mom_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_buffer_add(a : PhysicsemmomBuffer, b : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_buffer_copy(s : PhysicsemmomBuffer) -> PhysicsemmomBuffer {
  let result = physics_em_mom_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_buffer_fill(s : PhysicsemmomBuffer, v : Double) -> PhysicsemmomBuffer {
  let result = physics_em_mom_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_buffer_min(s : PhysicsemmomBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_buffer_max(s : PhysicsemmomBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_buffer_to_string(s : PhysicsemmomBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_cursor_make(size : Int) -> PhysicsemmomCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_cursor_len(s : PhysicsemmomCursor) -> Int { s.size }

pub fn physics_em_mom_cursor_get(s : PhysicsemmomCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_cursor_set(s : PhysicsemmomCursor, i : Int, v : Double) -> PhysicsemmomCursor {
  let result = physics_em_mom_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_cursor_sum(s : PhysicsemmomCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_cursor_mean(s : PhysicsemmomCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_cursor_scale(s : PhysicsemmomCursor, f : Double) -> PhysicsemmomCursor {
  let result = physics_em_mom_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_cursor_add(a : PhysicsemmomCursor, b : PhysicsemmomCursor) -> PhysicsemmomCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_cursor_copy(s : PhysicsemmomCursor) -> PhysicsemmomCursor {
  let result = physics_em_mom_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_cursor_fill(s : PhysicsemmomCursor, v : Double) -> PhysicsemmomCursor {
  let result = physics_em_mom_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_cursor_min(s : PhysicsemmomCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_cursor_max(s : PhysicsemmomCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_cursor_to_string(s : PhysicsemmomCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_view_make(size : Int) -> PhysicsemmomView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_view_len(s : PhysicsemmomView) -> Int { s.size }

pub fn physics_em_mom_view_get(s : PhysicsemmomView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_view_set(s : PhysicsemmomView, i : Int, v : Double) -> PhysicsemmomView {
  let result = physics_em_mom_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_view_sum(s : PhysicsemmomView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_view_mean(s : PhysicsemmomView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_view_scale(s : PhysicsemmomView, f : Double) -> PhysicsemmomView {
  let result = physics_em_mom_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_view_add(a : PhysicsemmomView, b : PhysicsemmomView) -> PhysicsemmomView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_view_copy(s : PhysicsemmomView) -> PhysicsemmomView {
  let result = physics_em_mom_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_view_fill(s : PhysicsemmomView, v : Double) -> PhysicsemmomView {
  let result = physics_em_mom_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_view_min(s : PhysicsemmomView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_view_max(s : PhysicsemmomView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_view_to_string(s : PhysicsemmomView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_range_make(size : Int) -> PhysicsemmomRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_range_len(s : PhysicsemmomRange) -> Int { s.size }

pub fn physics_em_mom_range_get(s : PhysicsemmomRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_range_set(s : PhysicsemmomRange, i : Int, v : Double) -> PhysicsemmomRange {
  let result = physics_em_mom_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_range_sum(s : PhysicsemmomRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_range_mean(s : PhysicsemmomRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_range_scale(s : PhysicsemmomRange, f : Double) -> PhysicsemmomRange {
  let result = physics_em_mom_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_range_add(a : PhysicsemmomRange, b : PhysicsemmomRange) -> PhysicsemmomRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_range_copy(s : PhysicsemmomRange) -> PhysicsemmomRange {
  let result = physics_em_mom_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_range_fill(s : PhysicsemmomRange, v : Double) -> PhysicsemmomRange {
  let result = physics_em_mom_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_range_min(s : PhysicsemmomRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_range_max(s : PhysicsemmomRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_range_to_string(s : PhysicsemmomRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmomSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_mom_slice_make(size : Int) -> PhysicsemmomSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_mom_slice_len(s : PhysicsemmomSlice) -> Int { s.size }

pub fn physics_em_mom_slice_get(s : PhysicsemmomSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_mom_slice_set(s : PhysicsemmomSlice, i : Int, v : Double) -> PhysicsemmomSlice {
  let result = physics_em_mom_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_slice_sum(s : PhysicsemmomSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_mom_slice_mean(s : PhysicsemmomSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_mom_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_mom_slice_scale(s : PhysicsemmomSlice, f : Double) -> PhysicsemmomSlice {
  let result = physics_em_mom_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_mom_slice_add(a : PhysicsemmomSlice, b : PhysicsemmomSlice) -> PhysicsemmomSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_mom_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_mom_slice_copy(s : PhysicsemmomSlice) -> PhysicsemmomSlice {
  let result = physics_em_mom_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_mom_slice_fill(s : PhysicsemmomSlice, v : Double) -> PhysicsemmomSlice {
  let result = physics_em_mom_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_mom_slice_min(s : PhysicsemmomSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_slice_max(s : PhysicsemmomSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_mom_slice_to_string(s : PhysicsemmomSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


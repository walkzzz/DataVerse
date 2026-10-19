///===
/// extcore/ml_cluster_affinity

pub(all) struct MlclusteraffinityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_affinity_make_point(x : Double, y : Double) -> MlclusteraffinityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_affinity_make_point3(x : Double, y : Double, z : Double) -> MlclusteraffinityPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_affinity_point_x(pt : MlclusteraffinityPoint) -> Double { pt.x }

pub fn ml_cluster_affinity_point_y(pt : MlclusteraffinityPoint) -> Double { pt.y }

pub fn ml_cluster_affinity_point_z(pt : MlclusteraffinityPoint) -> Double { pt.z }

pub fn ml_cluster_affinity_point_label(pt : MlclusteraffinityPoint) -> Int { pt.label }

pub fn ml_cluster_affinity_point_dist(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_affinity_point_add(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_affinity_point_sub(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_affinity_point_scale(pt : MlclusteraffinityPoint, s : Double) -> MlclusteraffinityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_affinity_point_dot(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_affinity_point_cross(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_affinity_point_norm(pt : MlclusteraffinityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_affinity_point_normalize(pt : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  let n = ml_cluster_affinity_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_affinity_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_affinity_point_negate(pt : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_affinity_point_mid(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_affinity_point_lerp(a : MlclusteraffinityPoint, b : MlclusteraffinityPoint, t : Double) -> MlclusteraffinityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_affinity_point_to_string(pt : MlclusteraffinityPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusteraffinitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_affinity_make_series(vals : Array[Double], name : String) -> MlclusteraffinitySeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_affinity_series_len(s : MlclusteraffinitySeries) -> Int { s.vals.length() }

pub fn ml_cluster_affinity_series_sum(s : MlclusteraffinitySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_affinity_series_mean(s : MlclusteraffinitySeries) -> Double {
  let n = ml_cluster_affinity_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_affinity_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_affinity_series_min(s : MlclusteraffinitySeries) -> Double {
  let n = ml_cluster_affinity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_affinity_series_max(s : MlclusteraffinitySeries) -> Double {
  let n = ml_cluster_affinity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_affinity_series_range(s : MlclusteraffinitySeries) -> Double {
  ml_cluster_affinity_series_max(s) - ml_cluster_affinity_series_min(s)
}

pub fn ml_cluster_affinity_series_var(s : MlclusteraffinitySeries) -> Double {
  let n = ml_cluster_affinity_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_affinity_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_affinity_series_std(s : MlclusteraffinitySeries) -> Double { @_common.sqrt(ml_cluster_affinity_series_var(s)) }

pub fn ml_cluster_affinity_series_median(s : MlclusteraffinitySeries) -> Double {
  let n = ml_cluster_affinity_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_affinity_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_affinity_series_scale(s : MlclusteraffinitySeries, f : Double) -> MlclusteraffinitySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_affinity_series_add(a : MlclusteraffinitySeries, b : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_affinity_series_sub(a : MlclusteraffinitySeries, b : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_affinity_series_normalize(s : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  let mn = ml_cluster_affinity_series_min(s)
  let mx = ml_cluster_affinity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_affinity_series_cumsum(s : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_affinity_series_to_string(s : MlclusteraffinitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteraffinityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_affinity_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteraffinityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_affinity_matrix_identity(n : Int) -> MlclusteraffinityMatrix {
  let m = ml_cluster_affinity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_affinity_matrix_get(m : MlclusteraffinityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_affinity_matrix_transpose(m : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_affinity_matrix_add(a : MlclusteraffinityMatrix, b : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_affinity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_affinity_matrix_scale(m : MlclusteraffinityMatrix, s : Double) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_affinity_matrix_multiply(a : MlclusteraffinityMatrix, b : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  if a.cols != b.rows { return ml_cluster_affinity_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_affinity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_affinity_matrix_trace(m : MlclusteraffinityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_affinity_matrix_det(m : MlclusteraffinityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_affinity_matrix_norm(m : MlclusteraffinityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_affinity_matrix_to_string(m : MlclusteraffinityMatrix) -> String {
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

pub(all) struct MlclusteraffinityVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_affinity_make_vector(comps : Array[Double]) -> MlclusteraffinityVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_affinity_vector_zero(dim : Int) -> MlclusteraffinityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_affinity_vector_add(a : MlclusteraffinityVector, b : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_affinity_vector_sub(a : MlclusteraffinityVector, b : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_affinity_vector_scale(v : MlclusteraffinityVector, s : Double) -> MlclusteraffinityVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_affinity_vector_dot(a : MlclusteraffinityVector, b : MlclusteraffinityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_affinity_vector_norm(v : MlclusteraffinityVector) -> Double { @_common.sqrt(ml_cluster_affinity_vector_dot(v, v)) }

pub fn ml_cluster_affinity_vector_normalize(v : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = ml_cluster_affinity_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_affinity_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_affinity_vector_dist(a : MlclusteraffinityVector, b : MlclusteraffinityVector) -> Double {
  ml_cluster_affinity_vector_norm(ml_cluster_affinity_vector_sub(a, b))
}

pub fn ml_cluster_affinity_vector_to_string(v : MlclusteraffinityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_affinity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_affinity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_affinity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_affinity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_affinity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_affinity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_affinity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_affinity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_affinity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_affinity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_affinity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_affinity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_affinity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_affinity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_affinity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_affinity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_affinity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_affinity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_affinity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_affinity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_affinity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_affinity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_affinity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_affinity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_affinity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_affinity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_affinity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_affinity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_affinity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusteraffinityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_frame_make(size : Int) -> MlclusteraffinityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_frame_len(s : MlclusteraffinityFrame) -> Int { s.size }

pub fn ml_cluster_affinity_frame_get(s : MlclusteraffinityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_frame_set(s : MlclusteraffinityFrame, i : Int, v : Double) -> MlclusteraffinityFrame {
  let result = ml_cluster_affinity_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_frame_sum(s : MlclusteraffinityFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_frame_mean(s : MlclusteraffinityFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_frame_scale(s : MlclusteraffinityFrame, f : Double) -> MlclusteraffinityFrame {
  let result = ml_cluster_affinity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_frame_add(a : MlclusteraffinityFrame, b : MlclusteraffinityFrame) -> MlclusteraffinityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_frame_copy(s : MlclusteraffinityFrame) -> MlclusteraffinityFrame {
  let result = ml_cluster_affinity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_frame_fill(s : MlclusteraffinityFrame, v : Double) -> MlclusteraffinityFrame {
  let result = ml_cluster_affinity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_frame_min(s : MlclusteraffinityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_frame_max(s : MlclusteraffinityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_frame_to_string(s : MlclusteraffinityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_table_make(size : Int) -> MlclusteraffinityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_table_len(s : MlclusteraffinityTable) -> Int { s.size }

pub fn ml_cluster_affinity_table_get(s : MlclusteraffinityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_table_set(s : MlclusteraffinityTable, i : Int, v : Double) -> MlclusteraffinityTable {
  let result = ml_cluster_affinity_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_table_sum(s : MlclusteraffinityTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_table_mean(s : MlclusteraffinityTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_table_scale(s : MlclusteraffinityTable, f : Double) -> MlclusteraffinityTable {
  let result = ml_cluster_affinity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_table_add(a : MlclusteraffinityTable, b : MlclusteraffinityTable) -> MlclusteraffinityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_table_copy(s : MlclusteraffinityTable) -> MlclusteraffinityTable {
  let result = ml_cluster_affinity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_table_fill(s : MlclusteraffinityTable, v : Double) -> MlclusteraffinityTable {
  let result = ml_cluster_affinity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_table_min(s : MlclusteraffinityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_table_max(s : MlclusteraffinityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_table_to_string(s : MlclusteraffinityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_graphn_make(size : Int) -> MlclusteraffinityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_graphn_len(s : MlclusteraffinityGraphN) -> Int { s.size }

pub fn ml_cluster_affinity_graphn_get(s : MlclusteraffinityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_graphn_set(s : MlclusteraffinityGraphN, i : Int, v : Double) -> MlclusteraffinityGraphN {
  let result = ml_cluster_affinity_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_graphn_sum(s : MlclusteraffinityGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_graphn_mean(s : MlclusteraffinityGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_graphn_scale(s : MlclusteraffinityGraphN, f : Double) -> MlclusteraffinityGraphN {
  let result = ml_cluster_affinity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_graphn_add(a : MlclusteraffinityGraphN, b : MlclusteraffinityGraphN) -> MlclusteraffinityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_graphn_copy(s : MlclusteraffinityGraphN) -> MlclusteraffinityGraphN {
  let result = ml_cluster_affinity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_graphn_fill(s : MlclusteraffinityGraphN, v : Double) -> MlclusteraffinityGraphN {
  let result = ml_cluster_affinity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_graphn_min(s : MlclusteraffinityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_graphn_max(s : MlclusteraffinityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_graphn_to_string(s : MlclusteraffinityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_node_make(size : Int) -> MlclusteraffinityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_node_len(s : MlclusteraffinityNode) -> Int { s.size }

pub fn ml_cluster_affinity_node_get(s : MlclusteraffinityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_node_set(s : MlclusteraffinityNode, i : Int, v : Double) -> MlclusteraffinityNode {
  let result = ml_cluster_affinity_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_node_sum(s : MlclusteraffinityNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_node_mean(s : MlclusteraffinityNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_node_scale(s : MlclusteraffinityNode, f : Double) -> MlclusteraffinityNode {
  let result = ml_cluster_affinity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_node_add(a : MlclusteraffinityNode, b : MlclusteraffinityNode) -> MlclusteraffinityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_node_copy(s : MlclusteraffinityNode) -> MlclusteraffinityNode {
  let result = ml_cluster_affinity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_node_fill(s : MlclusteraffinityNode, v : Double) -> MlclusteraffinityNode {
  let result = ml_cluster_affinity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_node_min(s : MlclusteraffinityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_node_max(s : MlclusteraffinityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_node_to_string(s : MlclusteraffinityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_edge_make(size : Int) -> MlclusteraffinityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_edge_len(s : MlclusteraffinityEdge) -> Int { s.size }

pub fn ml_cluster_affinity_edge_get(s : MlclusteraffinityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_edge_set(s : MlclusteraffinityEdge, i : Int, v : Double) -> MlclusteraffinityEdge {
  let result = ml_cluster_affinity_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_edge_sum(s : MlclusteraffinityEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_edge_mean(s : MlclusteraffinityEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_edge_scale(s : MlclusteraffinityEdge, f : Double) -> MlclusteraffinityEdge {
  let result = ml_cluster_affinity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_edge_add(a : MlclusteraffinityEdge, b : MlclusteraffinityEdge) -> MlclusteraffinityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_edge_copy(s : MlclusteraffinityEdge) -> MlclusteraffinityEdge {
  let result = ml_cluster_affinity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_edge_fill(s : MlclusteraffinityEdge, v : Double) -> MlclusteraffinityEdge {
  let result = ml_cluster_affinity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_edge_min(s : MlclusteraffinityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_edge_max(s : MlclusteraffinityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_edge_to_string(s : MlclusteraffinityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_path_make(size : Int) -> MlclusteraffinityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_path_len(s : MlclusteraffinityPath) -> Int { s.size }

pub fn ml_cluster_affinity_path_get(s : MlclusteraffinityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_path_set(s : MlclusteraffinityPath, i : Int, v : Double) -> MlclusteraffinityPath {
  let result = ml_cluster_affinity_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_path_sum(s : MlclusteraffinityPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_path_mean(s : MlclusteraffinityPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_path_scale(s : MlclusteraffinityPath, f : Double) -> MlclusteraffinityPath {
  let result = ml_cluster_affinity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_path_add(a : MlclusteraffinityPath, b : MlclusteraffinityPath) -> MlclusteraffinityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_path_copy(s : MlclusteraffinityPath) -> MlclusteraffinityPath {
  let result = ml_cluster_affinity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_path_fill(s : MlclusteraffinityPath, v : Double) -> MlclusteraffinityPath {
  let result = ml_cluster_affinity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_path_min(s : MlclusteraffinityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_path_max(s : MlclusteraffinityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_path_to_string(s : MlclusteraffinityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_cluster_make(size : Int) -> MlclusteraffinityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_cluster_len(s : MlclusteraffinityCluster) -> Int { s.size }

pub fn ml_cluster_affinity_cluster_get(s : MlclusteraffinityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_cluster_set(s : MlclusteraffinityCluster, i : Int, v : Double) -> MlclusteraffinityCluster {
  let result = ml_cluster_affinity_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_cluster_sum(s : MlclusteraffinityCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_cluster_mean(s : MlclusteraffinityCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_cluster_scale(s : MlclusteraffinityCluster, f : Double) -> MlclusteraffinityCluster {
  let result = ml_cluster_affinity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_cluster_add(a : MlclusteraffinityCluster, b : MlclusteraffinityCluster) -> MlclusteraffinityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_cluster_copy(s : MlclusteraffinityCluster) -> MlclusteraffinityCluster {
  let result = ml_cluster_affinity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_cluster_fill(s : MlclusteraffinityCluster, v : Double) -> MlclusteraffinityCluster {
  let result = ml_cluster_affinity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_cluster_min(s : MlclusteraffinityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_cluster_max(s : MlclusteraffinityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_cluster_to_string(s : MlclusteraffinityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_model_make(size : Int) -> MlclusteraffinityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_model_len(s : MlclusteraffinityModel) -> Int { s.size }

pub fn ml_cluster_affinity_model_get(s : MlclusteraffinityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_model_set(s : MlclusteraffinityModel, i : Int, v : Double) -> MlclusteraffinityModel {
  let result = ml_cluster_affinity_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_model_sum(s : MlclusteraffinityModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_model_mean(s : MlclusteraffinityModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_model_scale(s : MlclusteraffinityModel, f : Double) -> MlclusteraffinityModel {
  let result = ml_cluster_affinity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_model_add(a : MlclusteraffinityModel, b : MlclusteraffinityModel) -> MlclusteraffinityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_model_copy(s : MlclusteraffinityModel) -> MlclusteraffinityModel {
  let result = ml_cluster_affinity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_model_fill(s : MlclusteraffinityModel, v : Double) -> MlclusteraffinityModel {
  let result = ml_cluster_affinity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_model_min(s : MlclusteraffinityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_model_max(s : MlclusteraffinityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_model_to_string(s : MlclusteraffinityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_layer_make(size : Int) -> MlclusteraffinityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_layer_len(s : MlclusteraffinityLayer) -> Int { s.size }

pub fn ml_cluster_affinity_layer_get(s : MlclusteraffinityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_layer_set(s : MlclusteraffinityLayer, i : Int, v : Double) -> MlclusteraffinityLayer {
  let result = ml_cluster_affinity_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_layer_sum(s : MlclusteraffinityLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_layer_mean(s : MlclusteraffinityLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_layer_scale(s : MlclusteraffinityLayer, f : Double) -> MlclusteraffinityLayer {
  let result = ml_cluster_affinity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_layer_add(a : MlclusteraffinityLayer, b : MlclusteraffinityLayer) -> MlclusteraffinityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_layer_copy(s : MlclusteraffinityLayer) -> MlclusteraffinityLayer {
  let result = ml_cluster_affinity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_layer_fill(s : MlclusteraffinityLayer, v : Double) -> MlclusteraffinityLayer {
  let result = ml_cluster_affinity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_layer_min(s : MlclusteraffinityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_layer_max(s : MlclusteraffinityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_layer_to_string(s : MlclusteraffinityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_buffer_make(size : Int) -> MlclusteraffinityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_buffer_len(s : MlclusteraffinityBuffer) -> Int { s.size }

pub fn ml_cluster_affinity_buffer_get(s : MlclusteraffinityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_buffer_set(s : MlclusteraffinityBuffer, i : Int, v : Double) -> MlclusteraffinityBuffer {
  let result = ml_cluster_affinity_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_buffer_sum(s : MlclusteraffinityBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_buffer_mean(s : MlclusteraffinityBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_buffer_scale(s : MlclusteraffinityBuffer, f : Double) -> MlclusteraffinityBuffer {
  let result = ml_cluster_affinity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_buffer_add(a : MlclusteraffinityBuffer, b : MlclusteraffinityBuffer) -> MlclusteraffinityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_buffer_copy(s : MlclusteraffinityBuffer) -> MlclusteraffinityBuffer {
  let result = ml_cluster_affinity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_buffer_fill(s : MlclusteraffinityBuffer, v : Double) -> MlclusteraffinityBuffer {
  let result = ml_cluster_affinity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_buffer_min(s : MlclusteraffinityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_buffer_max(s : MlclusteraffinityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_buffer_to_string(s : MlclusteraffinityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_cursor_make(size : Int) -> MlclusteraffinityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_cursor_len(s : MlclusteraffinityCursor) -> Int { s.size }

pub fn ml_cluster_affinity_cursor_get(s : MlclusteraffinityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_cursor_set(s : MlclusteraffinityCursor, i : Int, v : Double) -> MlclusteraffinityCursor {
  let result = ml_cluster_affinity_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_cursor_sum(s : MlclusteraffinityCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_cursor_mean(s : MlclusteraffinityCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_cursor_scale(s : MlclusteraffinityCursor, f : Double) -> MlclusteraffinityCursor {
  let result = ml_cluster_affinity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_cursor_add(a : MlclusteraffinityCursor, b : MlclusteraffinityCursor) -> MlclusteraffinityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_cursor_copy(s : MlclusteraffinityCursor) -> MlclusteraffinityCursor {
  let result = ml_cluster_affinity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_cursor_fill(s : MlclusteraffinityCursor, v : Double) -> MlclusteraffinityCursor {
  let result = ml_cluster_affinity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_cursor_min(s : MlclusteraffinityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_cursor_max(s : MlclusteraffinityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_cursor_to_string(s : MlclusteraffinityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_view_make(size : Int) -> MlclusteraffinityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_view_len(s : MlclusteraffinityView) -> Int { s.size }

pub fn ml_cluster_affinity_view_get(s : MlclusteraffinityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_view_set(s : MlclusteraffinityView, i : Int, v : Double) -> MlclusteraffinityView {
  let result = ml_cluster_affinity_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_view_sum(s : MlclusteraffinityView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_view_mean(s : MlclusteraffinityView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_view_scale(s : MlclusteraffinityView, f : Double) -> MlclusteraffinityView {
  let result = ml_cluster_affinity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_view_add(a : MlclusteraffinityView, b : MlclusteraffinityView) -> MlclusteraffinityView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_view_copy(s : MlclusteraffinityView) -> MlclusteraffinityView {
  let result = ml_cluster_affinity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_view_fill(s : MlclusteraffinityView, v : Double) -> MlclusteraffinityView {
  let result = ml_cluster_affinity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_view_min(s : MlclusteraffinityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_view_max(s : MlclusteraffinityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_view_to_string(s : MlclusteraffinityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_range_make(size : Int) -> MlclusteraffinityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_range_len(s : MlclusteraffinityRange) -> Int { s.size }

pub fn ml_cluster_affinity_range_get(s : MlclusteraffinityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_range_set(s : MlclusteraffinityRange, i : Int, v : Double) -> MlclusteraffinityRange {
  let result = ml_cluster_affinity_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_range_sum(s : MlclusteraffinityRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_range_mean(s : MlclusteraffinityRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_range_scale(s : MlclusteraffinityRange, f : Double) -> MlclusteraffinityRange {
  let result = ml_cluster_affinity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_range_add(a : MlclusteraffinityRange, b : MlclusteraffinityRange) -> MlclusteraffinityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_range_copy(s : MlclusteraffinityRange) -> MlclusteraffinityRange {
  let result = ml_cluster_affinity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_range_fill(s : MlclusteraffinityRange, v : Double) -> MlclusteraffinityRange {
  let result = ml_cluster_affinity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_range_min(s : MlclusteraffinityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_range_max(s : MlclusteraffinityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_range_to_string(s : MlclusteraffinityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_slice_make(size : Int) -> MlclusteraffinitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_slice_len(s : MlclusteraffinitySlice) -> Int { s.size }

pub fn ml_cluster_affinity_slice_get(s : MlclusteraffinitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_slice_set(s : MlclusteraffinitySlice, i : Int, v : Double) -> MlclusteraffinitySlice {
  let result = ml_cluster_affinity_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_slice_sum(s : MlclusteraffinitySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_affinity_slice_mean(s : MlclusteraffinitySlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_affinity_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_affinity_slice_scale(s : MlclusteraffinitySlice, f : Double) -> MlclusteraffinitySlice {
  let result = ml_cluster_affinity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_affinity_slice_add(a : MlclusteraffinitySlice, b : MlclusteraffinitySlice) -> MlclusteraffinitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_affinity_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_affinity_slice_copy(s : MlclusteraffinitySlice) -> MlclusteraffinitySlice {
  let result = ml_cluster_affinity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_affinity_slice_fill(s : MlclusteraffinitySlice, v : Double) -> MlclusteraffinitySlice {
  let result = ml_cluster_affinity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_affinity_slice_min(s : MlclusteraffinitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_slice_max(s : MlclusteraffinitySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_affinity_slice_to_string(s : MlclusteraffinitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


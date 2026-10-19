///===
/// extcore/ml_cluster_kmeans

pub(all) struct MlclusterkmeansPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_kmeans_make_point(x : Double, y : Double) -> MlclusterkmeansPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_kmeans_make_point3(x : Double, y : Double, z : Double) -> MlclusterkmeansPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_kmeans_point_x(pt : MlclusterkmeansPoint) -> Double { pt.x }

pub fn ml_cluster_kmeans_point_y(pt : MlclusterkmeansPoint) -> Double { pt.y }

pub fn ml_cluster_kmeans_point_z(pt : MlclusterkmeansPoint) -> Double { pt.z }

pub fn ml_cluster_kmeans_point_label(pt : MlclusterkmeansPoint) -> Int { pt.label }

pub fn ml_cluster_kmeans_point_dist(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_kmeans_point_add(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_kmeans_point_sub(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_kmeans_point_scale(pt : MlclusterkmeansPoint, s : Double) -> MlclusterkmeansPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_kmeans_point_dot(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_kmeans_point_cross(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_kmeans_point_norm(pt : MlclusterkmeansPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_kmeans_point_normalize(pt : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  let n = ml_cluster_kmeans_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_kmeans_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_kmeans_point_negate(pt : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_kmeans_point_mid(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint) -> MlclusterkmeansPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_kmeans_point_lerp(a : MlclusterkmeansPoint, b : MlclusterkmeansPoint, t : Double) -> MlclusterkmeansPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_kmeans_point_to_string(pt : MlclusterkmeansPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusterkmeansSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_kmeans_make_series(vals : Array[Double], name : String) -> MlclusterkmeansSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_kmeans_series_len(s : MlclusterkmeansSeries) -> Int { s.vals.length() }

pub fn ml_cluster_kmeans_series_sum(s : MlclusterkmeansSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_kmeans_series_mean(s : MlclusterkmeansSeries) -> Double {
  let n = ml_cluster_kmeans_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_kmeans_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_kmeans_series_min(s : MlclusterkmeansSeries) -> Double {
  let n = ml_cluster_kmeans_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_series_max(s : MlclusterkmeansSeries) -> Double {
  let n = ml_cluster_kmeans_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_series_range(s : MlclusterkmeansSeries) -> Double {
  ml_cluster_kmeans_series_max(s) - ml_cluster_kmeans_series_min(s)
}

pub fn ml_cluster_kmeans_series_var(s : MlclusterkmeansSeries) -> Double {
  let n = ml_cluster_kmeans_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_kmeans_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_kmeans_series_std(s : MlclusterkmeansSeries) -> Double { @_common.sqrt(ml_cluster_kmeans_series_var(s)) }

pub fn ml_cluster_kmeans_series_median(s : MlclusterkmeansSeries) -> Double {
  let n = ml_cluster_kmeans_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_kmeans_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_kmeans_series_scale(s : MlclusterkmeansSeries, f : Double) -> MlclusterkmeansSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_kmeans_series_add(a : MlclusterkmeansSeries, b : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_kmeans_series_sub(a : MlclusterkmeansSeries, b : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_kmeans_series_normalize(s : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  let mn = ml_cluster_kmeans_series_min(s)
  let mx = ml_cluster_kmeans_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_kmeans_series_cumsum(s : MlclusterkmeansSeries) -> MlclusterkmeansSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_kmeans_series_to_string(s : MlclusterkmeansSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterkmeansMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_kmeans_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterkmeansMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_kmeans_matrix_identity(n : Int) -> MlclusterkmeansMatrix {
  let m = ml_cluster_kmeans_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_kmeans_matrix_get(m : MlclusterkmeansMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_kmeans_matrix_transpose(m : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_kmeans_matrix_add(a : MlclusterkmeansMatrix, b : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_kmeans_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_kmeans_matrix_scale(m : MlclusterkmeansMatrix, s : Double) -> MlclusterkmeansMatrix {
  let result = ml_cluster_kmeans_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_kmeans_matrix_multiply(a : MlclusterkmeansMatrix, b : MlclusterkmeansMatrix) -> MlclusterkmeansMatrix {
  if a.cols != b.rows { return ml_cluster_kmeans_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_kmeans_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_kmeans_matrix_trace(m : MlclusterkmeansMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_kmeans_matrix_det(m : MlclusterkmeansMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_kmeans_matrix_norm(m : MlclusterkmeansMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_cluster_kmeans_matrix_to_string(m : MlclusterkmeansMatrix) -> String {
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

pub(all) struct MlclusterkmeansVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_kmeans_make_vector(comps : Array[Double]) -> MlclusterkmeansVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_kmeans_vector_zero(dim : Int) -> MlclusterkmeansVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_kmeans_vector_add(a : MlclusterkmeansVector, b : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_kmeans_vector_sub(a : MlclusterkmeansVector, b : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_kmeans_vector_scale(v : MlclusterkmeansVector, s : Double) -> MlclusterkmeansVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_kmeans_vector_dot(a : MlclusterkmeansVector, b : MlclusterkmeansVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_kmeans_vector_norm(v : MlclusterkmeansVector) -> Double { @_common.sqrt(ml_cluster_kmeans_vector_dot(v, v)) }

pub fn ml_cluster_kmeans_vector_normalize(v : MlclusterkmeansVector) -> MlclusterkmeansVector {
  let n = ml_cluster_kmeans_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_kmeans_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_kmeans_vector_dist(a : MlclusterkmeansVector, b : MlclusterkmeansVector) -> Double {
  ml_cluster_kmeans_vector_norm(ml_cluster_kmeans_vector_sub(a, b))
}

pub fn ml_cluster_kmeans_vector_to_string(v : MlclusterkmeansVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_kmeans_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_kmeans_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_kmeans_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_kmeans_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_kmeans_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_kmeans_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_kmeans_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_kmeans_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_kmeans_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_kmeans_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_kmeans_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_kmeans_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_kmeans_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_kmeans_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_kmeans_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_kmeans_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_kmeans_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_kmeans_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_kmeans_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_kmeans_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_kmeans_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_kmeans_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_kmeans_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_kmeans_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_kmeans_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_kmeans_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_kmeans_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_kmeans_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_kmeans_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterkmeansFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_frame_make(size : Int) -> MlclusterkmeansFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_frame_len(s : MlclusterkmeansFrame) -> Int { s.size }

pub fn ml_cluster_kmeans_frame_get(s : MlclusterkmeansFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_frame_set(s : MlclusterkmeansFrame, i : Int, v : Double) -> MlclusterkmeansFrame {
  let result = ml_cluster_kmeans_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_frame_sum(s : MlclusterkmeansFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_frame_mean(s : MlclusterkmeansFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_frame_scale(s : MlclusterkmeansFrame, f : Double) -> MlclusterkmeansFrame {
  let result = ml_cluster_kmeans_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_frame_add(a : MlclusterkmeansFrame, b : MlclusterkmeansFrame) -> MlclusterkmeansFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_frame_copy(s : MlclusterkmeansFrame) -> MlclusterkmeansFrame {
  let result = ml_cluster_kmeans_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_frame_fill(s : MlclusterkmeansFrame, v : Double) -> MlclusterkmeansFrame {
  let result = ml_cluster_kmeans_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_frame_min(s : MlclusterkmeansFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_frame_max(s : MlclusterkmeansFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_frame_to_string(s : MlclusterkmeansFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_table_make(size : Int) -> MlclusterkmeansTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_table_len(s : MlclusterkmeansTable) -> Int { s.size }

pub fn ml_cluster_kmeans_table_get(s : MlclusterkmeansTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_table_set(s : MlclusterkmeansTable, i : Int, v : Double) -> MlclusterkmeansTable {
  let result = ml_cluster_kmeans_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_table_sum(s : MlclusterkmeansTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_table_mean(s : MlclusterkmeansTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_table_scale(s : MlclusterkmeansTable, f : Double) -> MlclusterkmeansTable {
  let result = ml_cluster_kmeans_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_table_add(a : MlclusterkmeansTable, b : MlclusterkmeansTable) -> MlclusterkmeansTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_table_copy(s : MlclusterkmeansTable) -> MlclusterkmeansTable {
  let result = ml_cluster_kmeans_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_table_fill(s : MlclusterkmeansTable, v : Double) -> MlclusterkmeansTable {
  let result = ml_cluster_kmeans_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_table_min(s : MlclusterkmeansTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_table_max(s : MlclusterkmeansTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_table_to_string(s : MlclusterkmeansTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_graphn_make(size : Int) -> MlclusterkmeansGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_graphn_len(s : MlclusterkmeansGraphN) -> Int { s.size }

pub fn ml_cluster_kmeans_graphn_get(s : MlclusterkmeansGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_graphn_set(s : MlclusterkmeansGraphN, i : Int, v : Double) -> MlclusterkmeansGraphN {
  let result = ml_cluster_kmeans_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_graphn_sum(s : MlclusterkmeansGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_graphn_mean(s : MlclusterkmeansGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_graphn_scale(s : MlclusterkmeansGraphN, f : Double) -> MlclusterkmeansGraphN {
  let result = ml_cluster_kmeans_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_graphn_add(a : MlclusterkmeansGraphN, b : MlclusterkmeansGraphN) -> MlclusterkmeansGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_graphn_copy(s : MlclusterkmeansGraphN) -> MlclusterkmeansGraphN {
  let result = ml_cluster_kmeans_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_graphn_fill(s : MlclusterkmeansGraphN, v : Double) -> MlclusterkmeansGraphN {
  let result = ml_cluster_kmeans_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_graphn_min(s : MlclusterkmeansGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_graphn_max(s : MlclusterkmeansGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_graphn_to_string(s : MlclusterkmeansGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_node_make(size : Int) -> MlclusterkmeansNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_node_len(s : MlclusterkmeansNode) -> Int { s.size }

pub fn ml_cluster_kmeans_node_get(s : MlclusterkmeansNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_node_set(s : MlclusterkmeansNode, i : Int, v : Double) -> MlclusterkmeansNode {
  let result = ml_cluster_kmeans_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_node_sum(s : MlclusterkmeansNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_node_mean(s : MlclusterkmeansNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_node_scale(s : MlclusterkmeansNode, f : Double) -> MlclusterkmeansNode {
  let result = ml_cluster_kmeans_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_node_add(a : MlclusterkmeansNode, b : MlclusterkmeansNode) -> MlclusterkmeansNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_node_copy(s : MlclusterkmeansNode) -> MlclusterkmeansNode {
  let result = ml_cluster_kmeans_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_node_fill(s : MlclusterkmeansNode, v : Double) -> MlclusterkmeansNode {
  let result = ml_cluster_kmeans_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_node_min(s : MlclusterkmeansNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_node_max(s : MlclusterkmeansNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_node_to_string(s : MlclusterkmeansNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_edge_make(size : Int) -> MlclusterkmeansEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_edge_len(s : MlclusterkmeansEdge) -> Int { s.size }

pub fn ml_cluster_kmeans_edge_get(s : MlclusterkmeansEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_edge_set(s : MlclusterkmeansEdge, i : Int, v : Double) -> MlclusterkmeansEdge {
  let result = ml_cluster_kmeans_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_edge_sum(s : MlclusterkmeansEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_edge_mean(s : MlclusterkmeansEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_edge_scale(s : MlclusterkmeansEdge, f : Double) -> MlclusterkmeansEdge {
  let result = ml_cluster_kmeans_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_edge_add(a : MlclusterkmeansEdge, b : MlclusterkmeansEdge) -> MlclusterkmeansEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_edge_copy(s : MlclusterkmeansEdge) -> MlclusterkmeansEdge {
  let result = ml_cluster_kmeans_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_edge_fill(s : MlclusterkmeansEdge, v : Double) -> MlclusterkmeansEdge {
  let result = ml_cluster_kmeans_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_edge_min(s : MlclusterkmeansEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_edge_max(s : MlclusterkmeansEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_edge_to_string(s : MlclusterkmeansEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_path_make(size : Int) -> MlclusterkmeansPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_path_len(s : MlclusterkmeansPath) -> Int { s.size }

pub fn ml_cluster_kmeans_path_get(s : MlclusterkmeansPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_path_set(s : MlclusterkmeansPath, i : Int, v : Double) -> MlclusterkmeansPath {
  let result = ml_cluster_kmeans_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_path_sum(s : MlclusterkmeansPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_path_mean(s : MlclusterkmeansPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_path_scale(s : MlclusterkmeansPath, f : Double) -> MlclusterkmeansPath {
  let result = ml_cluster_kmeans_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_path_add(a : MlclusterkmeansPath, b : MlclusterkmeansPath) -> MlclusterkmeansPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_path_copy(s : MlclusterkmeansPath) -> MlclusterkmeansPath {
  let result = ml_cluster_kmeans_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_path_fill(s : MlclusterkmeansPath, v : Double) -> MlclusterkmeansPath {
  let result = ml_cluster_kmeans_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_path_min(s : MlclusterkmeansPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_path_max(s : MlclusterkmeansPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_path_to_string(s : MlclusterkmeansPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_cluster_make(size : Int) -> MlclusterkmeansCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_cluster_len(s : MlclusterkmeansCluster) -> Int { s.size }

pub fn ml_cluster_kmeans_cluster_get(s : MlclusterkmeansCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_cluster_set(s : MlclusterkmeansCluster, i : Int, v : Double) -> MlclusterkmeansCluster {
  let result = ml_cluster_kmeans_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_cluster_sum(s : MlclusterkmeansCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_cluster_mean(s : MlclusterkmeansCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_cluster_scale(s : MlclusterkmeansCluster, f : Double) -> MlclusterkmeansCluster {
  let result = ml_cluster_kmeans_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_cluster_add(a : MlclusterkmeansCluster, b : MlclusterkmeansCluster) -> MlclusterkmeansCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_cluster_copy(s : MlclusterkmeansCluster) -> MlclusterkmeansCluster {
  let result = ml_cluster_kmeans_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_cluster_fill(s : MlclusterkmeansCluster, v : Double) -> MlclusterkmeansCluster {
  let result = ml_cluster_kmeans_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_cluster_min(s : MlclusterkmeansCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_cluster_max(s : MlclusterkmeansCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_cluster_to_string(s : MlclusterkmeansCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_model_make(size : Int) -> MlclusterkmeansModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_model_len(s : MlclusterkmeansModel) -> Int { s.size }

pub fn ml_cluster_kmeans_model_get(s : MlclusterkmeansModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_model_set(s : MlclusterkmeansModel, i : Int, v : Double) -> MlclusterkmeansModel {
  let result = ml_cluster_kmeans_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_model_sum(s : MlclusterkmeansModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_model_mean(s : MlclusterkmeansModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_model_scale(s : MlclusterkmeansModel, f : Double) -> MlclusterkmeansModel {
  let result = ml_cluster_kmeans_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_model_add(a : MlclusterkmeansModel, b : MlclusterkmeansModel) -> MlclusterkmeansModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_model_copy(s : MlclusterkmeansModel) -> MlclusterkmeansModel {
  let result = ml_cluster_kmeans_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_model_fill(s : MlclusterkmeansModel, v : Double) -> MlclusterkmeansModel {
  let result = ml_cluster_kmeans_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_model_min(s : MlclusterkmeansModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_model_max(s : MlclusterkmeansModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_model_to_string(s : MlclusterkmeansModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_layer_make(size : Int) -> MlclusterkmeansLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_layer_len(s : MlclusterkmeansLayer) -> Int { s.size }

pub fn ml_cluster_kmeans_layer_get(s : MlclusterkmeansLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_layer_set(s : MlclusterkmeansLayer, i : Int, v : Double) -> MlclusterkmeansLayer {
  let result = ml_cluster_kmeans_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_layer_sum(s : MlclusterkmeansLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_layer_mean(s : MlclusterkmeansLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_layer_scale(s : MlclusterkmeansLayer, f : Double) -> MlclusterkmeansLayer {
  let result = ml_cluster_kmeans_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_layer_add(a : MlclusterkmeansLayer, b : MlclusterkmeansLayer) -> MlclusterkmeansLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_layer_copy(s : MlclusterkmeansLayer) -> MlclusterkmeansLayer {
  let result = ml_cluster_kmeans_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_layer_fill(s : MlclusterkmeansLayer, v : Double) -> MlclusterkmeansLayer {
  let result = ml_cluster_kmeans_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_layer_min(s : MlclusterkmeansLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_layer_max(s : MlclusterkmeansLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_layer_to_string(s : MlclusterkmeansLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_buffer_make(size : Int) -> MlclusterkmeansBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_buffer_len(s : MlclusterkmeansBuffer) -> Int { s.size }

pub fn ml_cluster_kmeans_buffer_get(s : MlclusterkmeansBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_buffer_set(s : MlclusterkmeansBuffer, i : Int, v : Double) -> MlclusterkmeansBuffer {
  let result = ml_cluster_kmeans_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_buffer_sum(s : MlclusterkmeansBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_buffer_mean(s : MlclusterkmeansBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_buffer_scale(s : MlclusterkmeansBuffer, f : Double) -> MlclusterkmeansBuffer {
  let result = ml_cluster_kmeans_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_buffer_add(a : MlclusterkmeansBuffer, b : MlclusterkmeansBuffer) -> MlclusterkmeansBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_buffer_copy(s : MlclusterkmeansBuffer) -> MlclusterkmeansBuffer {
  let result = ml_cluster_kmeans_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_buffer_fill(s : MlclusterkmeansBuffer, v : Double) -> MlclusterkmeansBuffer {
  let result = ml_cluster_kmeans_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_buffer_min(s : MlclusterkmeansBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_buffer_max(s : MlclusterkmeansBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_buffer_to_string(s : MlclusterkmeansBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_cursor_make(size : Int) -> MlclusterkmeansCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_cursor_len(s : MlclusterkmeansCursor) -> Int { s.size }

pub fn ml_cluster_kmeans_cursor_get(s : MlclusterkmeansCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_cursor_set(s : MlclusterkmeansCursor, i : Int, v : Double) -> MlclusterkmeansCursor {
  let result = ml_cluster_kmeans_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_cursor_sum(s : MlclusterkmeansCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_cursor_mean(s : MlclusterkmeansCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_cursor_scale(s : MlclusterkmeansCursor, f : Double) -> MlclusterkmeansCursor {
  let result = ml_cluster_kmeans_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_cursor_add(a : MlclusterkmeansCursor, b : MlclusterkmeansCursor) -> MlclusterkmeansCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_cursor_copy(s : MlclusterkmeansCursor) -> MlclusterkmeansCursor {
  let result = ml_cluster_kmeans_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_cursor_fill(s : MlclusterkmeansCursor, v : Double) -> MlclusterkmeansCursor {
  let result = ml_cluster_kmeans_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_cursor_min(s : MlclusterkmeansCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_cursor_max(s : MlclusterkmeansCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_cursor_to_string(s : MlclusterkmeansCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_view_make(size : Int) -> MlclusterkmeansView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_view_len(s : MlclusterkmeansView) -> Int { s.size }

pub fn ml_cluster_kmeans_view_get(s : MlclusterkmeansView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_view_set(s : MlclusterkmeansView, i : Int, v : Double) -> MlclusterkmeansView {
  let result = ml_cluster_kmeans_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_view_sum(s : MlclusterkmeansView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_view_mean(s : MlclusterkmeansView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_view_scale(s : MlclusterkmeansView, f : Double) -> MlclusterkmeansView {
  let result = ml_cluster_kmeans_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_view_add(a : MlclusterkmeansView, b : MlclusterkmeansView) -> MlclusterkmeansView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_view_copy(s : MlclusterkmeansView) -> MlclusterkmeansView {
  let result = ml_cluster_kmeans_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_view_fill(s : MlclusterkmeansView, v : Double) -> MlclusterkmeansView {
  let result = ml_cluster_kmeans_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_view_min(s : MlclusterkmeansView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_view_max(s : MlclusterkmeansView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_view_to_string(s : MlclusterkmeansView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_range_make(size : Int) -> MlclusterkmeansRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_range_len(s : MlclusterkmeansRange) -> Int { s.size }

pub fn ml_cluster_kmeans_range_get(s : MlclusterkmeansRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_range_set(s : MlclusterkmeansRange, i : Int, v : Double) -> MlclusterkmeansRange {
  let result = ml_cluster_kmeans_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_range_sum(s : MlclusterkmeansRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_range_mean(s : MlclusterkmeansRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_range_scale(s : MlclusterkmeansRange, f : Double) -> MlclusterkmeansRange {
  let result = ml_cluster_kmeans_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_range_add(a : MlclusterkmeansRange, b : MlclusterkmeansRange) -> MlclusterkmeansRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_range_copy(s : MlclusterkmeansRange) -> MlclusterkmeansRange {
  let result = ml_cluster_kmeans_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_range_fill(s : MlclusterkmeansRange, v : Double) -> MlclusterkmeansRange {
  let result = ml_cluster_kmeans_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_range_min(s : MlclusterkmeansRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_range_max(s : MlclusterkmeansRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_range_to_string(s : MlclusterkmeansRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterkmeansSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_kmeans_slice_make(size : Int) -> MlclusterkmeansSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_kmeans_slice_len(s : MlclusterkmeansSlice) -> Int { s.size }

pub fn ml_cluster_kmeans_slice_get(s : MlclusterkmeansSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_kmeans_slice_set(s : MlclusterkmeansSlice, i : Int, v : Double) -> MlclusterkmeansSlice {
  let result = ml_cluster_kmeans_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_slice_sum(s : MlclusterkmeansSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_kmeans_slice_mean(s : MlclusterkmeansSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_kmeans_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_kmeans_slice_scale(s : MlclusterkmeansSlice, f : Double) -> MlclusterkmeansSlice {
  let result = ml_cluster_kmeans_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_kmeans_slice_add(a : MlclusterkmeansSlice, b : MlclusterkmeansSlice) -> MlclusterkmeansSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_kmeans_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_kmeans_slice_copy(s : MlclusterkmeansSlice) -> MlclusterkmeansSlice {
  let result = ml_cluster_kmeans_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_kmeans_slice_fill(s : MlclusterkmeansSlice, v : Double) -> MlclusterkmeansSlice {
  let result = ml_cluster_kmeans_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_kmeans_slice_min(s : MlclusterkmeansSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_slice_max(s : MlclusterkmeansSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_kmeans_slice_to_string(s : MlclusterkmeansSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/ds_hash_robin

pub(all) struct DshashrobinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_robin_make_point(x : Double, y : Double) -> DshashrobinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_robin_make_point3(x : Double, y : Double, z : Double) -> DshashrobinPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_robin_point_x(pt : DshashrobinPoint) -> Double { pt.x }

pub fn ds_hash_robin_point_y(pt : DshashrobinPoint) -> Double { pt.y }

pub fn ds_hash_robin_point_z(pt : DshashrobinPoint) -> Double { pt.z }

pub fn ds_hash_robin_point_label(pt : DshashrobinPoint) -> Int { pt.label }

pub fn ds_hash_robin_point_dist(a : DshashrobinPoint, b : DshashrobinPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_robin_point_add(a : DshashrobinPoint, b : DshashrobinPoint) -> DshashrobinPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_robin_point_sub(a : DshashrobinPoint, b : DshashrobinPoint) -> DshashrobinPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_robin_point_scale(pt : DshashrobinPoint, s : Double) -> DshashrobinPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_robin_point_dot(a : DshashrobinPoint, b : DshashrobinPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_robin_point_cross(a : DshashrobinPoint, b : DshashrobinPoint) -> DshashrobinPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_robin_point_norm(pt : DshashrobinPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_robin_point_normalize(pt : DshashrobinPoint) -> DshashrobinPoint {
  let n = ds_hash_robin_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_robin_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_robin_point_negate(pt : DshashrobinPoint) -> DshashrobinPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_robin_point_mid(a : DshashrobinPoint, b : DshashrobinPoint) -> DshashrobinPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_robin_point_lerp(a : DshashrobinPoint, b : DshashrobinPoint, t : Double) -> DshashrobinPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_robin_point_to_string(pt : DshashrobinPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashrobinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_robin_make_series(vals : Array[Double], name : String) -> DshashrobinSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_robin_series_len(s : DshashrobinSeries) -> Int { s.vals.length() }

pub fn ds_hash_robin_series_sum(s : DshashrobinSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_robin_series_mean(s : DshashrobinSeries) -> Double {
  let n = ds_hash_robin_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_robin_series_sum(s) / n.to_double() }
}

pub fn ds_hash_robin_series_min(s : DshashrobinSeries) -> Double {
  let n = ds_hash_robin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_robin_series_max(s : DshashrobinSeries) -> Double {
  let n = ds_hash_robin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_robin_series_range(s : DshashrobinSeries) -> Double {
  ds_hash_robin_series_max(s) - ds_hash_robin_series_min(s)
}

pub fn ds_hash_robin_series_var(s : DshashrobinSeries) -> Double {
  let n = ds_hash_robin_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_robin_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_robin_series_std(s : DshashrobinSeries) -> Double { @_common.sqrt(ds_hash_robin_series_var(s)) }

pub fn ds_hash_robin_series_median(s : DshashrobinSeries) -> Double {
  let n = ds_hash_robin_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_robin_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_robin_series_scale(s : DshashrobinSeries, f : Double) -> DshashrobinSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_robin_series_add(a : DshashrobinSeries, b : DshashrobinSeries) -> DshashrobinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_robin_series_sub(a : DshashrobinSeries, b : DshashrobinSeries) -> DshashrobinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_robin_series_normalize(s : DshashrobinSeries) -> DshashrobinSeries {
  let mn = ds_hash_robin_series_min(s)
  let mx = ds_hash_robin_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_robin_series_cumsum(s : DshashrobinSeries) -> DshashrobinSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_robin_series_to_string(s : DshashrobinSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashrobinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_robin_make_matrix(rows : Int, cols : Int, val : Double) -> DshashrobinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_robin_matrix_identity(n : Int) -> DshashrobinMatrix {
  let m = ds_hash_robin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_robin_matrix_get(m : DshashrobinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_robin_matrix_transpose(m : DshashrobinMatrix) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_robin_matrix_add(a : DshashrobinMatrix, b : DshashrobinMatrix) -> DshashrobinMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_robin_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_robin_matrix_scale(m : DshashrobinMatrix, s : Double) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_robin_matrix_multiply(a : DshashrobinMatrix, b : DshashrobinMatrix) -> DshashrobinMatrix {
  if a.cols != b.rows { return ds_hash_robin_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_robin_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_robin_matrix_trace(m : DshashrobinMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_robin_matrix_det(m : DshashrobinMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_robin_matrix_norm(m : DshashrobinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_robin_matrix_to_string(m : DshashrobinMatrix) -> String {
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

pub(all) struct DshashrobinVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_robin_make_vector(comps : Array[Double]) -> DshashrobinVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_robin_vector_zero(dim : Int) -> DshashrobinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_robin_vector_add(a : DshashrobinVector, b : DshashrobinVector) -> DshashrobinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_robin_vector_sub(a : DshashrobinVector, b : DshashrobinVector) -> DshashrobinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_robin_vector_scale(v : DshashrobinVector, s : Double) -> DshashrobinVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_robin_vector_dot(a : DshashrobinVector, b : DshashrobinVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_robin_vector_norm(v : DshashrobinVector) -> Double { @_common.sqrt(ds_hash_robin_vector_dot(v, v)) }

pub fn ds_hash_robin_vector_normalize(v : DshashrobinVector) -> DshashrobinVector {
  let n = ds_hash_robin_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_robin_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_robin_vector_dist(a : DshashrobinVector, b : DshashrobinVector) -> Double {
  ds_hash_robin_vector_norm(ds_hash_robin_vector_sub(a, b))
}

pub fn ds_hash_robin_vector_to_string(v : DshashrobinVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_robin_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_robin_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_robin_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_robin_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_robin_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_robin_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_robin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_robin_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_robin_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_robin_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_robin_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_robin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_robin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_robin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_robin_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_robin_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_robin_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_robin_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_robin_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_robin_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_robin_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_robin_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_robin_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_robin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_robin_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_robin_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_robin_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_robin_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_robin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashrobinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_frame_make(size : Int) -> DshashrobinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_frame_len(s : DshashrobinFrame) -> Int { s.size }

pub fn ds_hash_robin_frame_get(s : DshashrobinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_frame_set(s : DshashrobinFrame, i : Int, v : Double) -> DshashrobinFrame {
  let result = ds_hash_robin_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_frame_sum(s : DshashrobinFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_frame_mean(s : DshashrobinFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_frame_scale(s : DshashrobinFrame, f : Double) -> DshashrobinFrame {
  let result = ds_hash_robin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_frame_add(a : DshashrobinFrame, b : DshashrobinFrame) -> DshashrobinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_frame_copy(s : DshashrobinFrame) -> DshashrobinFrame {
  let result = ds_hash_robin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_frame_fill(s : DshashrobinFrame, v : Double) -> DshashrobinFrame {
  let result = ds_hash_robin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_frame_min(s : DshashrobinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_frame_max(s : DshashrobinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_frame_to_string(s : DshashrobinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_table_make(size : Int) -> DshashrobinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_table_len(s : DshashrobinTable) -> Int { s.size }

pub fn ds_hash_robin_table_get(s : DshashrobinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_table_set(s : DshashrobinTable, i : Int, v : Double) -> DshashrobinTable {
  let result = ds_hash_robin_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_table_sum(s : DshashrobinTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_table_mean(s : DshashrobinTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_table_scale(s : DshashrobinTable, f : Double) -> DshashrobinTable {
  let result = ds_hash_robin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_table_add(a : DshashrobinTable, b : DshashrobinTable) -> DshashrobinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_table_copy(s : DshashrobinTable) -> DshashrobinTable {
  let result = ds_hash_robin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_table_fill(s : DshashrobinTable, v : Double) -> DshashrobinTable {
  let result = ds_hash_robin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_table_min(s : DshashrobinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_table_max(s : DshashrobinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_table_to_string(s : DshashrobinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_graphn_make(size : Int) -> DshashrobinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_graphn_len(s : DshashrobinGraphN) -> Int { s.size }

pub fn ds_hash_robin_graphn_get(s : DshashrobinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_graphn_set(s : DshashrobinGraphN, i : Int, v : Double) -> DshashrobinGraphN {
  let result = ds_hash_robin_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_graphn_sum(s : DshashrobinGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_graphn_mean(s : DshashrobinGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_graphn_scale(s : DshashrobinGraphN, f : Double) -> DshashrobinGraphN {
  let result = ds_hash_robin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_graphn_add(a : DshashrobinGraphN, b : DshashrobinGraphN) -> DshashrobinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_graphn_copy(s : DshashrobinGraphN) -> DshashrobinGraphN {
  let result = ds_hash_robin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_graphn_fill(s : DshashrobinGraphN, v : Double) -> DshashrobinGraphN {
  let result = ds_hash_robin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_graphn_min(s : DshashrobinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_graphn_max(s : DshashrobinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_graphn_to_string(s : DshashrobinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_node_make(size : Int) -> DshashrobinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_node_len(s : DshashrobinNode) -> Int { s.size }

pub fn ds_hash_robin_node_get(s : DshashrobinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_node_set(s : DshashrobinNode, i : Int, v : Double) -> DshashrobinNode {
  let result = ds_hash_robin_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_node_sum(s : DshashrobinNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_node_mean(s : DshashrobinNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_node_scale(s : DshashrobinNode, f : Double) -> DshashrobinNode {
  let result = ds_hash_robin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_node_add(a : DshashrobinNode, b : DshashrobinNode) -> DshashrobinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_node_copy(s : DshashrobinNode) -> DshashrobinNode {
  let result = ds_hash_robin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_node_fill(s : DshashrobinNode, v : Double) -> DshashrobinNode {
  let result = ds_hash_robin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_node_min(s : DshashrobinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_node_max(s : DshashrobinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_node_to_string(s : DshashrobinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_edge_make(size : Int) -> DshashrobinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_edge_len(s : DshashrobinEdge) -> Int { s.size }

pub fn ds_hash_robin_edge_get(s : DshashrobinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_edge_set(s : DshashrobinEdge, i : Int, v : Double) -> DshashrobinEdge {
  let result = ds_hash_robin_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_edge_sum(s : DshashrobinEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_edge_mean(s : DshashrobinEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_edge_scale(s : DshashrobinEdge, f : Double) -> DshashrobinEdge {
  let result = ds_hash_robin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_edge_add(a : DshashrobinEdge, b : DshashrobinEdge) -> DshashrobinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_edge_copy(s : DshashrobinEdge) -> DshashrobinEdge {
  let result = ds_hash_robin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_edge_fill(s : DshashrobinEdge, v : Double) -> DshashrobinEdge {
  let result = ds_hash_robin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_edge_min(s : DshashrobinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_edge_max(s : DshashrobinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_edge_to_string(s : DshashrobinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_path_make(size : Int) -> DshashrobinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_path_len(s : DshashrobinPath) -> Int { s.size }

pub fn ds_hash_robin_path_get(s : DshashrobinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_path_set(s : DshashrobinPath, i : Int, v : Double) -> DshashrobinPath {
  let result = ds_hash_robin_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_path_sum(s : DshashrobinPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_path_mean(s : DshashrobinPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_path_scale(s : DshashrobinPath, f : Double) -> DshashrobinPath {
  let result = ds_hash_robin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_path_add(a : DshashrobinPath, b : DshashrobinPath) -> DshashrobinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_path_copy(s : DshashrobinPath) -> DshashrobinPath {
  let result = ds_hash_robin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_path_fill(s : DshashrobinPath, v : Double) -> DshashrobinPath {
  let result = ds_hash_robin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_path_min(s : DshashrobinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_path_max(s : DshashrobinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_path_to_string(s : DshashrobinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cluster_make(size : Int) -> DshashrobinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_cluster_len(s : DshashrobinCluster) -> Int { s.size }

pub fn ds_hash_robin_cluster_get(s : DshashrobinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_cluster_set(s : DshashrobinCluster, i : Int, v : Double) -> DshashrobinCluster {
  let result = ds_hash_robin_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_cluster_sum(s : DshashrobinCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_cluster_mean(s : DshashrobinCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_cluster_scale(s : DshashrobinCluster, f : Double) -> DshashrobinCluster {
  let result = ds_hash_robin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_cluster_add(a : DshashrobinCluster, b : DshashrobinCluster) -> DshashrobinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_cluster_copy(s : DshashrobinCluster) -> DshashrobinCluster {
  let result = ds_hash_robin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_cluster_fill(s : DshashrobinCluster, v : Double) -> DshashrobinCluster {
  let result = ds_hash_robin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_cluster_min(s : DshashrobinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_cluster_max(s : DshashrobinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_cluster_to_string(s : DshashrobinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_model_make(size : Int) -> DshashrobinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_model_len(s : DshashrobinModel) -> Int { s.size }

pub fn ds_hash_robin_model_get(s : DshashrobinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_model_set(s : DshashrobinModel, i : Int, v : Double) -> DshashrobinModel {
  let result = ds_hash_robin_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_model_sum(s : DshashrobinModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_model_mean(s : DshashrobinModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_model_scale(s : DshashrobinModel, f : Double) -> DshashrobinModel {
  let result = ds_hash_robin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_model_add(a : DshashrobinModel, b : DshashrobinModel) -> DshashrobinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_model_copy(s : DshashrobinModel) -> DshashrobinModel {
  let result = ds_hash_robin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_model_fill(s : DshashrobinModel, v : Double) -> DshashrobinModel {
  let result = ds_hash_robin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_model_min(s : DshashrobinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_model_max(s : DshashrobinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_model_to_string(s : DshashrobinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_layer_make(size : Int) -> DshashrobinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_layer_len(s : DshashrobinLayer) -> Int { s.size }

pub fn ds_hash_robin_layer_get(s : DshashrobinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_layer_set(s : DshashrobinLayer, i : Int, v : Double) -> DshashrobinLayer {
  let result = ds_hash_robin_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_layer_sum(s : DshashrobinLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_layer_mean(s : DshashrobinLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_layer_scale(s : DshashrobinLayer, f : Double) -> DshashrobinLayer {
  let result = ds_hash_robin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_layer_add(a : DshashrobinLayer, b : DshashrobinLayer) -> DshashrobinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_layer_copy(s : DshashrobinLayer) -> DshashrobinLayer {
  let result = ds_hash_robin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_layer_fill(s : DshashrobinLayer, v : Double) -> DshashrobinLayer {
  let result = ds_hash_robin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_layer_min(s : DshashrobinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_layer_max(s : DshashrobinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_layer_to_string(s : DshashrobinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_buffer_make(size : Int) -> DshashrobinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_buffer_len(s : DshashrobinBuffer) -> Int { s.size }

pub fn ds_hash_robin_buffer_get(s : DshashrobinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_buffer_set(s : DshashrobinBuffer, i : Int, v : Double) -> DshashrobinBuffer {
  let result = ds_hash_robin_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_buffer_sum(s : DshashrobinBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_buffer_mean(s : DshashrobinBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_buffer_scale(s : DshashrobinBuffer, f : Double) -> DshashrobinBuffer {
  let result = ds_hash_robin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_buffer_add(a : DshashrobinBuffer, b : DshashrobinBuffer) -> DshashrobinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_buffer_copy(s : DshashrobinBuffer) -> DshashrobinBuffer {
  let result = ds_hash_robin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_buffer_fill(s : DshashrobinBuffer, v : Double) -> DshashrobinBuffer {
  let result = ds_hash_robin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_buffer_min(s : DshashrobinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_buffer_max(s : DshashrobinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_buffer_to_string(s : DshashrobinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cursor_make(size : Int) -> DshashrobinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_cursor_len(s : DshashrobinCursor) -> Int { s.size }

pub fn ds_hash_robin_cursor_get(s : DshashrobinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_cursor_set(s : DshashrobinCursor, i : Int, v : Double) -> DshashrobinCursor {
  let result = ds_hash_robin_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_cursor_sum(s : DshashrobinCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_cursor_mean(s : DshashrobinCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_cursor_scale(s : DshashrobinCursor, f : Double) -> DshashrobinCursor {
  let result = ds_hash_robin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_cursor_add(a : DshashrobinCursor, b : DshashrobinCursor) -> DshashrobinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_cursor_copy(s : DshashrobinCursor) -> DshashrobinCursor {
  let result = ds_hash_robin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_cursor_fill(s : DshashrobinCursor, v : Double) -> DshashrobinCursor {
  let result = ds_hash_robin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_cursor_min(s : DshashrobinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_cursor_max(s : DshashrobinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_cursor_to_string(s : DshashrobinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_view_make(size : Int) -> DshashrobinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_view_len(s : DshashrobinView) -> Int { s.size }

pub fn ds_hash_robin_view_get(s : DshashrobinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_view_set(s : DshashrobinView, i : Int, v : Double) -> DshashrobinView {
  let result = ds_hash_robin_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_view_sum(s : DshashrobinView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_view_mean(s : DshashrobinView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_view_scale(s : DshashrobinView, f : Double) -> DshashrobinView {
  let result = ds_hash_robin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_view_add(a : DshashrobinView, b : DshashrobinView) -> DshashrobinView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_view_copy(s : DshashrobinView) -> DshashrobinView {
  let result = ds_hash_robin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_view_fill(s : DshashrobinView, v : Double) -> DshashrobinView {
  let result = ds_hash_robin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_view_min(s : DshashrobinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_view_max(s : DshashrobinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_view_to_string(s : DshashrobinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_range_make(size : Int) -> DshashrobinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_range_len(s : DshashrobinRange) -> Int { s.size }

pub fn ds_hash_robin_range_get(s : DshashrobinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_range_set(s : DshashrobinRange, i : Int, v : Double) -> DshashrobinRange {
  let result = ds_hash_robin_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_range_sum(s : DshashrobinRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_range_mean(s : DshashrobinRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_range_scale(s : DshashrobinRange, f : Double) -> DshashrobinRange {
  let result = ds_hash_robin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_range_add(a : DshashrobinRange, b : DshashrobinRange) -> DshashrobinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_range_copy(s : DshashrobinRange) -> DshashrobinRange {
  let result = ds_hash_robin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_range_fill(s : DshashrobinRange, v : Double) -> DshashrobinRange {
  let result = ds_hash_robin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_range_min(s : DshashrobinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_range_max(s : DshashrobinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_range_to_string(s : DshashrobinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_slice_make(size : Int) -> DshashrobinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_slice_len(s : DshashrobinSlice) -> Int { s.size }

pub fn ds_hash_robin_slice_get(s : DshashrobinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_slice_set(s : DshashrobinSlice, i : Int, v : Double) -> DshashrobinSlice {
  let result = ds_hash_robin_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_slice_sum(s : DshashrobinSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_robin_slice_mean(s : DshashrobinSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_robin_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_robin_slice_scale(s : DshashrobinSlice, f : Double) -> DshashrobinSlice {
  let result = ds_hash_robin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_robin_slice_add(a : DshashrobinSlice, b : DshashrobinSlice) -> DshashrobinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_robin_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_robin_slice_copy(s : DshashrobinSlice) -> DshashrobinSlice {
  let result = ds_hash_robin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_robin_slice_fill(s : DshashrobinSlice, v : Double) -> DshashrobinSlice {
  let result = ds_hash_robin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_robin_slice_min(s : DshashrobinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_slice_max(s : DshashrobinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_robin_slice_to_string(s : DshashrobinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


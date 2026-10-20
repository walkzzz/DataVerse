///===
/// extcore/opt_convex_sr1

pub(all) struct Optconvexsr1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_sr1_make_point(x : Double, y : Double) -> Optconvexsr1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_sr1_make_point3(x : Double, y : Double, z : Double) -> Optconvexsr1Point {
  { x, y, z, label: 0 }
}

pub fn opt_convex_sr1_point_x(pt : Optconvexsr1Point) -> Double { pt.x }

pub fn opt_convex_sr1_point_y(pt : Optconvexsr1Point) -> Double { pt.y }

pub fn opt_convex_sr1_point_z(pt : Optconvexsr1Point) -> Double { pt.z }

pub fn opt_convex_sr1_point_label(pt : Optconvexsr1Point) -> Int { pt.label }

pub fn opt_convex_sr1_point_dist(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_sr1_point_add(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_sr1_point_sub(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_sr1_point_scale(pt : Optconvexsr1Point, s : Double) -> Optconvexsr1Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_sr1_point_dot(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_sr1_point_cross(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_sr1_point_norm(pt : Optconvexsr1Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_sr1_point_normalize(pt : Optconvexsr1Point) -> Optconvexsr1Point {
  let n = opt_convex_sr1_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_sr1_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_sr1_point_negate(pt : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_sr1_point_mid(a : Optconvexsr1Point, b : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_sr1_point_lerp(a : Optconvexsr1Point, b : Optconvexsr1Point, t : Double) -> Optconvexsr1Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_sr1_point_to_string(pt : Optconvexsr1Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Optconvexsr1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_sr1_make_series(vals : Array[Double], name : String) -> Optconvexsr1Series {
  { vals, name, meta: 0 }
}

pub fn opt_convex_sr1_series_len(s : Optconvexsr1Series) -> Int { s.vals.length() }

pub fn opt_convex_sr1_series_sum(s : Optconvexsr1Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_sr1_series_mean(s : Optconvexsr1Series) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_sr1_series_min(s : Optconvexsr1Series) -> Double { @_common.min(s.vals) }

pub fn opt_convex_sr1_series_max(s : Optconvexsr1Series) -> Double { @_common.max(s.vals) }

pub fn opt_convex_sr1_series_range(s : Optconvexsr1Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_sr1_series_var(s : Optconvexsr1Series) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_sr1_series_std(s : Optconvexsr1Series) -> Double { @_common.std(s.vals) }

pub fn opt_convex_sr1_series_median(s : Optconvexsr1Series) -> Double { @_common.median(s.vals) }

pub fn opt_convex_sr1_series_scale(s : Optconvexsr1Series, f : Double) -> Optconvexsr1Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_sr1_series_add(a : Optconvexsr1Series, b : Optconvexsr1Series) -> Optconvexsr1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_sr1_series_sub(a : Optconvexsr1Series, b : Optconvexsr1Series) -> Optconvexsr1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_sr1_series_normalize(s : Optconvexsr1Series) -> Optconvexsr1Series {
  let mn = opt_convex_sr1_series_min(s)
  let mx = opt_convex_sr1_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_sr1_series_cumsum(s : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_sr1_series_to_string(s : Optconvexsr1Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Optconvexsr1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_sr1_make_matrix(rows : Int, cols : Int, val : Double) -> Optconvexsr1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_sr1_matrix_identity(n : Int) -> Optconvexsr1Matrix {
  let m = opt_convex_sr1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_sr1_matrix_get(m : Optconvexsr1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_sr1_matrix_transpose(m : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_sr1_matrix_add(a : Optconvexsr1Matrix, b : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_sr1_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_sr1_matrix_scale(m : Optconvexsr1Matrix, s : Double) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_sr1_matrix_multiply(a : Optconvexsr1Matrix, b : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if a.cols != b.rows { return opt_convex_sr1_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_sr1_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_sr1_matrix_trace(m : Optconvexsr1Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_sr1_matrix_det(m : Optconvexsr1Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_sr1_matrix_norm(m : Optconvexsr1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_sr1_matrix_to_string(m : Optconvexsr1Matrix) -> String {
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

pub(all) struct Optconvexsr1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_sr1_make_vector(comps : Array[Double]) -> Optconvexsr1Vector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_sr1_vector_zero(dim : Int) -> Optconvexsr1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_sr1_vector_add(a : Optconvexsr1Vector, b : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_sr1_vector_sub(a : Optconvexsr1Vector, b : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_sr1_vector_scale(v : Optconvexsr1Vector, s : Double) -> Optconvexsr1Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_sr1_vector_dot(a : Optconvexsr1Vector, b : Optconvexsr1Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_sr1_vector_norm(v : Optconvexsr1Vector) -> Double { @_common.sqrt(opt_convex_sr1_vector_dot(v, v)) }

pub fn opt_convex_sr1_vector_normalize(v : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = opt_convex_sr1_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_sr1_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_sr1_vector_dist(a : Optconvexsr1Vector, b : Optconvexsr1Vector) -> Double {
  opt_convex_sr1_vector_norm(opt_convex_sr1_vector_sub(a, b))
}

pub fn opt_convex_sr1_vector_to_string(v : Optconvexsr1Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_sr1_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_sr1_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_sr1_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_sr1_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_sr1_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_sr1_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_sr1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_sr1_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_sr1_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_sr1_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_sr1_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_sr1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_sr1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_sr1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_sr1_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_sr1_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_sr1_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_sr1_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_sr1_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_sr1_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_sr1_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_sr1_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_sr1_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_sr1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_sr1_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_sr1_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_sr1_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_sr1_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_sr1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Optconvexsr1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_frame_make(size : Int) -> Optconvexsr1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_frame_len(s : Optconvexsr1Frame) -> Int { s.size }

pub fn opt_convex_sr1_frame_get(s : Optconvexsr1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_frame_set(s : Optconvexsr1Frame, i : Int, v : Double) -> Optconvexsr1Frame {
  let result = opt_convex_sr1_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_frame_sum(s : Optconvexsr1Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_frame_mean(s : Optconvexsr1Frame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_frame_scale(s : Optconvexsr1Frame, f : Double) -> Optconvexsr1Frame {
  let result = opt_convex_sr1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_frame_add(a : Optconvexsr1Frame, b : Optconvexsr1Frame) -> Optconvexsr1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_frame_copy(s : Optconvexsr1Frame) -> Optconvexsr1Frame {
  let result = opt_convex_sr1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_frame_fill(s : Optconvexsr1Frame, v : Double) -> Optconvexsr1Frame {
  let result = opt_convex_sr1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_frame_min(s : Optconvexsr1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_frame_max(s : Optconvexsr1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_frame_to_string(s : Optconvexsr1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_table_make(size : Int) -> Optconvexsr1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_table_len(s : Optconvexsr1Table) -> Int { s.size }

pub fn opt_convex_sr1_table_get(s : Optconvexsr1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_table_set(s : Optconvexsr1Table, i : Int, v : Double) -> Optconvexsr1Table {
  let result = opt_convex_sr1_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_table_sum(s : Optconvexsr1Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_table_mean(s : Optconvexsr1Table) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_table_scale(s : Optconvexsr1Table, f : Double) -> Optconvexsr1Table {
  let result = opt_convex_sr1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_table_add(a : Optconvexsr1Table, b : Optconvexsr1Table) -> Optconvexsr1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_table_copy(s : Optconvexsr1Table) -> Optconvexsr1Table {
  let result = opt_convex_sr1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_table_fill(s : Optconvexsr1Table, v : Double) -> Optconvexsr1Table {
  let result = opt_convex_sr1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_table_min(s : Optconvexsr1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_table_max(s : Optconvexsr1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_table_to_string(s : Optconvexsr1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_graphn_make(size : Int) -> Optconvexsr1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_graphn_len(s : Optconvexsr1GraphN) -> Int { s.size }

pub fn opt_convex_sr1_graphn_get(s : Optconvexsr1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_graphn_set(s : Optconvexsr1GraphN, i : Int, v : Double) -> Optconvexsr1GraphN {
  let result = opt_convex_sr1_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_graphn_sum(s : Optconvexsr1GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_graphn_mean(s : Optconvexsr1GraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_graphn_scale(s : Optconvexsr1GraphN, f : Double) -> Optconvexsr1GraphN {
  let result = opt_convex_sr1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_graphn_add(a : Optconvexsr1GraphN, b : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_graphn_copy(s : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  let result = opt_convex_sr1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_graphn_fill(s : Optconvexsr1GraphN, v : Double) -> Optconvexsr1GraphN {
  let result = opt_convex_sr1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_graphn_min(s : Optconvexsr1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_graphn_max(s : Optconvexsr1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_graphn_to_string(s : Optconvexsr1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_node_make(size : Int) -> Optconvexsr1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_node_len(s : Optconvexsr1Node) -> Int { s.size }

pub fn opt_convex_sr1_node_get(s : Optconvexsr1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_node_set(s : Optconvexsr1Node, i : Int, v : Double) -> Optconvexsr1Node {
  let result = opt_convex_sr1_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_node_sum(s : Optconvexsr1Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_node_mean(s : Optconvexsr1Node) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_node_scale(s : Optconvexsr1Node, f : Double) -> Optconvexsr1Node {
  let result = opt_convex_sr1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_node_add(a : Optconvexsr1Node, b : Optconvexsr1Node) -> Optconvexsr1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_node_copy(s : Optconvexsr1Node) -> Optconvexsr1Node {
  let result = opt_convex_sr1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_node_fill(s : Optconvexsr1Node, v : Double) -> Optconvexsr1Node {
  let result = opt_convex_sr1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_node_min(s : Optconvexsr1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_node_max(s : Optconvexsr1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_node_to_string(s : Optconvexsr1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_edge_make(size : Int) -> Optconvexsr1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_edge_len(s : Optconvexsr1Edge) -> Int { s.size }

pub fn opt_convex_sr1_edge_get(s : Optconvexsr1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_edge_set(s : Optconvexsr1Edge, i : Int, v : Double) -> Optconvexsr1Edge {
  let result = opt_convex_sr1_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_edge_sum(s : Optconvexsr1Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_edge_mean(s : Optconvexsr1Edge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_edge_scale(s : Optconvexsr1Edge, f : Double) -> Optconvexsr1Edge {
  let result = opt_convex_sr1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_edge_add(a : Optconvexsr1Edge, b : Optconvexsr1Edge) -> Optconvexsr1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_edge_copy(s : Optconvexsr1Edge) -> Optconvexsr1Edge {
  let result = opt_convex_sr1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_edge_fill(s : Optconvexsr1Edge, v : Double) -> Optconvexsr1Edge {
  let result = opt_convex_sr1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_edge_min(s : Optconvexsr1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_edge_max(s : Optconvexsr1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_edge_to_string(s : Optconvexsr1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_path_make(size : Int) -> Optconvexsr1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_path_len(s : Optconvexsr1Path) -> Int { s.size }

pub fn opt_convex_sr1_path_get(s : Optconvexsr1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_path_set(s : Optconvexsr1Path, i : Int, v : Double) -> Optconvexsr1Path {
  let result = opt_convex_sr1_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_path_sum(s : Optconvexsr1Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_path_mean(s : Optconvexsr1Path) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_path_scale(s : Optconvexsr1Path, f : Double) -> Optconvexsr1Path {
  let result = opt_convex_sr1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_path_add(a : Optconvexsr1Path, b : Optconvexsr1Path) -> Optconvexsr1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_path_copy(s : Optconvexsr1Path) -> Optconvexsr1Path {
  let result = opt_convex_sr1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_path_fill(s : Optconvexsr1Path, v : Double) -> Optconvexsr1Path {
  let result = opt_convex_sr1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_path_min(s : Optconvexsr1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_path_max(s : Optconvexsr1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_path_to_string(s : Optconvexsr1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cluster_make(size : Int) -> Optconvexsr1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_cluster_len(s : Optconvexsr1Cluster) -> Int { s.size }

pub fn opt_convex_sr1_cluster_get(s : Optconvexsr1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_cluster_set(s : Optconvexsr1Cluster, i : Int, v : Double) -> Optconvexsr1Cluster {
  let result = opt_convex_sr1_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_cluster_sum(s : Optconvexsr1Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_cluster_mean(s : Optconvexsr1Cluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_cluster_scale(s : Optconvexsr1Cluster, f : Double) -> Optconvexsr1Cluster {
  let result = opt_convex_sr1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_cluster_add(a : Optconvexsr1Cluster, b : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_cluster_copy(s : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  let result = opt_convex_sr1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_cluster_fill(s : Optconvexsr1Cluster, v : Double) -> Optconvexsr1Cluster {
  let result = opt_convex_sr1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_cluster_min(s : Optconvexsr1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_cluster_max(s : Optconvexsr1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_cluster_to_string(s : Optconvexsr1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_model_make(size : Int) -> Optconvexsr1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_model_len(s : Optconvexsr1Model) -> Int { s.size }

pub fn opt_convex_sr1_model_get(s : Optconvexsr1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_model_set(s : Optconvexsr1Model, i : Int, v : Double) -> Optconvexsr1Model {
  let result = opt_convex_sr1_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_model_sum(s : Optconvexsr1Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_model_mean(s : Optconvexsr1Model) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_model_scale(s : Optconvexsr1Model, f : Double) -> Optconvexsr1Model {
  let result = opt_convex_sr1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_model_add(a : Optconvexsr1Model, b : Optconvexsr1Model) -> Optconvexsr1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_model_copy(s : Optconvexsr1Model) -> Optconvexsr1Model {
  let result = opt_convex_sr1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_model_fill(s : Optconvexsr1Model, v : Double) -> Optconvexsr1Model {
  let result = opt_convex_sr1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_model_min(s : Optconvexsr1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_model_max(s : Optconvexsr1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_model_to_string(s : Optconvexsr1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_layer_make(size : Int) -> Optconvexsr1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_layer_len(s : Optconvexsr1Layer) -> Int { s.size }

pub fn opt_convex_sr1_layer_get(s : Optconvexsr1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_layer_set(s : Optconvexsr1Layer, i : Int, v : Double) -> Optconvexsr1Layer {
  let result = opt_convex_sr1_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_layer_sum(s : Optconvexsr1Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_layer_mean(s : Optconvexsr1Layer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_layer_scale(s : Optconvexsr1Layer, f : Double) -> Optconvexsr1Layer {
  let result = opt_convex_sr1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_layer_add(a : Optconvexsr1Layer, b : Optconvexsr1Layer) -> Optconvexsr1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_layer_copy(s : Optconvexsr1Layer) -> Optconvexsr1Layer {
  let result = opt_convex_sr1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_layer_fill(s : Optconvexsr1Layer, v : Double) -> Optconvexsr1Layer {
  let result = opt_convex_sr1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_layer_min(s : Optconvexsr1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_layer_max(s : Optconvexsr1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_layer_to_string(s : Optconvexsr1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_buffer_make(size : Int) -> Optconvexsr1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_buffer_len(s : Optconvexsr1Buffer) -> Int { s.size }

pub fn opt_convex_sr1_buffer_get(s : Optconvexsr1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_buffer_set(s : Optconvexsr1Buffer, i : Int, v : Double) -> Optconvexsr1Buffer {
  let result = opt_convex_sr1_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_buffer_sum(s : Optconvexsr1Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_buffer_mean(s : Optconvexsr1Buffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_buffer_scale(s : Optconvexsr1Buffer, f : Double) -> Optconvexsr1Buffer {
  let result = opt_convex_sr1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_buffer_add(a : Optconvexsr1Buffer, b : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_buffer_copy(s : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  let result = opt_convex_sr1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_buffer_fill(s : Optconvexsr1Buffer, v : Double) -> Optconvexsr1Buffer {
  let result = opt_convex_sr1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_buffer_min(s : Optconvexsr1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_buffer_max(s : Optconvexsr1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_buffer_to_string(s : Optconvexsr1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cursor_make(size : Int) -> Optconvexsr1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_cursor_len(s : Optconvexsr1Cursor) -> Int { s.size }

pub fn opt_convex_sr1_cursor_get(s : Optconvexsr1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_cursor_set(s : Optconvexsr1Cursor, i : Int, v : Double) -> Optconvexsr1Cursor {
  let result = opt_convex_sr1_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_cursor_sum(s : Optconvexsr1Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_cursor_mean(s : Optconvexsr1Cursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_cursor_scale(s : Optconvexsr1Cursor, f : Double) -> Optconvexsr1Cursor {
  let result = opt_convex_sr1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_cursor_add(a : Optconvexsr1Cursor, b : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_cursor_copy(s : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  let result = opt_convex_sr1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_cursor_fill(s : Optconvexsr1Cursor, v : Double) -> Optconvexsr1Cursor {
  let result = opt_convex_sr1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_cursor_min(s : Optconvexsr1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_cursor_max(s : Optconvexsr1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_cursor_to_string(s : Optconvexsr1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_view_make(size : Int) -> Optconvexsr1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_view_len(s : Optconvexsr1View) -> Int { s.size }

pub fn opt_convex_sr1_view_get(s : Optconvexsr1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_view_set(s : Optconvexsr1View, i : Int, v : Double) -> Optconvexsr1View {
  let result = opt_convex_sr1_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_view_sum(s : Optconvexsr1View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_view_mean(s : Optconvexsr1View) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_view_scale(s : Optconvexsr1View, f : Double) -> Optconvexsr1View {
  let result = opt_convex_sr1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_view_add(a : Optconvexsr1View, b : Optconvexsr1View) -> Optconvexsr1View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_view_copy(s : Optconvexsr1View) -> Optconvexsr1View {
  let result = opt_convex_sr1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_view_fill(s : Optconvexsr1View, v : Double) -> Optconvexsr1View {
  let result = opt_convex_sr1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_view_min(s : Optconvexsr1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_view_max(s : Optconvexsr1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_view_to_string(s : Optconvexsr1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_range_make(size : Int) -> Optconvexsr1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_range_len(s : Optconvexsr1Range) -> Int { s.size }

pub fn opt_convex_sr1_range_get(s : Optconvexsr1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_range_set(s : Optconvexsr1Range, i : Int, v : Double) -> Optconvexsr1Range {
  let result = opt_convex_sr1_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_range_sum(s : Optconvexsr1Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_range_mean(s : Optconvexsr1Range) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_range_scale(s : Optconvexsr1Range, f : Double) -> Optconvexsr1Range {
  let result = opt_convex_sr1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_range_add(a : Optconvexsr1Range, b : Optconvexsr1Range) -> Optconvexsr1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_range_copy(s : Optconvexsr1Range) -> Optconvexsr1Range {
  let result = opt_convex_sr1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_range_fill(s : Optconvexsr1Range, v : Double) -> Optconvexsr1Range {
  let result = opt_convex_sr1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_range_min(s : Optconvexsr1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_range_max(s : Optconvexsr1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_range_to_string(s : Optconvexsr1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_slice_make(size : Int) -> Optconvexsr1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_slice_len(s : Optconvexsr1Slice) -> Int { s.size }

pub fn opt_convex_sr1_slice_get(s : Optconvexsr1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_slice_set(s : Optconvexsr1Slice, i : Int, v : Double) -> Optconvexsr1Slice {
  let result = opt_convex_sr1_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_slice_sum(s : Optconvexsr1Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_sr1_slice_mean(s : Optconvexsr1Slice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_sr1_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_sr1_slice_scale(s : Optconvexsr1Slice, f : Double) -> Optconvexsr1Slice {
  let result = opt_convex_sr1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_sr1_slice_add(a : Optconvexsr1Slice, b : Optconvexsr1Slice) -> Optconvexsr1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_sr1_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_sr1_slice_copy(s : Optconvexsr1Slice) -> Optconvexsr1Slice {
  let result = opt_convex_sr1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_sr1_slice_fill(s : Optconvexsr1Slice, v : Double) -> Optconvexsr1Slice {
  let result = opt_convex_sr1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_sr1_slice_min(s : Optconvexsr1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_slice_max(s : Optconvexsr1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_sr1_slice_to_string(s : Optconvexsr1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


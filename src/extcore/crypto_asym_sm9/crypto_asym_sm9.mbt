///===
/// extcore/crypto_asym_sm9

pub(all) struct Cryptoasymsm9Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_sm9_make_point(x : Double, y : Double) -> Cryptoasymsm9Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_sm9_make_point3(x : Double, y : Double, z : Double) -> Cryptoasymsm9Point {
  { x, y, z, label: 0 }
}

pub fn crypto_asym_sm9_point_x(pt : Cryptoasymsm9Point) -> Double { pt.x }

pub fn crypto_asym_sm9_point_y(pt : Cryptoasymsm9Point) -> Double { pt.y }

pub fn crypto_asym_sm9_point_z(pt : Cryptoasymsm9Point) -> Double { pt.z }

pub fn crypto_asym_sm9_point_label(pt : Cryptoasymsm9Point) -> Int { pt.label }

pub fn crypto_asym_sm9_point_dist(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_asym_sm9_point_add(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_asym_sm9_point_sub(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_asym_sm9_point_scale(pt : Cryptoasymsm9Point, s : Double) -> Cryptoasymsm9Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_asym_sm9_point_dot(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_asym_sm9_point_cross(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_asym_sm9_point_norm(pt : Cryptoasymsm9Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_asym_sm9_point_normalize(pt : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  let n = crypto_asym_sm9_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_asym_sm9_point_scale(pt, 1.0 / n) }
}

pub fn crypto_asym_sm9_point_negate(pt : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_asym_sm9_point_mid(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_asym_sm9_point_lerp(a : Cryptoasymsm9Point, b : Cryptoasymsm9Point, t : Double) -> Cryptoasymsm9Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_asym_sm9_point_to_string(pt : Cryptoasymsm9Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_sm9_make_series(vals : Array[Double], name : String) -> Cryptoasymsm9Series {
  { vals, name, meta: 0 }
}

pub fn crypto_asym_sm9_series_len(s : Cryptoasymsm9Series) -> Int { s.vals.length() }

pub fn crypto_asym_sm9_series_sum(s : Cryptoasymsm9Series) -> Double { @_common.sum(s.vals) }

pub fn crypto_asym_sm9_series_mean(s : Cryptoasymsm9Series) -> Double { @_common.mean(s.vals) }

pub fn crypto_asym_sm9_series_min(s : Cryptoasymsm9Series) -> Double { @_common.min(s.vals) }

pub fn crypto_asym_sm9_series_max(s : Cryptoasymsm9Series) -> Double { @_common.max(s.vals) }

pub fn crypto_asym_sm9_series_range(s : Cryptoasymsm9Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_asym_sm9_series_var(s : Cryptoasymsm9Series) -> Double { @_common.variance(s.vals) }

pub fn crypto_asym_sm9_series_std(s : Cryptoasymsm9Series) -> Double { @_common.std(s.vals) }

pub fn crypto_asym_sm9_series_median(s : Cryptoasymsm9Series) -> Double { @_common.median(s.vals) }

pub fn crypto_asym_sm9_series_scale(s : Cryptoasymsm9Series, f : Double) -> Cryptoasymsm9Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_asym_sm9_series_add(a : Cryptoasymsm9Series, b : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_asym_sm9_series_sub(a : Cryptoasymsm9Series, b : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_asym_sm9_series_normalize(s : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  let mn = crypto_asym_sm9_series_min(s)
  let mx = crypto_asym_sm9_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_asym_sm9_series_cumsum(s : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_asym_sm9_series_to_string(s : Cryptoasymsm9Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm9Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_sm9_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptoasymsm9Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_sm9_matrix_identity(n : Int) -> Cryptoasymsm9Matrix {
  let m = crypto_asym_sm9_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_asym_sm9_matrix_get(m : Cryptoasymsm9Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_asym_sm9_matrix_transpose(m : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_asym_sm9_matrix_add(a : Cryptoasymsm9Matrix, b : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_asym_sm9_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_asym_sm9_matrix_scale(m : Cryptoasymsm9Matrix, s : Double) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_asym_sm9_matrix_multiply(a : Cryptoasymsm9Matrix, b : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  if a.cols != b.rows { return crypto_asym_sm9_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_asym_sm9_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_asym_sm9_matrix_trace(m : Cryptoasymsm9Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_asym_sm9_matrix_det(m : Cryptoasymsm9Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_asym_sm9_matrix_norm(m : Cryptoasymsm9Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_asym_sm9_matrix_to_string(m : Cryptoasymsm9Matrix) -> String {
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

pub(all) struct Cryptoasymsm9Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_sm9_make_vector(comps : Array[Double]) -> Cryptoasymsm9Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_sm9_vector_zero(dim : Int) -> Cryptoasymsm9Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_asym_sm9_vector_add(a : Cryptoasymsm9Vector, b : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_sm9_vector_sub(a : Cryptoasymsm9Vector, b : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_asym_sm9_vector_scale(v : Cryptoasymsm9Vector, s : Double) -> Cryptoasymsm9Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_asym_sm9_vector_dot(a : Cryptoasymsm9Vector, b : Cryptoasymsm9Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_asym_sm9_vector_norm(v : Cryptoasymsm9Vector) -> Double { @_common.sqrt(crypto_asym_sm9_vector_dot(v, v)) }

pub fn crypto_asym_sm9_vector_normalize(v : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = crypto_asym_sm9_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_asym_sm9_vector_scale(v, 1.0 / n) }
}

pub fn crypto_asym_sm9_vector_dist(a : Cryptoasymsm9Vector, b : Cryptoasymsm9Vector) -> Double {
  crypto_asym_sm9_vector_norm(crypto_asym_sm9_vector_sub(a, b))
}

pub fn crypto_asym_sm9_vector_to_string(v : Cryptoasymsm9Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_sm9_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_sm9_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_sm9_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_sm9_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_sm9_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_sm9_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_sm9_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_sm9_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_sm9_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_sm9_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_sm9_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_sm9_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_sm9_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_sm9_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_sm9_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_sm9_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_sm9_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_sm9_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_sm9_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_sm9_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_sm9_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_sm9_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_sm9_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_sm9_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_sm9_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_sm9_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_sm9_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_sm9_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_sm9_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptoasymsm9Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_frame_make(size : Int) -> Cryptoasymsm9Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_frame_len(s : Cryptoasymsm9Frame) -> Int { s.size }

pub fn crypto_asym_sm9_frame_get(s : Cryptoasymsm9Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_frame_set(s : Cryptoasymsm9Frame, i : Int, v : Double) -> Cryptoasymsm9Frame {
  let result = crypto_asym_sm9_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_frame_sum(s : Cryptoasymsm9Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_frame_mean(s : Cryptoasymsm9Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_frame_scale(s : Cryptoasymsm9Frame, f : Double) -> Cryptoasymsm9Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_add(a : Cryptoasymsm9Frame, b : Cryptoasymsm9Frame) -> Cryptoasymsm9Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_frame_copy(s : Cryptoasymsm9Frame) -> Cryptoasymsm9Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_fill(s : Cryptoasymsm9Frame, v : Double) -> Cryptoasymsm9Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_min(s : Cryptoasymsm9Frame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_frame_max(s : Cryptoasymsm9Frame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_frame_to_string(s : Cryptoasymsm9Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_table_make(size : Int) -> Cryptoasymsm9Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_table_len(s : Cryptoasymsm9Table) -> Int { s.size }

pub fn crypto_asym_sm9_table_get(s : Cryptoasymsm9Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_table_set(s : Cryptoasymsm9Table, i : Int, v : Double) -> Cryptoasymsm9Table {
  let result = crypto_asym_sm9_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_table_sum(s : Cryptoasymsm9Table) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_table_mean(s : Cryptoasymsm9Table) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_table_scale(s : Cryptoasymsm9Table, f : Double) -> Cryptoasymsm9Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_add(a : Cryptoasymsm9Table, b : Cryptoasymsm9Table) -> Cryptoasymsm9Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_table_copy(s : Cryptoasymsm9Table) -> Cryptoasymsm9Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_fill(s : Cryptoasymsm9Table, v : Double) -> Cryptoasymsm9Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_min(s : Cryptoasymsm9Table) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_table_max(s : Cryptoasymsm9Table) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_table_to_string(s : Cryptoasymsm9Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_graphn_make(size : Int) -> Cryptoasymsm9GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_graphn_len(s : Cryptoasymsm9GraphN) -> Int { s.size }

pub fn crypto_asym_sm9_graphn_get(s : Cryptoasymsm9GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_graphn_set(s : Cryptoasymsm9GraphN, i : Int, v : Double) -> Cryptoasymsm9GraphN {
  let result = crypto_asym_sm9_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_graphn_sum(s : Cryptoasymsm9GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_graphn_mean(s : Cryptoasymsm9GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_graphn_scale(s : Cryptoasymsm9GraphN, f : Double) -> Cryptoasymsm9GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_add(a : Cryptoasymsm9GraphN, b : Cryptoasymsm9GraphN) -> Cryptoasymsm9GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_graphn_copy(s : Cryptoasymsm9GraphN) -> Cryptoasymsm9GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_fill(s : Cryptoasymsm9GraphN, v : Double) -> Cryptoasymsm9GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_min(s : Cryptoasymsm9GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_graphn_max(s : Cryptoasymsm9GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_graphn_to_string(s : Cryptoasymsm9GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_node_make(size : Int) -> Cryptoasymsm9Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_node_len(s : Cryptoasymsm9Node) -> Int { s.size }

pub fn crypto_asym_sm9_node_get(s : Cryptoasymsm9Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_node_set(s : Cryptoasymsm9Node, i : Int, v : Double) -> Cryptoasymsm9Node {
  let result = crypto_asym_sm9_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_node_sum(s : Cryptoasymsm9Node) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_node_mean(s : Cryptoasymsm9Node) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_node_scale(s : Cryptoasymsm9Node, f : Double) -> Cryptoasymsm9Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_add(a : Cryptoasymsm9Node, b : Cryptoasymsm9Node) -> Cryptoasymsm9Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_node_copy(s : Cryptoasymsm9Node) -> Cryptoasymsm9Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_fill(s : Cryptoasymsm9Node, v : Double) -> Cryptoasymsm9Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_min(s : Cryptoasymsm9Node) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_node_max(s : Cryptoasymsm9Node) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_node_to_string(s : Cryptoasymsm9Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_edge_make(size : Int) -> Cryptoasymsm9Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_edge_len(s : Cryptoasymsm9Edge) -> Int { s.size }

pub fn crypto_asym_sm9_edge_get(s : Cryptoasymsm9Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_edge_set(s : Cryptoasymsm9Edge, i : Int, v : Double) -> Cryptoasymsm9Edge {
  let result = crypto_asym_sm9_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_edge_sum(s : Cryptoasymsm9Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_edge_mean(s : Cryptoasymsm9Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_edge_scale(s : Cryptoasymsm9Edge, f : Double) -> Cryptoasymsm9Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_add(a : Cryptoasymsm9Edge, b : Cryptoasymsm9Edge) -> Cryptoasymsm9Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_edge_copy(s : Cryptoasymsm9Edge) -> Cryptoasymsm9Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_fill(s : Cryptoasymsm9Edge, v : Double) -> Cryptoasymsm9Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_min(s : Cryptoasymsm9Edge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_edge_max(s : Cryptoasymsm9Edge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_edge_to_string(s : Cryptoasymsm9Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_path_make(size : Int) -> Cryptoasymsm9Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_path_len(s : Cryptoasymsm9Path) -> Int { s.size }

pub fn crypto_asym_sm9_path_get(s : Cryptoasymsm9Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_path_set(s : Cryptoasymsm9Path, i : Int, v : Double) -> Cryptoasymsm9Path {
  let result = crypto_asym_sm9_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_path_sum(s : Cryptoasymsm9Path) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_path_mean(s : Cryptoasymsm9Path) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_path_scale(s : Cryptoasymsm9Path, f : Double) -> Cryptoasymsm9Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_add(a : Cryptoasymsm9Path, b : Cryptoasymsm9Path) -> Cryptoasymsm9Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_path_copy(s : Cryptoasymsm9Path) -> Cryptoasymsm9Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_fill(s : Cryptoasymsm9Path, v : Double) -> Cryptoasymsm9Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_min(s : Cryptoasymsm9Path) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_path_max(s : Cryptoasymsm9Path) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_path_to_string(s : Cryptoasymsm9Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_cluster_make(size : Int) -> Cryptoasymsm9Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_cluster_len(s : Cryptoasymsm9Cluster) -> Int { s.size }

pub fn crypto_asym_sm9_cluster_get(s : Cryptoasymsm9Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_cluster_set(s : Cryptoasymsm9Cluster, i : Int, v : Double) -> Cryptoasymsm9Cluster {
  let result = crypto_asym_sm9_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_cluster_sum(s : Cryptoasymsm9Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_cluster_mean(s : Cryptoasymsm9Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_cluster_scale(s : Cryptoasymsm9Cluster, f : Double) -> Cryptoasymsm9Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_add(a : Cryptoasymsm9Cluster, b : Cryptoasymsm9Cluster) -> Cryptoasymsm9Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_cluster_copy(s : Cryptoasymsm9Cluster) -> Cryptoasymsm9Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_fill(s : Cryptoasymsm9Cluster, v : Double) -> Cryptoasymsm9Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_min(s : Cryptoasymsm9Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_cluster_max(s : Cryptoasymsm9Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_cluster_to_string(s : Cryptoasymsm9Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_model_make(size : Int) -> Cryptoasymsm9Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_model_len(s : Cryptoasymsm9Model) -> Int { s.size }

pub fn crypto_asym_sm9_model_get(s : Cryptoasymsm9Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_model_set(s : Cryptoasymsm9Model, i : Int, v : Double) -> Cryptoasymsm9Model {
  let result = crypto_asym_sm9_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_model_sum(s : Cryptoasymsm9Model) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_model_mean(s : Cryptoasymsm9Model) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_model_scale(s : Cryptoasymsm9Model, f : Double) -> Cryptoasymsm9Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_add(a : Cryptoasymsm9Model, b : Cryptoasymsm9Model) -> Cryptoasymsm9Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_model_copy(s : Cryptoasymsm9Model) -> Cryptoasymsm9Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_fill(s : Cryptoasymsm9Model, v : Double) -> Cryptoasymsm9Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_min(s : Cryptoasymsm9Model) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_model_max(s : Cryptoasymsm9Model) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_model_to_string(s : Cryptoasymsm9Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_layer_make(size : Int) -> Cryptoasymsm9Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_layer_len(s : Cryptoasymsm9Layer) -> Int { s.size }

pub fn crypto_asym_sm9_layer_get(s : Cryptoasymsm9Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_layer_set(s : Cryptoasymsm9Layer, i : Int, v : Double) -> Cryptoasymsm9Layer {
  let result = crypto_asym_sm9_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_layer_sum(s : Cryptoasymsm9Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_layer_mean(s : Cryptoasymsm9Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_layer_scale(s : Cryptoasymsm9Layer, f : Double) -> Cryptoasymsm9Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_add(a : Cryptoasymsm9Layer, b : Cryptoasymsm9Layer) -> Cryptoasymsm9Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_layer_copy(s : Cryptoasymsm9Layer) -> Cryptoasymsm9Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_fill(s : Cryptoasymsm9Layer, v : Double) -> Cryptoasymsm9Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_min(s : Cryptoasymsm9Layer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_layer_max(s : Cryptoasymsm9Layer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_layer_to_string(s : Cryptoasymsm9Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_buffer_make(size : Int) -> Cryptoasymsm9Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_buffer_len(s : Cryptoasymsm9Buffer) -> Int { s.size }

pub fn crypto_asym_sm9_buffer_get(s : Cryptoasymsm9Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_buffer_set(s : Cryptoasymsm9Buffer, i : Int, v : Double) -> Cryptoasymsm9Buffer {
  let result = crypto_asym_sm9_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_buffer_sum(s : Cryptoasymsm9Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_buffer_mean(s : Cryptoasymsm9Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_buffer_scale(s : Cryptoasymsm9Buffer, f : Double) -> Cryptoasymsm9Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_add(a : Cryptoasymsm9Buffer, b : Cryptoasymsm9Buffer) -> Cryptoasymsm9Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_buffer_copy(s : Cryptoasymsm9Buffer) -> Cryptoasymsm9Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_fill(s : Cryptoasymsm9Buffer, v : Double) -> Cryptoasymsm9Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_min(s : Cryptoasymsm9Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_buffer_max(s : Cryptoasymsm9Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_buffer_to_string(s : Cryptoasymsm9Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_cursor_make(size : Int) -> Cryptoasymsm9Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_cursor_len(s : Cryptoasymsm9Cursor) -> Int { s.size }

pub fn crypto_asym_sm9_cursor_get(s : Cryptoasymsm9Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_cursor_set(s : Cryptoasymsm9Cursor, i : Int, v : Double) -> Cryptoasymsm9Cursor {
  let result = crypto_asym_sm9_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_cursor_sum(s : Cryptoasymsm9Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_cursor_mean(s : Cryptoasymsm9Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_cursor_scale(s : Cryptoasymsm9Cursor, f : Double) -> Cryptoasymsm9Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_add(a : Cryptoasymsm9Cursor, b : Cryptoasymsm9Cursor) -> Cryptoasymsm9Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_cursor_copy(s : Cryptoasymsm9Cursor) -> Cryptoasymsm9Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_fill(s : Cryptoasymsm9Cursor, v : Double) -> Cryptoasymsm9Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_min(s : Cryptoasymsm9Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_cursor_max(s : Cryptoasymsm9Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_cursor_to_string(s : Cryptoasymsm9Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_view_make(size : Int) -> Cryptoasymsm9View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_view_len(s : Cryptoasymsm9View) -> Int { s.size }

pub fn crypto_asym_sm9_view_get(s : Cryptoasymsm9View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_view_set(s : Cryptoasymsm9View, i : Int, v : Double) -> Cryptoasymsm9View {
  let result = crypto_asym_sm9_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_view_sum(s : Cryptoasymsm9View) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_view_mean(s : Cryptoasymsm9View) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_view_scale(s : Cryptoasymsm9View, f : Double) -> Cryptoasymsm9View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_add(a : Cryptoasymsm9View, b : Cryptoasymsm9View) -> Cryptoasymsm9View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_view_copy(s : Cryptoasymsm9View) -> Cryptoasymsm9View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_fill(s : Cryptoasymsm9View, v : Double) -> Cryptoasymsm9View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_min(s : Cryptoasymsm9View) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_view_max(s : Cryptoasymsm9View) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_view_to_string(s : Cryptoasymsm9View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_range_make(size : Int) -> Cryptoasymsm9Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_range_len(s : Cryptoasymsm9Range) -> Int { s.size }

pub fn crypto_asym_sm9_range_get(s : Cryptoasymsm9Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_range_set(s : Cryptoasymsm9Range, i : Int, v : Double) -> Cryptoasymsm9Range {
  let result = crypto_asym_sm9_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_range_sum(s : Cryptoasymsm9Range) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_range_mean(s : Cryptoasymsm9Range) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_range_scale(s : Cryptoasymsm9Range, f : Double) -> Cryptoasymsm9Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_add(a : Cryptoasymsm9Range, b : Cryptoasymsm9Range) -> Cryptoasymsm9Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_range_copy(s : Cryptoasymsm9Range) -> Cryptoasymsm9Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_fill(s : Cryptoasymsm9Range, v : Double) -> Cryptoasymsm9Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_min(s : Cryptoasymsm9Range) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_range_max(s : Cryptoasymsm9Range) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_range_to_string(s : Cryptoasymsm9Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_slice_make(size : Int) -> Cryptoasymsm9Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_slice_len(s : Cryptoasymsm9Slice) -> Int { s.size }

pub fn crypto_asym_sm9_slice_get(s : Cryptoasymsm9Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_slice_set(s : Cryptoasymsm9Slice, i : Int, v : Double) -> Cryptoasymsm9Slice {
  let result = crypto_asym_sm9_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_asym_sm9_slice_sum(s : Cryptoasymsm9Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_slice_mean(s : Cryptoasymsm9Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_slice_scale(s : Cryptoasymsm9Slice, f : Double) -> Cryptoasymsm9Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_add(a : Cryptoasymsm9Slice, b : Cryptoasymsm9Slice) -> Cryptoasymsm9Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_slice_copy(s : Cryptoasymsm9Slice) -> Cryptoasymsm9Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_fill(s : Cryptoasymsm9Slice, v : Double) -> Cryptoasymsm9Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_min(s : Cryptoasymsm9Slice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_slice_max(s : Cryptoasymsm9Slice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_slice_to_string(s : Cryptoasymsm9Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


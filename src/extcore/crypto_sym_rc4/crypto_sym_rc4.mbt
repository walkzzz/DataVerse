///===
/// extcore/crypto_sym_rc4

pub(all) struct Cryptosymrc4Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_rc4_make_point(x : Double, y : Double) -> Cryptosymrc4Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_rc4_make_point3(x : Double, y : Double, z : Double) -> Cryptosymrc4Point {
  { x, y, z, label: 0 }
}

pub fn crypto_sym_rc4_point_x(pt : Cryptosymrc4Point) -> Double { pt.x }

pub fn crypto_sym_rc4_point_y(pt : Cryptosymrc4Point) -> Double { pt.y }

pub fn crypto_sym_rc4_point_z(pt : Cryptosymrc4Point) -> Double { pt.z }

pub fn crypto_sym_rc4_point_label(pt : Cryptosymrc4Point) -> Int { pt.label }

pub fn crypto_sym_rc4_point_dist(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn crypto_sym_rc4_point_add(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn crypto_sym_rc4_point_sub(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn crypto_sym_rc4_point_scale(pt : Cryptosymrc4Point, s : Double) -> Cryptosymrc4Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn crypto_sym_rc4_point_dot(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn crypto_sym_rc4_point_cross(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn crypto_sym_rc4_point_norm(pt : Cryptosymrc4Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn crypto_sym_rc4_point_normalize(pt : Cryptosymrc4Point) -> Cryptosymrc4Point {
  let n = crypto_sym_rc4_point_norm(pt)
  if n < 0.0000001 { pt } else { crypto_sym_rc4_point_scale(pt, 1.0 / n) }
}

pub fn crypto_sym_rc4_point_negate(pt : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn crypto_sym_rc4_point_mid(a : Cryptosymrc4Point, b : Cryptosymrc4Point) -> Cryptosymrc4Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn crypto_sym_rc4_point_lerp(a : Cryptosymrc4Point, b : Cryptosymrc4Point, t : Double) -> Cryptosymrc4Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn crypto_sym_rc4_point_to_string(pt : Cryptosymrc4Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Cryptosymrc4Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_rc4_make_series(vals : Array[Double], name : String) -> Cryptosymrc4Series {
  { vals, name, meta: 0 }
}

pub fn crypto_sym_rc4_series_len(s : Cryptosymrc4Series) -> Int { s.vals.length() }

pub fn crypto_sym_rc4_series_sum(s : Cryptosymrc4Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn crypto_sym_rc4_series_mean(s : Cryptosymrc4Series) -> Double { @_common.mean(s.vals) }

pub fn crypto_sym_rc4_series_min(s : Cryptosymrc4Series) -> Double { @_common.min(s.vals) }

pub fn crypto_sym_rc4_series_max(s : Cryptosymrc4Series) -> Double { @_common.max(s.vals) }

pub fn crypto_sym_rc4_series_range(s : Cryptosymrc4Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn crypto_sym_rc4_series_var(s : Cryptosymrc4Series) -> Double { @_common.variance(s.vals) }

pub fn crypto_sym_rc4_series_std(s : Cryptosymrc4Series) -> Double { @_common.std(s.vals) }

pub fn crypto_sym_rc4_series_median(s : Cryptosymrc4Series) -> Double { @_common.median(s.vals) }

pub fn crypto_sym_rc4_series_scale(s : Cryptosymrc4Series, f : Double) -> Cryptosymrc4Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn crypto_sym_rc4_series_add(a : Cryptosymrc4Series, b : Cryptosymrc4Series) -> Cryptosymrc4Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn crypto_sym_rc4_series_sub(a : Cryptosymrc4Series, b : Cryptosymrc4Series) -> Cryptosymrc4Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn crypto_sym_rc4_series_normalize(s : Cryptosymrc4Series) -> Cryptosymrc4Series {
  let mn = crypto_sym_rc4_series_min(s)
  let mx = crypto_sym_rc4_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn crypto_sym_rc4_series_cumsum(s : Cryptosymrc4Series) -> Cryptosymrc4Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn crypto_sym_rc4_series_to_string(s : Cryptosymrc4Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptosymrc4Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_rc4_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptosymrc4Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_rc4_matrix_identity(n : Int) -> Cryptosymrc4Matrix {
  let m = crypto_sym_rc4_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn crypto_sym_rc4_matrix_get(m : Cryptosymrc4Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn crypto_sym_rc4_matrix_transpose(m : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn crypto_sym_rc4_matrix_add(a : Cryptosymrc4Matrix, b : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = crypto_sym_rc4_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn crypto_sym_rc4_matrix_scale(m : Cryptosymrc4Matrix, s : Double) -> Cryptosymrc4Matrix {
  let result = crypto_sym_rc4_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn crypto_sym_rc4_matrix_multiply(a : Cryptosymrc4Matrix, b : Cryptosymrc4Matrix) -> Cryptosymrc4Matrix {
  if a.cols != b.rows { return crypto_sym_rc4_make_matrix(a.rows, b.cols, 0.0) }
  let result = crypto_sym_rc4_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn crypto_sym_rc4_matrix_trace(m : Cryptosymrc4Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn crypto_sym_rc4_matrix_det(m : Cryptosymrc4Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn crypto_sym_rc4_matrix_norm(m : Cryptosymrc4Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn crypto_sym_rc4_matrix_to_string(m : Cryptosymrc4Matrix) -> String {
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

pub(all) struct Cryptosymrc4Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_rc4_make_vector(comps : Array[Double]) -> Cryptosymrc4Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_rc4_vector_zero(dim : Int) -> Cryptosymrc4Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn crypto_sym_rc4_vector_add(a : Cryptosymrc4Vector, b : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_rc4_vector_sub(a : Cryptosymrc4Vector, b : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn crypto_sym_rc4_vector_scale(v : Cryptosymrc4Vector, s : Double) -> Cryptosymrc4Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn crypto_sym_rc4_vector_dot(a : Cryptosymrc4Vector, b : Cryptosymrc4Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn crypto_sym_rc4_vector_norm(v : Cryptosymrc4Vector) -> Double { @_common.sqrt(crypto_sym_rc4_vector_dot(v, v)) }

pub fn crypto_sym_rc4_vector_normalize(v : Cryptosymrc4Vector) -> Cryptosymrc4Vector {
  let n = crypto_sym_rc4_vector_norm(v)
  if n < 0.0000001 { v } else { crypto_sym_rc4_vector_scale(v, 1.0 / n) }
}

pub fn crypto_sym_rc4_vector_dist(a : Cryptosymrc4Vector, b : Cryptosymrc4Vector) -> Double {
  crypto_sym_rc4_vector_norm(crypto_sym_rc4_vector_sub(a, b))
}

pub fn crypto_sym_rc4_vector_to_string(v : Cryptosymrc4Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_rc4_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_rc4_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_rc4_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_rc4_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_rc4_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_rc4_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_rc4_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_rc4_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_rc4_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_rc4_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_rc4_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_rc4_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_rc4_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_rc4_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_rc4_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_rc4_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_rc4_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_rc4_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_rc4_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_rc4_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_rc4_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_rc4_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_rc4_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_rc4_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_rc4_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_rc4_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_rc4_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_rc4_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_rc4_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptosymrc4Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_frame_make(size : Int) -> Cryptosymrc4Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_frame_len(s : Cryptosymrc4Frame) -> Int { s.size }

pub fn crypto_sym_rc4_frame_get(s : Cryptosymrc4Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_frame_set(s : Cryptosymrc4Frame, i : Int, v : Double) -> Cryptosymrc4Frame {
  let result = crypto_sym_rc4_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_frame_sum(s : Cryptosymrc4Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_frame_mean(s : Cryptosymrc4Frame) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_frame_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_frame_scale(s : Cryptosymrc4Frame, f : Double) -> Cryptosymrc4Frame {
  let result = crypto_sym_rc4_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_frame_add(a : Cryptosymrc4Frame, b : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_frame_copy(s : Cryptosymrc4Frame) -> Cryptosymrc4Frame {
  let result = crypto_sym_rc4_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_frame_fill(s : Cryptosymrc4Frame, v : Double) -> Cryptosymrc4Frame {
  let result = crypto_sym_rc4_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_frame_min(s : Cryptosymrc4Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_frame_max(s : Cryptosymrc4Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_frame_to_string(s : Cryptosymrc4Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_table_make(size : Int) -> Cryptosymrc4Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_table_len(s : Cryptosymrc4Table) -> Int { s.size }

pub fn crypto_sym_rc4_table_get(s : Cryptosymrc4Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_table_set(s : Cryptosymrc4Table, i : Int, v : Double) -> Cryptosymrc4Table {
  let result = crypto_sym_rc4_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_table_sum(s : Cryptosymrc4Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_table_mean(s : Cryptosymrc4Table) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_table_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_table_scale(s : Cryptosymrc4Table, f : Double) -> Cryptosymrc4Table {
  let result = crypto_sym_rc4_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_table_add(a : Cryptosymrc4Table, b : Cryptosymrc4Table) -> Cryptosymrc4Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_table_copy(s : Cryptosymrc4Table) -> Cryptosymrc4Table {
  let result = crypto_sym_rc4_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_table_fill(s : Cryptosymrc4Table, v : Double) -> Cryptosymrc4Table {
  let result = crypto_sym_rc4_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_table_min(s : Cryptosymrc4Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_table_max(s : Cryptosymrc4Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_table_to_string(s : Cryptosymrc4Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_graphn_make(size : Int) -> Cryptosymrc4GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_graphn_len(s : Cryptosymrc4GraphN) -> Int { s.size }

pub fn crypto_sym_rc4_graphn_get(s : Cryptosymrc4GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_graphn_set(s : Cryptosymrc4GraphN, i : Int, v : Double) -> Cryptosymrc4GraphN {
  let result = crypto_sym_rc4_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_graphn_sum(s : Cryptosymrc4GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_graphn_mean(s : Cryptosymrc4GraphN) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_graphn_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_graphn_scale(s : Cryptosymrc4GraphN, f : Double) -> Cryptosymrc4GraphN {
  let result = crypto_sym_rc4_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_graphn_add(a : Cryptosymrc4GraphN, b : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_graphn_copy(s : Cryptosymrc4GraphN) -> Cryptosymrc4GraphN {
  let result = crypto_sym_rc4_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_graphn_fill(s : Cryptosymrc4GraphN, v : Double) -> Cryptosymrc4GraphN {
  let result = crypto_sym_rc4_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_graphn_min(s : Cryptosymrc4GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_graphn_max(s : Cryptosymrc4GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_graphn_to_string(s : Cryptosymrc4GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_node_make(size : Int) -> Cryptosymrc4Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_node_len(s : Cryptosymrc4Node) -> Int { s.size }

pub fn crypto_sym_rc4_node_get(s : Cryptosymrc4Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_node_set(s : Cryptosymrc4Node, i : Int, v : Double) -> Cryptosymrc4Node {
  let result = crypto_sym_rc4_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_node_sum(s : Cryptosymrc4Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_node_mean(s : Cryptosymrc4Node) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_node_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_node_scale(s : Cryptosymrc4Node, f : Double) -> Cryptosymrc4Node {
  let result = crypto_sym_rc4_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_node_add(a : Cryptosymrc4Node, b : Cryptosymrc4Node) -> Cryptosymrc4Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_node_copy(s : Cryptosymrc4Node) -> Cryptosymrc4Node {
  let result = crypto_sym_rc4_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_node_fill(s : Cryptosymrc4Node, v : Double) -> Cryptosymrc4Node {
  let result = crypto_sym_rc4_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_node_min(s : Cryptosymrc4Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_node_max(s : Cryptosymrc4Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_node_to_string(s : Cryptosymrc4Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_edge_make(size : Int) -> Cryptosymrc4Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_edge_len(s : Cryptosymrc4Edge) -> Int { s.size }

pub fn crypto_sym_rc4_edge_get(s : Cryptosymrc4Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_edge_set(s : Cryptosymrc4Edge, i : Int, v : Double) -> Cryptosymrc4Edge {
  let result = crypto_sym_rc4_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_edge_sum(s : Cryptosymrc4Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_edge_mean(s : Cryptosymrc4Edge) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_edge_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_edge_scale(s : Cryptosymrc4Edge, f : Double) -> Cryptosymrc4Edge {
  let result = crypto_sym_rc4_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_edge_add(a : Cryptosymrc4Edge, b : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_edge_copy(s : Cryptosymrc4Edge) -> Cryptosymrc4Edge {
  let result = crypto_sym_rc4_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_edge_fill(s : Cryptosymrc4Edge, v : Double) -> Cryptosymrc4Edge {
  let result = crypto_sym_rc4_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_edge_min(s : Cryptosymrc4Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_edge_max(s : Cryptosymrc4Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_edge_to_string(s : Cryptosymrc4Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_path_make(size : Int) -> Cryptosymrc4Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_path_len(s : Cryptosymrc4Path) -> Int { s.size }

pub fn crypto_sym_rc4_path_get(s : Cryptosymrc4Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_path_set(s : Cryptosymrc4Path, i : Int, v : Double) -> Cryptosymrc4Path {
  let result = crypto_sym_rc4_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_path_sum(s : Cryptosymrc4Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_path_mean(s : Cryptosymrc4Path) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_path_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_path_scale(s : Cryptosymrc4Path, f : Double) -> Cryptosymrc4Path {
  let result = crypto_sym_rc4_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_path_add(a : Cryptosymrc4Path, b : Cryptosymrc4Path) -> Cryptosymrc4Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_path_copy(s : Cryptosymrc4Path) -> Cryptosymrc4Path {
  let result = crypto_sym_rc4_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_path_fill(s : Cryptosymrc4Path, v : Double) -> Cryptosymrc4Path {
  let result = crypto_sym_rc4_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_path_min(s : Cryptosymrc4Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_path_max(s : Cryptosymrc4Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_path_to_string(s : Cryptosymrc4Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cluster_make(size : Int) -> Cryptosymrc4Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_cluster_len(s : Cryptosymrc4Cluster) -> Int { s.size }

pub fn crypto_sym_rc4_cluster_get(s : Cryptosymrc4Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_cluster_set(s : Cryptosymrc4Cluster, i : Int, v : Double) -> Cryptosymrc4Cluster {
  let result = crypto_sym_rc4_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_cluster_sum(s : Cryptosymrc4Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_cluster_mean(s : Cryptosymrc4Cluster) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_cluster_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_cluster_scale(s : Cryptosymrc4Cluster, f : Double) -> Cryptosymrc4Cluster {
  let result = crypto_sym_rc4_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_cluster_add(a : Cryptosymrc4Cluster, b : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_cluster_copy(s : Cryptosymrc4Cluster) -> Cryptosymrc4Cluster {
  let result = crypto_sym_rc4_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_cluster_fill(s : Cryptosymrc4Cluster, v : Double) -> Cryptosymrc4Cluster {
  let result = crypto_sym_rc4_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_cluster_min(s : Cryptosymrc4Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_cluster_max(s : Cryptosymrc4Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_cluster_to_string(s : Cryptosymrc4Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_model_make(size : Int) -> Cryptosymrc4Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_model_len(s : Cryptosymrc4Model) -> Int { s.size }

pub fn crypto_sym_rc4_model_get(s : Cryptosymrc4Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_model_set(s : Cryptosymrc4Model, i : Int, v : Double) -> Cryptosymrc4Model {
  let result = crypto_sym_rc4_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_model_sum(s : Cryptosymrc4Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_model_mean(s : Cryptosymrc4Model) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_model_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_model_scale(s : Cryptosymrc4Model, f : Double) -> Cryptosymrc4Model {
  let result = crypto_sym_rc4_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_model_add(a : Cryptosymrc4Model, b : Cryptosymrc4Model) -> Cryptosymrc4Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_model_copy(s : Cryptosymrc4Model) -> Cryptosymrc4Model {
  let result = crypto_sym_rc4_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_model_fill(s : Cryptosymrc4Model, v : Double) -> Cryptosymrc4Model {
  let result = crypto_sym_rc4_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_model_min(s : Cryptosymrc4Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_model_max(s : Cryptosymrc4Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_model_to_string(s : Cryptosymrc4Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_layer_make(size : Int) -> Cryptosymrc4Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_layer_len(s : Cryptosymrc4Layer) -> Int { s.size }

pub fn crypto_sym_rc4_layer_get(s : Cryptosymrc4Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_layer_set(s : Cryptosymrc4Layer, i : Int, v : Double) -> Cryptosymrc4Layer {
  let result = crypto_sym_rc4_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_layer_sum(s : Cryptosymrc4Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_layer_mean(s : Cryptosymrc4Layer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_layer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_layer_scale(s : Cryptosymrc4Layer, f : Double) -> Cryptosymrc4Layer {
  let result = crypto_sym_rc4_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_layer_add(a : Cryptosymrc4Layer, b : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_layer_copy(s : Cryptosymrc4Layer) -> Cryptosymrc4Layer {
  let result = crypto_sym_rc4_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_layer_fill(s : Cryptosymrc4Layer, v : Double) -> Cryptosymrc4Layer {
  let result = crypto_sym_rc4_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_layer_min(s : Cryptosymrc4Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_layer_max(s : Cryptosymrc4Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_layer_to_string(s : Cryptosymrc4Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_buffer_make(size : Int) -> Cryptosymrc4Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_buffer_len(s : Cryptosymrc4Buffer) -> Int { s.size }

pub fn crypto_sym_rc4_buffer_get(s : Cryptosymrc4Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_buffer_set(s : Cryptosymrc4Buffer, i : Int, v : Double) -> Cryptosymrc4Buffer {
  let result = crypto_sym_rc4_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_buffer_sum(s : Cryptosymrc4Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_buffer_mean(s : Cryptosymrc4Buffer) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_buffer_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_buffer_scale(s : Cryptosymrc4Buffer, f : Double) -> Cryptosymrc4Buffer {
  let result = crypto_sym_rc4_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_buffer_add(a : Cryptosymrc4Buffer, b : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_buffer_copy(s : Cryptosymrc4Buffer) -> Cryptosymrc4Buffer {
  let result = crypto_sym_rc4_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_buffer_fill(s : Cryptosymrc4Buffer, v : Double) -> Cryptosymrc4Buffer {
  let result = crypto_sym_rc4_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_buffer_min(s : Cryptosymrc4Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_buffer_max(s : Cryptosymrc4Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_buffer_to_string(s : Cryptosymrc4Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_cursor_make(size : Int) -> Cryptosymrc4Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_cursor_len(s : Cryptosymrc4Cursor) -> Int { s.size }

pub fn crypto_sym_rc4_cursor_get(s : Cryptosymrc4Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_cursor_set(s : Cryptosymrc4Cursor, i : Int, v : Double) -> Cryptosymrc4Cursor {
  let result = crypto_sym_rc4_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_cursor_sum(s : Cryptosymrc4Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_cursor_mean(s : Cryptosymrc4Cursor) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_cursor_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_cursor_scale(s : Cryptosymrc4Cursor, f : Double) -> Cryptosymrc4Cursor {
  let result = crypto_sym_rc4_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_cursor_add(a : Cryptosymrc4Cursor, b : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_cursor_copy(s : Cryptosymrc4Cursor) -> Cryptosymrc4Cursor {
  let result = crypto_sym_rc4_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_cursor_fill(s : Cryptosymrc4Cursor, v : Double) -> Cryptosymrc4Cursor {
  let result = crypto_sym_rc4_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_cursor_min(s : Cryptosymrc4Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_cursor_max(s : Cryptosymrc4Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_cursor_to_string(s : Cryptosymrc4Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_view_make(size : Int) -> Cryptosymrc4View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_view_len(s : Cryptosymrc4View) -> Int { s.size }

pub fn crypto_sym_rc4_view_get(s : Cryptosymrc4View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_view_set(s : Cryptosymrc4View, i : Int, v : Double) -> Cryptosymrc4View {
  let result = crypto_sym_rc4_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_view_sum(s : Cryptosymrc4View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_view_mean(s : Cryptosymrc4View) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_view_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_view_scale(s : Cryptosymrc4View, f : Double) -> Cryptosymrc4View {
  let result = crypto_sym_rc4_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_view_add(a : Cryptosymrc4View, b : Cryptosymrc4View) -> Cryptosymrc4View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_view_copy(s : Cryptosymrc4View) -> Cryptosymrc4View {
  let result = crypto_sym_rc4_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_view_fill(s : Cryptosymrc4View, v : Double) -> Cryptosymrc4View {
  let result = crypto_sym_rc4_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_view_min(s : Cryptosymrc4View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_view_max(s : Cryptosymrc4View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_view_to_string(s : Cryptosymrc4View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_range_make(size : Int) -> Cryptosymrc4Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_range_len(s : Cryptosymrc4Range) -> Int { s.size }

pub fn crypto_sym_rc4_range_get(s : Cryptosymrc4Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_range_set(s : Cryptosymrc4Range, i : Int, v : Double) -> Cryptosymrc4Range {
  let result = crypto_sym_rc4_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_range_sum(s : Cryptosymrc4Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_range_mean(s : Cryptosymrc4Range) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_range_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_range_scale(s : Cryptosymrc4Range, f : Double) -> Cryptosymrc4Range {
  let result = crypto_sym_rc4_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_range_add(a : Cryptosymrc4Range, b : Cryptosymrc4Range) -> Cryptosymrc4Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_range_copy(s : Cryptosymrc4Range) -> Cryptosymrc4Range {
  let result = crypto_sym_rc4_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_range_fill(s : Cryptosymrc4Range, v : Double) -> Cryptosymrc4Range {
  let result = crypto_sym_rc4_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_range_min(s : Cryptosymrc4Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_range_max(s : Cryptosymrc4Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_range_to_string(s : Cryptosymrc4Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptosymrc4Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_rc4_slice_make(size : Int) -> Cryptosymrc4Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_rc4_slice_len(s : Cryptosymrc4Slice) -> Int { s.size }

pub fn crypto_sym_rc4_slice_get(s : Cryptosymrc4Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_rc4_slice_set(s : Cryptosymrc4Slice, i : Int, v : Double) -> Cryptosymrc4Slice {
  let result = crypto_sym_rc4_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_slice_sum(s : Cryptosymrc4Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn crypto_sym_rc4_slice_mean(s : Cryptosymrc4Slice) -> Double {
  if s.size == 0 { 0.0 } else { crypto_sym_rc4_slice_sum(s) / s.size.to_double() }
}

pub fn crypto_sym_rc4_slice_scale(s : Cryptosymrc4Slice, f : Double) -> Cryptosymrc4Slice {
  let result = crypto_sym_rc4_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn crypto_sym_rc4_slice_add(a : Cryptosymrc4Slice, b : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = crypto_sym_rc4_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn crypto_sym_rc4_slice_copy(s : Cryptosymrc4Slice) -> Cryptosymrc4Slice {
  let result = crypto_sym_rc4_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn crypto_sym_rc4_slice_fill(s : Cryptosymrc4Slice, v : Double) -> Cryptosymrc4Slice {
  let result = crypto_sym_rc4_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn crypto_sym_rc4_slice_min(s : Cryptosymrc4Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_slice_max(s : Cryptosymrc4Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn crypto_sym_rc4_slice_to_string(s : Cryptosymrc4Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


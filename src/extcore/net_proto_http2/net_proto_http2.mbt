///===
/// extcore/net_proto_http2

pub(all) struct Netprotohttp2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http2_make_point(x : Double, y : Double) -> Netprotohttp2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http2_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp2Point {
  { x, y, z, label: 0 }
}

pub fn net_proto_http2_point_x(pt : Netprotohttp2Point) -> Double { pt.x }

pub fn net_proto_http2_point_y(pt : Netprotohttp2Point) -> Double { pt.y }

pub fn net_proto_http2_point_z(pt : Netprotohttp2Point) -> Double { pt.z }

pub fn net_proto_http2_point_label(pt : Netprotohttp2Point) -> Int { pt.label }

pub fn net_proto_http2_point_dist(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_http2_point_add(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_http2_point_sub(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_http2_point_scale(pt : Netprotohttp2Point, s : Double) -> Netprotohttp2Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_http2_point_dot(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_http2_point_cross(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_http2_point_norm(pt : Netprotohttp2Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_http2_point_normalize(pt : Netprotohttp2Point) -> Netprotohttp2Point {
  let n = net_proto_http2_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_http2_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_http2_point_negate(pt : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_http2_point_mid(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_http2_point_lerp(a : Netprotohttp2Point, b : Netprotohttp2Point, t : Double) -> Netprotohttp2Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_http2_point_to_string(pt : Netprotohttp2Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Netprotohttp2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http2_make_series(vals : Array[Double], name : String) -> Netprotohttp2Series {
  { vals, name, meta: 0 }
}

pub fn net_proto_http2_series_len(s : Netprotohttp2Series) -> Int { s.vals.length() }

pub fn net_proto_http2_series_sum(s : Netprotohttp2Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_http2_series_mean(s : Netprotohttp2Series) -> Double { @_common.mean(s.vals) }

pub fn net_proto_http2_series_min(s : Netprotohttp2Series) -> Double { @_common.min(s.vals) }

pub fn net_proto_http2_series_max(s : Netprotohttp2Series) -> Double { @_common.max(s.vals) }

pub fn net_proto_http2_series_range(s : Netprotohttp2Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_proto_http2_series_var(s : Netprotohttp2Series) -> Double { @_common.variance(s.vals) }

pub fn net_proto_http2_series_std(s : Netprotohttp2Series) -> Double { @_common.std(s.vals) }

pub fn net_proto_http2_series_median(s : Netprotohttp2Series) -> Double { @_common.median(s.vals) }

pub fn net_proto_http2_series_scale(s : Netprotohttp2Series, f : Double) -> Netprotohttp2Series {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_http2_series_add(a : Netprotohttp2Series, b : Netprotohttp2Series) -> Netprotohttp2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_http2_series_sub(a : Netprotohttp2Series, b : Netprotohttp2Series) -> Netprotohttp2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_http2_series_normalize(s : Netprotohttp2Series) -> Netprotohttp2Series {
  let mn = net_proto_http2_series_min(s)
  let mx = net_proto_http2_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_http2_series_cumsum(s : Netprotohttp2Series) -> Netprotohttp2Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_http2_series_to_string(s : Netprotohttp2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http2_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http2_matrix_identity(n : Int) -> Netprotohttp2Matrix {
  let m = net_proto_http2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_http2_matrix_get(m : Netprotohttp2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_http2_matrix_transpose(m : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_http2_matrix_add(a : Netprotohttp2Matrix, b : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_http2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_http2_matrix_scale(m : Netprotohttp2Matrix, s : Double) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_http2_matrix_multiply(a : Netprotohttp2Matrix, b : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if a.cols != b.rows { return net_proto_http2_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_http2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_http2_matrix_trace(m : Netprotohttp2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_http2_matrix_det(m : Netprotohttp2Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_http2_matrix_norm(m : Netprotohttp2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_proto_http2_matrix_to_string(m : Netprotohttp2Matrix) -> String {
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

pub(all) struct Netprotohttp2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http2_make_vector(comps : Array[Double]) -> Netprotohttp2Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http2_vector_zero(dim : Int) -> Netprotohttp2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_http2_vector_add(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http2_vector_sub(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http2_vector_scale(v : Netprotohttp2Vector, s : Double) -> Netprotohttp2Vector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_http2_vector_dot(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_http2_vector_norm(v : Netprotohttp2Vector) -> Double { @_common.sqrt(net_proto_http2_vector_dot(v, v)) }

pub fn net_proto_http2_vector_normalize(v : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = net_proto_http2_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_http2_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_http2_vector_dist(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Double {
  net_proto_http2_vector_norm(net_proto_http2_vector_sub(a, b))
}

pub fn net_proto_http2_vector_to_string(v : Netprotohttp2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_http2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_http2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_http2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_http2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_http2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_http2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_http2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_http2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_http2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_http2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_http2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_http2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_http2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_http2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_http2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_http2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_http2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_http2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_http2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_http2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_http2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_http2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_http2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_http2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_http2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_http2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_http2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_http2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Netprotohttp2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_frame_make(size : Int) -> Netprotohttp2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_frame_len(s : Netprotohttp2Frame) -> Int { s.size }

pub fn net_proto_http2_frame_get(s : Netprotohttp2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_frame_set(s : Netprotohttp2Frame, i : Int, v : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_frame_sum(s : Netprotohttp2Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_frame_mean(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_frame_scale(s : Netprotohttp2Frame, f : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_frame_add(a : Netprotohttp2Frame, b : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_frame_copy(s : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_frame_fill(s : Netprotohttp2Frame, v : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_frame_min(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_frame_max(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_frame_to_string(s : Netprotohttp2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_table_make(size : Int) -> Netprotohttp2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_table_len(s : Netprotohttp2Table) -> Int { s.size }

pub fn net_proto_http2_table_get(s : Netprotohttp2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_table_set(s : Netprotohttp2Table, i : Int, v : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_table_sum(s : Netprotohttp2Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_table_mean(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_table_scale(s : Netprotohttp2Table, f : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_table_add(a : Netprotohttp2Table, b : Netprotohttp2Table) -> Netprotohttp2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_table_copy(s : Netprotohttp2Table) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_table_fill(s : Netprotohttp2Table, v : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_table_min(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_table_max(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_table_to_string(s : Netprotohttp2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_graphn_make(size : Int) -> Netprotohttp2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_graphn_len(s : Netprotohttp2GraphN) -> Int { s.size }

pub fn net_proto_http2_graphn_get(s : Netprotohttp2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_graphn_set(s : Netprotohttp2GraphN, i : Int, v : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_graphn_sum(s : Netprotohttp2GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_graphn_mean(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_graphn_scale(s : Netprotohttp2GraphN, f : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_graphn_add(a : Netprotohttp2GraphN, b : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_graphn_copy(s : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_graphn_fill(s : Netprotohttp2GraphN, v : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_graphn_min(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_graphn_max(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_graphn_to_string(s : Netprotohttp2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_node_make(size : Int) -> Netprotohttp2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_node_len(s : Netprotohttp2Node) -> Int { s.size }

pub fn net_proto_http2_node_get(s : Netprotohttp2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_node_set(s : Netprotohttp2Node, i : Int, v : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_node_sum(s : Netprotohttp2Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_node_mean(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_node_scale(s : Netprotohttp2Node, f : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_node_add(a : Netprotohttp2Node, b : Netprotohttp2Node) -> Netprotohttp2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_node_copy(s : Netprotohttp2Node) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_node_fill(s : Netprotohttp2Node, v : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_node_min(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_node_max(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_node_to_string(s : Netprotohttp2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_edge_make(size : Int) -> Netprotohttp2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_edge_len(s : Netprotohttp2Edge) -> Int { s.size }

pub fn net_proto_http2_edge_get(s : Netprotohttp2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_edge_set(s : Netprotohttp2Edge, i : Int, v : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_edge_sum(s : Netprotohttp2Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_edge_mean(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_edge_scale(s : Netprotohttp2Edge, f : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_edge_add(a : Netprotohttp2Edge, b : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_edge_copy(s : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_edge_fill(s : Netprotohttp2Edge, v : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_edge_min(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_edge_max(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_edge_to_string(s : Netprotohttp2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_path_make(size : Int) -> Netprotohttp2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_path_len(s : Netprotohttp2Path) -> Int { s.size }

pub fn net_proto_http2_path_get(s : Netprotohttp2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_path_set(s : Netprotohttp2Path, i : Int, v : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_path_sum(s : Netprotohttp2Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_path_mean(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_path_scale(s : Netprotohttp2Path, f : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_path_add(a : Netprotohttp2Path, b : Netprotohttp2Path) -> Netprotohttp2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_path_copy(s : Netprotohttp2Path) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_path_fill(s : Netprotohttp2Path, v : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_path_min(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_path_max(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_path_to_string(s : Netprotohttp2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cluster_make(size : Int) -> Netprotohttp2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cluster_len(s : Netprotohttp2Cluster) -> Int { s.size }

pub fn net_proto_http2_cluster_get(s : Netprotohttp2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cluster_set(s : Netprotohttp2Cluster, i : Int, v : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cluster_sum(s : Netprotohttp2Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_cluster_mean(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_cluster_scale(s : Netprotohttp2Cluster, f : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_cluster_add(a : Netprotohttp2Cluster, b : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_cluster_copy(s : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_cluster_fill(s : Netprotohttp2Cluster, v : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cluster_min(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cluster_max(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cluster_to_string(s : Netprotohttp2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_model_make(size : Int) -> Netprotohttp2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_model_len(s : Netprotohttp2Model) -> Int { s.size }

pub fn net_proto_http2_model_get(s : Netprotohttp2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_model_set(s : Netprotohttp2Model, i : Int, v : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_model_sum(s : Netprotohttp2Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_model_mean(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_model_scale(s : Netprotohttp2Model, f : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_model_add(a : Netprotohttp2Model, b : Netprotohttp2Model) -> Netprotohttp2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_model_copy(s : Netprotohttp2Model) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_model_fill(s : Netprotohttp2Model, v : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_model_min(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_model_max(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_model_to_string(s : Netprotohttp2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_layer_make(size : Int) -> Netprotohttp2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_layer_len(s : Netprotohttp2Layer) -> Int { s.size }

pub fn net_proto_http2_layer_get(s : Netprotohttp2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_layer_set(s : Netprotohttp2Layer, i : Int, v : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_layer_sum(s : Netprotohttp2Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_layer_mean(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_layer_scale(s : Netprotohttp2Layer, f : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_layer_add(a : Netprotohttp2Layer, b : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_layer_copy(s : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_layer_fill(s : Netprotohttp2Layer, v : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_layer_min(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_layer_max(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_layer_to_string(s : Netprotohttp2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_buffer_make(size : Int) -> Netprotohttp2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_buffer_len(s : Netprotohttp2Buffer) -> Int { s.size }

pub fn net_proto_http2_buffer_get(s : Netprotohttp2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_buffer_set(s : Netprotohttp2Buffer, i : Int, v : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_buffer_sum(s : Netprotohttp2Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_buffer_mean(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_buffer_scale(s : Netprotohttp2Buffer, f : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_buffer_add(a : Netprotohttp2Buffer, b : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_buffer_copy(s : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_buffer_fill(s : Netprotohttp2Buffer, v : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_buffer_min(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_buffer_max(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_buffer_to_string(s : Netprotohttp2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cursor_make(size : Int) -> Netprotohttp2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cursor_len(s : Netprotohttp2Cursor) -> Int { s.size }

pub fn net_proto_http2_cursor_get(s : Netprotohttp2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cursor_set(s : Netprotohttp2Cursor, i : Int, v : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cursor_sum(s : Netprotohttp2Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_cursor_mean(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_cursor_scale(s : Netprotohttp2Cursor, f : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_cursor_add(a : Netprotohttp2Cursor, b : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_cursor_copy(s : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_cursor_fill(s : Netprotohttp2Cursor, v : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cursor_min(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cursor_max(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cursor_to_string(s : Netprotohttp2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_view_make(size : Int) -> Netprotohttp2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_view_len(s : Netprotohttp2View) -> Int { s.size }

pub fn net_proto_http2_view_get(s : Netprotohttp2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_view_set(s : Netprotohttp2View, i : Int, v : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_view_sum(s : Netprotohttp2View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_view_mean(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_view_scale(s : Netprotohttp2View, f : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_view_add(a : Netprotohttp2View, b : Netprotohttp2View) -> Netprotohttp2View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_view_copy(s : Netprotohttp2View) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_view_fill(s : Netprotohttp2View, v : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_view_min(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_view_max(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_view_to_string(s : Netprotohttp2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_range_make(size : Int) -> Netprotohttp2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_range_len(s : Netprotohttp2Range) -> Int { s.size }

pub fn net_proto_http2_range_get(s : Netprotohttp2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_range_set(s : Netprotohttp2Range, i : Int, v : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_range_sum(s : Netprotohttp2Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_range_mean(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_range_scale(s : Netprotohttp2Range, f : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_range_add(a : Netprotohttp2Range, b : Netprotohttp2Range) -> Netprotohttp2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_range_copy(s : Netprotohttp2Range) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_range_fill(s : Netprotohttp2Range, v : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_range_min(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_range_max(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_range_to_string(s : Netprotohttp2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_slice_make(size : Int) -> Netprotohttp2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_slice_len(s : Netprotohttp2Slice) -> Int { s.size }

pub fn net_proto_http2_slice_get(s : Netprotohttp2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_slice_set(s : Netprotohttp2Slice, i : Int, v : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_slice_sum(s : Netprotohttp2Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_slice_mean(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_slice_scale(s : Netprotohttp2Slice, f : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_slice_add(a : Netprotohttp2Slice, b : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_slice_copy(s : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_slice_fill(s : Netprotohttp2Slice, v : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_slice_min(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_slice_max(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_slice_to_string(s : Netprotohttp2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


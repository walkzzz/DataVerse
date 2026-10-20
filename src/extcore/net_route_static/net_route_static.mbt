///===
/// extcore/net_route_static

pub(all) struct NetroutestaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_static_make_point(x : Double, y : Double) -> NetroutestaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_static_make_point3(x : Double, y : Double, z : Double) -> NetroutestaticPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_static_point_x(pt : NetroutestaticPoint) -> Double { pt.x }

pub fn net_route_static_point_y(pt : NetroutestaticPoint) -> Double { pt.y }

pub fn net_route_static_point_z(pt : NetroutestaticPoint) -> Double { pt.z }

pub fn net_route_static_point_label(pt : NetroutestaticPoint) -> Int { pt.label }

pub fn net_route_static_point_dist(a : NetroutestaticPoint, b : NetroutestaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_static_point_add(a : NetroutestaticPoint, b : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_static_point_sub(a : NetroutestaticPoint, b : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_static_point_scale(pt : NetroutestaticPoint, s : Double) -> NetroutestaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_static_point_dot(a : NetroutestaticPoint, b : NetroutestaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_static_point_cross(a : NetroutestaticPoint, b : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_static_point_norm(pt : NetroutestaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_static_point_normalize(pt : NetroutestaticPoint) -> NetroutestaticPoint {
  let n = net_route_static_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_static_point_scale(pt, 1.0 / n) }
}

pub fn net_route_static_point_negate(pt : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_static_point_mid(a : NetroutestaticPoint, b : NetroutestaticPoint) -> NetroutestaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_static_point_lerp(a : NetroutestaticPoint, b : NetroutestaticPoint, t : Double) -> NetroutestaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_static_point_to_string(pt : NetroutestaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutestaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_static_make_series(vals : Array[Double], name : String) -> NetroutestaticSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_static_series_len(s : NetroutestaticSeries) -> Int { s.vals.length() }

pub fn net_route_static_series_sum(s : NetroutestaticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_static_series_mean(s : NetroutestaticSeries) -> Double { @_common.mean(s.vals) }

pub fn net_route_static_series_min(s : NetroutestaticSeries) -> Double { @_common.min(s.vals) }

pub fn net_route_static_series_max(s : NetroutestaticSeries) -> Double { @_common.max(s.vals) }

pub fn net_route_static_series_range(s : NetroutestaticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn net_route_static_series_var(s : NetroutestaticSeries) -> Double { @_common.variance(s.vals) }

pub fn net_route_static_series_std(s : NetroutestaticSeries) -> Double { @_common.std(s.vals) }

pub fn net_route_static_series_median(s : NetroutestaticSeries) -> Double { @_common.median(s.vals) }

pub fn net_route_static_series_scale(s : NetroutestaticSeries, f : Double) -> NetroutestaticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_static_series_add(a : NetroutestaticSeries, b : NetroutestaticSeries) -> NetroutestaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_static_series_sub(a : NetroutestaticSeries, b : NetroutestaticSeries) -> NetroutestaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_static_series_normalize(s : NetroutestaticSeries) -> NetroutestaticSeries {
  let mn = net_route_static_series_min(s)
  let mx = net_route_static_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_static_series_cumsum(s : NetroutestaticSeries) -> NetroutestaticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_static_series_to_string(s : NetroutestaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutestaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_static_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutestaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_static_matrix_identity(n : Int) -> NetroutestaticMatrix {
  let m = net_route_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_static_matrix_get(m : NetroutestaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_static_matrix_transpose(m : NetroutestaticMatrix) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_static_matrix_add(a : NetroutestaticMatrix, b : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_static_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_static_matrix_scale(m : NetroutestaticMatrix, s : Double) -> NetroutestaticMatrix {
  let result = net_route_static_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_static_matrix_multiply(a : NetroutestaticMatrix, b : NetroutestaticMatrix) -> NetroutestaticMatrix {
  if a.cols != b.rows { return net_route_static_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_static_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_static_matrix_trace(m : NetroutestaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_static_matrix_det(m : NetroutestaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_static_matrix_norm(m : NetroutestaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_static_matrix_to_string(m : NetroutestaticMatrix) -> String {
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

pub(all) struct NetroutestaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_static_make_vector(comps : Array[Double]) -> NetroutestaticVector {
  { comps, dim: comps.length() }
}

pub fn net_route_static_vector_zero(dim : Int) -> NetroutestaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_static_vector_add(a : NetroutestaticVector, b : NetroutestaticVector) -> NetroutestaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_static_vector_sub(a : NetroutestaticVector, b : NetroutestaticVector) -> NetroutestaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_static_vector_scale(v : NetroutestaticVector, s : Double) -> NetroutestaticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_static_vector_dot(a : NetroutestaticVector, b : NetroutestaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_static_vector_norm(v : NetroutestaticVector) -> Double { @_common.sqrt(net_route_static_vector_dot(v, v)) }

pub fn net_route_static_vector_normalize(v : NetroutestaticVector) -> NetroutestaticVector {
  let n = net_route_static_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_static_vector_scale(v, 1.0 / n) }
}

pub fn net_route_static_vector_dist(a : NetroutestaticVector, b : NetroutestaticVector) -> Double {
  net_route_static_vector_norm(net_route_static_vector_sub(a, b))
}

pub fn net_route_static_vector_to_string(v : NetroutestaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_static_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_static_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_static_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_static_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_static_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_static_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_static_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_static_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_static_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_static_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_static_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_static_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_static_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_static_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_static_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_static_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_static_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_static_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_static_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_static_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_static_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_static_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_static_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_static_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_static_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_static_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_static_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_static_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_static_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutestaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_frame_make(size : Int) -> NetroutestaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_frame_len(s : NetroutestaticFrame) -> Int { s.size }

pub fn net_route_static_frame_get(s : NetroutestaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_frame_set(s : NetroutestaticFrame, i : Int, v : Double) -> NetroutestaticFrame {
  let result = net_route_static_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_frame_sum(s : NetroutestaticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_frame_mean(s : NetroutestaticFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_static_frame_scale(s : NetroutestaticFrame, f : Double) -> NetroutestaticFrame {
  let result = net_route_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_frame_add(a : NetroutestaticFrame, b : NetroutestaticFrame) -> NetroutestaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_frame_copy(s : NetroutestaticFrame) -> NetroutestaticFrame {
  let result = net_route_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_frame_fill(s : NetroutestaticFrame, v : Double) -> NetroutestaticFrame {
  let result = net_route_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_frame_min(s : NetroutestaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_frame_max(s : NetroutestaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_frame_to_string(s : NetroutestaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_table_make(size : Int) -> NetroutestaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_table_len(s : NetroutestaticTable) -> Int { s.size }

pub fn net_route_static_table_get(s : NetroutestaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_table_set(s : NetroutestaticTable, i : Int, v : Double) -> NetroutestaticTable {
  let result = net_route_static_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_table_sum(s : NetroutestaticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_table_mean(s : NetroutestaticTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_table_sum(s) / s.size.to_double() }
}

pub fn net_route_static_table_scale(s : NetroutestaticTable, f : Double) -> NetroutestaticTable {
  let result = net_route_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_table_add(a : NetroutestaticTable, b : NetroutestaticTable) -> NetroutestaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_table_copy(s : NetroutestaticTable) -> NetroutestaticTable {
  let result = net_route_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_table_fill(s : NetroutestaticTable, v : Double) -> NetroutestaticTable {
  let result = net_route_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_table_min(s : NetroutestaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_table_max(s : NetroutestaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_table_to_string(s : NetroutestaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_graphn_make(size : Int) -> NetroutestaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_graphn_len(s : NetroutestaticGraphN) -> Int { s.size }

pub fn net_route_static_graphn_get(s : NetroutestaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_graphn_set(s : NetroutestaticGraphN, i : Int, v : Double) -> NetroutestaticGraphN {
  let result = net_route_static_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_graphn_sum(s : NetroutestaticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_graphn_mean(s : NetroutestaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_static_graphn_scale(s : NetroutestaticGraphN, f : Double) -> NetroutestaticGraphN {
  let result = net_route_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_graphn_add(a : NetroutestaticGraphN, b : NetroutestaticGraphN) -> NetroutestaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_graphn_copy(s : NetroutestaticGraphN) -> NetroutestaticGraphN {
  let result = net_route_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_graphn_fill(s : NetroutestaticGraphN, v : Double) -> NetroutestaticGraphN {
  let result = net_route_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_graphn_min(s : NetroutestaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_graphn_max(s : NetroutestaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_graphn_to_string(s : NetroutestaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_node_make(size : Int) -> NetroutestaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_node_len(s : NetroutestaticNode) -> Int { s.size }

pub fn net_route_static_node_get(s : NetroutestaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_node_set(s : NetroutestaticNode, i : Int, v : Double) -> NetroutestaticNode {
  let result = net_route_static_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_node_sum(s : NetroutestaticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_node_mean(s : NetroutestaticNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_node_sum(s) / s.size.to_double() }
}

pub fn net_route_static_node_scale(s : NetroutestaticNode, f : Double) -> NetroutestaticNode {
  let result = net_route_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_node_add(a : NetroutestaticNode, b : NetroutestaticNode) -> NetroutestaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_node_copy(s : NetroutestaticNode) -> NetroutestaticNode {
  let result = net_route_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_node_fill(s : NetroutestaticNode, v : Double) -> NetroutestaticNode {
  let result = net_route_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_node_min(s : NetroutestaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_node_max(s : NetroutestaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_node_to_string(s : NetroutestaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_edge_make(size : Int) -> NetroutestaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_edge_len(s : NetroutestaticEdge) -> Int { s.size }

pub fn net_route_static_edge_get(s : NetroutestaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_edge_set(s : NetroutestaticEdge, i : Int, v : Double) -> NetroutestaticEdge {
  let result = net_route_static_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_edge_sum(s : NetroutestaticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_edge_mean(s : NetroutestaticEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_static_edge_scale(s : NetroutestaticEdge, f : Double) -> NetroutestaticEdge {
  let result = net_route_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_edge_add(a : NetroutestaticEdge, b : NetroutestaticEdge) -> NetroutestaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_edge_copy(s : NetroutestaticEdge) -> NetroutestaticEdge {
  let result = net_route_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_edge_fill(s : NetroutestaticEdge, v : Double) -> NetroutestaticEdge {
  let result = net_route_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_edge_min(s : NetroutestaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_edge_max(s : NetroutestaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_edge_to_string(s : NetroutestaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_path_make(size : Int) -> NetroutestaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_path_len(s : NetroutestaticPath) -> Int { s.size }

pub fn net_route_static_path_get(s : NetroutestaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_path_set(s : NetroutestaticPath, i : Int, v : Double) -> NetroutestaticPath {
  let result = net_route_static_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_path_sum(s : NetroutestaticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_path_mean(s : NetroutestaticPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_path_sum(s) / s.size.to_double() }
}

pub fn net_route_static_path_scale(s : NetroutestaticPath, f : Double) -> NetroutestaticPath {
  let result = net_route_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_path_add(a : NetroutestaticPath, b : NetroutestaticPath) -> NetroutestaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_path_copy(s : NetroutestaticPath) -> NetroutestaticPath {
  let result = net_route_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_path_fill(s : NetroutestaticPath, v : Double) -> NetroutestaticPath {
  let result = net_route_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_path_min(s : NetroutestaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_path_max(s : NetroutestaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_path_to_string(s : NetroutestaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cluster_make(size : Int) -> NetroutestaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_cluster_len(s : NetroutestaticCluster) -> Int { s.size }

pub fn net_route_static_cluster_get(s : NetroutestaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_cluster_set(s : NetroutestaticCluster, i : Int, v : Double) -> NetroutestaticCluster {
  let result = net_route_static_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_cluster_sum(s : NetroutestaticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_cluster_mean(s : NetroutestaticCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_static_cluster_scale(s : NetroutestaticCluster, f : Double) -> NetroutestaticCluster {
  let result = net_route_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_cluster_add(a : NetroutestaticCluster, b : NetroutestaticCluster) -> NetroutestaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_cluster_copy(s : NetroutestaticCluster) -> NetroutestaticCluster {
  let result = net_route_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_cluster_fill(s : NetroutestaticCluster, v : Double) -> NetroutestaticCluster {
  let result = net_route_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_cluster_min(s : NetroutestaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_cluster_max(s : NetroutestaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_cluster_to_string(s : NetroutestaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_model_make(size : Int) -> NetroutestaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_model_len(s : NetroutestaticModel) -> Int { s.size }

pub fn net_route_static_model_get(s : NetroutestaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_model_set(s : NetroutestaticModel, i : Int, v : Double) -> NetroutestaticModel {
  let result = net_route_static_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_model_sum(s : NetroutestaticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_model_mean(s : NetroutestaticModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_model_sum(s) / s.size.to_double() }
}

pub fn net_route_static_model_scale(s : NetroutestaticModel, f : Double) -> NetroutestaticModel {
  let result = net_route_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_model_add(a : NetroutestaticModel, b : NetroutestaticModel) -> NetroutestaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_model_copy(s : NetroutestaticModel) -> NetroutestaticModel {
  let result = net_route_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_model_fill(s : NetroutestaticModel, v : Double) -> NetroutestaticModel {
  let result = net_route_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_model_min(s : NetroutestaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_model_max(s : NetroutestaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_model_to_string(s : NetroutestaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_layer_make(size : Int) -> NetroutestaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_layer_len(s : NetroutestaticLayer) -> Int { s.size }

pub fn net_route_static_layer_get(s : NetroutestaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_layer_set(s : NetroutestaticLayer, i : Int, v : Double) -> NetroutestaticLayer {
  let result = net_route_static_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_layer_sum(s : NetroutestaticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_layer_mean(s : NetroutestaticLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_static_layer_scale(s : NetroutestaticLayer, f : Double) -> NetroutestaticLayer {
  let result = net_route_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_layer_add(a : NetroutestaticLayer, b : NetroutestaticLayer) -> NetroutestaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_layer_copy(s : NetroutestaticLayer) -> NetroutestaticLayer {
  let result = net_route_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_layer_fill(s : NetroutestaticLayer, v : Double) -> NetroutestaticLayer {
  let result = net_route_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_layer_min(s : NetroutestaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_layer_max(s : NetroutestaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_layer_to_string(s : NetroutestaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_buffer_make(size : Int) -> NetroutestaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_buffer_len(s : NetroutestaticBuffer) -> Int { s.size }

pub fn net_route_static_buffer_get(s : NetroutestaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_buffer_set(s : NetroutestaticBuffer, i : Int, v : Double) -> NetroutestaticBuffer {
  let result = net_route_static_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_buffer_sum(s : NetroutestaticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_buffer_mean(s : NetroutestaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_static_buffer_scale(s : NetroutestaticBuffer, f : Double) -> NetroutestaticBuffer {
  let result = net_route_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_buffer_add(a : NetroutestaticBuffer, b : NetroutestaticBuffer) -> NetroutestaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_buffer_copy(s : NetroutestaticBuffer) -> NetroutestaticBuffer {
  let result = net_route_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_buffer_fill(s : NetroutestaticBuffer, v : Double) -> NetroutestaticBuffer {
  let result = net_route_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_buffer_min(s : NetroutestaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_buffer_max(s : NetroutestaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_buffer_to_string(s : NetroutestaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_cursor_make(size : Int) -> NetroutestaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_cursor_len(s : NetroutestaticCursor) -> Int { s.size }

pub fn net_route_static_cursor_get(s : NetroutestaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_cursor_set(s : NetroutestaticCursor, i : Int, v : Double) -> NetroutestaticCursor {
  let result = net_route_static_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_cursor_sum(s : NetroutestaticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_cursor_mean(s : NetroutestaticCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_static_cursor_scale(s : NetroutestaticCursor, f : Double) -> NetroutestaticCursor {
  let result = net_route_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_cursor_add(a : NetroutestaticCursor, b : NetroutestaticCursor) -> NetroutestaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_cursor_copy(s : NetroutestaticCursor) -> NetroutestaticCursor {
  let result = net_route_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_cursor_fill(s : NetroutestaticCursor, v : Double) -> NetroutestaticCursor {
  let result = net_route_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_cursor_min(s : NetroutestaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_cursor_max(s : NetroutestaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_cursor_to_string(s : NetroutestaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_view_make(size : Int) -> NetroutestaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_view_len(s : NetroutestaticView) -> Int { s.size }

pub fn net_route_static_view_get(s : NetroutestaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_view_set(s : NetroutestaticView, i : Int, v : Double) -> NetroutestaticView {
  let result = net_route_static_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_view_sum(s : NetroutestaticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_view_mean(s : NetroutestaticView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_view_sum(s) / s.size.to_double() }
}

pub fn net_route_static_view_scale(s : NetroutestaticView, f : Double) -> NetroutestaticView {
  let result = net_route_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_view_add(a : NetroutestaticView, b : NetroutestaticView) -> NetroutestaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_view_copy(s : NetroutestaticView) -> NetroutestaticView {
  let result = net_route_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_view_fill(s : NetroutestaticView, v : Double) -> NetroutestaticView {
  let result = net_route_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_view_min(s : NetroutestaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_view_max(s : NetroutestaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_view_to_string(s : NetroutestaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_range_make(size : Int) -> NetroutestaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_range_len(s : NetroutestaticRange) -> Int { s.size }

pub fn net_route_static_range_get(s : NetroutestaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_range_set(s : NetroutestaticRange, i : Int, v : Double) -> NetroutestaticRange {
  let result = net_route_static_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_range_sum(s : NetroutestaticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_range_mean(s : NetroutestaticRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_range_sum(s) / s.size.to_double() }
}

pub fn net_route_static_range_scale(s : NetroutestaticRange, f : Double) -> NetroutestaticRange {
  let result = net_route_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_range_add(a : NetroutestaticRange, b : NetroutestaticRange) -> NetroutestaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_range_copy(s : NetroutestaticRange) -> NetroutestaticRange {
  let result = net_route_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_range_fill(s : NetroutestaticRange, v : Double) -> NetroutestaticRange {
  let result = net_route_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_range_min(s : NetroutestaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_range_max(s : NetroutestaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_range_to_string(s : NetroutestaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutestaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_static_slice_make(size : Int) -> NetroutestaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_static_slice_len(s : NetroutestaticSlice) -> Int { s.size }

pub fn net_route_static_slice_get(s : NetroutestaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_static_slice_set(s : NetroutestaticSlice, i : Int, v : Double) -> NetroutestaticSlice {
  let result = net_route_static_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_static_slice_sum(s : NetroutestaticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_static_slice_mean(s : NetroutestaticSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_static_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_static_slice_scale(s : NetroutestaticSlice, f : Double) -> NetroutestaticSlice {
  let result = net_route_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_static_slice_add(a : NetroutestaticSlice, b : NetroutestaticSlice) -> NetroutestaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_static_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_static_slice_copy(s : NetroutestaticSlice) -> NetroutestaticSlice {
  let result = net_route_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_static_slice_fill(s : NetroutestaticSlice, v : Double) -> NetroutestaticSlice {
  let result = net_route_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_static_slice_min(s : NetroutestaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_slice_max(s : NetroutestaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_static_slice_to_string(s : NetroutestaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


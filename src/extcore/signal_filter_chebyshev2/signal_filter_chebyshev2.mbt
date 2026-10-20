///===
/// extcore/signal_filter_chebyshev2

pub(all) struct Signalfilterchebyshev2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_chebyshev2_make_point(x : Double, y : Double) -> Signalfilterchebyshev2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_chebyshev2_make_point3(x : Double, y : Double, z : Double) -> Signalfilterchebyshev2Point {
  { x, y, z, label: 0 }
}

pub fn signal_filter_chebyshev2_point_x(pt : Signalfilterchebyshev2Point) -> Double { pt.x }

pub fn signal_filter_chebyshev2_point_y(pt : Signalfilterchebyshev2Point) -> Double { pt.y }

pub fn signal_filter_chebyshev2_point_z(pt : Signalfilterchebyshev2Point) -> Double { pt.z }

pub fn signal_filter_chebyshev2_point_label(pt : Signalfilterchebyshev2Point) -> Int { pt.label }

pub fn signal_filter_chebyshev2_point_dist(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_chebyshev2_point_add(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_chebyshev2_point_sub(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_chebyshev2_point_scale(pt : Signalfilterchebyshev2Point, s : Double) -> Signalfilterchebyshev2Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_chebyshev2_point_dot(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_chebyshev2_point_cross(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_chebyshev2_point_norm(pt : Signalfilterchebyshev2Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_chebyshev2_point_normalize(pt : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  let n = signal_filter_chebyshev2_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_chebyshev2_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_chebyshev2_point_negate(pt : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_chebyshev2_point_mid(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_chebyshev2_point_lerp(a : Signalfilterchebyshev2Point, b : Signalfilterchebyshev2Point, t : Double) -> Signalfilterchebyshev2Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_chebyshev2_point_to_string(pt : Signalfilterchebyshev2Point) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_chebyshev2_make_series(vals : Array[Double], name : String) -> Signalfilterchebyshev2Series {
  { vals, name, meta: 0 }
}

pub fn signal_filter_chebyshev2_series_len(s : Signalfilterchebyshev2Series) -> Int { s.vals.length() }

pub fn signal_filter_chebyshev2_series_sum(s : Signalfilterchebyshev2Series) -> Double { @_common.sum(s.vals) }

pub fn signal_filter_chebyshev2_series_mean(s : Signalfilterchebyshev2Series) -> Double { @_common.mean(s.vals) }

pub fn signal_filter_chebyshev2_series_min(s : Signalfilterchebyshev2Series) -> Double { @_common.min(s.vals) }

pub fn signal_filter_chebyshev2_series_max(s : Signalfilterchebyshev2Series) -> Double { @_common.max(s.vals) }

pub fn signal_filter_chebyshev2_series_range(s : Signalfilterchebyshev2Series) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn signal_filter_chebyshev2_series_var(s : Signalfilterchebyshev2Series) -> Double { @_common.variance(s.vals) }

pub fn signal_filter_chebyshev2_series_std(s : Signalfilterchebyshev2Series) -> Double { @_common.std(s.vals) }

pub fn signal_filter_chebyshev2_series_median(s : Signalfilterchebyshev2Series) -> Double { @_common.median(s.vals) }

pub fn signal_filter_chebyshev2_series_scale(s : Signalfilterchebyshev2Series, f : Double) -> Signalfilterchebyshev2Series {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn signal_filter_chebyshev2_series_add(a : Signalfilterchebyshev2Series, b : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_chebyshev2_series_sub(a : Signalfilterchebyshev2Series, b : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_chebyshev2_series_normalize(s : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  let mn = signal_filter_chebyshev2_series_min(s)
  let mx = signal_filter_chebyshev2_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_chebyshev2_series_cumsum(s : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_chebyshev2_series_to_string(s : Signalfilterchebyshev2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_chebyshev2_make_matrix(rows : Int, cols : Int, val : Double) -> Signalfilterchebyshev2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_chebyshev2_matrix_identity(n : Int) -> Signalfilterchebyshev2Matrix {
  let m = signal_filter_chebyshev2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_chebyshev2_matrix_get(m : Signalfilterchebyshev2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_chebyshev2_matrix_transpose(m : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_chebyshev2_matrix_add(a : Signalfilterchebyshev2Matrix, b : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_chebyshev2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_chebyshev2_matrix_scale(m : Signalfilterchebyshev2Matrix, s : Double) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_chebyshev2_matrix_multiply(a : Signalfilterchebyshev2Matrix, b : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  if a.cols != b.rows { return signal_filter_chebyshev2_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_chebyshev2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_chebyshev2_matrix_trace(m : Signalfilterchebyshev2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_chebyshev2_matrix_det(m : Signalfilterchebyshev2Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_chebyshev2_matrix_norm(m : Signalfilterchebyshev2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn signal_filter_chebyshev2_matrix_to_string(m : Signalfilterchebyshev2Matrix) -> String {
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

pub(all) struct Signalfilterchebyshev2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_chebyshev2_make_vector(comps : Array[Double]) -> Signalfilterchebyshev2Vector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_chebyshev2_vector_zero(dim : Int) -> Signalfilterchebyshev2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_chebyshev2_vector_add(a : Signalfilterchebyshev2Vector, b : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn signal_filter_chebyshev2_vector_sub(a : Signalfilterchebyshev2Vector, b : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn signal_filter_chebyshev2_vector_scale(v : Signalfilterchebyshev2Vector, s : Double) -> Signalfilterchebyshev2Vector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn signal_filter_chebyshev2_vector_dot(a : Signalfilterchebyshev2Vector, b : Signalfilterchebyshev2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_chebyshev2_vector_norm(v : Signalfilterchebyshev2Vector) -> Double { @_common.sqrt(signal_filter_chebyshev2_vector_dot(v, v)) }

pub fn signal_filter_chebyshev2_vector_normalize(v : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = signal_filter_chebyshev2_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_chebyshev2_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_chebyshev2_vector_dist(a : Signalfilterchebyshev2Vector, b : Signalfilterchebyshev2Vector) -> Double {
  signal_filter_chebyshev2_vector_norm(signal_filter_chebyshev2_vector_sub(a, b))
}

pub fn signal_filter_chebyshev2_vector_to_string(v : Signalfilterchebyshev2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_chebyshev2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_chebyshev2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_chebyshev2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_chebyshev2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_chebyshev2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_chebyshev2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_chebyshev2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_chebyshev2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_chebyshev2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_chebyshev2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_chebyshev2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_chebyshev2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_chebyshev2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_chebyshev2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_chebyshev2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_chebyshev2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_chebyshev2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_chebyshev2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_chebyshev2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_chebyshev2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_chebyshev2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_chebyshev2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_chebyshev2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_chebyshev2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_chebyshev2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_chebyshev2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_chebyshev2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_chebyshev2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_chebyshev2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Signalfilterchebyshev2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_frame_make(size : Int) -> Signalfilterchebyshev2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_frame_len(s : Signalfilterchebyshev2Frame) -> Int { s.size }

pub fn signal_filter_chebyshev2_frame_get(s : Signalfilterchebyshev2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_frame_set(s : Signalfilterchebyshev2Frame, i : Int, v : Double) -> Signalfilterchebyshev2Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_sum(s : Signalfilterchebyshev2Frame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_frame_mean(s : Signalfilterchebyshev2Frame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_frame_scale(s : Signalfilterchebyshev2Frame, f : Double) -> Signalfilterchebyshev2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_add(a : Signalfilterchebyshev2Frame, b : Signalfilterchebyshev2Frame) -> Signalfilterchebyshev2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_frame_copy(s : Signalfilterchebyshev2Frame) -> Signalfilterchebyshev2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_fill(s : Signalfilterchebyshev2Frame, v : Double) -> Signalfilterchebyshev2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_min(s : Signalfilterchebyshev2Frame) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_frame_max(s : Signalfilterchebyshev2Frame) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_frame_to_string(s : Signalfilterchebyshev2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_table_make(size : Int) -> Signalfilterchebyshev2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_table_len(s : Signalfilterchebyshev2Table) -> Int { s.size }

pub fn signal_filter_chebyshev2_table_get(s : Signalfilterchebyshev2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_table_set(s : Signalfilterchebyshev2Table, i : Int, v : Double) -> Signalfilterchebyshev2Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_sum(s : Signalfilterchebyshev2Table) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_table_mean(s : Signalfilterchebyshev2Table) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_table_scale(s : Signalfilterchebyshev2Table, f : Double) -> Signalfilterchebyshev2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_add(a : Signalfilterchebyshev2Table, b : Signalfilterchebyshev2Table) -> Signalfilterchebyshev2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_table_copy(s : Signalfilterchebyshev2Table) -> Signalfilterchebyshev2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_fill(s : Signalfilterchebyshev2Table, v : Double) -> Signalfilterchebyshev2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_min(s : Signalfilterchebyshev2Table) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_table_max(s : Signalfilterchebyshev2Table) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_table_to_string(s : Signalfilterchebyshev2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_graphn_make(size : Int) -> Signalfilterchebyshev2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_graphn_len(s : Signalfilterchebyshev2GraphN) -> Int { s.size }

pub fn signal_filter_chebyshev2_graphn_get(s : Signalfilterchebyshev2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_graphn_set(s : Signalfilterchebyshev2GraphN, i : Int, v : Double) -> Signalfilterchebyshev2GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_sum(s : Signalfilterchebyshev2GraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_graphn_mean(s : Signalfilterchebyshev2GraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_graphn_scale(s : Signalfilterchebyshev2GraphN, f : Double) -> Signalfilterchebyshev2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_add(a : Signalfilterchebyshev2GraphN, b : Signalfilterchebyshev2GraphN) -> Signalfilterchebyshev2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_graphn_copy(s : Signalfilterchebyshev2GraphN) -> Signalfilterchebyshev2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_fill(s : Signalfilterchebyshev2GraphN, v : Double) -> Signalfilterchebyshev2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_min(s : Signalfilterchebyshev2GraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_graphn_max(s : Signalfilterchebyshev2GraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_graphn_to_string(s : Signalfilterchebyshev2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_node_make(size : Int) -> Signalfilterchebyshev2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_node_len(s : Signalfilterchebyshev2Node) -> Int { s.size }

pub fn signal_filter_chebyshev2_node_get(s : Signalfilterchebyshev2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_node_set(s : Signalfilterchebyshev2Node, i : Int, v : Double) -> Signalfilterchebyshev2Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_sum(s : Signalfilterchebyshev2Node) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_node_mean(s : Signalfilterchebyshev2Node) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_node_scale(s : Signalfilterchebyshev2Node, f : Double) -> Signalfilterchebyshev2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_add(a : Signalfilterchebyshev2Node, b : Signalfilterchebyshev2Node) -> Signalfilterchebyshev2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_node_copy(s : Signalfilterchebyshev2Node) -> Signalfilterchebyshev2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_fill(s : Signalfilterchebyshev2Node, v : Double) -> Signalfilterchebyshev2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_min(s : Signalfilterchebyshev2Node) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_node_max(s : Signalfilterchebyshev2Node) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_node_to_string(s : Signalfilterchebyshev2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_edge_make(size : Int) -> Signalfilterchebyshev2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_edge_len(s : Signalfilterchebyshev2Edge) -> Int { s.size }

pub fn signal_filter_chebyshev2_edge_get(s : Signalfilterchebyshev2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_edge_set(s : Signalfilterchebyshev2Edge, i : Int, v : Double) -> Signalfilterchebyshev2Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_sum(s : Signalfilterchebyshev2Edge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_edge_mean(s : Signalfilterchebyshev2Edge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_edge_scale(s : Signalfilterchebyshev2Edge, f : Double) -> Signalfilterchebyshev2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_add(a : Signalfilterchebyshev2Edge, b : Signalfilterchebyshev2Edge) -> Signalfilterchebyshev2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_edge_copy(s : Signalfilterchebyshev2Edge) -> Signalfilterchebyshev2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_fill(s : Signalfilterchebyshev2Edge, v : Double) -> Signalfilterchebyshev2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_min(s : Signalfilterchebyshev2Edge) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_edge_max(s : Signalfilterchebyshev2Edge) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_edge_to_string(s : Signalfilterchebyshev2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_path_make(size : Int) -> Signalfilterchebyshev2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_path_len(s : Signalfilterchebyshev2Path) -> Int { s.size }

pub fn signal_filter_chebyshev2_path_get(s : Signalfilterchebyshev2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_path_set(s : Signalfilterchebyshev2Path, i : Int, v : Double) -> Signalfilterchebyshev2Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_sum(s : Signalfilterchebyshev2Path) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_path_mean(s : Signalfilterchebyshev2Path) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_path_scale(s : Signalfilterchebyshev2Path, f : Double) -> Signalfilterchebyshev2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_add(a : Signalfilterchebyshev2Path, b : Signalfilterchebyshev2Path) -> Signalfilterchebyshev2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_path_copy(s : Signalfilterchebyshev2Path) -> Signalfilterchebyshev2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_fill(s : Signalfilterchebyshev2Path, v : Double) -> Signalfilterchebyshev2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_min(s : Signalfilterchebyshev2Path) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_path_max(s : Signalfilterchebyshev2Path) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_path_to_string(s : Signalfilterchebyshev2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_cluster_make(size : Int) -> Signalfilterchebyshev2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_cluster_len(s : Signalfilterchebyshev2Cluster) -> Int { s.size }

pub fn signal_filter_chebyshev2_cluster_get(s : Signalfilterchebyshev2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_cluster_set(s : Signalfilterchebyshev2Cluster, i : Int, v : Double) -> Signalfilterchebyshev2Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_sum(s : Signalfilterchebyshev2Cluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_cluster_mean(s : Signalfilterchebyshev2Cluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_cluster_scale(s : Signalfilterchebyshev2Cluster, f : Double) -> Signalfilterchebyshev2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_add(a : Signalfilterchebyshev2Cluster, b : Signalfilterchebyshev2Cluster) -> Signalfilterchebyshev2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_cluster_copy(s : Signalfilterchebyshev2Cluster) -> Signalfilterchebyshev2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_fill(s : Signalfilterchebyshev2Cluster, v : Double) -> Signalfilterchebyshev2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_min(s : Signalfilterchebyshev2Cluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_cluster_max(s : Signalfilterchebyshev2Cluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_cluster_to_string(s : Signalfilterchebyshev2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_model_make(size : Int) -> Signalfilterchebyshev2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_model_len(s : Signalfilterchebyshev2Model) -> Int { s.size }

pub fn signal_filter_chebyshev2_model_get(s : Signalfilterchebyshev2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_model_set(s : Signalfilterchebyshev2Model, i : Int, v : Double) -> Signalfilterchebyshev2Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_sum(s : Signalfilterchebyshev2Model) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_model_mean(s : Signalfilterchebyshev2Model) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_model_scale(s : Signalfilterchebyshev2Model, f : Double) -> Signalfilterchebyshev2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_add(a : Signalfilterchebyshev2Model, b : Signalfilterchebyshev2Model) -> Signalfilterchebyshev2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_model_copy(s : Signalfilterchebyshev2Model) -> Signalfilterchebyshev2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_fill(s : Signalfilterchebyshev2Model, v : Double) -> Signalfilterchebyshev2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_min(s : Signalfilterchebyshev2Model) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_model_max(s : Signalfilterchebyshev2Model) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_model_to_string(s : Signalfilterchebyshev2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_layer_make(size : Int) -> Signalfilterchebyshev2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_layer_len(s : Signalfilterchebyshev2Layer) -> Int { s.size }

pub fn signal_filter_chebyshev2_layer_get(s : Signalfilterchebyshev2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_layer_set(s : Signalfilterchebyshev2Layer, i : Int, v : Double) -> Signalfilterchebyshev2Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_sum(s : Signalfilterchebyshev2Layer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_layer_mean(s : Signalfilterchebyshev2Layer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_layer_scale(s : Signalfilterchebyshev2Layer, f : Double) -> Signalfilterchebyshev2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_add(a : Signalfilterchebyshev2Layer, b : Signalfilterchebyshev2Layer) -> Signalfilterchebyshev2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_layer_copy(s : Signalfilterchebyshev2Layer) -> Signalfilterchebyshev2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_fill(s : Signalfilterchebyshev2Layer, v : Double) -> Signalfilterchebyshev2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_min(s : Signalfilterchebyshev2Layer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_layer_max(s : Signalfilterchebyshev2Layer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_layer_to_string(s : Signalfilterchebyshev2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_buffer_make(size : Int) -> Signalfilterchebyshev2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_buffer_len(s : Signalfilterchebyshev2Buffer) -> Int { s.size }

pub fn signal_filter_chebyshev2_buffer_get(s : Signalfilterchebyshev2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_buffer_set(s : Signalfilterchebyshev2Buffer, i : Int, v : Double) -> Signalfilterchebyshev2Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_sum(s : Signalfilterchebyshev2Buffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_buffer_mean(s : Signalfilterchebyshev2Buffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_buffer_scale(s : Signalfilterchebyshev2Buffer, f : Double) -> Signalfilterchebyshev2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_add(a : Signalfilterchebyshev2Buffer, b : Signalfilterchebyshev2Buffer) -> Signalfilterchebyshev2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_buffer_copy(s : Signalfilterchebyshev2Buffer) -> Signalfilterchebyshev2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_fill(s : Signalfilterchebyshev2Buffer, v : Double) -> Signalfilterchebyshev2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_min(s : Signalfilterchebyshev2Buffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_buffer_max(s : Signalfilterchebyshev2Buffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_buffer_to_string(s : Signalfilterchebyshev2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_cursor_make(size : Int) -> Signalfilterchebyshev2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_cursor_len(s : Signalfilterchebyshev2Cursor) -> Int { s.size }

pub fn signal_filter_chebyshev2_cursor_get(s : Signalfilterchebyshev2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_cursor_set(s : Signalfilterchebyshev2Cursor, i : Int, v : Double) -> Signalfilterchebyshev2Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_sum(s : Signalfilterchebyshev2Cursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_cursor_mean(s : Signalfilterchebyshev2Cursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_cursor_scale(s : Signalfilterchebyshev2Cursor, f : Double) -> Signalfilterchebyshev2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_add(a : Signalfilterchebyshev2Cursor, b : Signalfilterchebyshev2Cursor) -> Signalfilterchebyshev2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_cursor_copy(s : Signalfilterchebyshev2Cursor) -> Signalfilterchebyshev2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_fill(s : Signalfilterchebyshev2Cursor, v : Double) -> Signalfilterchebyshev2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_min(s : Signalfilterchebyshev2Cursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_cursor_max(s : Signalfilterchebyshev2Cursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_cursor_to_string(s : Signalfilterchebyshev2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_view_make(size : Int) -> Signalfilterchebyshev2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_view_len(s : Signalfilterchebyshev2View) -> Int { s.size }

pub fn signal_filter_chebyshev2_view_get(s : Signalfilterchebyshev2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_view_set(s : Signalfilterchebyshev2View, i : Int, v : Double) -> Signalfilterchebyshev2View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_sum(s : Signalfilterchebyshev2View) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_view_mean(s : Signalfilterchebyshev2View) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_view_scale(s : Signalfilterchebyshev2View, f : Double) -> Signalfilterchebyshev2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_add(a : Signalfilterchebyshev2View, b : Signalfilterchebyshev2View) -> Signalfilterchebyshev2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_view_copy(s : Signalfilterchebyshev2View) -> Signalfilterchebyshev2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_fill(s : Signalfilterchebyshev2View, v : Double) -> Signalfilterchebyshev2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_min(s : Signalfilterchebyshev2View) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_view_max(s : Signalfilterchebyshev2View) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_view_to_string(s : Signalfilterchebyshev2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_range_make(size : Int) -> Signalfilterchebyshev2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_range_len(s : Signalfilterchebyshev2Range) -> Int { s.size }

pub fn signal_filter_chebyshev2_range_get(s : Signalfilterchebyshev2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_range_set(s : Signalfilterchebyshev2Range, i : Int, v : Double) -> Signalfilterchebyshev2Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_sum(s : Signalfilterchebyshev2Range) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_range_mean(s : Signalfilterchebyshev2Range) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_range_scale(s : Signalfilterchebyshev2Range, f : Double) -> Signalfilterchebyshev2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_add(a : Signalfilterchebyshev2Range, b : Signalfilterchebyshev2Range) -> Signalfilterchebyshev2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_range_copy(s : Signalfilterchebyshev2Range) -> Signalfilterchebyshev2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_fill(s : Signalfilterchebyshev2Range, v : Double) -> Signalfilterchebyshev2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_min(s : Signalfilterchebyshev2Range) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_range_max(s : Signalfilterchebyshev2Range) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_range_to_string(s : Signalfilterchebyshev2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_slice_make(size : Int) -> Signalfilterchebyshev2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_slice_len(s : Signalfilterchebyshev2Slice) -> Int { s.size }

pub fn signal_filter_chebyshev2_slice_get(s : Signalfilterchebyshev2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_slice_set(s : Signalfilterchebyshev2Slice, i : Int, v : Double) -> Signalfilterchebyshev2Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_sum(s : Signalfilterchebyshev2Slice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_slice_mean(s : Signalfilterchebyshev2Slice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_slice_scale(s : Signalfilterchebyshev2Slice, f : Double) -> Signalfilterchebyshev2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_add(a : Signalfilterchebyshev2Slice, b : Signalfilterchebyshev2Slice) -> Signalfilterchebyshev2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_slice_copy(s : Signalfilterchebyshev2Slice) -> Signalfilterchebyshev2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_fill(s : Signalfilterchebyshev2Slice, v : Double) -> Signalfilterchebyshev2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_min(s : Signalfilterchebyshev2Slice) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_slice_max(s : Signalfilterchebyshev2Slice) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_slice_to_string(s : Signalfilterchebyshev2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/bio_seq_assembly_polish

pub(all) struct BioseqassemblypolishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_polish_make_point(x : Double, y : Double) -> BioseqassemblypolishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_polish_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblypolishPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_polish_point_x(pt : BioseqassemblypolishPoint) -> Double { pt.x }

pub fn bio_seq_assembly_polish_point_y(pt : BioseqassemblypolishPoint) -> Double { pt.y }

pub fn bio_seq_assembly_polish_point_z(pt : BioseqassemblypolishPoint) -> Double { pt.z }

pub fn bio_seq_assembly_polish_point_label(pt : BioseqassemblypolishPoint) -> Int { pt.label }

pub fn bio_seq_assembly_polish_point_dist(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_polish_point_add(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_polish_point_sub(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_polish_point_scale(pt : BioseqassemblypolishPoint, s : Double) -> BioseqassemblypolishPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_polish_point_dot(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_polish_point_cross(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_polish_point_norm(pt : BioseqassemblypolishPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_polish_point_normalize(pt : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  let n = bio_seq_assembly_polish_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_polish_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_polish_point_negate(pt : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_polish_point_mid(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_polish_point_lerp(a : BioseqassemblypolishPoint, b : BioseqassemblypolishPoint, t : Double) -> BioseqassemblypolishPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_polish_point_to_string(pt : BioseqassemblypolishPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblypolishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_polish_make_series(vals : Array[Double], name : String) -> BioseqassemblypolishSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_polish_series_len(s : BioseqassemblypolishSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_polish_series_sum(s : BioseqassemblypolishSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_polish_series_mean(s : BioseqassemblypolishSeries) -> Double {
  let n = bio_seq_assembly_polish_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_assembly_polish_series_sum(s) / n.to_double() }
}

pub fn bio_seq_assembly_polish_series_min(s : BioseqassemblypolishSeries) -> Double {
  let n = bio_seq_assembly_polish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_series_max(s : BioseqassemblypolishSeries) -> Double {
  let n = bio_seq_assembly_polish_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_series_range(s : BioseqassemblypolishSeries) -> Double {
  bio_seq_assembly_polish_series_max(s) - bio_seq_assembly_polish_series_min(s)
}

pub fn bio_seq_assembly_polish_series_var(s : BioseqassemblypolishSeries) -> Double {
  let n = bio_seq_assembly_polish_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_polish_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_assembly_polish_series_std(s : BioseqassemblypolishSeries) -> Double { @_common.sqrt(bio_seq_assembly_polish_series_var(s)) }

pub fn bio_seq_assembly_polish_series_median(s : BioseqassemblypolishSeries) -> Double {
  let n = bio_seq_assembly_polish_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_polish_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_polish_series_scale(s : BioseqassemblypolishSeries, f : Double) -> BioseqassemblypolishSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_polish_series_add(a : BioseqassemblypolishSeries, b : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_polish_series_sub(a : BioseqassemblypolishSeries, b : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_polish_series_normalize(s : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  let mn = bio_seq_assembly_polish_series_min(s)
  let mx = bio_seq_assembly_polish_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_polish_series_cumsum(s : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_polish_series_to_string(s : BioseqassemblypolishSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblypolishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_polish_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblypolishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_polish_matrix_identity(n : Int) -> BioseqassemblypolishMatrix {
  let m = bio_seq_assembly_polish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_polish_matrix_get(m : BioseqassemblypolishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_polish_matrix_transpose(m : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  let result = bio_seq_assembly_polish_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_polish_matrix_add(a : BioseqassemblypolishMatrix, b : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_polish_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_polish_matrix_scale(m : BioseqassemblypolishMatrix, s : Double) -> BioseqassemblypolishMatrix {
  let result = bio_seq_assembly_polish_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_polish_matrix_multiply(a : BioseqassemblypolishMatrix, b : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  if a.cols != b.rows { return bio_seq_assembly_polish_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_polish_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_polish_matrix_trace(m : BioseqassemblypolishMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_polish_matrix_det(m : BioseqassemblypolishMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_polish_matrix_norm(m : BioseqassemblypolishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_polish_matrix_to_string(m : BioseqassemblypolishMatrix) -> String {
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

pub(all) struct BioseqassemblypolishVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_polish_make_vector(comps : Array[Double]) -> BioseqassemblypolishVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_polish_vector_zero(dim : Int) -> BioseqassemblypolishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_polish_vector_add(a : BioseqassemblypolishVector, b : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_polish_vector_sub(a : BioseqassemblypolishVector, b : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_polish_vector_scale(v : BioseqassemblypolishVector, s : Double) -> BioseqassemblypolishVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_polish_vector_dot(a : BioseqassemblypolishVector, b : BioseqassemblypolishVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_polish_vector_norm(v : BioseqassemblypolishVector) -> Double { @_common.sqrt(bio_seq_assembly_polish_vector_dot(v, v)) }

pub fn bio_seq_assembly_polish_vector_normalize(v : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = bio_seq_assembly_polish_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_polish_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_polish_vector_dist(a : BioseqassemblypolishVector, b : BioseqassemblypolishVector) -> Double {
  bio_seq_assembly_polish_vector_norm(bio_seq_assembly_polish_vector_sub(a, b))
}

pub fn bio_seq_assembly_polish_vector_to_string(v : BioseqassemblypolishVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_polish_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_polish_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_polish_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_polish_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_polish_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_polish_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_polish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_polish_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_polish_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_polish_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_polish_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_polish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_polish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_polish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_polish_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_polish_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_polish_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_polish_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_polish_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_polish_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_polish_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_polish_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_polish_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_polish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_polish_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_polish_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_polish_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_polish_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_polish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblypolishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_frame_make(size : Int) -> BioseqassemblypolishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_frame_len(s : BioseqassemblypolishFrame) -> Int { s.size }

pub fn bio_seq_assembly_polish_frame_get(s : BioseqassemblypolishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_frame_set(s : BioseqassemblypolishFrame, i : Int, v : Double) -> BioseqassemblypolishFrame {
  let result = bio_seq_assembly_polish_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_frame_sum(s : BioseqassemblypolishFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_frame_mean(s : BioseqassemblypolishFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_frame_scale(s : BioseqassemblypolishFrame, f : Double) -> BioseqassemblypolishFrame {
  let result = bio_seq_assembly_polish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_frame_add(a : BioseqassemblypolishFrame, b : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_frame_copy(s : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  let result = bio_seq_assembly_polish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_frame_fill(s : BioseqassemblypolishFrame, v : Double) -> BioseqassemblypolishFrame {
  let result = bio_seq_assembly_polish_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_frame_min(s : BioseqassemblypolishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_frame_max(s : BioseqassemblypolishFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_frame_to_string(s : BioseqassemblypolishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_table_make(size : Int) -> BioseqassemblypolishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_table_len(s : BioseqassemblypolishTable) -> Int { s.size }

pub fn bio_seq_assembly_polish_table_get(s : BioseqassemblypolishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_table_set(s : BioseqassemblypolishTable, i : Int, v : Double) -> BioseqassemblypolishTable {
  let result = bio_seq_assembly_polish_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_table_sum(s : BioseqassemblypolishTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_table_mean(s : BioseqassemblypolishTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_table_scale(s : BioseqassemblypolishTable, f : Double) -> BioseqassemblypolishTable {
  let result = bio_seq_assembly_polish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_table_add(a : BioseqassemblypolishTable, b : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_table_copy(s : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  let result = bio_seq_assembly_polish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_table_fill(s : BioseqassemblypolishTable, v : Double) -> BioseqassemblypolishTable {
  let result = bio_seq_assembly_polish_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_table_min(s : BioseqassemblypolishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_table_max(s : BioseqassemblypolishTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_table_to_string(s : BioseqassemblypolishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_graphn_make(size : Int) -> BioseqassemblypolishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_graphn_len(s : BioseqassemblypolishGraphN) -> Int { s.size }

pub fn bio_seq_assembly_polish_graphn_get(s : BioseqassemblypolishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_graphn_set(s : BioseqassemblypolishGraphN, i : Int, v : Double) -> BioseqassemblypolishGraphN {
  let result = bio_seq_assembly_polish_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_graphn_sum(s : BioseqassemblypolishGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_graphn_mean(s : BioseqassemblypolishGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_graphn_scale(s : BioseqassemblypolishGraphN, f : Double) -> BioseqassemblypolishGraphN {
  let result = bio_seq_assembly_polish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_graphn_add(a : BioseqassemblypolishGraphN, b : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_graphn_copy(s : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  let result = bio_seq_assembly_polish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_graphn_fill(s : BioseqassemblypolishGraphN, v : Double) -> BioseqassemblypolishGraphN {
  let result = bio_seq_assembly_polish_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_graphn_min(s : BioseqassemblypolishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_graphn_max(s : BioseqassemblypolishGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_graphn_to_string(s : BioseqassemblypolishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_node_make(size : Int) -> BioseqassemblypolishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_node_len(s : BioseqassemblypolishNode) -> Int { s.size }

pub fn bio_seq_assembly_polish_node_get(s : BioseqassemblypolishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_node_set(s : BioseqassemblypolishNode, i : Int, v : Double) -> BioseqassemblypolishNode {
  let result = bio_seq_assembly_polish_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_node_sum(s : BioseqassemblypolishNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_node_mean(s : BioseqassemblypolishNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_node_scale(s : BioseqassemblypolishNode, f : Double) -> BioseqassemblypolishNode {
  let result = bio_seq_assembly_polish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_node_add(a : BioseqassemblypolishNode, b : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_node_copy(s : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  let result = bio_seq_assembly_polish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_node_fill(s : BioseqassemblypolishNode, v : Double) -> BioseqassemblypolishNode {
  let result = bio_seq_assembly_polish_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_node_min(s : BioseqassemblypolishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_node_max(s : BioseqassemblypolishNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_node_to_string(s : BioseqassemblypolishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_edge_make(size : Int) -> BioseqassemblypolishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_edge_len(s : BioseqassemblypolishEdge) -> Int { s.size }

pub fn bio_seq_assembly_polish_edge_get(s : BioseqassemblypolishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_edge_set(s : BioseqassemblypolishEdge, i : Int, v : Double) -> BioseqassemblypolishEdge {
  let result = bio_seq_assembly_polish_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_edge_sum(s : BioseqassemblypolishEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_edge_mean(s : BioseqassemblypolishEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_edge_scale(s : BioseqassemblypolishEdge, f : Double) -> BioseqassemblypolishEdge {
  let result = bio_seq_assembly_polish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_edge_add(a : BioseqassemblypolishEdge, b : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_edge_copy(s : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  let result = bio_seq_assembly_polish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_edge_fill(s : BioseqassemblypolishEdge, v : Double) -> BioseqassemblypolishEdge {
  let result = bio_seq_assembly_polish_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_edge_min(s : BioseqassemblypolishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_edge_max(s : BioseqassemblypolishEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_edge_to_string(s : BioseqassemblypolishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_path_make(size : Int) -> BioseqassemblypolishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_path_len(s : BioseqassemblypolishPath) -> Int { s.size }

pub fn bio_seq_assembly_polish_path_get(s : BioseqassemblypolishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_path_set(s : BioseqassemblypolishPath, i : Int, v : Double) -> BioseqassemblypolishPath {
  let result = bio_seq_assembly_polish_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_path_sum(s : BioseqassemblypolishPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_path_mean(s : BioseqassemblypolishPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_path_scale(s : BioseqassemblypolishPath, f : Double) -> BioseqassemblypolishPath {
  let result = bio_seq_assembly_polish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_path_add(a : BioseqassemblypolishPath, b : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_path_copy(s : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  let result = bio_seq_assembly_polish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_path_fill(s : BioseqassemblypolishPath, v : Double) -> BioseqassemblypolishPath {
  let result = bio_seq_assembly_polish_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_path_min(s : BioseqassemblypolishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_path_max(s : BioseqassemblypolishPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_path_to_string(s : BioseqassemblypolishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cluster_make(size : Int) -> BioseqassemblypolishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_cluster_len(s : BioseqassemblypolishCluster) -> Int { s.size }

pub fn bio_seq_assembly_polish_cluster_get(s : BioseqassemblypolishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_cluster_set(s : BioseqassemblypolishCluster, i : Int, v : Double) -> BioseqassemblypolishCluster {
  let result = bio_seq_assembly_polish_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_cluster_sum(s : BioseqassemblypolishCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_cluster_mean(s : BioseqassemblypolishCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_cluster_scale(s : BioseqassemblypolishCluster, f : Double) -> BioseqassemblypolishCluster {
  let result = bio_seq_assembly_polish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_cluster_add(a : BioseqassemblypolishCluster, b : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_cluster_copy(s : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  let result = bio_seq_assembly_polish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_cluster_fill(s : BioseqassemblypolishCluster, v : Double) -> BioseqassemblypolishCluster {
  let result = bio_seq_assembly_polish_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_cluster_min(s : BioseqassemblypolishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_cluster_max(s : BioseqassemblypolishCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_cluster_to_string(s : BioseqassemblypolishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_model_make(size : Int) -> BioseqassemblypolishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_model_len(s : BioseqassemblypolishModel) -> Int { s.size }

pub fn bio_seq_assembly_polish_model_get(s : BioseqassemblypolishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_model_set(s : BioseqassemblypolishModel, i : Int, v : Double) -> BioseqassemblypolishModel {
  let result = bio_seq_assembly_polish_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_model_sum(s : BioseqassemblypolishModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_model_mean(s : BioseqassemblypolishModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_model_scale(s : BioseqassemblypolishModel, f : Double) -> BioseqassemblypolishModel {
  let result = bio_seq_assembly_polish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_model_add(a : BioseqassemblypolishModel, b : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_model_copy(s : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  let result = bio_seq_assembly_polish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_model_fill(s : BioseqassemblypolishModel, v : Double) -> BioseqassemblypolishModel {
  let result = bio_seq_assembly_polish_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_model_min(s : BioseqassemblypolishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_model_max(s : BioseqassemblypolishModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_model_to_string(s : BioseqassemblypolishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_layer_make(size : Int) -> BioseqassemblypolishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_layer_len(s : BioseqassemblypolishLayer) -> Int { s.size }

pub fn bio_seq_assembly_polish_layer_get(s : BioseqassemblypolishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_layer_set(s : BioseqassemblypolishLayer, i : Int, v : Double) -> BioseqassemblypolishLayer {
  let result = bio_seq_assembly_polish_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_layer_sum(s : BioseqassemblypolishLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_layer_mean(s : BioseqassemblypolishLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_layer_scale(s : BioseqassemblypolishLayer, f : Double) -> BioseqassemblypolishLayer {
  let result = bio_seq_assembly_polish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_layer_add(a : BioseqassemblypolishLayer, b : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_layer_copy(s : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  let result = bio_seq_assembly_polish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_layer_fill(s : BioseqassemblypolishLayer, v : Double) -> BioseqassemblypolishLayer {
  let result = bio_seq_assembly_polish_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_layer_min(s : BioseqassemblypolishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_layer_max(s : BioseqassemblypolishLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_layer_to_string(s : BioseqassemblypolishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_buffer_make(size : Int) -> BioseqassemblypolishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_buffer_len(s : BioseqassemblypolishBuffer) -> Int { s.size }

pub fn bio_seq_assembly_polish_buffer_get(s : BioseqassemblypolishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_buffer_set(s : BioseqassemblypolishBuffer, i : Int, v : Double) -> BioseqassemblypolishBuffer {
  let result = bio_seq_assembly_polish_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_buffer_sum(s : BioseqassemblypolishBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_buffer_mean(s : BioseqassemblypolishBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_buffer_scale(s : BioseqassemblypolishBuffer, f : Double) -> BioseqassemblypolishBuffer {
  let result = bio_seq_assembly_polish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_buffer_add(a : BioseqassemblypolishBuffer, b : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_buffer_copy(s : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  let result = bio_seq_assembly_polish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_buffer_fill(s : BioseqassemblypolishBuffer, v : Double) -> BioseqassemblypolishBuffer {
  let result = bio_seq_assembly_polish_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_buffer_min(s : BioseqassemblypolishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_buffer_max(s : BioseqassemblypolishBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_buffer_to_string(s : BioseqassemblypolishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cursor_make(size : Int) -> BioseqassemblypolishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_cursor_len(s : BioseqassemblypolishCursor) -> Int { s.size }

pub fn bio_seq_assembly_polish_cursor_get(s : BioseqassemblypolishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_cursor_set(s : BioseqassemblypolishCursor, i : Int, v : Double) -> BioseqassemblypolishCursor {
  let result = bio_seq_assembly_polish_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_cursor_sum(s : BioseqassemblypolishCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_cursor_mean(s : BioseqassemblypolishCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_cursor_scale(s : BioseqassemblypolishCursor, f : Double) -> BioseqassemblypolishCursor {
  let result = bio_seq_assembly_polish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_cursor_add(a : BioseqassemblypolishCursor, b : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_cursor_copy(s : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  let result = bio_seq_assembly_polish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_cursor_fill(s : BioseqassemblypolishCursor, v : Double) -> BioseqassemblypolishCursor {
  let result = bio_seq_assembly_polish_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_cursor_min(s : BioseqassemblypolishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_cursor_max(s : BioseqassemblypolishCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_cursor_to_string(s : BioseqassemblypolishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_view_make(size : Int) -> BioseqassemblypolishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_view_len(s : BioseqassemblypolishView) -> Int { s.size }

pub fn bio_seq_assembly_polish_view_get(s : BioseqassemblypolishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_view_set(s : BioseqassemblypolishView, i : Int, v : Double) -> BioseqassemblypolishView {
  let result = bio_seq_assembly_polish_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_view_sum(s : BioseqassemblypolishView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_view_mean(s : BioseqassemblypolishView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_view_scale(s : BioseqassemblypolishView, f : Double) -> BioseqassemblypolishView {
  let result = bio_seq_assembly_polish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_view_add(a : BioseqassemblypolishView, b : BioseqassemblypolishView) -> BioseqassemblypolishView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_view_copy(s : BioseqassemblypolishView) -> BioseqassemblypolishView {
  let result = bio_seq_assembly_polish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_view_fill(s : BioseqassemblypolishView, v : Double) -> BioseqassemblypolishView {
  let result = bio_seq_assembly_polish_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_view_min(s : BioseqassemblypolishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_view_max(s : BioseqassemblypolishView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_view_to_string(s : BioseqassemblypolishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_range_make(size : Int) -> BioseqassemblypolishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_range_len(s : BioseqassemblypolishRange) -> Int { s.size }

pub fn bio_seq_assembly_polish_range_get(s : BioseqassemblypolishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_range_set(s : BioseqassemblypolishRange, i : Int, v : Double) -> BioseqassemblypolishRange {
  let result = bio_seq_assembly_polish_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_range_sum(s : BioseqassemblypolishRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_range_mean(s : BioseqassemblypolishRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_range_scale(s : BioseqassemblypolishRange, f : Double) -> BioseqassemblypolishRange {
  let result = bio_seq_assembly_polish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_range_add(a : BioseqassemblypolishRange, b : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_range_copy(s : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  let result = bio_seq_assembly_polish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_range_fill(s : BioseqassemblypolishRange, v : Double) -> BioseqassemblypolishRange {
  let result = bio_seq_assembly_polish_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_range_min(s : BioseqassemblypolishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_range_max(s : BioseqassemblypolishRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_range_to_string(s : BioseqassemblypolishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_slice_make(size : Int) -> BioseqassemblypolishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_slice_len(s : BioseqassemblypolishSlice) -> Int { s.size }

pub fn bio_seq_assembly_polish_slice_get(s : BioseqassemblypolishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_slice_set(s : BioseqassemblypolishSlice, i : Int, v : Double) -> BioseqassemblypolishSlice {
  let result = bio_seq_assembly_polish_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_slice_sum(s : BioseqassemblypolishSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_polish_slice_mean(s : BioseqassemblypolishSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_polish_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_polish_slice_scale(s : BioseqassemblypolishSlice, f : Double) -> BioseqassemblypolishSlice {
  let result = bio_seq_assembly_polish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_polish_slice_add(a : BioseqassemblypolishSlice, b : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_polish_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_polish_slice_copy(s : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  let result = bio_seq_assembly_polish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_polish_slice_fill(s : BioseqassemblypolishSlice, v : Double) -> BioseqassemblypolishSlice {
  let result = bio_seq_assembly_polish_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_polish_slice_min(s : BioseqassemblypolishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_slice_max(s : BioseqassemblypolishSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_polish_slice_to_string(s : BioseqassemblypolishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


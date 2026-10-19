///===
/// extcore/nlp_embed_sent2vec

pub(all) struct Nlpembedsent2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_sent2vec_make_point(x : Double, y : Double) -> Nlpembedsent2vecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_sent2vec_make_point3(x : Double, y : Double, z : Double) -> Nlpembedsent2vecPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_sent2vec_point_x(pt : Nlpembedsent2vecPoint) -> Double { pt.x }

pub fn nlp_embed_sent2vec_point_y(pt : Nlpembedsent2vecPoint) -> Double { pt.y }

pub fn nlp_embed_sent2vec_point_z(pt : Nlpembedsent2vecPoint) -> Double { pt.z }

pub fn nlp_embed_sent2vec_point_label(pt : Nlpembedsent2vecPoint) -> Int { pt.label }

pub fn nlp_embed_sent2vec_point_dist(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_sent2vec_point_add(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_sent2vec_point_sub(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_sent2vec_point_scale(pt : Nlpembedsent2vecPoint, s : Double) -> Nlpembedsent2vecPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_sent2vec_point_dot(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_sent2vec_point_cross(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_sent2vec_point_norm(pt : Nlpembedsent2vecPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_sent2vec_point_normalize(pt : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  let n = nlp_embed_sent2vec_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_sent2vec_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_sent2vec_point_negate(pt : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_sent2vec_point_mid(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint) -> Nlpembedsent2vecPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_sent2vec_point_lerp(a : Nlpembedsent2vecPoint, b : Nlpembedsent2vecPoint, t : Double) -> Nlpembedsent2vecPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_sent2vec_point_to_string(pt : Nlpembedsent2vecPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_sent2vec_make_series(vals : Array[Double], name : String) -> Nlpembedsent2vecSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_sent2vec_series_len(s : Nlpembedsent2vecSeries) -> Int { s.vals.length() }

pub fn nlp_embed_sent2vec_series_sum(s : Nlpembedsent2vecSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_embed_sent2vec_series_mean(s : Nlpembedsent2vecSeries) -> Double {
  let n = nlp_embed_sent2vec_series_len(s)
  if n == 0 { 0.0 } else { nlp_embed_sent2vec_series_sum(s) / n.to_double() }
}

pub fn nlp_embed_sent2vec_series_min(s : Nlpembedsent2vecSeries) -> Double {
  let n = nlp_embed_sent2vec_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_series_max(s : Nlpembedsent2vecSeries) -> Double {
  let n = nlp_embed_sent2vec_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_series_range(s : Nlpembedsent2vecSeries) -> Double {
  nlp_embed_sent2vec_series_max(s) - nlp_embed_sent2vec_series_min(s)
}

pub fn nlp_embed_sent2vec_series_var(s : Nlpembedsent2vecSeries) -> Double {
  let n = nlp_embed_sent2vec_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_embed_sent2vec_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_embed_sent2vec_series_std(s : Nlpembedsent2vecSeries) -> Double { @_common.sqrt(nlp_embed_sent2vec_series_var(s)) }

pub fn nlp_embed_sent2vec_series_median(s : Nlpembedsent2vecSeries) -> Double {
  let n = nlp_embed_sent2vec_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_embed_sent2vec_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_embed_sent2vec_series_scale(s : Nlpembedsent2vecSeries, f : Double) -> Nlpembedsent2vecSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_sent2vec_series_add(a : Nlpembedsent2vecSeries, b : Nlpembedsent2vecSeries) -> Nlpembedsent2vecSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_sent2vec_series_sub(a : Nlpembedsent2vecSeries, b : Nlpembedsent2vecSeries) -> Nlpembedsent2vecSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_sent2vec_series_normalize(s : Nlpembedsent2vecSeries) -> Nlpembedsent2vecSeries {
  let mn = nlp_embed_sent2vec_series_min(s)
  let mx = nlp_embed_sent2vec_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_sent2vec_series_cumsum(s : Nlpembedsent2vecSeries) -> Nlpembedsent2vecSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_sent2vec_series_to_string(s : Nlpembedsent2vecSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembedsent2vecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_sent2vec_make_matrix(rows : Int, cols : Int, val : Double) -> Nlpembedsent2vecMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_sent2vec_matrix_identity(n : Int) -> Nlpembedsent2vecMatrix {
  let m = nlp_embed_sent2vec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_sent2vec_matrix_get(m : Nlpembedsent2vecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_sent2vec_matrix_transpose(m : Nlpembedsent2vecMatrix) -> Nlpembedsent2vecMatrix {
  let result = nlp_embed_sent2vec_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_sent2vec_matrix_add(a : Nlpembedsent2vecMatrix, b : Nlpembedsent2vecMatrix) -> Nlpembedsent2vecMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_sent2vec_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_sent2vec_matrix_scale(m : Nlpembedsent2vecMatrix, s : Double) -> Nlpembedsent2vecMatrix {
  let result = nlp_embed_sent2vec_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_sent2vec_matrix_multiply(a : Nlpembedsent2vecMatrix, b : Nlpembedsent2vecMatrix) -> Nlpembedsent2vecMatrix {
  if a.cols != b.rows { return nlp_embed_sent2vec_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_sent2vec_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_sent2vec_matrix_trace(m : Nlpembedsent2vecMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_sent2vec_matrix_det(m : Nlpembedsent2vecMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_sent2vec_matrix_norm(m : Nlpembedsent2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_sent2vec_matrix_to_string(m : Nlpembedsent2vecMatrix) -> String {
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

pub(all) struct Nlpembedsent2vecVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_sent2vec_make_vector(comps : Array[Double]) -> Nlpembedsent2vecVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_sent2vec_vector_zero(dim : Int) -> Nlpembedsent2vecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_sent2vec_vector_add(a : Nlpembedsent2vecVector, b : Nlpembedsent2vecVector) -> Nlpembedsent2vecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_sent2vec_vector_sub(a : Nlpembedsent2vecVector, b : Nlpembedsent2vecVector) -> Nlpembedsent2vecVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_sent2vec_vector_scale(v : Nlpembedsent2vecVector, s : Double) -> Nlpembedsent2vecVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_sent2vec_vector_dot(a : Nlpembedsent2vecVector, b : Nlpembedsent2vecVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_sent2vec_vector_norm(v : Nlpembedsent2vecVector) -> Double { @_common.sqrt(nlp_embed_sent2vec_vector_dot(v, v)) }

pub fn nlp_embed_sent2vec_vector_normalize(v : Nlpembedsent2vecVector) -> Nlpembedsent2vecVector {
  let n = nlp_embed_sent2vec_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_sent2vec_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_sent2vec_vector_dist(a : Nlpembedsent2vecVector, b : Nlpembedsent2vecVector) -> Double {
  nlp_embed_sent2vec_vector_norm(nlp_embed_sent2vec_vector_sub(a, b))
}

pub fn nlp_embed_sent2vec_vector_to_string(v : Nlpembedsent2vecVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_sent2vec_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_sent2vec_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_sent2vec_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_sent2vec_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_sent2vec_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_sent2vec_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_sent2vec_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_sent2vec_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_sent2vec_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_sent2vec_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_sent2vec_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_sent2vec_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_sent2vec_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_sent2vec_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_sent2vec_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_sent2vec_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_sent2vec_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_sent2vec_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_sent2vec_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_sent2vec_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_sent2vec_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_sent2vec_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_sent2vec_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_sent2vec_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_sent2vec_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_sent2vec_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_sent2vec_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_sent2vec_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_sent2vec_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Nlpembedsent2vecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_frame_make(size : Int) -> Nlpembedsent2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_frame_len(s : Nlpembedsent2vecFrame) -> Int { s.size }

pub fn nlp_embed_sent2vec_frame_get(s : Nlpembedsent2vecFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_frame_set(s : Nlpembedsent2vecFrame, i : Int, v : Double) -> Nlpembedsent2vecFrame {
  let result = nlp_embed_sent2vec_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_frame_sum(s : Nlpembedsent2vecFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_frame_mean(s : Nlpembedsent2vecFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_frame_scale(s : Nlpembedsent2vecFrame, f : Double) -> Nlpembedsent2vecFrame {
  let result = nlp_embed_sent2vec_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_frame_add(a : Nlpembedsent2vecFrame, b : Nlpembedsent2vecFrame) -> Nlpembedsent2vecFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_frame_copy(s : Nlpembedsent2vecFrame) -> Nlpembedsent2vecFrame {
  let result = nlp_embed_sent2vec_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_frame_fill(s : Nlpembedsent2vecFrame, v : Double) -> Nlpembedsent2vecFrame {
  let result = nlp_embed_sent2vec_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_frame_min(s : Nlpembedsent2vecFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_frame_max(s : Nlpembedsent2vecFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_frame_to_string(s : Nlpembedsent2vecFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_table_make(size : Int) -> Nlpembedsent2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_table_len(s : Nlpembedsent2vecTable) -> Int { s.size }

pub fn nlp_embed_sent2vec_table_get(s : Nlpembedsent2vecTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_table_set(s : Nlpembedsent2vecTable, i : Int, v : Double) -> Nlpembedsent2vecTable {
  let result = nlp_embed_sent2vec_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_table_sum(s : Nlpembedsent2vecTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_table_mean(s : Nlpembedsent2vecTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_table_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_table_scale(s : Nlpembedsent2vecTable, f : Double) -> Nlpembedsent2vecTable {
  let result = nlp_embed_sent2vec_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_table_add(a : Nlpembedsent2vecTable, b : Nlpembedsent2vecTable) -> Nlpembedsent2vecTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_table_copy(s : Nlpembedsent2vecTable) -> Nlpembedsent2vecTable {
  let result = nlp_embed_sent2vec_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_table_fill(s : Nlpembedsent2vecTable, v : Double) -> Nlpembedsent2vecTable {
  let result = nlp_embed_sent2vec_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_table_min(s : Nlpembedsent2vecTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_table_max(s : Nlpembedsent2vecTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_table_to_string(s : Nlpembedsent2vecTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_graphn_make(size : Int) -> Nlpembedsent2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_graphn_len(s : Nlpembedsent2vecGraphN) -> Int { s.size }

pub fn nlp_embed_sent2vec_graphn_get(s : Nlpembedsent2vecGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_graphn_set(s : Nlpembedsent2vecGraphN, i : Int, v : Double) -> Nlpembedsent2vecGraphN {
  let result = nlp_embed_sent2vec_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_graphn_sum(s : Nlpembedsent2vecGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_graphn_mean(s : Nlpembedsent2vecGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_graphn_scale(s : Nlpembedsent2vecGraphN, f : Double) -> Nlpembedsent2vecGraphN {
  let result = nlp_embed_sent2vec_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_graphn_add(a : Nlpembedsent2vecGraphN, b : Nlpembedsent2vecGraphN) -> Nlpembedsent2vecGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_graphn_copy(s : Nlpembedsent2vecGraphN) -> Nlpembedsent2vecGraphN {
  let result = nlp_embed_sent2vec_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_graphn_fill(s : Nlpembedsent2vecGraphN, v : Double) -> Nlpembedsent2vecGraphN {
  let result = nlp_embed_sent2vec_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_graphn_min(s : Nlpembedsent2vecGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_graphn_max(s : Nlpembedsent2vecGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_graphn_to_string(s : Nlpembedsent2vecGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_node_make(size : Int) -> Nlpembedsent2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_node_len(s : Nlpembedsent2vecNode) -> Int { s.size }

pub fn nlp_embed_sent2vec_node_get(s : Nlpembedsent2vecNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_node_set(s : Nlpembedsent2vecNode, i : Int, v : Double) -> Nlpembedsent2vecNode {
  let result = nlp_embed_sent2vec_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_node_sum(s : Nlpembedsent2vecNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_node_mean(s : Nlpembedsent2vecNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_node_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_node_scale(s : Nlpembedsent2vecNode, f : Double) -> Nlpembedsent2vecNode {
  let result = nlp_embed_sent2vec_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_node_add(a : Nlpembedsent2vecNode, b : Nlpembedsent2vecNode) -> Nlpembedsent2vecNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_node_copy(s : Nlpembedsent2vecNode) -> Nlpembedsent2vecNode {
  let result = nlp_embed_sent2vec_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_node_fill(s : Nlpembedsent2vecNode, v : Double) -> Nlpembedsent2vecNode {
  let result = nlp_embed_sent2vec_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_node_min(s : Nlpembedsent2vecNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_node_max(s : Nlpembedsent2vecNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_node_to_string(s : Nlpembedsent2vecNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_edge_make(size : Int) -> Nlpembedsent2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_edge_len(s : Nlpembedsent2vecEdge) -> Int { s.size }

pub fn nlp_embed_sent2vec_edge_get(s : Nlpembedsent2vecEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_edge_set(s : Nlpembedsent2vecEdge, i : Int, v : Double) -> Nlpembedsent2vecEdge {
  let result = nlp_embed_sent2vec_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_edge_sum(s : Nlpembedsent2vecEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_edge_mean(s : Nlpembedsent2vecEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_edge_scale(s : Nlpembedsent2vecEdge, f : Double) -> Nlpembedsent2vecEdge {
  let result = nlp_embed_sent2vec_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_edge_add(a : Nlpembedsent2vecEdge, b : Nlpembedsent2vecEdge) -> Nlpembedsent2vecEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_edge_copy(s : Nlpembedsent2vecEdge) -> Nlpembedsent2vecEdge {
  let result = nlp_embed_sent2vec_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_edge_fill(s : Nlpembedsent2vecEdge, v : Double) -> Nlpembedsent2vecEdge {
  let result = nlp_embed_sent2vec_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_edge_min(s : Nlpembedsent2vecEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_edge_max(s : Nlpembedsent2vecEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_edge_to_string(s : Nlpembedsent2vecEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_path_make(size : Int) -> Nlpembedsent2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_path_len(s : Nlpembedsent2vecPath) -> Int { s.size }

pub fn nlp_embed_sent2vec_path_get(s : Nlpembedsent2vecPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_path_set(s : Nlpembedsent2vecPath, i : Int, v : Double) -> Nlpembedsent2vecPath {
  let result = nlp_embed_sent2vec_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_path_sum(s : Nlpembedsent2vecPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_path_mean(s : Nlpembedsent2vecPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_path_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_path_scale(s : Nlpembedsent2vecPath, f : Double) -> Nlpembedsent2vecPath {
  let result = nlp_embed_sent2vec_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_path_add(a : Nlpembedsent2vecPath, b : Nlpembedsent2vecPath) -> Nlpembedsent2vecPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_path_copy(s : Nlpembedsent2vecPath) -> Nlpembedsent2vecPath {
  let result = nlp_embed_sent2vec_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_path_fill(s : Nlpembedsent2vecPath, v : Double) -> Nlpembedsent2vecPath {
  let result = nlp_embed_sent2vec_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_path_min(s : Nlpembedsent2vecPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_path_max(s : Nlpembedsent2vecPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_path_to_string(s : Nlpembedsent2vecPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_cluster_make(size : Int) -> Nlpembedsent2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_cluster_len(s : Nlpembedsent2vecCluster) -> Int { s.size }

pub fn nlp_embed_sent2vec_cluster_get(s : Nlpembedsent2vecCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_cluster_set(s : Nlpembedsent2vecCluster, i : Int, v : Double) -> Nlpembedsent2vecCluster {
  let result = nlp_embed_sent2vec_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_cluster_sum(s : Nlpembedsent2vecCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_cluster_mean(s : Nlpembedsent2vecCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_cluster_scale(s : Nlpembedsent2vecCluster, f : Double) -> Nlpembedsent2vecCluster {
  let result = nlp_embed_sent2vec_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_cluster_add(a : Nlpembedsent2vecCluster, b : Nlpembedsent2vecCluster) -> Nlpembedsent2vecCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_cluster_copy(s : Nlpembedsent2vecCluster) -> Nlpembedsent2vecCluster {
  let result = nlp_embed_sent2vec_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_cluster_fill(s : Nlpembedsent2vecCluster, v : Double) -> Nlpembedsent2vecCluster {
  let result = nlp_embed_sent2vec_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_cluster_min(s : Nlpembedsent2vecCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_cluster_max(s : Nlpembedsent2vecCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_cluster_to_string(s : Nlpembedsent2vecCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_model_make(size : Int) -> Nlpembedsent2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_model_len(s : Nlpembedsent2vecModel) -> Int { s.size }

pub fn nlp_embed_sent2vec_model_get(s : Nlpembedsent2vecModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_model_set(s : Nlpembedsent2vecModel, i : Int, v : Double) -> Nlpembedsent2vecModel {
  let result = nlp_embed_sent2vec_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_model_sum(s : Nlpembedsent2vecModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_model_mean(s : Nlpembedsent2vecModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_model_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_model_scale(s : Nlpembedsent2vecModel, f : Double) -> Nlpembedsent2vecModel {
  let result = nlp_embed_sent2vec_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_model_add(a : Nlpembedsent2vecModel, b : Nlpembedsent2vecModel) -> Nlpembedsent2vecModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_model_copy(s : Nlpembedsent2vecModel) -> Nlpembedsent2vecModel {
  let result = nlp_embed_sent2vec_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_model_fill(s : Nlpembedsent2vecModel, v : Double) -> Nlpembedsent2vecModel {
  let result = nlp_embed_sent2vec_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_model_min(s : Nlpembedsent2vecModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_model_max(s : Nlpembedsent2vecModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_model_to_string(s : Nlpembedsent2vecModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_layer_make(size : Int) -> Nlpembedsent2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_layer_len(s : Nlpembedsent2vecLayer) -> Int { s.size }

pub fn nlp_embed_sent2vec_layer_get(s : Nlpembedsent2vecLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_layer_set(s : Nlpembedsent2vecLayer, i : Int, v : Double) -> Nlpembedsent2vecLayer {
  let result = nlp_embed_sent2vec_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_layer_sum(s : Nlpembedsent2vecLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_layer_mean(s : Nlpembedsent2vecLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_layer_scale(s : Nlpembedsent2vecLayer, f : Double) -> Nlpembedsent2vecLayer {
  let result = nlp_embed_sent2vec_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_layer_add(a : Nlpembedsent2vecLayer, b : Nlpembedsent2vecLayer) -> Nlpembedsent2vecLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_layer_copy(s : Nlpembedsent2vecLayer) -> Nlpembedsent2vecLayer {
  let result = nlp_embed_sent2vec_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_layer_fill(s : Nlpembedsent2vecLayer, v : Double) -> Nlpembedsent2vecLayer {
  let result = nlp_embed_sent2vec_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_layer_min(s : Nlpembedsent2vecLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_layer_max(s : Nlpembedsent2vecLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_layer_to_string(s : Nlpembedsent2vecLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_buffer_make(size : Int) -> Nlpembedsent2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_buffer_len(s : Nlpembedsent2vecBuffer) -> Int { s.size }

pub fn nlp_embed_sent2vec_buffer_get(s : Nlpembedsent2vecBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_buffer_set(s : Nlpembedsent2vecBuffer, i : Int, v : Double) -> Nlpembedsent2vecBuffer {
  let result = nlp_embed_sent2vec_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_buffer_sum(s : Nlpembedsent2vecBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_buffer_mean(s : Nlpembedsent2vecBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_buffer_scale(s : Nlpembedsent2vecBuffer, f : Double) -> Nlpembedsent2vecBuffer {
  let result = nlp_embed_sent2vec_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_buffer_add(a : Nlpembedsent2vecBuffer, b : Nlpembedsent2vecBuffer) -> Nlpembedsent2vecBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_buffer_copy(s : Nlpembedsent2vecBuffer) -> Nlpembedsent2vecBuffer {
  let result = nlp_embed_sent2vec_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_buffer_fill(s : Nlpembedsent2vecBuffer, v : Double) -> Nlpembedsent2vecBuffer {
  let result = nlp_embed_sent2vec_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_buffer_min(s : Nlpembedsent2vecBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_buffer_max(s : Nlpembedsent2vecBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_buffer_to_string(s : Nlpembedsent2vecBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_cursor_make(size : Int) -> Nlpembedsent2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_cursor_len(s : Nlpembedsent2vecCursor) -> Int { s.size }

pub fn nlp_embed_sent2vec_cursor_get(s : Nlpembedsent2vecCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_cursor_set(s : Nlpembedsent2vecCursor, i : Int, v : Double) -> Nlpembedsent2vecCursor {
  let result = nlp_embed_sent2vec_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_cursor_sum(s : Nlpembedsent2vecCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_cursor_mean(s : Nlpembedsent2vecCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_cursor_scale(s : Nlpembedsent2vecCursor, f : Double) -> Nlpembedsent2vecCursor {
  let result = nlp_embed_sent2vec_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_cursor_add(a : Nlpembedsent2vecCursor, b : Nlpembedsent2vecCursor) -> Nlpembedsent2vecCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_cursor_copy(s : Nlpembedsent2vecCursor) -> Nlpembedsent2vecCursor {
  let result = nlp_embed_sent2vec_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_cursor_fill(s : Nlpembedsent2vecCursor, v : Double) -> Nlpembedsent2vecCursor {
  let result = nlp_embed_sent2vec_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_cursor_min(s : Nlpembedsent2vecCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_cursor_max(s : Nlpembedsent2vecCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_cursor_to_string(s : Nlpembedsent2vecCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_view_make(size : Int) -> Nlpembedsent2vecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_view_len(s : Nlpembedsent2vecView) -> Int { s.size }

pub fn nlp_embed_sent2vec_view_get(s : Nlpembedsent2vecView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_view_set(s : Nlpembedsent2vecView, i : Int, v : Double) -> Nlpembedsent2vecView {
  let result = nlp_embed_sent2vec_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_view_sum(s : Nlpembedsent2vecView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_view_mean(s : Nlpembedsent2vecView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_view_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_view_scale(s : Nlpembedsent2vecView, f : Double) -> Nlpembedsent2vecView {
  let result = nlp_embed_sent2vec_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_view_add(a : Nlpembedsent2vecView, b : Nlpembedsent2vecView) -> Nlpembedsent2vecView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_view_copy(s : Nlpembedsent2vecView) -> Nlpembedsent2vecView {
  let result = nlp_embed_sent2vec_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_view_fill(s : Nlpembedsent2vecView, v : Double) -> Nlpembedsent2vecView {
  let result = nlp_embed_sent2vec_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_view_min(s : Nlpembedsent2vecView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_view_max(s : Nlpembedsent2vecView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_view_to_string(s : Nlpembedsent2vecView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_range_make(size : Int) -> Nlpembedsent2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_range_len(s : Nlpembedsent2vecRange) -> Int { s.size }

pub fn nlp_embed_sent2vec_range_get(s : Nlpembedsent2vecRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_range_set(s : Nlpembedsent2vecRange, i : Int, v : Double) -> Nlpembedsent2vecRange {
  let result = nlp_embed_sent2vec_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_range_sum(s : Nlpembedsent2vecRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_range_mean(s : Nlpembedsent2vecRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_range_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_range_scale(s : Nlpembedsent2vecRange, f : Double) -> Nlpembedsent2vecRange {
  let result = nlp_embed_sent2vec_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_range_add(a : Nlpembedsent2vecRange, b : Nlpembedsent2vecRange) -> Nlpembedsent2vecRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_range_copy(s : Nlpembedsent2vecRange) -> Nlpembedsent2vecRange {
  let result = nlp_embed_sent2vec_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_range_fill(s : Nlpembedsent2vecRange, v : Double) -> Nlpembedsent2vecRange {
  let result = nlp_embed_sent2vec_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_range_min(s : Nlpembedsent2vecRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_range_max(s : Nlpembedsent2vecRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_range_to_string(s : Nlpembedsent2vecRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedsent2vecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_sent2vec_slice_make(size : Int) -> Nlpembedsent2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_sent2vec_slice_len(s : Nlpembedsent2vecSlice) -> Int { s.size }

pub fn nlp_embed_sent2vec_slice_get(s : Nlpembedsent2vecSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_sent2vec_slice_set(s : Nlpembedsent2vecSlice, i : Int, v : Double) -> Nlpembedsent2vecSlice {
  let result = nlp_embed_sent2vec_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_slice_sum(s : Nlpembedsent2vecSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_sent2vec_slice_mean(s : Nlpembedsent2vecSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_sent2vec_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_sent2vec_slice_scale(s : Nlpembedsent2vecSlice, f : Double) -> Nlpembedsent2vecSlice {
  let result = nlp_embed_sent2vec_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_sent2vec_slice_add(a : Nlpembedsent2vecSlice, b : Nlpembedsent2vecSlice) -> Nlpembedsent2vecSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_sent2vec_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_sent2vec_slice_copy(s : Nlpembedsent2vecSlice) -> Nlpembedsent2vecSlice {
  let result = nlp_embed_sent2vec_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_sent2vec_slice_fill(s : Nlpembedsent2vecSlice, v : Double) -> Nlpembedsent2vecSlice {
  let result = nlp_embed_sent2vec_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_sent2vec_slice_min(s : Nlpembedsent2vecSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_slice_max(s : Nlpembedsent2vecSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_sent2vec_slice_to_string(s : Nlpembedsent2vecSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


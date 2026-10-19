///===
/// extcore/nlp_embed_contrastive

pub(all) struct NlpembedcontrastivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_contrastive_make_point(x : Double, y : Double) -> NlpembedcontrastivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_contrastive_make_point3(x : Double, y : Double, z : Double) -> NlpembedcontrastivePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_contrastive_point_x(pt : NlpembedcontrastivePoint) -> Double { pt.x }

pub fn nlp_embed_contrastive_point_y(pt : NlpembedcontrastivePoint) -> Double { pt.y }

pub fn nlp_embed_contrastive_point_z(pt : NlpembedcontrastivePoint) -> Double { pt.z }

pub fn nlp_embed_contrastive_point_label(pt : NlpembedcontrastivePoint) -> Int { pt.label }

pub fn nlp_embed_contrastive_point_dist(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  nlp_embed_contrastive_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_contrastive_point_add(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_contrastive_point_sub(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_contrastive_point_scale(pt : NlpembedcontrastivePoint, s : Double) -> NlpembedcontrastivePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_contrastive_point_dot(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_contrastive_point_cross(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_contrastive_point_norm(pt : NlpembedcontrastivePoint) -> Double {
  nlp_embed_contrastive_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_contrastive_point_normalize(pt : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  let n = nlp_embed_contrastive_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_contrastive_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_contrastive_point_negate(pt : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_contrastive_point_mid(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_contrastive_point_lerp(a : NlpembedcontrastivePoint, b : NlpembedcontrastivePoint, t : Double) -> NlpembedcontrastivePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_contrastive_point_to_string(pt : NlpembedcontrastivePoint) -> String {
  "(" + nlp_embed_contrastive_dbl(pt.x) + ", " + nlp_embed_contrastive_dbl(pt.y) + ", " + nlp_embed_contrastive_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_contrastive_make_series(vals : Array[Double], name : String) -> NlpembedcontrastiveSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_contrastive_series_len(s : NlpembedcontrastiveSeries) -> Int { s.vals.length() }

pub fn nlp_embed_contrastive_series_sum(s : NlpembedcontrastiveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_embed_contrastive_series_mean(s : NlpembedcontrastiveSeries) -> Double {
  let n = nlp_embed_contrastive_series_len(s)
  if n == 0 { 0.0 } else { nlp_embed_contrastive_series_sum(s) / n.to_double() }
}

pub fn nlp_embed_contrastive_series_min(s : NlpembedcontrastiveSeries) -> Double {
  let n = nlp_embed_contrastive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_series_max(s : NlpembedcontrastiveSeries) -> Double {
  let n = nlp_embed_contrastive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_series_range(s : NlpembedcontrastiveSeries) -> Double {
  nlp_embed_contrastive_series_max(s) - nlp_embed_contrastive_series_min(s)
}

pub fn nlp_embed_contrastive_series_var(s : NlpembedcontrastiveSeries) -> Double {
  let n = nlp_embed_contrastive_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_embed_contrastive_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_embed_contrastive_series_std(s : NlpembedcontrastiveSeries) -> Double { nlp_embed_contrastive_sqrt(nlp_embed_contrastive_series_var(s)) }

pub fn nlp_embed_contrastive_series_median(s : NlpembedcontrastiveSeries) -> Double {
  let n = nlp_embed_contrastive_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_embed_contrastive_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_embed_contrastive_series_scale(s : NlpembedcontrastiveSeries, f : Double) -> NlpembedcontrastiveSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = nlp_embed_contrastive_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_contrastive_series_add(a : NlpembedcontrastiveSeries, b : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_embed_contrastive_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_contrastive_series_sub(a : NlpembedcontrastiveSeries, b : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = nlp_embed_contrastive_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_contrastive_series_normalize(s : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  let mn = nlp_embed_contrastive_series_min(s)
  let mx = nlp_embed_contrastive_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = nlp_embed_contrastive_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_contrastive_series_cumsum(s : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = nlp_embed_contrastive_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_contrastive_series_to_string(s : NlpembedcontrastiveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_embed_contrastive_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedcontrastiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_contrastive_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedcontrastiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_contrastive_matrix_identity(n : Int) -> NlpembedcontrastiveMatrix {
  let m = nlp_embed_contrastive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_contrastive_matrix_get(m : NlpembedcontrastiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_contrastive_matrix_transpose(m : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_contrastive_matrix_add(a : NlpembedcontrastiveMatrix, b : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_contrastive_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_contrastive_matrix_scale(m : NlpembedcontrastiveMatrix, s : Double) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_contrastive_matrix_multiply(a : NlpembedcontrastiveMatrix, b : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  if a.cols != b.rows { return nlp_embed_contrastive_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_contrastive_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_contrastive_matrix_trace(m : NlpembedcontrastiveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_contrastive_matrix_det(m : NlpembedcontrastiveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_contrastive_matrix_norm(m : NlpembedcontrastiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  nlp_embed_contrastive_sqrt(sum)
}

pub fn nlp_embed_contrastive_matrix_to_string(m : NlpembedcontrastiveMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + nlp_embed_contrastive_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NlpembedcontrastiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_contrastive_make_vector(comps : Array[Double]) -> NlpembedcontrastiveVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_contrastive_vector_zero(dim : Int) -> NlpembedcontrastiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_contrastive_vector_add(a : NlpembedcontrastiveVector, b : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_embed_contrastive_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_contrastive_vector_sub(a : NlpembedcontrastiveVector, b : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = nlp_embed_contrastive_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_contrastive_vector_scale(v : NlpembedcontrastiveVector, s : Double) -> NlpembedcontrastiveVector {
  let mut result = []
  for i in 0..<v.dim { result = nlp_embed_contrastive_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_contrastive_vector_dot(a : NlpembedcontrastiveVector, b : NlpembedcontrastiveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_contrastive_vector_norm(v : NlpembedcontrastiveVector) -> Double { nlp_embed_contrastive_sqrt(nlp_embed_contrastive_vector_dot(v, v)) }

pub fn nlp_embed_contrastive_vector_normalize(v : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = nlp_embed_contrastive_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_contrastive_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_contrastive_vector_dist(a : NlpembedcontrastiveVector, b : NlpembedcontrastiveVector) -> Double {
  nlp_embed_contrastive_vector_norm(nlp_embed_contrastive_vector_sub(a, b))
}

pub fn nlp_embed_contrastive_vector_to_string(v : NlpembedcontrastiveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + nlp_embed_contrastive_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_contrastive_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_embed_contrastive_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_embed_contrastive_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_embed_contrastive_std(data : Array[Double]) -> Double { nlp_embed_contrastive_sqrt(nlp_embed_contrastive_var(data)) }

pub fn nlp_embed_contrastive_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_embed_contrastive_mean(a); let mb = nlp_embed_contrastive_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_embed_contrastive_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_embed_contrastive_std(a); let sb = nlp_embed_contrastive_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_embed_contrastive_cov(a, b) / (sa * sb) }
}

pub fn nlp_embed_contrastive_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_embed_contrastive_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_embed_contrastive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_embed_contrastive_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_embed_contrastive_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  nlp_embed_contrastive_sqrt(nlp_embed_contrastive_mse(pred, labels))
}

pub fn nlp_embed_contrastive_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + nlp_embed_contrastive_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_embed_contrastive_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_embed_contrastive_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_embed_contrastive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_embed_contrastive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_embed_contrastive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_embed_contrastive_precision(pred, labels, pos); let r = nlp_embed_contrastive_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_embed_contrastive_sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  for i in 0..<n {
    let mut min_idx = i
    let start = i + 1
    for j in start..<n { if result[j] < result[min_idx] { min_idx = j } }
    let tmp = result[i]; result[i] = result[min_idx]; result[min_idx] = tmp
  }
  result
}

pub fn nlp_embed_contrastive_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_embed_contrastive_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_embed_contrastive_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_embed_contrastive_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_embed_contrastive_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_embed_contrastive_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_embed_contrastive_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_embed_contrastive_fibonacci(n : Int) -> Int {
  if n < 2 {
    n
  } else {
    let mut a = 0
    let mut b = 1
    let end = n + 1
    for _ in 2..<end {
      let c = a + b
      a = b
      b = c
    }
    b
  }
}

pub fn nlp_embed_contrastive_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_embed_contrastive_min(data); let mx = nlp_embed_contrastive_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_embed_contrastive_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_embed_contrastive_mean(data); let sd = nlp_embed_contrastive_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_embed_contrastive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_embed_contrastive_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_embed_contrastive_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_embed_contrastive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn nlp_embed_contrastive_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn nlp_embed_contrastive_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn nlp_embed_contrastive_dbl(x : Double) -> String {
  let i = if x >= 0.0 { nlp_embed_contrastive_int(x) } else { -nlp_embed_contrastive_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { nlp_embed_contrastive_int(f * 1000000.0) } else { nlp_embed_contrastive_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn nlp_embed_contrastive_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn nlp_embed_contrastive_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NlpembedcontrastiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_frame_make(size : Int) -> NlpembedcontrastiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_frame_len(s : NlpembedcontrastiveFrame) -> Int { s.size }

pub fn nlp_embed_contrastive_frame_get(s : NlpembedcontrastiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_frame_set(s : NlpembedcontrastiveFrame, i : Int, v : Double) -> NlpembedcontrastiveFrame {
  let result = nlp_embed_contrastive_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_frame_sum(s : NlpembedcontrastiveFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_frame_mean(s : NlpembedcontrastiveFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_frame_scale(s : NlpembedcontrastiveFrame, f : Double) -> NlpembedcontrastiveFrame {
  let result = nlp_embed_contrastive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_frame_add(a : NlpembedcontrastiveFrame, b : NlpembedcontrastiveFrame) -> NlpembedcontrastiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_frame_copy(s : NlpembedcontrastiveFrame) -> NlpembedcontrastiveFrame {
  let result = nlp_embed_contrastive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_frame_fill(s : NlpembedcontrastiveFrame, v : Double) -> NlpembedcontrastiveFrame {
  let result = nlp_embed_contrastive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_frame_min(s : NlpembedcontrastiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_frame_max(s : NlpembedcontrastiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_frame_to_string(s : NlpembedcontrastiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_table_make(size : Int) -> NlpembedcontrastiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_table_len(s : NlpembedcontrastiveTable) -> Int { s.size }

pub fn nlp_embed_contrastive_table_get(s : NlpembedcontrastiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_table_set(s : NlpembedcontrastiveTable, i : Int, v : Double) -> NlpembedcontrastiveTable {
  let result = nlp_embed_contrastive_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_table_sum(s : NlpembedcontrastiveTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_table_mean(s : NlpembedcontrastiveTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_table_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_table_scale(s : NlpembedcontrastiveTable, f : Double) -> NlpembedcontrastiveTable {
  let result = nlp_embed_contrastive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_table_add(a : NlpembedcontrastiveTable, b : NlpembedcontrastiveTable) -> NlpembedcontrastiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_table_copy(s : NlpembedcontrastiveTable) -> NlpembedcontrastiveTable {
  let result = nlp_embed_contrastive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_table_fill(s : NlpembedcontrastiveTable, v : Double) -> NlpembedcontrastiveTable {
  let result = nlp_embed_contrastive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_table_min(s : NlpembedcontrastiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_table_max(s : NlpembedcontrastiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_table_to_string(s : NlpembedcontrastiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_graphn_make(size : Int) -> NlpembedcontrastiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_graphn_len(s : NlpembedcontrastiveGraphN) -> Int { s.size }

pub fn nlp_embed_contrastive_graphn_get(s : NlpembedcontrastiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_graphn_set(s : NlpembedcontrastiveGraphN, i : Int, v : Double) -> NlpembedcontrastiveGraphN {
  let result = nlp_embed_contrastive_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_graphn_sum(s : NlpembedcontrastiveGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_graphn_mean(s : NlpembedcontrastiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_graphn_scale(s : NlpembedcontrastiveGraphN, f : Double) -> NlpembedcontrastiveGraphN {
  let result = nlp_embed_contrastive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_graphn_add(a : NlpembedcontrastiveGraphN, b : NlpembedcontrastiveGraphN) -> NlpembedcontrastiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_graphn_copy(s : NlpembedcontrastiveGraphN) -> NlpembedcontrastiveGraphN {
  let result = nlp_embed_contrastive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_graphn_fill(s : NlpembedcontrastiveGraphN, v : Double) -> NlpembedcontrastiveGraphN {
  let result = nlp_embed_contrastive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_graphn_min(s : NlpembedcontrastiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_graphn_max(s : NlpembedcontrastiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_graphn_to_string(s : NlpembedcontrastiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_node_make(size : Int) -> NlpembedcontrastiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_node_len(s : NlpembedcontrastiveNode) -> Int { s.size }

pub fn nlp_embed_contrastive_node_get(s : NlpembedcontrastiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_node_set(s : NlpembedcontrastiveNode, i : Int, v : Double) -> NlpembedcontrastiveNode {
  let result = nlp_embed_contrastive_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_node_sum(s : NlpembedcontrastiveNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_node_mean(s : NlpembedcontrastiveNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_node_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_node_scale(s : NlpembedcontrastiveNode, f : Double) -> NlpembedcontrastiveNode {
  let result = nlp_embed_contrastive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_node_add(a : NlpembedcontrastiveNode, b : NlpembedcontrastiveNode) -> NlpembedcontrastiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_node_copy(s : NlpembedcontrastiveNode) -> NlpembedcontrastiveNode {
  let result = nlp_embed_contrastive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_node_fill(s : NlpembedcontrastiveNode, v : Double) -> NlpembedcontrastiveNode {
  let result = nlp_embed_contrastive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_node_min(s : NlpembedcontrastiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_node_max(s : NlpembedcontrastiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_node_to_string(s : NlpembedcontrastiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_edge_make(size : Int) -> NlpembedcontrastiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_edge_len(s : NlpembedcontrastiveEdge) -> Int { s.size }

pub fn nlp_embed_contrastive_edge_get(s : NlpembedcontrastiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_edge_set(s : NlpembedcontrastiveEdge, i : Int, v : Double) -> NlpembedcontrastiveEdge {
  let result = nlp_embed_contrastive_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_edge_sum(s : NlpembedcontrastiveEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_edge_mean(s : NlpembedcontrastiveEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_edge_scale(s : NlpembedcontrastiveEdge, f : Double) -> NlpembedcontrastiveEdge {
  let result = nlp_embed_contrastive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_edge_add(a : NlpembedcontrastiveEdge, b : NlpembedcontrastiveEdge) -> NlpembedcontrastiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_edge_copy(s : NlpembedcontrastiveEdge) -> NlpembedcontrastiveEdge {
  let result = nlp_embed_contrastive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_edge_fill(s : NlpembedcontrastiveEdge, v : Double) -> NlpembedcontrastiveEdge {
  let result = nlp_embed_contrastive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_edge_min(s : NlpembedcontrastiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_edge_max(s : NlpembedcontrastiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_edge_to_string(s : NlpembedcontrastiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_path_make(size : Int) -> NlpembedcontrastivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_path_len(s : NlpembedcontrastivePath) -> Int { s.size }

pub fn nlp_embed_contrastive_path_get(s : NlpembedcontrastivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_path_set(s : NlpembedcontrastivePath, i : Int, v : Double) -> NlpembedcontrastivePath {
  let result = nlp_embed_contrastive_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_path_sum(s : NlpembedcontrastivePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_path_mean(s : NlpembedcontrastivePath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_path_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_path_scale(s : NlpembedcontrastivePath, f : Double) -> NlpembedcontrastivePath {
  let result = nlp_embed_contrastive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_path_add(a : NlpembedcontrastivePath, b : NlpembedcontrastivePath) -> NlpembedcontrastivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_path_copy(s : NlpembedcontrastivePath) -> NlpembedcontrastivePath {
  let result = nlp_embed_contrastive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_path_fill(s : NlpembedcontrastivePath, v : Double) -> NlpembedcontrastivePath {
  let result = nlp_embed_contrastive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_path_min(s : NlpembedcontrastivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_path_max(s : NlpembedcontrastivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_path_to_string(s : NlpembedcontrastivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_cluster_make(size : Int) -> NlpembedcontrastiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_cluster_len(s : NlpembedcontrastiveCluster) -> Int { s.size }

pub fn nlp_embed_contrastive_cluster_get(s : NlpembedcontrastiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_cluster_set(s : NlpembedcontrastiveCluster, i : Int, v : Double) -> NlpembedcontrastiveCluster {
  let result = nlp_embed_contrastive_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_cluster_sum(s : NlpembedcontrastiveCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_cluster_mean(s : NlpembedcontrastiveCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_cluster_scale(s : NlpembedcontrastiveCluster, f : Double) -> NlpembedcontrastiveCluster {
  let result = nlp_embed_contrastive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_cluster_add(a : NlpembedcontrastiveCluster, b : NlpembedcontrastiveCluster) -> NlpembedcontrastiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_cluster_copy(s : NlpembedcontrastiveCluster) -> NlpembedcontrastiveCluster {
  let result = nlp_embed_contrastive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_cluster_fill(s : NlpembedcontrastiveCluster, v : Double) -> NlpembedcontrastiveCluster {
  let result = nlp_embed_contrastive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_cluster_min(s : NlpembedcontrastiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_cluster_max(s : NlpembedcontrastiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_cluster_to_string(s : NlpembedcontrastiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_model_make(size : Int) -> NlpembedcontrastiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_model_len(s : NlpembedcontrastiveModel) -> Int { s.size }

pub fn nlp_embed_contrastive_model_get(s : NlpembedcontrastiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_model_set(s : NlpembedcontrastiveModel, i : Int, v : Double) -> NlpembedcontrastiveModel {
  let result = nlp_embed_contrastive_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_model_sum(s : NlpembedcontrastiveModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_model_mean(s : NlpembedcontrastiveModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_model_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_model_scale(s : NlpembedcontrastiveModel, f : Double) -> NlpembedcontrastiveModel {
  let result = nlp_embed_contrastive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_model_add(a : NlpembedcontrastiveModel, b : NlpembedcontrastiveModel) -> NlpembedcontrastiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_model_copy(s : NlpembedcontrastiveModel) -> NlpembedcontrastiveModel {
  let result = nlp_embed_contrastive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_model_fill(s : NlpembedcontrastiveModel, v : Double) -> NlpembedcontrastiveModel {
  let result = nlp_embed_contrastive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_model_min(s : NlpembedcontrastiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_model_max(s : NlpembedcontrastiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_model_to_string(s : NlpembedcontrastiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_layer_make(size : Int) -> NlpembedcontrastiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_layer_len(s : NlpembedcontrastiveLayer) -> Int { s.size }

pub fn nlp_embed_contrastive_layer_get(s : NlpembedcontrastiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_layer_set(s : NlpembedcontrastiveLayer, i : Int, v : Double) -> NlpembedcontrastiveLayer {
  let result = nlp_embed_contrastive_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_layer_sum(s : NlpembedcontrastiveLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_layer_mean(s : NlpembedcontrastiveLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_layer_scale(s : NlpembedcontrastiveLayer, f : Double) -> NlpembedcontrastiveLayer {
  let result = nlp_embed_contrastive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_layer_add(a : NlpembedcontrastiveLayer, b : NlpembedcontrastiveLayer) -> NlpembedcontrastiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_layer_copy(s : NlpembedcontrastiveLayer) -> NlpembedcontrastiveLayer {
  let result = nlp_embed_contrastive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_layer_fill(s : NlpembedcontrastiveLayer, v : Double) -> NlpembedcontrastiveLayer {
  let result = nlp_embed_contrastive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_layer_min(s : NlpembedcontrastiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_layer_max(s : NlpembedcontrastiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_layer_to_string(s : NlpembedcontrastiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_buffer_make(size : Int) -> NlpembedcontrastiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_buffer_len(s : NlpembedcontrastiveBuffer) -> Int { s.size }

pub fn nlp_embed_contrastive_buffer_get(s : NlpembedcontrastiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_buffer_set(s : NlpembedcontrastiveBuffer, i : Int, v : Double) -> NlpembedcontrastiveBuffer {
  let result = nlp_embed_contrastive_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_buffer_sum(s : NlpembedcontrastiveBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_buffer_mean(s : NlpembedcontrastiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_buffer_scale(s : NlpembedcontrastiveBuffer, f : Double) -> NlpembedcontrastiveBuffer {
  let result = nlp_embed_contrastive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_buffer_add(a : NlpembedcontrastiveBuffer, b : NlpembedcontrastiveBuffer) -> NlpembedcontrastiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_buffer_copy(s : NlpembedcontrastiveBuffer) -> NlpembedcontrastiveBuffer {
  let result = nlp_embed_contrastive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_buffer_fill(s : NlpembedcontrastiveBuffer, v : Double) -> NlpembedcontrastiveBuffer {
  let result = nlp_embed_contrastive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_buffer_min(s : NlpembedcontrastiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_buffer_max(s : NlpembedcontrastiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_buffer_to_string(s : NlpembedcontrastiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_cursor_make(size : Int) -> NlpembedcontrastiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_cursor_len(s : NlpembedcontrastiveCursor) -> Int { s.size }

pub fn nlp_embed_contrastive_cursor_get(s : NlpembedcontrastiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_cursor_set(s : NlpembedcontrastiveCursor, i : Int, v : Double) -> NlpembedcontrastiveCursor {
  let result = nlp_embed_contrastive_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_cursor_sum(s : NlpembedcontrastiveCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_cursor_mean(s : NlpembedcontrastiveCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_cursor_scale(s : NlpembedcontrastiveCursor, f : Double) -> NlpembedcontrastiveCursor {
  let result = nlp_embed_contrastive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_cursor_add(a : NlpembedcontrastiveCursor, b : NlpembedcontrastiveCursor) -> NlpembedcontrastiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_cursor_copy(s : NlpembedcontrastiveCursor) -> NlpembedcontrastiveCursor {
  let result = nlp_embed_contrastive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_cursor_fill(s : NlpembedcontrastiveCursor, v : Double) -> NlpembedcontrastiveCursor {
  let result = nlp_embed_contrastive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_cursor_min(s : NlpembedcontrastiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_cursor_max(s : NlpembedcontrastiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_cursor_to_string(s : NlpembedcontrastiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_view_make(size : Int) -> NlpembedcontrastiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_view_len(s : NlpembedcontrastiveView) -> Int { s.size }

pub fn nlp_embed_contrastive_view_get(s : NlpembedcontrastiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_view_set(s : NlpembedcontrastiveView, i : Int, v : Double) -> NlpembedcontrastiveView {
  let result = nlp_embed_contrastive_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_view_sum(s : NlpembedcontrastiveView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_view_mean(s : NlpembedcontrastiveView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_view_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_view_scale(s : NlpembedcontrastiveView, f : Double) -> NlpembedcontrastiveView {
  let result = nlp_embed_contrastive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_view_add(a : NlpembedcontrastiveView, b : NlpembedcontrastiveView) -> NlpembedcontrastiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_view_copy(s : NlpembedcontrastiveView) -> NlpembedcontrastiveView {
  let result = nlp_embed_contrastive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_view_fill(s : NlpembedcontrastiveView, v : Double) -> NlpembedcontrastiveView {
  let result = nlp_embed_contrastive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_view_min(s : NlpembedcontrastiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_view_max(s : NlpembedcontrastiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_view_to_string(s : NlpembedcontrastiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_range_make(size : Int) -> NlpembedcontrastiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_range_len(s : NlpembedcontrastiveRange) -> Int { s.size }

pub fn nlp_embed_contrastive_range_get(s : NlpembedcontrastiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_range_set(s : NlpembedcontrastiveRange, i : Int, v : Double) -> NlpembedcontrastiveRange {
  let result = nlp_embed_contrastive_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_range_sum(s : NlpembedcontrastiveRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_range_mean(s : NlpembedcontrastiveRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_range_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_range_scale(s : NlpembedcontrastiveRange, f : Double) -> NlpembedcontrastiveRange {
  let result = nlp_embed_contrastive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_range_add(a : NlpembedcontrastiveRange, b : NlpembedcontrastiveRange) -> NlpembedcontrastiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_range_copy(s : NlpembedcontrastiveRange) -> NlpembedcontrastiveRange {
  let result = nlp_embed_contrastive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_range_fill(s : NlpembedcontrastiveRange, v : Double) -> NlpembedcontrastiveRange {
  let result = nlp_embed_contrastive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_range_min(s : NlpembedcontrastiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_range_max(s : NlpembedcontrastiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_range_to_string(s : NlpembedcontrastiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_slice_make(size : Int) -> NlpembedcontrastiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_slice_len(s : NlpembedcontrastiveSlice) -> Int { s.size }

pub fn nlp_embed_contrastive_slice_get(s : NlpembedcontrastiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_slice_set(s : NlpembedcontrastiveSlice, i : Int, v : Double) -> NlpembedcontrastiveSlice {
  let result = nlp_embed_contrastive_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_slice_sum(s : NlpembedcontrastiveSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_contrastive_slice_mean(s : NlpembedcontrastiveSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_contrastive_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_contrastive_slice_scale(s : NlpembedcontrastiveSlice, f : Double) -> NlpembedcontrastiveSlice {
  let result = nlp_embed_contrastive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_contrastive_slice_add(a : NlpembedcontrastiveSlice, b : NlpembedcontrastiveSlice) -> NlpembedcontrastiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_contrastive_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_contrastive_slice_copy(s : NlpembedcontrastiveSlice) -> NlpembedcontrastiveSlice {
  let result = nlp_embed_contrastive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_contrastive_slice_fill(s : NlpembedcontrastiveSlice, v : Double) -> NlpembedcontrastiveSlice {
  let result = nlp_embed_contrastive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_contrastive_slice_min(s : NlpembedcontrastiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_slice_max(s : NlpembedcontrastiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_contrastive_slice_to_string(s : NlpembedcontrastiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn nlp_embed_contrastive_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn nlp_embed_contrastive_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


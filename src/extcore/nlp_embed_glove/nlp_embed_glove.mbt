///===
/// extcore/nlp_embed_glove

pub(all) struct NlpembedglovePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_glove_make_point(x : Double, y : Double) -> NlpembedglovePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_glove_make_point3(x : Double, y : Double, z : Double) -> NlpembedglovePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_embed_glove_point_x(pt : NlpembedglovePoint) -> Double { pt.x }

pub fn nlp_embed_glove_point_y(pt : NlpembedglovePoint) -> Double { pt.y }

pub fn nlp_embed_glove_point_z(pt : NlpembedglovePoint) -> Double { pt.z }

pub fn nlp_embed_glove_point_label(pt : NlpembedglovePoint) -> Int { pt.label }

pub fn nlp_embed_glove_point_dist(a : NlpembedglovePoint, b : NlpembedglovePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_embed_glove_point_add(a : NlpembedglovePoint, b : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_embed_glove_point_sub(a : NlpembedglovePoint, b : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_embed_glove_point_scale(pt : NlpembedglovePoint, s : Double) -> NlpembedglovePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_embed_glove_point_dot(a : NlpembedglovePoint, b : NlpembedglovePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_embed_glove_point_cross(a : NlpembedglovePoint, b : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_embed_glove_point_norm(pt : NlpembedglovePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_embed_glove_point_normalize(pt : NlpembedglovePoint) -> NlpembedglovePoint {
  let n = nlp_embed_glove_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_embed_glove_point_scale(pt, 1.0 / n) }
}

pub fn nlp_embed_glove_point_negate(pt : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_embed_glove_point_mid(a : NlpembedglovePoint, b : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_embed_glove_point_lerp(a : NlpembedglovePoint, b : NlpembedglovePoint, t : Double) -> NlpembedglovePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_embed_glove_point_to_string(pt : NlpembedglovePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpembedgloveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_glove_make_series(vals : Array[Double], name : String) -> NlpembedgloveSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_embed_glove_series_len(s : NlpembedgloveSeries) -> Int { s.vals.length() }

pub fn nlp_embed_glove_series_sum(s : NlpembedgloveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_embed_glove_series_mean(s : NlpembedgloveSeries) -> Double {
  let n = nlp_embed_glove_series_len(s)
  if n == 0 { 0.0 } else { nlp_embed_glove_series_sum(s) / n.to_double() }
}

pub fn nlp_embed_glove_series_min(s : NlpembedgloveSeries) -> Double {
  let n = nlp_embed_glove_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_glove_series_max(s : NlpembedgloveSeries) -> Double {
  let n = nlp_embed_glove_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_embed_glove_series_range(s : NlpembedgloveSeries) -> Double {
  nlp_embed_glove_series_max(s) - nlp_embed_glove_series_min(s)
}

pub fn nlp_embed_glove_series_var(s : NlpembedgloveSeries) -> Double {
  let n = nlp_embed_glove_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_embed_glove_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_embed_glove_series_std(s : NlpembedgloveSeries) -> Double { @_common.sqrt(nlp_embed_glove_series_var(s)) }

pub fn nlp_embed_glove_series_median(s : NlpembedgloveSeries) -> Double {
  let n = nlp_embed_glove_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_embed_glove_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_embed_glove_series_scale(s : NlpembedgloveSeries, f : Double) -> NlpembedgloveSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_embed_glove_series_add(a : NlpembedgloveSeries, b : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_embed_glove_series_sub(a : NlpembedgloveSeries, b : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_embed_glove_series_normalize(s : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let mn = nlp_embed_glove_series_min(s)
  let mx = nlp_embed_glove_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_embed_glove_series_cumsum(s : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_embed_glove_series_to_string(s : NlpembedgloveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgloveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_glove_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedgloveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_glove_matrix_identity(n : Int) -> NlpembedgloveMatrix {
  let m = nlp_embed_glove_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_embed_glove_matrix_get(m : NlpembedgloveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_embed_glove_matrix_transpose(m : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_embed_glove_matrix_add(a : NlpembedgloveMatrix, b : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_embed_glove_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_embed_glove_matrix_scale(m : NlpembedgloveMatrix, s : Double) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_embed_glove_matrix_multiply(a : NlpembedgloveMatrix, b : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if a.cols != b.rows { return nlp_embed_glove_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_embed_glove_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_embed_glove_matrix_trace(m : NlpembedgloveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_embed_glove_matrix_det(m : NlpembedgloveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_embed_glove_matrix_norm(m : NlpembedgloveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_embed_glove_matrix_to_string(m : NlpembedgloveMatrix) -> String {
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

pub(all) struct NlpembedgloveVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_glove_make_vector(comps : Array[Double]) -> NlpembedgloveVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_glove_vector_zero(dim : Int) -> NlpembedgloveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_embed_glove_vector_add(a : NlpembedgloveVector, b : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_glove_vector_sub(a : NlpembedgloveVector, b : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_embed_glove_vector_scale(v : NlpembedgloveVector, s : Double) -> NlpembedgloveVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_embed_glove_vector_dot(a : NlpembedgloveVector, b : NlpembedgloveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_embed_glove_vector_norm(v : NlpembedgloveVector) -> Double { @_common.sqrt(nlp_embed_glove_vector_dot(v, v)) }

pub fn nlp_embed_glove_vector_normalize(v : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = nlp_embed_glove_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_embed_glove_vector_scale(v, 1.0 / n) }
}

pub fn nlp_embed_glove_vector_dist(a : NlpembedgloveVector, b : NlpembedgloveVector) -> Double {
  nlp_embed_glove_vector_norm(nlp_embed_glove_vector_sub(a, b))
}

pub fn nlp_embed_glove_vector_to_string(v : NlpembedgloveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_glove_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_embed_glove_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_embed_glove_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_embed_glove_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_embed_glove_var(data)) }

pub fn nlp_embed_glove_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_embed_glove_mean(a); let mb = nlp_embed_glove_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_embed_glove_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_embed_glove_std(a); let sb = nlp_embed_glove_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_embed_glove_cov(a, b) / (sa * sb) }
}

pub fn nlp_embed_glove_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_embed_glove_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_embed_glove_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_embed_glove_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_embed_glove_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_embed_glove_mse(pred, labels))
}

pub fn nlp_embed_glove_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_embed_glove_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_embed_glove_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_embed_glove_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_embed_glove_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_embed_glove_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_embed_glove_precision(pred, labels, pos); let r = nlp_embed_glove_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_embed_glove_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_embed_glove_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_embed_glove_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_embed_glove_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_embed_glove_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_embed_glove_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_embed_glove_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_embed_glove_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_embed_glove_fibonacci(n : Int) -> Int {
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

pub fn nlp_embed_glove_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_embed_glove_min(data); let mx = nlp_embed_glove_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_embed_glove_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_embed_glove_mean(data); let sd = nlp_embed_glove_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_embed_glove_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_embed_glove_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_embed_glove_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_embed_glove_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_embed_glove_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_embed_glove_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlpembedgloveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_frame_make(size : Int) -> NlpembedgloveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_frame_len(s : NlpembedgloveFrame) -> Int { s.size }

pub fn nlp_embed_glove_frame_get(s : NlpembedgloveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_frame_set(s : NlpembedgloveFrame, i : Int, v : Double) -> NlpembedgloveFrame {
  let result = nlp_embed_glove_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_frame_sum(s : NlpembedgloveFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_frame_mean(s : NlpembedgloveFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_frame_scale(s : NlpembedgloveFrame, f : Double) -> NlpembedgloveFrame {
  let result = nlp_embed_glove_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_frame_add(a : NlpembedgloveFrame, b : NlpembedgloveFrame) -> NlpembedgloveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_frame_copy(s : NlpembedgloveFrame) -> NlpembedgloveFrame {
  let result = nlp_embed_glove_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_frame_fill(s : NlpembedgloveFrame, v : Double) -> NlpembedgloveFrame {
  let result = nlp_embed_glove_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_frame_min(s : NlpembedgloveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_frame_max(s : NlpembedgloveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_frame_to_string(s : NlpembedgloveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_table_make(size : Int) -> NlpembedgloveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_table_len(s : NlpembedgloveTable) -> Int { s.size }

pub fn nlp_embed_glove_table_get(s : NlpembedgloveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_table_set(s : NlpembedgloveTable, i : Int, v : Double) -> NlpembedgloveTable {
  let result = nlp_embed_glove_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_table_sum(s : NlpembedgloveTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_table_mean(s : NlpembedgloveTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_table_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_table_scale(s : NlpembedgloveTable, f : Double) -> NlpembedgloveTable {
  let result = nlp_embed_glove_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_table_add(a : NlpembedgloveTable, b : NlpembedgloveTable) -> NlpembedgloveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_table_copy(s : NlpembedgloveTable) -> NlpembedgloveTable {
  let result = nlp_embed_glove_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_table_fill(s : NlpembedgloveTable, v : Double) -> NlpembedgloveTable {
  let result = nlp_embed_glove_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_table_min(s : NlpembedgloveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_table_max(s : NlpembedgloveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_table_to_string(s : NlpembedgloveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_graphn_make(size : Int) -> NlpembedgloveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_graphn_len(s : NlpembedgloveGraphN) -> Int { s.size }

pub fn nlp_embed_glove_graphn_get(s : NlpembedgloveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_graphn_set(s : NlpembedgloveGraphN, i : Int, v : Double) -> NlpembedgloveGraphN {
  let result = nlp_embed_glove_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_graphn_sum(s : NlpembedgloveGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_graphn_mean(s : NlpembedgloveGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_graphn_scale(s : NlpembedgloveGraphN, f : Double) -> NlpembedgloveGraphN {
  let result = nlp_embed_glove_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_graphn_add(a : NlpembedgloveGraphN, b : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_graphn_copy(s : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  let result = nlp_embed_glove_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_graphn_fill(s : NlpembedgloveGraphN, v : Double) -> NlpembedgloveGraphN {
  let result = nlp_embed_glove_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_graphn_min(s : NlpembedgloveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_graphn_max(s : NlpembedgloveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_graphn_to_string(s : NlpembedgloveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_node_make(size : Int) -> NlpembedgloveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_node_len(s : NlpembedgloveNode) -> Int { s.size }

pub fn nlp_embed_glove_node_get(s : NlpembedgloveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_node_set(s : NlpembedgloveNode, i : Int, v : Double) -> NlpembedgloveNode {
  let result = nlp_embed_glove_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_node_sum(s : NlpembedgloveNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_node_mean(s : NlpembedgloveNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_node_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_node_scale(s : NlpembedgloveNode, f : Double) -> NlpembedgloveNode {
  let result = nlp_embed_glove_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_node_add(a : NlpembedgloveNode, b : NlpembedgloveNode) -> NlpembedgloveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_node_copy(s : NlpembedgloveNode) -> NlpembedgloveNode {
  let result = nlp_embed_glove_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_node_fill(s : NlpembedgloveNode, v : Double) -> NlpembedgloveNode {
  let result = nlp_embed_glove_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_node_min(s : NlpembedgloveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_node_max(s : NlpembedgloveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_node_to_string(s : NlpembedgloveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_edge_make(size : Int) -> NlpembedgloveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_edge_len(s : NlpembedgloveEdge) -> Int { s.size }

pub fn nlp_embed_glove_edge_get(s : NlpembedgloveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_edge_set(s : NlpembedgloveEdge, i : Int, v : Double) -> NlpembedgloveEdge {
  let result = nlp_embed_glove_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_edge_sum(s : NlpembedgloveEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_edge_mean(s : NlpembedgloveEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_edge_scale(s : NlpembedgloveEdge, f : Double) -> NlpembedgloveEdge {
  let result = nlp_embed_glove_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_edge_add(a : NlpembedgloveEdge, b : NlpembedgloveEdge) -> NlpembedgloveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_edge_copy(s : NlpembedgloveEdge) -> NlpembedgloveEdge {
  let result = nlp_embed_glove_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_edge_fill(s : NlpembedgloveEdge, v : Double) -> NlpembedgloveEdge {
  let result = nlp_embed_glove_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_edge_min(s : NlpembedgloveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_edge_max(s : NlpembedgloveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_edge_to_string(s : NlpembedgloveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedglovePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_path_make(size : Int) -> NlpembedglovePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_path_len(s : NlpembedglovePath) -> Int { s.size }

pub fn nlp_embed_glove_path_get(s : NlpembedglovePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_path_set(s : NlpembedglovePath, i : Int, v : Double) -> NlpembedglovePath {
  let result = nlp_embed_glove_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_path_sum(s : NlpembedglovePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_path_mean(s : NlpembedglovePath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_path_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_path_scale(s : NlpembedglovePath, f : Double) -> NlpembedglovePath {
  let result = nlp_embed_glove_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_path_add(a : NlpembedglovePath, b : NlpembedglovePath) -> NlpembedglovePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_path_copy(s : NlpembedglovePath) -> NlpembedglovePath {
  let result = nlp_embed_glove_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_path_fill(s : NlpembedglovePath, v : Double) -> NlpembedglovePath {
  let result = nlp_embed_glove_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_path_min(s : NlpembedglovePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_path_max(s : NlpembedglovePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_path_to_string(s : NlpembedglovePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cluster_make(size : Int) -> NlpembedgloveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_cluster_len(s : NlpembedgloveCluster) -> Int { s.size }

pub fn nlp_embed_glove_cluster_get(s : NlpembedgloveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_cluster_set(s : NlpembedgloveCluster, i : Int, v : Double) -> NlpembedgloveCluster {
  let result = nlp_embed_glove_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_cluster_sum(s : NlpembedgloveCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_cluster_mean(s : NlpembedgloveCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_cluster_scale(s : NlpembedgloveCluster, f : Double) -> NlpembedgloveCluster {
  let result = nlp_embed_glove_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_cluster_add(a : NlpembedgloveCluster, b : NlpembedgloveCluster) -> NlpembedgloveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_cluster_copy(s : NlpembedgloveCluster) -> NlpembedgloveCluster {
  let result = nlp_embed_glove_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_cluster_fill(s : NlpembedgloveCluster, v : Double) -> NlpembedgloveCluster {
  let result = nlp_embed_glove_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_cluster_min(s : NlpembedgloveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_cluster_max(s : NlpembedgloveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_cluster_to_string(s : NlpembedgloveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_model_make(size : Int) -> NlpembedgloveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_model_len(s : NlpembedgloveModel) -> Int { s.size }

pub fn nlp_embed_glove_model_get(s : NlpembedgloveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_model_set(s : NlpembedgloveModel, i : Int, v : Double) -> NlpembedgloveModel {
  let result = nlp_embed_glove_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_model_sum(s : NlpembedgloveModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_model_mean(s : NlpembedgloveModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_model_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_model_scale(s : NlpembedgloveModel, f : Double) -> NlpembedgloveModel {
  let result = nlp_embed_glove_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_model_add(a : NlpembedgloveModel, b : NlpembedgloveModel) -> NlpembedgloveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_model_copy(s : NlpembedgloveModel) -> NlpembedgloveModel {
  let result = nlp_embed_glove_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_model_fill(s : NlpembedgloveModel, v : Double) -> NlpembedgloveModel {
  let result = nlp_embed_glove_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_model_min(s : NlpembedgloveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_model_max(s : NlpembedgloveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_model_to_string(s : NlpembedgloveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_layer_make(size : Int) -> NlpembedgloveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_layer_len(s : NlpembedgloveLayer) -> Int { s.size }

pub fn nlp_embed_glove_layer_get(s : NlpembedgloveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_layer_set(s : NlpembedgloveLayer, i : Int, v : Double) -> NlpembedgloveLayer {
  let result = nlp_embed_glove_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_layer_sum(s : NlpembedgloveLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_layer_mean(s : NlpembedgloveLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_layer_scale(s : NlpembedgloveLayer, f : Double) -> NlpembedgloveLayer {
  let result = nlp_embed_glove_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_layer_add(a : NlpembedgloveLayer, b : NlpembedgloveLayer) -> NlpembedgloveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_layer_copy(s : NlpembedgloveLayer) -> NlpembedgloveLayer {
  let result = nlp_embed_glove_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_layer_fill(s : NlpembedgloveLayer, v : Double) -> NlpembedgloveLayer {
  let result = nlp_embed_glove_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_layer_min(s : NlpembedgloveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_layer_max(s : NlpembedgloveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_layer_to_string(s : NlpembedgloveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_buffer_make(size : Int) -> NlpembedgloveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_buffer_len(s : NlpembedgloveBuffer) -> Int { s.size }

pub fn nlp_embed_glove_buffer_get(s : NlpembedgloveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_buffer_set(s : NlpembedgloveBuffer, i : Int, v : Double) -> NlpembedgloveBuffer {
  let result = nlp_embed_glove_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_buffer_sum(s : NlpembedgloveBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_buffer_mean(s : NlpembedgloveBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_buffer_scale(s : NlpembedgloveBuffer, f : Double) -> NlpembedgloveBuffer {
  let result = nlp_embed_glove_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_buffer_add(a : NlpembedgloveBuffer, b : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_buffer_copy(s : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  let result = nlp_embed_glove_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_buffer_fill(s : NlpembedgloveBuffer, v : Double) -> NlpembedgloveBuffer {
  let result = nlp_embed_glove_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_buffer_min(s : NlpembedgloveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_buffer_max(s : NlpembedgloveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_buffer_to_string(s : NlpembedgloveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cursor_make(size : Int) -> NlpembedgloveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_cursor_len(s : NlpembedgloveCursor) -> Int { s.size }

pub fn nlp_embed_glove_cursor_get(s : NlpembedgloveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_cursor_set(s : NlpembedgloveCursor, i : Int, v : Double) -> NlpembedgloveCursor {
  let result = nlp_embed_glove_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_cursor_sum(s : NlpembedgloveCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_cursor_mean(s : NlpembedgloveCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_cursor_scale(s : NlpembedgloveCursor, f : Double) -> NlpembedgloveCursor {
  let result = nlp_embed_glove_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_cursor_add(a : NlpembedgloveCursor, b : NlpembedgloveCursor) -> NlpembedgloveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_cursor_copy(s : NlpembedgloveCursor) -> NlpembedgloveCursor {
  let result = nlp_embed_glove_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_cursor_fill(s : NlpembedgloveCursor, v : Double) -> NlpembedgloveCursor {
  let result = nlp_embed_glove_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_cursor_min(s : NlpembedgloveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_cursor_max(s : NlpembedgloveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_cursor_to_string(s : NlpembedgloveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_view_make(size : Int) -> NlpembedgloveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_view_len(s : NlpembedgloveView) -> Int { s.size }

pub fn nlp_embed_glove_view_get(s : NlpembedgloveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_view_set(s : NlpembedgloveView, i : Int, v : Double) -> NlpembedgloveView {
  let result = nlp_embed_glove_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_view_sum(s : NlpembedgloveView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_view_mean(s : NlpembedgloveView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_view_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_view_scale(s : NlpembedgloveView, f : Double) -> NlpembedgloveView {
  let result = nlp_embed_glove_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_view_add(a : NlpembedgloveView, b : NlpembedgloveView) -> NlpembedgloveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_view_copy(s : NlpembedgloveView) -> NlpembedgloveView {
  let result = nlp_embed_glove_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_view_fill(s : NlpembedgloveView, v : Double) -> NlpembedgloveView {
  let result = nlp_embed_glove_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_view_min(s : NlpembedgloveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_view_max(s : NlpembedgloveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_view_to_string(s : NlpembedgloveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_range_make(size : Int) -> NlpembedgloveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_range_len(s : NlpembedgloveRange) -> Int { s.size }

pub fn nlp_embed_glove_range_get(s : NlpembedgloveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_range_set(s : NlpembedgloveRange, i : Int, v : Double) -> NlpembedgloveRange {
  let result = nlp_embed_glove_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_range_sum(s : NlpembedgloveRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_range_mean(s : NlpembedgloveRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_range_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_range_scale(s : NlpembedgloveRange, f : Double) -> NlpembedgloveRange {
  let result = nlp_embed_glove_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_range_add(a : NlpembedgloveRange, b : NlpembedgloveRange) -> NlpembedgloveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_range_copy(s : NlpembedgloveRange) -> NlpembedgloveRange {
  let result = nlp_embed_glove_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_range_fill(s : NlpembedgloveRange, v : Double) -> NlpembedgloveRange {
  let result = nlp_embed_glove_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_range_min(s : NlpembedgloveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_range_max(s : NlpembedgloveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_range_to_string(s : NlpembedgloveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_slice_make(size : Int) -> NlpembedgloveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_slice_len(s : NlpembedgloveSlice) -> Int { s.size }

pub fn nlp_embed_glove_slice_get(s : NlpembedgloveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_slice_set(s : NlpembedgloveSlice, i : Int, v : Double) -> NlpembedgloveSlice {
  let result = nlp_embed_glove_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_slice_sum(s : NlpembedgloveSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_embed_glove_slice_mean(s : NlpembedgloveSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_embed_glove_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_embed_glove_slice_scale(s : NlpembedgloveSlice, f : Double) -> NlpembedgloveSlice {
  let result = nlp_embed_glove_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_embed_glove_slice_add(a : NlpembedgloveSlice, b : NlpembedgloveSlice) -> NlpembedgloveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_embed_glove_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_embed_glove_slice_copy(s : NlpembedgloveSlice) -> NlpembedgloveSlice {
  let result = nlp_embed_glove_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_embed_glove_slice_fill(s : NlpembedgloveSlice, v : Double) -> NlpembedgloveSlice {
  let result = nlp_embed_glove_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_embed_glove_slice_min(s : NlpembedgloveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_slice_max(s : NlpembedgloveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_embed_glove_slice_to_string(s : NlpembedgloveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


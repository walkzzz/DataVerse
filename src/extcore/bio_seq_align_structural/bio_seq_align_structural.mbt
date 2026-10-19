///===
/// extcore/bio_seq_align_structural

pub(all) struct BioseqalignstructuralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_structural_make_point(x : Double, y : Double) -> BioseqalignstructuralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_structural_make_point3(x : Double, y : Double, z : Double) -> BioseqalignstructuralPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_structural_point_x(pt : BioseqalignstructuralPoint) -> Double { pt.x }

pub fn bio_seq_align_structural_point_y(pt : BioseqalignstructuralPoint) -> Double { pt.y }

pub fn bio_seq_align_structural_point_z(pt : BioseqalignstructuralPoint) -> Double { pt.z }

pub fn bio_seq_align_structural_point_label(pt : BioseqalignstructuralPoint) -> Int { pt.label }

pub fn bio_seq_align_structural_point_dist(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_seq_align_structural_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_structural_point_add(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_structural_point_sub(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_structural_point_scale(pt : BioseqalignstructuralPoint, s : Double) -> BioseqalignstructuralPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_structural_point_dot(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_structural_point_cross(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_structural_point_norm(pt : BioseqalignstructuralPoint) -> Double {
  bio_seq_align_structural_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_structural_point_normalize(pt : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  let n = bio_seq_align_structural_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_structural_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_structural_point_negate(pt : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_structural_point_mid(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_structural_point_lerp(a : BioseqalignstructuralPoint, b : BioseqalignstructuralPoint, t : Double) -> BioseqalignstructuralPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_structural_point_to_string(pt : BioseqalignstructuralPoint) -> String {
  "(" + bio_seq_align_structural_dbl(pt.x) + ", " + bio_seq_align_structural_dbl(pt.y) + ", " + bio_seq_align_structural_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_structural_make_series(vals : Array[Double], name : String) -> BioseqalignstructuralSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_structural_series_len(s : BioseqalignstructuralSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_structural_series_sum(s : BioseqalignstructuralSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_structural_series_mean(s : BioseqalignstructuralSeries) -> Double {
  let n = bio_seq_align_structural_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_align_structural_series_sum(s) / n.to_double() }
}

pub fn bio_seq_align_structural_series_min(s : BioseqalignstructuralSeries) -> Double {
  let n = bio_seq_align_structural_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_structural_series_max(s : BioseqalignstructuralSeries) -> Double {
  let n = bio_seq_align_structural_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_structural_series_range(s : BioseqalignstructuralSeries) -> Double {
  bio_seq_align_structural_series_max(s) - bio_seq_align_structural_series_min(s)
}

pub fn bio_seq_align_structural_series_var(s : BioseqalignstructuralSeries) -> Double {
  let n = bio_seq_align_structural_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_structural_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_align_structural_series_std(s : BioseqalignstructuralSeries) -> Double { bio_seq_align_structural_sqrt(bio_seq_align_structural_series_var(s)) }

pub fn bio_seq_align_structural_series_median(s : BioseqalignstructuralSeries) -> Double {
  let n = bio_seq_align_structural_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_structural_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_structural_series_scale(s : BioseqalignstructuralSeries, f : Double) -> BioseqalignstructuralSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_seq_align_structural_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_structural_series_add(a : BioseqalignstructuralSeries, b : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_align_structural_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_structural_series_sub(a : BioseqalignstructuralSeries, b : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_align_structural_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_structural_series_normalize(s : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let mn = bio_seq_align_structural_series_min(s)
  let mx = bio_seq_align_structural_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_seq_align_structural_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_structural_series_cumsum(s : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_seq_align_structural_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_structural_series_to_string(s : BioseqalignstructuralSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_align_structural_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignstructuralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_structural_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignstructuralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_structural_matrix_identity(n : Int) -> BioseqalignstructuralMatrix {
  let m = bio_seq_align_structural_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_structural_matrix_get(m : BioseqalignstructuralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_structural_matrix_transpose(m : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_structural_matrix_add(a : BioseqalignstructuralMatrix, b : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_structural_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_structural_matrix_scale(m : BioseqalignstructuralMatrix, s : Double) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_structural_matrix_multiply(a : BioseqalignstructuralMatrix, b : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if a.cols != b.rows { return bio_seq_align_structural_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_structural_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_structural_matrix_trace(m : BioseqalignstructuralMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_structural_matrix_det(m : BioseqalignstructuralMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_structural_matrix_norm(m : BioseqalignstructuralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_seq_align_structural_sqrt(sum)
}

pub fn bio_seq_align_structural_matrix_to_string(m : BioseqalignstructuralMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_seq_align_structural_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BioseqalignstructuralVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_structural_make_vector(comps : Array[Double]) -> BioseqalignstructuralVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_structural_vector_zero(dim : Int) -> BioseqalignstructuralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_structural_vector_add(a : BioseqalignstructuralVector, b : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_align_structural_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_structural_vector_sub(a : BioseqalignstructuralVector, b : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_align_structural_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_structural_vector_scale(v : BioseqalignstructuralVector, s : Double) -> BioseqalignstructuralVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_seq_align_structural_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_structural_vector_dot(a : BioseqalignstructuralVector, b : BioseqalignstructuralVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_structural_vector_norm(v : BioseqalignstructuralVector) -> Double { bio_seq_align_structural_sqrt(bio_seq_align_structural_vector_dot(v, v)) }

pub fn bio_seq_align_structural_vector_normalize(v : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = bio_seq_align_structural_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_structural_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_structural_vector_dist(a : BioseqalignstructuralVector, b : BioseqalignstructuralVector) -> Double {
  bio_seq_align_structural_vector_norm(bio_seq_align_structural_vector_sub(a, b))
}

pub fn bio_seq_align_structural_vector_to_string(v : BioseqalignstructuralVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_align_structural_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_structural_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_structural_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_structural_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_structural_std(data : Array[Double]) -> Double { bio_seq_align_structural_sqrt(bio_seq_align_structural_var(data)) }

pub fn bio_seq_align_structural_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_align_structural_mean(a); let mb = bio_seq_align_structural_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_structural_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_align_structural_std(a); let sb = bio_seq_align_structural_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_align_structural_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_align_structural_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_structural_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_structural_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_align_structural_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_structural_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_seq_align_structural_sqrt(bio_seq_align_structural_mse(pred, labels))
}

pub fn bio_seq_align_structural_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_seq_align_structural_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_structural_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_align_structural_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_align_structural_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_align_structural_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_align_structural_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_align_structural_precision(pred, labels, pos); let r = bio_seq_align_structural_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_align_structural_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_align_structural_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_align_structural_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_align_structural_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_align_structural_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_align_structural_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_align_structural_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_align_structural_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_align_structural_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_align_structural_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_align_structural_min(data); let mx = bio_seq_align_structural_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_align_structural_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_align_structural_mean(data); let sd = bio_seq_align_structural_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_align_structural_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_align_structural_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_align_structural_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_align_structural_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_seq_align_structural_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_seq_align_structural_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_seq_align_structural_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_seq_align_structural_int(x) } else { -bio_seq_align_structural_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_seq_align_structural_int(f * 1000000.0) } else { bio_seq_align_structural_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_seq_align_structural_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_seq_align_structural_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BioseqalignstructuralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_frame_make(size : Int) -> BioseqalignstructuralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_frame_len(s : BioseqalignstructuralFrame) -> Int { s.size }

pub fn bio_seq_align_structural_frame_get(s : BioseqalignstructuralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_frame_set(s : BioseqalignstructuralFrame, i : Int, v : Double) -> BioseqalignstructuralFrame {
  let result = bio_seq_align_structural_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_frame_sum(s : BioseqalignstructuralFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_frame_mean(s : BioseqalignstructuralFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_frame_scale(s : BioseqalignstructuralFrame, f : Double) -> BioseqalignstructuralFrame {
  let result = bio_seq_align_structural_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_frame_add(a : BioseqalignstructuralFrame, b : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_frame_copy(s : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  let result = bio_seq_align_structural_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_frame_fill(s : BioseqalignstructuralFrame, v : Double) -> BioseqalignstructuralFrame {
  let result = bio_seq_align_structural_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_frame_min(s : BioseqalignstructuralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_frame_max(s : BioseqalignstructuralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_frame_to_string(s : BioseqalignstructuralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_table_make(size : Int) -> BioseqalignstructuralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_table_len(s : BioseqalignstructuralTable) -> Int { s.size }

pub fn bio_seq_align_structural_table_get(s : BioseqalignstructuralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_table_set(s : BioseqalignstructuralTable, i : Int, v : Double) -> BioseqalignstructuralTable {
  let result = bio_seq_align_structural_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_table_sum(s : BioseqalignstructuralTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_table_mean(s : BioseqalignstructuralTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_table_scale(s : BioseqalignstructuralTable, f : Double) -> BioseqalignstructuralTable {
  let result = bio_seq_align_structural_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_table_add(a : BioseqalignstructuralTable, b : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_table_copy(s : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  let result = bio_seq_align_structural_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_table_fill(s : BioseqalignstructuralTable, v : Double) -> BioseqalignstructuralTable {
  let result = bio_seq_align_structural_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_table_min(s : BioseqalignstructuralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_table_max(s : BioseqalignstructuralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_table_to_string(s : BioseqalignstructuralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_graphn_make(size : Int) -> BioseqalignstructuralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_graphn_len(s : BioseqalignstructuralGraphN) -> Int { s.size }

pub fn bio_seq_align_structural_graphn_get(s : BioseqalignstructuralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_graphn_set(s : BioseqalignstructuralGraphN, i : Int, v : Double) -> BioseqalignstructuralGraphN {
  let result = bio_seq_align_structural_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_graphn_sum(s : BioseqalignstructuralGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_graphn_mean(s : BioseqalignstructuralGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_graphn_scale(s : BioseqalignstructuralGraphN, f : Double) -> BioseqalignstructuralGraphN {
  let result = bio_seq_align_structural_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_graphn_add(a : BioseqalignstructuralGraphN, b : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_graphn_copy(s : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  let result = bio_seq_align_structural_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_graphn_fill(s : BioseqalignstructuralGraphN, v : Double) -> BioseqalignstructuralGraphN {
  let result = bio_seq_align_structural_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_graphn_min(s : BioseqalignstructuralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_graphn_max(s : BioseqalignstructuralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_graphn_to_string(s : BioseqalignstructuralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_node_make(size : Int) -> BioseqalignstructuralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_node_len(s : BioseqalignstructuralNode) -> Int { s.size }

pub fn bio_seq_align_structural_node_get(s : BioseqalignstructuralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_node_set(s : BioseqalignstructuralNode, i : Int, v : Double) -> BioseqalignstructuralNode {
  let result = bio_seq_align_structural_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_node_sum(s : BioseqalignstructuralNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_node_mean(s : BioseqalignstructuralNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_node_scale(s : BioseqalignstructuralNode, f : Double) -> BioseqalignstructuralNode {
  let result = bio_seq_align_structural_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_node_add(a : BioseqalignstructuralNode, b : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_node_copy(s : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  let result = bio_seq_align_structural_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_node_fill(s : BioseqalignstructuralNode, v : Double) -> BioseqalignstructuralNode {
  let result = bio_seq_align_structural_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_node_min(s : BioseqalignstructuralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_node_max(s : BioseqalignstructuralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_node_to_string(s : BioseqalignstructuralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_edge_make(size : Int) -> BioseqalignstructuralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_edge_len(s : BioseqalignstructuralEdge) -> Int { s.size }

pub fn bio_seq_align_structural_edge_get(s : BioseqalignstructuralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_edge_set(s : BioseqalignstructuralEdge, i : Int, v : Double) -> BioseqalignstructuralEdge {
  let result = bio_seq_align_structural_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_edge_sum(s : BioseqalignstructuralEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_edge_mean(s : BioseqalignstructuralEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_edge_scale(s : BioseqalignstructuralEdge, f : Double) -> BioseqalignstructuralEdge {
  let result = bio_seq_align_structural_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_edge_add(a : BioseqalignstructuralEdge, b : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_edge_copy(s : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  let result = bio_seq_align_structural_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_edge_fill(s : BioseqalignstructuralEdge, v : Double) -> BioseqalignstructuralEdge {
  let result = bio_seq_align_structural_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_edge_min(s : BioseqalignstructuralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_edge_max(s : BioseqalignstructuralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_edge_to_string(s : BioseqalignstructuralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_path_make(size : Int) -> BioseqalignstructuralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_path_len(s : BioseqalignstructuralPath) -> Int { s.size }

pub fn bio_seq_align_structural_path_get(s : BioseqalignstructuralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_path_set(s : BioseqalignstructuralPath, i : Int, v : Double) -> BioseqalignstructuralPath {
  let result = bio_seq_align_structural_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_path_sum(s : BioseqalignstructuralPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_path_mean(s : BioseqalignstructuralPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_path_scale(s : BioseqalignstructuralPath, f : Double) -> BioseqalignstructuralPath {
  let result = bio_seq_align_structural_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_path_add(a : BioseqalignstructuralPath, b : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_path_copy(s : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  let result = bio_seq_align_structural_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_path_fill(s : BioseqalignstructuralPath, v : Double) -> BioseqalignstructuralPath {
  let result = bio_seq_align_structural_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_path_min(s : BioseqalignstructuralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_path_max(s : BioseqalignstructuralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_path_to_string(s : BioseqalignstructuralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cluster_make(size : Int) -> BioseqalignstructuralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_cluster_len(s : BioseqalignstructuralCluster) -> Int { s.size }

pub fn bio_seq_align_structural_cluster_get(s : BioseqalignstructuralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_cluster_set(s : BioseqalignstructuralCluster, i : Int, v : Double) -> BioseqalignstructuralCluster {
  let result = bio_seq_align_structural_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_cluster_sum(s : BioseqalignstructuralCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_cluster_mean(s : BioseqalignstructuralCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_cluster_scale(s : BioseqalignstructuralCluster, f : Double) -> BioseqalignstructuralCluster {
  let result = bio_seq_align_structural_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_cluster_add(a : BioseqalignstructuralCluster, b : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_cluster_copy(s : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  let result = bio_seq_align_structural_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_cluster_fill(s : BioseqalignstructuralCluster, v : Double) -> BioseqalignstructuralCluster {
  let result = bio_seq_align_structural_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_cluster_min(s : BioseqalignstructuralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_cluster_max(s : BioseqalignstructuralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_cluster_to_string(s : BioseqalignstructuralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_model_make(size : Int) -> BioseqalignstructuralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_model_len(s : BioseqalignstructuralModel) -> Int { s.size }

pub fn bio_seq_align_structural_model_get(s : BioseqalignstructuralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_model_set(s : BioseqalignstructuralModel, i : Int, v : Double) -> BioseqalignstructuralModel {
  let result = bio_seq_align_structural_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_model_sum(s : BioseqalignstructuralModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_model_mean(s : BioseqalignstructuralModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_model_scale(s : BioseqalignstructuralModel, f : Double) -> BioseqalignstructuralModel {
  let result = bio_seq_align_structural_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_model_add(a : BioseqalignstructuralModel, b : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_model_copy(s : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  let result = bio_seq_align_structural_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_model_fill(s : BioseqalignstructuralModel, v : Double) -> BioseqalignstructuralModel {
  let result = bio_seq_align_structural_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_model_min(s : BioseqalignstructuralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_model_max(s : BioseqalignstructuralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_model_to_string(s : BioseqalignstructuralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_layer_make(size : Int) -> BioseqalignstructuralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_layer_len(s : BioseqalignstructuralLayer) -> Int { s.size }

pub fn bio_seq_align_structural_layer_get(s : BioseqalignstructuralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_layer_set(s : BioseqalignstructuralLayer, i : Int, v : Double) -> BioseqalignstructuralLayer {
  let result = bio_seq_align_structural_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_layer_sum(s : BioseqalignstructuralLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_layer_mean(s : BioseqalignstructuralLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_layer_scale(s : BioseqalignstructuralLayer, f : Double) -> BioseqalignstructuralLayer {
  let result = bio_seq_align_structural_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_layer_add(a : BioseqalignstructuralLayer, b : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_layer_copy(s : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  let result = bio_seq_align_structural_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_layer_fill(s : BioseqalignstructuralLayer, v : Double) -> BioseqalignstructuralLayer {
  let result = bio_seq_align_structural_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_layer_min(s : BioseqalignstructuralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_layer_max(s : BioseqalignstructuralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_layer_to_string(s : BioseqalignstructuralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_buffer_make(size : Int) -> BioseqalignstructuralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_buffer_len(s : BioseqalignstructuralBuffer) -> Int { s.size }

pub fn bio_seq_align_structural_buffer_get(s : BioseqalignstructuralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_buffer_set(s : BioseqalignstructuralBuffer, i : Int, v : Double) -> BioseqalignstructuralBuffer {
  let result = bio_seq_align_structural_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_buffer_sum(s : BioseqalignstructuralBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_buffer_mean(s : BioseqalignstructuralBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_buffer_scale(s : BioseqalignstructuralBuffer, f : Double) -> BioseqalignstructuralBuffer {
  let result = bio_seq_align_structural_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_buffer_add(a : BioseqalignstructuralBuffer, b : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_buffer_copy(s : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  let result = bio_seq_align_structural_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_buffer_fill(s : BioseqalignstructuralBuffer, v : Double) -> BioseqalignstructuralBuffer {
  let result = bio_seq_align_structural_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_buffer_min(s : BioseqalignstructuralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_buffer_max(s : BioseqalignstructuralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_buffer_to_string(s : BioseqalignstructuralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cursor_make(size : Int) -> BioseqalignstructuralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_cursor_len(s : BioseqalignstructuralCursor) -> Int { s.size }

pub fn bio_seq_align_structural_cursor_get(s : BioseqalignstructuralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_cursor_set(s : BioseqalignstructuralCursor, i : Int, v : Double) -> BioseqalignstructuralCursor {
  let result = bio_seq_align_structural_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_cursor_sum(s : BioseqalignstructuralCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_cursor_mean(s : BioseqalignstructuralCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_cursor_scale(s : BioseqalignstructuralCursor, f : Double) -> BioseqalignstructuralCursor {
  let result = bio_seq_align_structural_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_cursor_add(a : BioseqalignstructuralCursor, b : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_cursor_copy(s : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  let result = bio_seq_align_structural_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_cursor_fill(s : BioseqalignstructuralCursor, v : Double) -> BioseqalignstructuralCursor {
  let result = bio_seq_align_structural_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_cursor_min(s : BioseqalignstructuralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_cursor_max(s : BioseqalignstructuralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_cursor_to_string(s : BioseqalignstructuralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_view_make(size : Int) -> BioseqalignstructuralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_view_len(s : BioseqalignstructuralView) -> Int { s.size }

pub fn bio_seq_align_structural_view_get(s : BioseqalignstructuralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_view_set(s : BioseqalignstructuralView, i : Int, v : Double) -> BioseqalignstructuralView {
  let result = bio_seq_align_structural_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_view_sum(s : BioseqalignstructuralView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_view_mean(s : BioseqalignstructuralView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_view_scale(s : BioseqalignstructuralView, f : Double) -> BioseqalignstructuralView {
  let result = bio_seq_align_structural_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_view_add(a : BioseqalignstructuralView, b : BioseqalignstructuralView) -> BioseqalignstructuralView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_view_copy(s : BioseqalignstructuralView) -> BioseqalignstructuralView {
  let result = bio_seq_align_structural_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_view_fill(s : BioseqalignstructuralView, v : Double) -> BioseqalignstructuralView {
  let result = bio_seq_align_structural_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_view_min(s : BioseqalignstructuralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_view_max(s : BioseqalignstructuralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_view_to_string(s : BioseqalignstructuralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_range_make(size : Int) -> BioseqalignstructuralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_range_len(s : BioseqalignstructuralRange) -> Int { s.size }

pub fn bio_seq_align_structural_range_get(s : BioseqalignstructuralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_range_set(s : BioseqalignstructuralRange, i : Int, v : Double) -> BioseqalignstructuralRange {
  let result = bio_seq_align_structural_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_range_sum(s : BioseqalignstructuralRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_range_mean(s : BioseqalignstructuralRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_range_scale(s : BioseqalignstructuralRange, f : Double) -> BioseqalignstructuralRange {
  let result = bio_seq_align_structural_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_range_add(a : BioseqalignstructuralRange, b : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_range_copy(s : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  let result = bio_seq_align_structural_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_range_fill(s : BioseqalignstructuralRange, v : Double) -> BioseqalignstructuralRange {
  let result = bio_seq_align_structural_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_range_min(s : BioseqalignstructuralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_range_max(s : BioseqalignstructuralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_range_to_string(s : BioseqalignstructuralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_slice_make(size : Int) -> BioseqalignstructuralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_slice_len(s : BioseqalignstructuralSlice) -> Int { s.size }

pub fn bio_seq_align_structural_slice_get(s : BioseqalignstructuralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_slice_set(s : BioseqalignstructuralSlice, i : Int, v : Double) -> BioseqalignstructuralSlice {
  let result = bio_seq_align_structural_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_slice_sum(s : BioseqalignstructuralSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_structural_slice_mean(s : BioseqalignstructuralSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_structural_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_structural_slice_scale(s : BioseqalignstructuralSlice, f : Double) -> BioseqalignstructuralSlice {
  let result = bio_seq_align_structural_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_structural_slice_add(a : BioseqalignstructuralSlice, b : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_structural_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_structural_slice_copy(s : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  let result = bio_seq_align_structural_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_structural_slice_fill(s : BioseqalignstructuralSlice, v : Double) -> BioseqalignstructuralSlice {
  let result = bio_seq_align_structural_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_structural_slice_min(s : BioseqalignstructuralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_slice_max(s : BioseqalignstructuralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_structural_slice_to_string(s : BioseqalignstructuralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_seq_align_structural_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_align_structural_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


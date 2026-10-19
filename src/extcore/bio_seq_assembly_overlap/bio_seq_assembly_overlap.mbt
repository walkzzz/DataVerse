///===
/// extcore/bio_seq_assembly_overlap

pub(all) struct BioseqassemblyoverlapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_overlap_make_point(x : Double, y : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_overlap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_overlap_point_x(pt : BioseqassemblyoverlapPoint) -> Double { pt.x }

pub fn bio_seq_assembly_overlap_point_y(pt : BioseqassemblyoverlapPoint) -> Double { pt.y }

pub fn bio_seq_assembly_overlap_point_z(pt : BioseqassemblyoverlapPoint) -> Double { pt.z }

pub fn bio_seq_assembly_overlap_point_label(pt : BioseqassemblyoverlapPoint) -> Int { pt.label }

pub fn bio_seq_assembly_overlap_point_dist(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_seq_assembly_overlap_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_overlap_point_add(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_overlap_point_sub(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_overlap_point_scale(pt : BioseqassemblyoverlapPoint, s : Double) -> BioseqassemblyoverlapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_overlap_point_dot(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_overlap_point_cross(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_overlap_point_norm(pt : BioseqassemblyoverlapPoint) -> Double {
  bio_seq_assembly_overlap_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_overlap_point_normalize(pt : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  let n = bio_seq_assembly_overlap_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_overlap_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_overlap_point_negate(pt : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_overlap_point_mid(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_overlap_point_lerp(a : BioseqassemblyoverlapPoint, b : BioseqassemblyoverlapPoint, t : Double) -> BioseqassemblyoverlapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_overlap_point_to_string(pt : BioseqassemblyoverlapPoint) -> String {
  "(" + bio_seq_assembly_overlap_dbl(pt.x) + ", " + bio_seq_assembly_overlap_dbl(pt.y) + ", " + bio_seq_assembly_overlap_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_overlap_make_series(vals : Array[Double], name : String) -> BioseqassemblyoverlapSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_overlap_series_len(s : BioseqassemblyoverlapSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_overlap_series_sum(s : BioseqassemblyoverlapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_overlap_series_mean(s : BioseqassemblyoverlapSeries) -> Double {
  let n = bio_seq_assembly_overlap_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_assembly_overlap_series_sum(s) / n.to_double() }
}

pub fn bio_seq_assembly_overlap_series_min(s : BioseqassemblyoverlapSeries) -> Double {
  let n = bio_seq_assembly_overlap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_series_max(s : BioseqassemblyoverlapSeries) -> Double {
  let n = bio_seq_assembly_overlap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_series_range(s : BioseqassemblyoverlapSeries) -> Double {
  bio_seq_assembly_overlap_series_max(s) - bio_seq_assembly_overlap_series_min(s)
}

pub fn bio_seq_assembly_overlap_series_var(s : BioseqassemblyoverlapSeries) -> Double {
  let n = bio_seq_assembly_overlap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_overlap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_series_std(s : BioseqassemblyoverlapSeries) -> Double { bio_seq_assembly_overlap_sqrt(bio_seq_assembly_overlap_series_var(s)) }

pub fn bio_seq_assembly_overlap_series_median(s : BioseqassemblyoverlapSeries) -> Double {
  let n = bio_seq_assembly_overlap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_overlap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_overlap_series_scale(s : BioseqassemblyoverlapSeries, f : Double) -> BioseqassemblyoverlapSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_seq_assembly_overlap_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_overlap_series_add(a : BioseqassemblyoverlapSeries, b : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_overlap_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_overlap_series_sub(a : BioseqassemblyoverlapSeries, b : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_overlap_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_overlap_series_normalize(s : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let mn = bio_seq_assembly_overlap_series_min(s)
  let mx = bio_seq_assembly_overlap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_seq_assembly_overlap_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_overlap_series_cumsum(s : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_seq_assembly_overlap_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_overlap_series_to_string(s : BioseqassemblyoverlapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_assembly_overlap_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyoverlapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_overlap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyoverlapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_overlap_matrix_identity(n : Int) -> BioseqassemblyoverlapMatrix {
  let m = bio_seq_assembly_overlap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_overlap_matrix_get(m : BioseqassemblyoverlapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_overlap_matrix_transpose(m : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_overlap_matrix_add(a : BioseqassemblyoverlapMatrix, b : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_overlap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_overlap_matrix_scale(m : BioseqassemblyoverlapMatrix, s : Double) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_overlap_matrix_multiply(a : BioseqassemblyoverlapMatrix, b : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if a.cols != b.rows { return bio_seq_assembly_overlap_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_overlap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_overlap_matrix_trace(m : BioseqassemblyoverlapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_overlap_matrix_det(m : BioseqassemblyoverlapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_overlap_matrix_norm(m : BioseqassemblyoverlapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_seq_assembly_overlap_sqrt(sum)
}

pub fn bio_seq_assembly_overlap_matrix_to_string(m : BioseqassemblyoverlapMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_seq_assembly_overlap_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BioseqassemblyoverlapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_overlap_make_vector(comps : Array[Double]) -> BioseqassemblyoverlapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_overlap_vector_zero(dim : Int) -> BioseqassemblyoverlapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_overlap_vector_add(a : BioseqassemblyoverlapVector, b : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_overlap_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_overlap_vector_sub(a : BioseqassemblyoverlapVector, b : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_overlap_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_overlap_vector_scale(v : BioseqassemblyoverlapVector, s : Double) -> BioseqassemblyoverlapVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_seq_assembly_overlap_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_overlap_vector_dot(a : BioseqassemblyoverlapVector, b : BioseqassemblyoverlapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_overlap_vector_norm(v : BioseqassemblyoverlapVector) -> Double { bio_seq_assembly_overlap_sqrt(bio_seq_assembly_overlap_vector_dot(v, v)) }

pub fn bio_seq_assembly_overlap_vector_normalize(v : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = bio_seq_assembly_overlap_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_overlap_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_overlap_vector_dist(a : BioseqassemblyoverlapVector, b : BioseqassemblyoverlapVector) -> Double {
  bio_seq_assembly_overlap_vector_norm(bio_seq_assembly_overlap_vector_sub(a, b))
}

pub fn bio_seq_assembly_overlap_vector_to_string(v : BioseqassemblyoverlapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_assembly_overlap_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_overlap_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_overlap_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_std(data : Array[Double]) -> Double { bio_seq_assembly_overlap_sqrt(bio_seq_assembly_overlap_var(data)) }

pub fn bio_seq_assembly_overlap_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_assembly_overlap_mean(a); let mb = bio_seq_assembly_overlap_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_assembly_overlap_std(a); let sb = bio_seq_assembly_overlap_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_assembly_overlap_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_assembly_overlap_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_overlap_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_overlap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_seq_assembly_overlap_sqrt(bio_seq_assembly_overlap_mse(pred, labels))
}

pub fn bio_seq_assembly_overlap_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_seq_assembly_overlap_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_assembly_overlap_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_assembly_overlap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_assembly_overlap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_assembly_overlap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_assembly_overlap_precision(pred, labels, pos); let r = bio_seq_assembly_overlap_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_assembly_overlap_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_assembly_overlap_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_assembly_overlap_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_overlap_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_assembly_overlap_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_assembly_overlap_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_assembly_overlap_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_assembly_overlap_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_assembly_overlap_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_assembly_overlap_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_assembly_overlap_min(data); let mx = bio_seq_assembly_overlap_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_assembly_overlap_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_assembly_overlap_mean(data); let sd = bio_seq_assembly_overlap_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_assembly_overlap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_assembly_overlap_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_assembly_overlap_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_overlap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_seq_assembly_overlap_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_seq_assembly_overlap_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_seq_assembly_overlap_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_seq_assembly_overlap_int(x) } else { -bio_seq_assembly_overlap_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_seq_assembly_overlap_int(f * 1000000.0) } else { bio_seq_assembly_overlap_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_seq_assembly_overlap_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_seq_assembly_overlap_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BioseqassemblyoverlapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_frame_make(size : Int) -> BioseqassemblyoverlapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_frame_len(s : BioseqassemblyoverlapFrame) -> Int { s.size }

pub fn bio_seq_assembly_overlap_frame_get(s : BioseqassemblyoverlapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_frame_set(s : BioseqassemblyoverlapFrame, i : Int, v : Double) -> BioseqassemblyoverlapFrame {
  let result = bio_seq_assembly_overlap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_frame_sum(s : BioseqassemblyoverlapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_frame_mean(s : BioseqassemblyoverlapFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_frame_scale(s : BioseqassemblyoverlapFrame, f : Double) -> BioseqassemblyoverlapFrame {
  let result = bio_seq_assembly_overlap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_frame_add(a : BioseqassemblyoverlapFrame, b : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_frame_copy(s : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  let result = bio_seq_assembly_overlap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_frame_fill(s : BioseqassemblyoverlapFrame, v : Double) -> BioseqassemblyoverlapFrame {
  let result = bio_seq_assembly_overlap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_frame_min(s : BioseqassemblyoverlapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_frame_max(s : BioseqassemblyoverlapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_frame_to_string(s : BioseqassemblyoverlapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_table_make(size : Int) -> BioseqassemblyoverlapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_table_len(s : BioseqassemblyoverlapTable) -> Int { s.size }

pub fn bio_seq_assembly_overlap_table_get(s : BioseqassemblyoverlapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_table_set(s : BioseqassemblyoverlapTable, i : Int, v : Double) -> BioseqassemblyoverlapTable {
  let result = bio_seq_assembly_overlap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_table_sum(s : BioseqassemblyoverlapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_table_mean(s : BioseqassemblyoverlapTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_table_scale(s : BioseqassemblyoverlapTable, f : Double) -> BioseqassemblyoverlapTable {
  let result = bio_seq_assembly_overlap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_table_add(a : BioseqassemblyoverlapTable, b : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_table_copy(s : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  let result = bio_seq_assembly_overlap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_table_fill(s : BioseqassemblyoverlapTable, v : Double) -> BioseqassemblyoverlapTable {
  let result = bio_seq_assembly_overlap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_table_min(s : BioseqassemblyoverlapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_table_max(s : BioseqassemblyoverlapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_table_to_string(s : BioseqassemblyoverlapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_graphn_make(size : Int) -> BioseqassemblyoverlapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_graphn_len(s : BioseqassemblyoverlapGraphN) -> Int { s.size }

pub fn bio_seq_assembly_overlap_graphn_get(s : BioseqassemblyoverlapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_graphn_set(s : BioseqassemblyoverlapGraphN, i : Int, v : Double) -> BioseqassemblyoverlapGraphN {
  let result = bio_seq_assembly_overlap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_graphn_sum(s : BioseqassemblyoverlapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_graphn_mean(s : BioseqassemblyoverlapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_graphn_scale(s : BioseqassemblyoverlapGraphN, f : Double) -> BioseqassemblyoverlapGraphN {
  let result = bio_seq_assembly_overlap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_graphn_add(a : BioseqassemblyoverlapGraphN, b : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_graphn_copy(s : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  let result = bio_seq_assembly_overlap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_graphn_fill(s : BioseqassemblyoverlapGraphN, v : Double) -> BioseqassemblyoverlapGraphN {
  let result = bio_seq_assembly_overlap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_graphn_min(s : BioseqassemblyoverlapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_graphn_max(s : BioseqassemblyoverlapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_graphn_to_string(s : BioseqassemblyoverlapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_node_make(size : Int) -> BioseqassemblyoverlapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_node_len(s : BioseqassemblyoverlapNode) -> Int { s.size }

pub fn bio_seq_assembly_overlap_node_get(s : BioseqassemblyoverlapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_node_set(s : BioseqassemblyoverlapNode, i : Int, v : Double) -> BioseqassemblyoverlapNode {
  let result = bio_seq_assembly_overlap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_node_sum(s : BioseqassemblyoverlapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_node_mean(s : BioseqassemblyoverlapNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_node_scale(s : BioseqassemblyoverlapNode, f : Double) -> BioseqassemblyoverlapNode {
  let result = bio_seq_assembly_overlap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_node_add(a : BioseqassemblyoverlapNode, b : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_node_copy(s : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  let result = bio_seq_assembly_overlap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_node_fill(s : BioseqassemblyoverlapNode, v : Double) -> BioseqassemblyoverlapNode {
  let result = bio_seq_assembly_overlap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_node_min(s : BioseqassemblyoverlapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_node_max(s : BioseqassemblyoverlapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_node_to_string(s : BioseqassemblyoverlapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_edge_make(size : Int) -> BioseqassemblyoverlapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_edge_len(s : BioseqassemblyoverlapEdge) -> Int { s.size }

pub fn bio_seq_assembly_overlap_edge_get(s : BioseqassemblyoverlapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_edge_set(s : BioseqassemblyoverlapEdge, i : Int, v : Double) -> BioseqassemblyoverlapEdge {
  let result = bio_seq_assembly_overlap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_edge_sum(s : BioseqassemblyoverlapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_edge_mean(s : BioseqassemblyoverlapEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_edge_scale(s : BioseqassemblyoverlapEdge, f : Double) -> BioseqassemblyoverlapEdge {
  let result = bio_seq_assembly_overlap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_edge_add(a : BioseqassemblyoverlapEdge, b : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_edge_copy(s : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  let result = bio_seq_assembly_overlap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_edge_fill(s : BioseqassemblyoverlapEdge, v : Double) -> BioseqassemblyoverlapEdge {
  let result = bio_seq_assembly_overlap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_edge_min(s : BioseqassemblyoverlapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_edge_max(s : BioseqassemblyoverlapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_edge_to_string(s : BioseqassemblyoverlapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_path_make(size : Int) -> BioseqassemblyoverlapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_path_len(s : BioseqassemblyoverlapPath) -> Int { s.size }

pub fn bio_seq_assembly_overlap_path_get(s : BioseqassemblyoverlapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_path_set(s : BioseqassemblyoverlapPath, i : Int, v : Double) -> BioseqassemblyoverlapPath {
  let result = bio_seq_assembly_overlap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_path_sum(s : BioseqassemblyoverlapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_path_mean(s : BioseqassemblyoverlapPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_path_scale(s : BioseqassemblyoverlapPath, f : Double) -> BioseqassemblyoverlapPath {
  let result = bio_seq_assembly_overlap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_path_add(a : BioseqassemblyoverlapPath, b : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_path_copy(s : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  let result = bio_seq_assembly_overlap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_path_fill(s : BioseqassemblyoverlapPath, v : Double) -> BioseqassemblyoverlapPath {
  let result = bio_seq_assembly_overlap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_path_min(s : BioseqassemblyoverlapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_path_max(s : BioseqassemblyoverlapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_path_to_string(s : BioseqassemblyoverlapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cluster_make(size : Int) -> BioseqassemblyoverlapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_cluster_len(s : BioseqassemblyoverlapCluster) -> Int { s.size }

pub fn bio_seq_assembly_overlap_cluster_get(s : BioseqassemblyoverlapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_cluster_set(s : BioseqassemblyoverlapCluster, i : Int, v : Double) -> BioseqassemblyoverlapCluster {
  let result = bio_seq_assembly_overlap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_cluster_sum(s : BioseqassemblyoverlapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_cluster_mean(s : BioseqassemblyoverlapCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_cluster_scale(s : BioseqassemblyoverlapCluster, f : Double) -> BioseqassemblyoverlapCluster {
  let result = bio_seq_assembly_overlap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_cluster_add(a : BioseqassemblyoverlapCluster, b : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_cluster_copy(s : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  let result = bio_seq_assembly_overlap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_cluster_fill(s : BioseqassemblyoverlapCluster, v : Double) -> BioseqassemblyoverlapCluster {
  let result = bio_seq_assembly_overlap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_cluster_min(s : BioseqassemblyoverlapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_cluster_max(s : BioseqassemblyoverlapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_cluster_to_string(s : BioseqassemblyoverlapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_model_make(size : Int) -> BioseqassemblyoverlapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_model_len(s : BioseqassemblyoverlapModel) -> Int { s.size }

pub fn bio_seq_assembly_overlap_model_get(s : BioseqassemblyoverlapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_model_set(s : BioseqassemblyoverlapModel, i : Int, v : Double) -> BioseqassemblyoverlapModel {
  let result = bio_seq_assembly_overlap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_model_sum(s : BioseqassemblyoverlapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_model_mean(s : BioseqassemblyoverlapModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_model_scale(s : BioseqassemblyoverlapModel, f : Double) -> BioseqassemblyoverlapModel {
  let result = bio_seq_assembly_overlap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_model_add(a : BioseqassemblyoverlapModel, b : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_model_copy(s : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  let result = bio_seq_assembly_overlap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_model_fill(s : BioseqassemblyoverlapModel, v : Double) -> BioseqassemblyoverlapModel {
  let result = bio_seq_assembly_overlap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_model_min(s : BioseqassemblyoverlapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_model_max(s : BioseqassemblyoverlapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_model_to_string(s : BioseqassemblyoverlapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_layer_make(size : Int) -> BioseqassemblyoverlapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_layer_len(s : BioseqassemblyoverlapLayer) -> Int { s.size }

pub fn bio_seq_assembly_overlap_layer_get(s : BioseqassemblyoverlapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_layer_set(s : BioseqassemblyoverlapLayer, i : Int, v : Double) -> BioseqassemblyoverlapLayer {
  let result = bio_seq_assembly_overlap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_layer_sum(s : BioseqassemblyoverlapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_layer_mean(s : BioseqassemblyoverlapLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_layer_scale(s : BioseqassemblyoverlapLayer, f : Double) -> BioseqassemblyoverlapLayer {
  let result = bio_seq_assembly_overlap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_layer_add(a : BioseqassemblyoverlapLayer, b : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_layer_copy(s : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  let result = bio_seq_assembly_overlap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_layer_fill(s : BioseqassemblyoverlapLayer, v : Double) -> BioseqassemblyoverlapLayer {
  let result = bio_seq_assembly_overlap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_layer_min(s : BioseqassemblyoverlapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_layer_max(s : BioseqassemblyoverlapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_layer_to_string(s : BioseqassemblyoverlapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_buffer_make(size : Int) -> BioseqassemblyoverlapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_buffer_len(s : BioseqassemblyoverlapBuffer) -> Int { s.size }

pub fn bio_seq_assembly_overlap_buffer_get(s : BioseqassemblyoverlapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_buffer_set(s : BioseqassemblyoverlapBuffer, i : Int, v : Double) -> BioseqassemblyoverlapBuffer {
  let result = bio_seq_assembly_overlap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_buffer_sum(s : BioseqassemblyoverlapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_buffer_mean(s : BioseqassemblyoverlapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_buffer_scale(s : BioseqassemblyoverlapBuffer, f : Double) -> BioseqassemblyoverlapBuffer {
  let result = bio_seq_assembly_overlap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_buffer_add(a : BioseqassemblyoverlapBuffer, b : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_buffer_copy(s : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  let result = bio_seq_assembly_overlap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_buffer_fill(s : BioseqassemblyoverlapBuffer, v : Double) -> BioseqassemblyoverlapBuffer {
  let result = bio_seq_assembly_overlap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_buffer_min(s : BioseqassemblyoverlapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_buffer_max(s : BioseqassemblyoverlapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_buffer_to_string(s : BioseqassemblyoverlapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cursor_make(size : Int) -> BioseqassemblyoverlapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_cursor_len(s : BioseqassemblyoverlapCursor) -> Int { s.size }

pub fn bio_seq_assembly_overlap_cursor_get(s : BioseqassemblyoverlapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_cursor_set(s : BioseqassemblyoverlapCursor, i : Int, v : Double) -> BioseqassemblyoverlapCursor {
  let result = bio_seq_assembly_overlap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_cursor_sum(s : BioseqassemblyoverlapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_cursor_mean(s : BioseqassemblyoverlapCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_cursor_scale(s : BioseqassemblyoverlapCursor, f : Double) -> BioseqassemblyoverlapCursor {
  let result = bio_seq_assembly_overlap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_cursor_add(a : BioseqassemblyoverlapCursor, b : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_cursor_copy(s : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  let result = bio_seq_assembly_overlap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_cursor_fill(s : BioseqassemblyoverlapCursor, v : Double) -> BioseqassemblyoverlapCursor {
  let result = bio_seq_assembly_overlap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_cursor_min(s : BioseqassemblyoverlapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_cursor_max(s : BioseqassemblyoverlapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_cursor_to_string(s : BioseqassemblyoverlapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_view_make(size : Int) -> BioseqassemblyoverlapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_view_len(s : BioseqassemblyoverlapView) -> Int { s.size }

pub fn bio_seq_assembly_overlap_view_get(s : BioseqassemblyoverlapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_view_set(s : BioseqassemblyoverlapView, i : Int, v : Double) -> BioseqassemblyoverlapView {
  let result = bio_seq_assembly_overlap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_view_sum(s : BioseqassemblyoverlapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_view_mean(s : BioseqassemblyoverlapView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_view_scale(s : BioseqassemblyoverlapView, f : Double) -> BioseqassemblyoverlapView {
  let result = bio_seq_assembly_overlap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_view_add(a : BioseqassemblyoverlapView, b : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_view_copy(s : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  let result = bio_seq_assembly_overlap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_view_fill(s : BioseqassemblyoverlapView, v : Double) -> BioseqassemblyoverlapView {
  let result = bio_seq_assembly_overlap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_view_min(s : BioseqassemblyoverlapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_view_max(s : BioseqassemblyoverlapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_view_to_string(s : BioseqassemblyoverlapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_range_make(size : Int) -> BioseqassemblyoverlapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_range_len(s : BioseqassemblyoverlapRange) -> Int { s.size }

pub fn bio_seq_assembly_overlap_range_get(s : BioseqassemblyoverlapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_range_set(s : BioseqassemblyoverlapRange, i : Int, v : Double) -> BioseqassemblyoverlapRange {
  let result = bio_seq_assembly_overlap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_range_sum(s : BioseqassemblyoverlapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_range_mean(s : BioseqassemblyoverlapRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_range_scale(s : BioseqassemblyoverlapRange, f : Double) -> BioseqassemblyoverlapRange {
  let result = bio_seq_assembly_overlap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_range_add(a : BioseqassemblyoverlapRange, b : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_range_copy(s : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  let result = bio_seq_assembly_overlap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_range_fill(s : BioseqassemblyoverlapRange, v : Double) -> BioseqassemblyoverlapRange {
  let result = bio_seq_assembly_overlap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_range_min(s : BioseqassemblyoverlapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_range_max(s : BioseqassemblyoverlapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_range_to_string(s : BioseqassemblyoverlapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_slice_make(size : Int) -> BioseqassemblyoverlapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_slice_len(s : BioseqassemblyoverlapSlice) -> Int { s.size }

pub fn bio_seq_assembly_overlap_slice_get(s : BioseqassemblyoverlapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_slice_set(s : BioseqassemblyoverlapSlice, i : Int, v : Double) -> BioseqassemblyoverlapSlice {
  let result = bio_seq_assembly_overlap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_slice_sum(s : BioseqassemblyoverlapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_overlap_slice_mean(s : BioseqassemblyoverlapSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_overlap_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_overlap_slice_scale(s : BioseqassemblyoverlapSlice, f : Double) -> BioseqassemblyoverlapSlice {
  let result = bio_seq_assembly_overlap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_overlap_slice_add(a : BioseqassemblyoverlapSlice, b : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_overlap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_slice_copy(s : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  let result = bio_seq_assembly_overlap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_overlap_slice_fill(s : BioseqassemblyoverlapSlice, v : Double) -> BioseqassemblyoverlapSlice {
  let result = bio_seq_assembly_overlap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_overlap_slice_min(s : BioseqassemblyoverlapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_slice_max(s : BioseqassemblyoverlapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_overlap_slice_to_string(s : BioseqassemblyoverlapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_seq_assembly_overlap_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_overlap_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


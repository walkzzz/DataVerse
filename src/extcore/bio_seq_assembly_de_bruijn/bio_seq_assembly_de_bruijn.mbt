///===
/// extcore/bio_seq_assembly_de_bruijn

pub(all) struct BioseqassemblydebruijnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_de_bruijn_make_point(x : Double, y : Double) -> BioseqassemblydebruijnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_de_bruijn_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblydebruijnPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_de_bruijn_point_x(pt : BioseqassemblydebruijnPoint) -> Double { pt.x }

pub fn bio_seq_assembly_de_bruijn_point_y(pt : BioseqassemblydebruijnPoint) -> Double { pt.y }

pub fn bio_seq_assembly_de_bruijn_point_z(pt : BioseqassemblydebruijnPoint) -> Double { pt.z }

pub fn bio_seq_assembly_de_bruijn_point_label(pt : BioseqassemblydebruijnPoint) -> Int { pt.label }

pub fn bio_seq_assembly_de_bruijn_point_dist(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_seq_assembly_de_bruijn_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_de_bruijn_point_add(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_de_bruijn_point_sub(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_de_bruijn_point_scale(pt : BioseqassemblydebruijnPoint, s : Double) -> BioseqassemblydebruijnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_de_bruijn_point_dot(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_de_bruijn_point_cross(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_de_bruijn_point_norm(pt : BioseqassemblydebruijnPoint) -> Double {
  bio_seq_assembly_de_bruijn_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_de_bruijn_point_normalize(pt : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  let n = bio_seq_assembly_de_bruijn_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_de_bruijn_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_de_bruijn_point_negate(pt : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_de_bruijn_point_mid(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint) -> BioseqassemblydebruijnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_de_bruijn_point_lerp(a : BioseqassemblydebruijnPoint, b : BioseqassemblydebruijnPoint, t : Double) -> BioseqassemblydebruijnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_de_bruijn_point_to_string(pt : BioseqassemblydebruijnPoint) -> String {
  "(" + bio_seq_assembly_de_bruijn_dbl(pt.x) + ", " + bio_seq_assembly_de_bruijn_dbl(pt.y) + ", " + bio_seq_assembly_de_bruijn_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_de_bruijn_make_series(vals : Array[Double], name : String) -> BioseqassemblydebruijnSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_de_bruijn_series_len(s : BioseqassemblydebruijnSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_de_bruijn_series_sum(s : BioseqassemblydebruijnSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_series_mean(s : BioseqassemblydebruijnSeries) -> Double {
  let n = bio_seq_assembly_de_bruijn_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_series_sum(s) / n.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_series_min(s : BioseqassemblydebruijnSeries) -> Double {
  let n = bio_seq_assembly_de_bruijn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_series_max(s : BioseqassemblydebruijnSeries) -> Double {
  let n = bio_seq_assembly_de_bruijn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_series_range(s : BioseqassemblydebruijnSeries) -> Double {
  bio_seq_assembly_de_bruijn_series_max(s) - bio_seq_assembly_de_bruijn_series_min(s)
}

pub fn bio_seq_assembly_de_bruijn_series_var(s : BioseqassemblydebruijnSeries) -> Double {
  let n = bio_seq_assembly_de_bruijn_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_de_bruijn_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_series_std(s : BioseqassemblydebruijnSeries) -> Double { bio_seq_assembly_de_bruijn_sqrt(bio_seq_assembly_de_bruijn_series_var(s)) }

pub fn bio_seq_assembly_de_bruijn_series_median(s : BioseqassemblydebruijnSeries) -> Double {
  let n = bio_seq_assembly_de_bruijn_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_de_bruijn_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_de_bruijn_series_scale(s : BioseqassemblydebruijnSeries, f : Double) -> BioseqassemblydebruijnSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_seq_assembly_de_bruijn_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_de_bruijn_series_add(a : BioseqassemblydebruijnSeries, b : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_de_bruijn_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_de_bruijn_series_sub(a : BioseqassemblydebruijnSeries, b : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_de_bruijn_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_de_bruijn_series_normalize(s : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  let mn = bio_seq_assembly_de_bruijn_series_min(s)
  let mx = bio_seq_assembly_de_bruijn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_seq_assembly_de_bruijn_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_de_bruijn_series_cumsum(s : BioseqassemblydebruijnSeries) -> BioseqassemblydebruijnSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_seq_assembly_de_bruijn_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_de_bruijn_series_to_string(s : BioseqassemblydebruijnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_assembly_de_bruijn_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblydebruijnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_de_bruijn_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblydebruijnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_de_bruijn_matrix_identity(n : Int) -> BioseqassemblydebruijnMatrix {
  let m = bio_seq_assembly_de_bruijn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_de_bruijn_matrix_get(m : BioseqassemblydebruijnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_de_bruijn_matrix_transpose(m : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  let result = bio_seq_assembly_de_bruijn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_de_bruijn_matrix_add(a : BioseqassemblydebruijnMatrix, b : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_de_bruijn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_de_bruijn_matrix_scale(m : BioseqassemblydebruijnMatrix, s : Double) -> BioseqassemblydebruijnMatrix {
  let result = bio_seq_assembly_de_bruijn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_de_bruijn_matrix_multiply(a : BioseqassemblydebruijnMatrix, b : BioseqassemblydebruijnMatrix) -> BioseqassemblydebruijnMatrix {
  if a.cols != b.rows { return bio_seq_assembly_de_bruijn_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_de_bruijn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_de_bruijn_matrix_trace(m : BioseqassemblydebruijnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_de_bruijn_matrix_det(m : BioseqassemblydebruijnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_de_bruijn_matrix_norm(m : BioseqassemblydebruijnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_seq_assembly_de_bruijn_sqrt(sum)
}

pub fn bio_seq_assembly_de_bruijn_matrix_to_string(m : BioseqassemblydebruijnMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_seq_assembly_de_bruijn_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BioseqassemblydebruijnVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_de_bruijn_make_vector(comps : Array[Double]) -> BioseqassemblydebruijnVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_de_bruijn_vector_zero(dim : Int) -> BioseqassemblydebruijnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_de_bruijn_vector_add(a : BioseqassemblydebruijnVector, b : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_de_bruijn_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_de_bruijn_vector_sub(a : BioseqassemblydebruijnVector, b : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_seq_assembly_de_bruijn_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_de_bruijn_vector_scale(v : BioseqassemblydebruijnVector, s : Double) -> BioseqassemblydebruijnVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_seq_assembly_de_bruijn_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_de_bruijn_vector_dot(a : BioseqassemblydebruijnVector, b : BioseqassemblydebruijnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_de_bruijn_vector_norm(v : BioseqassemblydebruijnVector) -> Double { bio_seq_assembly_de_bruijn_sqrt(bio_seq_assembly_de_bruijn_vector_dot(v, v)) }

pub fn bio_seq_assembly_de_bruijn_vector_normalize(v : BioseqassemblydebruijnVector) -> BioseqassemblydebruijnVector {
  let n = bio_seq_assembly_de_bruijn_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_de_bruijn_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_de_bruijn_vector_dist(a : BioseqassemblydebruijnVector, b : BioseqassemblydebruijnVector) -> Double {
  bio_seq_assembly_de_bruijn_vector_norm(bio_seq_assembly_de_bruijn_vector_sub(a, b))
}

pub fn bio_seq_assembly_de_bruijn_vector_to_string(v : BioseqassemblydebruijnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_seq_assembly_de_bruijn_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_de_bruijn_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_de_bruijn_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_std(data : Array[Double]) -> Double { bio_seq_assembly_de_bruijn_sqrt(bio_seq_assembly_de_bruijn_var(data)) }

pub fn bio_seq_assembly_de_bruijn_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_assembly_de_bruijn_mean(a); let mb = bio_seq_assembly_de_bruijn_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_assembly_de_bruijn_std(a); let sb = bio_seq_assembly_de_bruijn_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_assembly_de_bruijn_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_assembly_de_bruijn_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_de_bruijn_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_de_bruijn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_seq_assembly_de_bruijn_sqrt(bio_seq_assembly_de_bruijn_mse(pred, labels))
}

pub fn bio_seq_assembly_de_bruijn_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_seq_assembly_de_bruijn_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_assembly_de_bruijn_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_assembly_de_bruijn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_assembly_de_bruijn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_assembly_de_bruijn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_assembly_de_bruijn_precision(pred, labels, pos); let r = bio_seq_assembly_de_bruijn_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_assembly_de_bruijn_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_assembly_de_bruijn_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_assembly_de_bruijn_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_assembly_de_bruijn_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_assembly_de_bruijn_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_assembly_de_bruijn_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_assembly_de_bruijn_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_assembly_de_bruijn_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_assembly_de_bruijn_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_assembly_de_bruijn_min(data); let mx = bio_seq_assembly_de_bruijn_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_assembly_de_bruijn_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_assembly_de_bruijn_mean(data); let sd = bio_seq_assembly_de_bruijn_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_assembly_de_bruijn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_assembly_de_bruijn_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_assembly_de_bruijn_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_seq_assembly_de_bruijn_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_seq_assembly_de_bruijn_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_seq_assembly_de_bruijn_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_seq_assembly_de_bruijn_int(x) } else { -bio_seq_assembly_de_bruijn_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_seq_assembly_de_bruijn_int(f * 1000000.0) } else { bio_seq_assembly_de_bruijn_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_seq_assembly_de_bruijn_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_seq_assembly_de_bruijn_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BioseqassemblydebruijnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_frame_make(size : Int) -> BioseqassemblydebruijnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_frame_len(s : BioseqassemblydebruijnFrame) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_frame_get(s : BioseqassemblydebruijnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_frame_set(s : BioseqassemblydebruijnFrame, i : Int, v : Double) -> BioseqassemblydebruijnFrame {
  let result = bio_seq_assembly_de_bruijn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_frame_sum(s : BioseqassemblydebruijnFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_frame_mean(s : BioseqassemblydebruijnFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_frame_scale(s : BioseqassemblydebruijnFrame, f : Double) -> BioseqassemblydebruijnFrame {
  let result = bio_seq_assembly_de_bruijn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_frame_add(a : BioseqassemblydebruijnFrame, b : BioseqassemblydebruijnFrame) -> BioseqassemblydebruijnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_frame_copy(s : BioseqassemblydebruijnFrame) -> BioseqassemblydebruijnFrame {
  let result = bio_seq_assembly_de_bruijn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_frame_fill(s : BioseqassemblydebruijnFrame, v : Double) -> BioseqassemblydebruijnFrame {
  let result = bio_seq_assembly_de_bruijn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_frame_min(s : BioseqassemblydebruijnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_frame_max(s : BioseqassemblydebruijnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_frame_to_string(s : BioseqassemblydebruijnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_table_make(size : Int) -> BioseqassemblydebruijnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_table_len(s : BioseqassemblydebruijnTable) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_table_get(s : BioseqassemblydebruijnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_table_set(s : BioseqassemblydebruijnTable, i : Int, v : Double) -> BioseqassemblydebruijnTable {
  let result = bio_seq_assembly_de_bruijn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_table_sum(s : BioseqassemblydebruijnTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_table_mean(s : BioseqassemblydebruijnTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_table_scale(s : BioseqassemblydebruijnTable, f : Double) -> BioseqassemblydebruijnTable {
  let result = bio_seq_assembly_de_bruijn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_table_add(a : BioseqassemblydebruijnTable, b : BioseqassemblydebruijnTable) -> BioseqassemblydebruijnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_table_copy(s : BioseqassemblydebruijnTable) -> BioseqassemblydebruijnTable {
  let result = bio_seq_assembly_de_bruijn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_table_fill(s : BioseqassemblydebruijnTable, v : Double) -> BioseqassemblydebruijnTable {
  let result = bio_seq_assembly_de_bruijn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_table_min(s : BioseqassemblydebruijnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_table_max(s : BioseqassemblydebruijnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_table_to_string(s : BioseqassemblydebruijnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_graphn_make(size : Int) -> BioseqassemblydebruijnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_graphn_len(s : BioseqassemblydebruijnGraphN) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_graphn_get(s : BioseqassemblydebruijnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_graphn_set(s : BioseqassemblydebruijnGraphN, i : Int, v : Double) -> BioseqassemblydebruijnGraphN {
  let result = bio_seq_assembly_de_bruijn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_graphn_sum(s : BioseqassemblydebruijnGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_graphn_mean(s : BioseqassemblydebruijnGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_graphn_scale(s : BioseqassemblydebruijnGraphN, f : Double) -> BioseqassemblydebruijnGraphN {
  let result = bio_seq_assembly_de_bruijn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_graphn_add(a : BioseqassemblydebruijnGraphN, b : BioseqassemblydebruijnGraphN) -> BioseqassemblydebruijnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_graphn_copy(s : BioseqassemblydebruijnGraphN) -> BioseqassemblydebruijnGraphN {
  let result = bio_seq_assembly_de_bruijn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_graphn_fill(s : BioseqassemblydebruijnGraphN, v : Double) -> BioseqassemblydebruijnGraphN {
  let result = bio_seq_assembly_de_bruijn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_graphn_min(s : BioseqassemblydebruijnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_graphn_max(s : BioseqassemblydebruijnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_graphn_to_string(s : BioseqassemblydebruijnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_node_make(size : Int) -> BioseqassemblydebruijnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_node_len(s : BioseqassemblydebruijnNode) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_node_get(s : BioseqassemblydebruijnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_node_set(s : BioseqassemblydebruijnNode, i : Int, v : Double) -> BioseqassemblydebruijnNode {
  let result = bio_seq_assembly_de_bruijn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_node_sum(s : BioseqassemblydebruijnNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_node_mean(s : BioseqassemblydebruijnNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_node_scale(s : BioseqassemblydebruijnNode, f : Double) -> BioseqassemblydebruijnNode {
  let result = bio_seq_assembly_de_bruijn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_node_add(a : BioseqassemblydebruijnNode, b : BioseqassemblydebruijnNode) -> BioseqassemblydebruijnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_node_copy(s : BioseqassemblydebruijnNode) -> BioseqassemblydebruijnNode {
  let result = bio_seq_assembly_de_bruijn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_node_fill(s : BioseqassemblydebruijnNode, v : Double) -> BioseqassemblydebruijnNode {
  let result = bio_seq_assembly_de_bruijn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_node_min(s : BioseqassemblydebruijnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_node_max(s : BioseqassemblydebruijnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_node_to_string(s : BioseqassemblydebruijnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_edge_make(size : Int) -> BioseqassemblydebruijnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_edge_len(s : BioseqassemblydebruijnEdge) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_edge_get(s : BioseqassemblydebruijnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_edge_set(s : BioseqassemblydebruijnEdge, i : Int, v : Double) -> BioseqassemblydebruijnEdge {
  let result = bio_seq_assembly_de_bruijn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_edge_sum(s : BioseqassemblydebruijnEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_edge_mean(s : BioseqassemblydebruijnEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_edge_scale(s : BioseqassemblydebruijnEdge, f : Double) -> BioseqassemblydebruijnEdge {
  let result = bio_seq_assembly_de_bruijn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_edge_add(a : BioseqassemblydebruijnEdge, b : BioseqassemblydebruijnEdge) -> BioseqassemblydebruijnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_edge_copy(s : BioseqassemblydebruijnEdge) -> BioseqassemblydebruijnEdge {
  let result = bio_seq_assembly_de_bruijn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_edge_fill(s : BioseqassemblydebruijnEdge, v : Double) -> BioseqassemblydebruijnEdge {
  let result = bio_seq_assembly_de_bruijn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_edge_min(s : BioseqassemblydebruijnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_edge_max(s : BioseqassemblydebruijnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_edge_to_string(s : BioseqassemblydebruijnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_path_make(size : Int) -> BioseqassemblydebruijnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_path_len(s : BioseqassemblydebruijnPath) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_path_get(s : BioseqassemblydebruijnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_path_set(s : BioseqassemblydebruijnPath, i : Int, v : Double) -> BioseqassemblydebruijnPath {
  let result = bio_seq_assembly_de_bruijn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_path_sum(s : BioseqassemblydebruijnPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_path_mean(s : BioseqassemblydebruijnPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_path_scale(s : BioseqassemblydebruijnPath, f : Double) -> BioseqassemblydebruijnPath {
  let result = bio_seq_assembly_de_bruijn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_path_add(a : BioseqassemblydebruijnPath, b : BioseqassemblydebruijnPath) -> BioseqassemblydebruijnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_path_copy(s : BioseqassemblydebruijnPath) -> BioseqassemblydebruijnPath {
  let result = bio_seq_assembly_de_bruijn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_path_fill(s : BioseqassemblydebruijnPath, v : Double) -> BioseqassemblydebruijnPath {
  let result = bio_seq_assembly_de_bruijn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_path_min(s : BioseqassemblydebruijnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_path_max(s : BioseqassemblydebruijnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_path_to_string(s : BioseqassemblydebruijnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_cluster_make(size : Int) -> BioseqassemblydebruijnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_cluster_len(s : BioseqassemblydebruijnCluster) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_cluster_get(s : BioseqassemblydebruijnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_cluster_set(s : BioseqassemblydebruijnCluster, i : Int, v : Double) -> BioseqassemblydebruijnCluster {
  let result = bio_seq_assembly_de_bruijn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_cluster_sum(s : BioseqassemblydebruijnCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_cluster_mean(s : BioseqassemblydebruijnCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_cluster_scale(s : BioseqassemblydebruijnCluster, f : Double) -> BioseqassemblydebruijnCluster {
  let result = bio_seq_assembly_de_bruijn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_cluster_add(a : BioseqassemblydebruijnCluster, b : BioseqassemblydebruijnCluster) -> BioseqassemblydebruijnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_cluster_copy(s : BioseqassemblydebruijnCluster) -> BioseqassemblydebruijnCluster {
  let result = bio_seq_assembly_de_bruijn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_cluster_fill(s : BioseqassemblydebruijnCluster, v : Double) -> BioseqassemblydebruijnCluster {
  let result = bio_seq_assembly_de_bruijn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_cluster_min(s : BioseqassemblydebruijnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_cluster_max(s : BioseqassemblydebruijnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_cluster_to_string(s : BioseqassemblydebruijnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_model_make(size : Int) -> BioseqassemblydebruijnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_model_len(s : BioseqassemblydebruijnModel) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_model_get(s : BioseqassemblydebruijnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_model_set(s : BioseqassemblydebruijnModel, i : Int, v : Double) -> BioseqassemblydebruijnModel {
  let result = bio_seq_assembly_de_bruijn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_model_sum(s : BioseqassemblydebruijnModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_model_mean(s : BioseqassemblydebruijnModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_model_scale(s : BioseqassemblydebruijnModel, f : Double) -> BioseqassemblydebruijnModel {
  let result = bio_seq_assembly_de_bruijn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_model_add(a : BioseqassemblydebruijnModel, b : BioseqassemblydebruijnModel) -> BioseqassemblydebruijnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_model_copy(s : BioseqassemblydebruijnModel) -> BioseqassemblydebruijnModel {
  let result = bio_seq_assembly_de_bruijn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_model_fill(s : BioseqassemblydebruijnModel, v : Double) -> BioseqassemblydebruijnModel {
  let result = bio_seq_assembly_de_bruijn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_model_min(s : BioseqassemblydebruijnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_model_max(s : BioseqassemblydebruijnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_model_to_string(s : BioseqassemblydebruijnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_layer_make(size : Int) -> BioseqassemblydebruijnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_layer_len(s : BioseqassemblydebruijnLayer) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_layer_get(s : BioseqassemblydebruijnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_layer_set(s : BioseqassemblydebruijnLayer, i : Int, v : Double) -> BioseqassemblydebruijnLayer {
  let result = bio_seq_assembly_de_bruijn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_layer_sum(s : BioseqassemblydebruijnLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_layer_mean(s : BioseqassemblydebruijnLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_layer_scale(s : BioseqassemblydebruijnLayer, f : Double) -> BioseqassemblydebruijnLayer {
  let result = bio_seq_assembly_de_bruijn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_layer_add(a : BioseqassemblydebruijnLayer, b : BioseqassemblydebruijnLayer) -> BioseqassemblydebruijnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_layer_copy(s : BioseqassemblydebruijnLayer) -> BioseqassemblydebruijnLayer {
  let result = bio_seq_assembly_de_bruijn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_layer_fill(s : BioseqassemblydebruijnLayer, v : Double) -> BioseqassemblydebruijnLayer {
  let result = bio_seq_assembly_de_bruijn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_layer_min(s : BioseqassemblydebruijnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_layer_max(s : BioseqassemblydebruijnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_layer_to_string(s : BioseqassemblydebruijnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_buffer_make(size : Int) -> BioseqassemblydebruijnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_buffer_len(s : BioseqassemblydebruijnBuffer) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_buffer_get(s : BioseqassemblydebruijnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_buffer_set(s : BioseqassemblydebruijnBuffer, i : Int, v : Double) -> BioseqassemblydebruijnBuffer {
  let result = bio_seq_assembly_de_bruijn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_buffer_sum(s : BioseqassemblydebruijnBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_buffer_mean(s : BioseqassemblydebruijnBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_buffer_scale(s : BioseqassemblydebruijnBuffer, f : Double) -> BioseqassemblydebruijnBuffer {
  let result = bio_seq_assembly_de_bruijn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_buffer_add(a : BioseqassemblydebruijnBuffer, b : BioseqassemblydebruijnBuffer) -> BioseqassemblydebruijnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_buffer_copy(s : BioseqassemblydebruijnBuffer) -> BioseqassemblydebruijnBuffer {
  let result = bio_seq_assembly_de_bruijn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_buffer_fill(s : BioseqassemblydebruijnBuffer, v : Double) -> BioseqassemblydebruijnBuffer {
  let result = bio_seq_assembly_de_bruijn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_buffer_min(s : BioseqassemblydebruijnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_buffer_max(s : BioseqassemblydebruijnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_buffer_to_string(s : BioseqassemblydebruijnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_cursor_make(size : Int) -> BioseqassemblydebruijnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_cursor_len(s : BioseqassemblydebruijnCursor) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_cursor_get(s : BioseqassemblydebruijnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_cursor_set(s : BioseqassemblydebruijnCursor, i : Int, v : Double) -> BioseqassemblydebruijnCursor {
  let result = bio_seq_assembly_de_bruijn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_cursor_sum(s : BioseqassemblydebruijnCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_cursor_mean(s : BioseqassemblydebruijnCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_cursor_scale(s : BioseqassemblydebruijnCursor, f : Double) -> BioseqassemblydebruijnCursor {
  let result = bio_seq_assembly_de_bruijn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_cursor_add(a : BioseqassemblydebruijnCursor, b : BioseqassemblydebruijnCursor) -> BioseqassemblydebruijnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_cursor_copy(s : BioseqassemblydebruijnCursor) -> BioseqassemblydebruijnCursor {
  let result = bio_seq_assembly_de_bruijn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_cursor_fill(s : BioseqassemblydebruijnCursor, v : Double) -> BioseqassemblydebruijnCursor {
  let result = bio_seq_assembly_de_bruijn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_cursor_min(s : BioseqassemblydebruijnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_cursor_max(s : BioseqassemblydebruijnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_cursor_to_string(s : BioseqassemblydebruijnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_view_make(size : Int) -> BioseqassemblydebruijnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_view_len(s : BioseqassemblydebruijnView) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_view_get(s : BioseqassemblydebruijnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_view_set(s : BioseqassemblydebruijnView, i : Int, v : Double) -> BioseqassemblydebruijnView {
  let result = bio_seq_assembly_de_bruijn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_view_sum(s : BioseqassemblydebruijnView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_view_mean(s : BioseqassemblydebruijnView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_view_scale(s : BioseqassemblydebruijnView, f : Double) -> BioseqassemblydebruijnView {
  let result = bio_seq_assembly_de_bruijn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_view_add(a : BioseqassemblydebruijnView, b : BioseqassemblydebruijnView) -> BioseqassemblydebruijnView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_view_copy(s : BioseqassemblydebruijnView) -> BioseqassemblydebruijnView {
  let result = bio_seq_assembly_de_bruijn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_view_fill(s : BioseqassemblydebruijnView, v : Double) -> BioseqassemblydebruijnView {
  let result = bio_seq_assembly_de_bruijn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_view_min(s : BioseqassemblydebruijnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_view_max(s : BioseqassemblydebruijnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_view_to_string(s : BioseqassemblydebruijnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_range_make(size : Int) -> BioseqassemblydebruijnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_range_len(s : BioseqassemblydebruijnRange) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_range_get(s : BioseqassemblydebruijnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_range_set(s : BioseqassemblydebruijnRange, i : Int, v : Double) -> BioseqassemblydebruijnRange {
  let result = bio_seq_assembly_de_bruijn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_range_sum(s : BioseqassemblydebruijnRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_range_mean(s : BioseqassemblydebruijnRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_range_scale(s : BioseqassemblydebruijnRange, f : Double) -> BioseqassemblydebruijnRange {
  let result = bio_seq_assembly_de_bruijn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_range_add(a : BioseqassemblydebruijnRange, b : BioseqassemblydebruijnRange) -> BioseqassemblydebruijnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_range_copy(s : BioseqassemblydebruijnRange) -> BioseqassemblydebruijnRange {
  let result = bio_seq_assembly_de_bruijn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_range_fill(s : BioseqassemblydebruijnRange, v : Double) -> BioseqassemblydebruijnRange {
  let result = bio_seq_assembly_de_bruijn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_range_min(s : BioseqassemblydebruijnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_range_max(s : BioseqassemblydebruijnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_range_to_string(s : BioseqassemblydebruijnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblydebruijnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_de_bruijn_slice_make(size : Int) -> BioseqassemblydebruijnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_de_bruijn_slice_len(s : BioseqassemblydebruijnSlice) -> Int { s.size }

pub fn bio_seq_assembly_de_bruijn_slice_get(s : BioseqassemblydebruijnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_de_bruijn_slice_set(s : BioseqassemblydebruijnSlice, i : Int, v : Double) -> BioseqassemblydebruijnSlice {
  let result = bio_seq_assembly_de_bruijn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_slice_sum(s : BioseqassemblydebruijnSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_de_bruijn_slice_mean(s : BioseqassemblydebruijnSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_de_bruijn_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_de_bruijn_slice_scale(s : BioseqassemblydebruijnSlice, f : Double) -> BioseqassemblydebruijnSlice {
  let result = bio_seq_assembly_de_bruijn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_de_bruijn_slice_add(a : BioseqassemblydebruijnSlice, b : BioseqassemblydebruijnSlice) -> BioseqassemblydebruijnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_de_bruijn_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_slice_copy(s : BioseqassemblydebruijnSlice) -> BioseqassemblydebruijnSlice {
  let result = bio_seq_assembly_de_bruijn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_de_bruijn_slice_fill(s : BioseqassemblydebruijnSlice, v : Double) -> BioseqassemblydebruijnSlice {
  let result = bio_seq_assembly_de_bruijn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_de_bruijn_slice_min(s : BioseqassemblydebruijnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_slice_max(s : BioseqassemblydebruijnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_de_bruijn_slice_to_string(s : BioseqassemblydebruijnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_seq_assembly_de_bruijn_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_seq_assembly_de_bruijn_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


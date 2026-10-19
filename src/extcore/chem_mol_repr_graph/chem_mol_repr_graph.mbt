///===
/// extcore/chem_mol_repr_graph

pub(all) struct ChemmolreprgraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_graph_make_point(x : Double, y : Double) -> ChemmolreprgraphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_graph_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprgraphPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_graph_point_x(pt : ChemmolreprgraphPoint) -> Double { pt.x }

pub fn chem_mol_repr_graph_point_y(pt : ChemmolreprgraphPoint) -> Double { pt.y }

pub fn chem_mol_repr_graph_point_z(pt : ChemmolreprgraphPoint) -> Double { pt.z }

pub fn chem_mol_repr_graph_point_label(pt : ChemmolreprgraphPoint) -> Int { pt.label }

pub fn chem_mol_repr_graph_point_dist(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_mol_repr_graph_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_graph_point_add(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_graph_point_sub(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_graph_point_scale(pt : ChemmolreprgraphPoint, s : Double) -> ChemmolreprgraphPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_graph_point_dot(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_graph_point_cross(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_graph_point_norm(pt : ChemmolreprgraphPoint) -> Double {
  chem_mol_repr_graph_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_graph_point_normalize(pt : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  let n = chem_mol_repr_graph_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_graph_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_graph_point_negate(pt : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_graph_point_mid(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint) -> ChemmolreprgraphPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_graph_point_lerp(a : ChemmolreprgraphPoint, b : ChemmolreprgraphPoint, t : Double) -> ChemmolreprgraphPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_graph_point_to_string(pt : ChemmolreprgraphPoint) -> String {
  "(" + chem_mol_repr_graph_dbl(pt.x) + ", " + chem_mol_repr_graph_dbl(pt.y) + ", " + chem_mol_repr_graph_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprgraphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_graph_make_series(vals : Array[Double], name : String) -> ChemmolreprgraphSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_graph_series_len(s : ChemmolreprgraphSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_graph_series_sum(s : ChemmolreprgraphSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_graph_series_mean(s : ChemmolreprgraphSeries) -> Double {
  let n = chem_mol_repr_graph_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_graph_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_graph_series_min(s : ChemmolreprgraphSeries) -> Double {
  let n = chem_mol_repr_graph_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_series_max(s : ChemmolreprgraphSeries) -> Double {
  let n = chem_mol_repr_graph_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_series_range(s : ChemmolreprgraphSeries) -> Double {
  chem_mol_repr_graph_series_max(s) - chem_mol_repr_graph_series_min(s)
}

pub fn chem_mol_repr_graph_series_var(s : ChemmolreprgraphSeries) -> Double {
  let n = chem_mol_repr_graph_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_graph_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_graph_series_std(s : ChemmolreprgraphSeries) -> Double { chem_mol_repr_graph_sqrt(chem_mol_repr_graph_series_var(s)) }

pub fn chem_mol_repr_graph_series_median(s : ChemmolreprgraphSeries) -> Double {
  let n = chem_mol_repr_graph_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_graph_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_graph_series_scale(s : ChemmolreprgraphSeries, f : Double) -> ChemmolreprgraphSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_mol_repr_graph_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_graph_series_add(a : ChemmolreprgraphSeries, b : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_graph_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_graph_series_sub(a : ChemmolreprgraphSeries, b : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_graph_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_graph_series_normalize(s : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  let mn = chem_mol_repr_graph_series_min(s)
  let mx = chem_mol_repr_graph_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_mol_repr_graph_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_graph_series_cumsum(s : ChemmolreprgraphSeries) -> ChemmolreprgraphSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_mol_repr_graph_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_graph_series_to_string(s : ChemmolreprgraphSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_repr_graph_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprgraphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_graph_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprgraphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_graph_matrix_identity(n : Int) -> ChemmolreprgraphMatrix {
  let m = chem_mol_repr_graph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_graph_matrix_get(m : ChemmolreprgraphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_graph_matrix_transpose(m : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_graph_matrix_add(a : ChemmolreprgraphMatrix, b : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_graph_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_graph_matrix_scale(m : ChemmolreprgraphMatrix, s : Double) -> ChemmolreprgraphMatrix {
  let result = chem_mol_repr_graph_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_graph_matrix_multiply(a : ChemmolreprgraphMatrix, b : ChemmolreprgraphMatrix) -> ChemmolreprgraphMatrix {
  if a.cols != b.rows { return chem_mol_repr_graph_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_graph_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_graph_matrix_trace(m : ChemmolreprgraphMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_graph_matrix_det(m : ChemmolreprgraphMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_graph_matrix_norm(m : ChemmolreprgraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_mol_repr_graph_sqrt(sum)
}

pub fn chem_mol_repr_graph_matrix_to_string(m : ChemmolreprgraphMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_mol_repr_graph_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolreprgraphVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_graph_make_vector(comps : Array[Double]) -> ChemmolreprgraphVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_graph_vector_zero(dim : Int) -> ChemmolreprgraphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_graph_vector_add(a : ChemmolreprgraphVector, b : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_graph_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_graph_vector_sub(a : ChemmolreprgraphVector, b : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_graph_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_graph_vector_scale(v : ChemmolreprgraphVector, s : Double) -> ChemmolreprgraphVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_mol_repr_graph_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_graph_vector_dot(a : ChemmolreprgraphVector, b : ChemmolreprgraphVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_graph_vector_norm(v : ChemmolreprgraphVector) -> Double { chem_mol_repr_graph_sqrt(chem_mol_repr_graph_vector_dot(v, v)) }

pub fn chem_mol_repr_graph_vector_normalize(v : ChemmolreprgraphVector) -> ChemmolreprgraphVector {
  let n = chem_mol_repr_graph_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_graph_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_graph_vector_dist(a : ChemmolreprgraphVector, b : ChemmolreprgraphVector) -> Double {
  chem_mol_repr_graph_vector_norm(chem_mol_repr_graph_vector_sub(a, b))
}

pub fn chem_mol_repr_graph_vector_to_string(v : ChemmolreprgraphVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_repr_graph_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_graph_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_graph_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_graph_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_graph_std(data : Array[Double]) -> Double { chem_mol_repr_graph_sqrt(chem_mol_repr_graph_var(data)) }

pub fn chem_mol_repr_graph_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_graph_mean(a); let mb = chem_mol_repr_graph_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_graph_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_graph_std(a); let sb = chem_mol_repr_graph_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_graph_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_graph_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_graph_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_graph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_graph_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_graph_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_mol_repr_graph_sqrt(chem_mol_repr_graph_mse(pred, labels))
}

pub fn chem_mol_repr_graph_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_mol_repr_graph_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_graph_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_graph_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_graph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_graph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_graph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_graph_precision(pred, labels, pos); let r = chem_mol_repr_graph_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_graph_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_graph_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_graph_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_graph_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_graph_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_graph_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_graph_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_graph_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_graph_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_graph_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_graph_min(data); let mx = chem_mol_repr_graph_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_graph_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_graph_mean(data); let sd = chem_mol_repr_graph_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_graph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_graph_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_graph_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_graph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_mol_repr_graph_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_mol_repr_graph_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_mol_repr_graph_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_mol_repr_graph_int(x) } else { -chem_mol_repr_graph_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_mol_repr_graph_int(f * 1000000.0) } else { chem_mol_repr_graph_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_mol_repr_graph_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_mol_repr_graph_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemmolreprgraphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_frame_make(size : Int) -> ChemmolreprgraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_frame_len(s : ChemmolreprgraphFrame) -> Int { s.size }

pub fn chem_mol_repr_graph_frame_get(s : ChemmolreprgraphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_frame_set(s : ChemmolreprgraphFrame, i : Int, v : Double) -> ChemmolreprgraphFrame {
  let result = chem_mol_repr_graph_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_frame_sum(s : ChemmolreprgraphFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_frame_mean(s : ChemmolreprgraphFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_frame_scale(s : ChemmolreprgraphFrame, f : Double) -> ChemmolreprgraphFrame {
  let result = chem_mol_repr_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_frame_add(a : ChemmolreprgraphFrame, b : ChemmolreprgraphFrame) -> ChemmolreprgraphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_frame_copy(s : ChemmolreprgraphFrame) -> ChemmolreprgraphFrame {
  let result = chem_mol_repr_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_frame_fill(s : ChemmolreprgraphFrame, v : Double) -> ChemmolreprgraphFrame {
  let result = chem_mol_repr_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_frame_min(s : ChemmolreprgraphFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_frame_max(s : ChemmolreprgraphFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_frame_to_string(s : ChemmolreprgraphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_table_make(size : Int) -> ChemmolreprgraphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_table_len(s : ChemmolreprgraphTable) -> Int { s.size }

pub fn chem_mol_repr_graph_table_get(s : ChemmolreprgraphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_table_set(s : ChemmolreprgraphTable, i : Int, v : Double) -> ChemmolreprgraphTable {
  let result = chem_mol_repr_graph_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_table_sum(s : ChemmolreprgraphTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_table_mean(s : ChemmolreprgraphTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_table_scale(s : ChemmolreprgraphTable, f : Double) -> ChemmolreprgraphTable {
  let result = chem_mol_repr_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_table_add(a : ChemmolreprgraphTable, b : ChemmolreprgraphTable) -> ChemmolreprgraphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_table_copy(s : ChemmolreprgraphTable) -> ChemmolreprgraphTable {
  let result = chem_mol_repr_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_table_fill(s : ChemmolreprgraphTable, v : Double) -> ChemmolreprgraphTable {
  let result = chem_mol_repr_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_table_min(s : ChemmolreprgraphTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_table_max(s : ChemmolreprgraphTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_table_to_string(s : ChemmolreprgraphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_graphn_make(size : Int) -> ChemmolreprgraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_graphn_len(s : ChemmolreprgraphGraphN) -> Int { s.size }

pub fn chem_mol_repr_graph_graphn_get(s : ChemmolreprgraphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_graphn_set(s : ChemmolreprgraphGraphN, i : Int, v : Double) -> ChemmolreprgraphGraphN {
  let result = chem_mol_repr_graph_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_graphn_sum(s : ChemmolreprgraphGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_graphn_mean(s : ChemmolreprgraphGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_graphn_scale(s : ChemmolreprgraphGraphN, f : Double) -> ChemmolreprgraphGraphN {
  let result = chem_mol_repr_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_graphn_add(a : ChemmolreprgraphGraphN, b : ChemmolreprgraphGraphN) -> ChemmolreprgraphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_graphn_copy(s : ChemmolreprgraphGraphN) -> ChemmolreprgraphGraphN {
  let result = chem_mol_repr_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_graphn_fill(s : ChemmolreprgraphGraphN, v : Double) -> ChemmolreprgraphGraphN {
  let result = chem_mol_repr_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_graphn_min(s : ChemmolreprgraphGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_graphn_max(s : ChemmolreprgraphGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_graphn_to_string(s : ChemmolreprgraphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_node_make(size : Int) -> ChemmolreprgraphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_node_len(s : ChemmolreprgraphNode) -> Int { s.size }

pub fn chem_mol_repr_graph_node_get(s : ChemmolreprgraphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_node_set(s : ChemmolreprgraphNode, i : Int, v : Double) -> ChemmolreprgraphNode {
  let result = chem_mol_repr_graph_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_node_sum(s : ChemmolreprgraphNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_node_mean(s : ChemmolreprgraphNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_node_scale(s : ChemmolreprgraphNode, f : Double) -> ChemmolreprgraphNode {
  let result = chem_mol_repr_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_node_add(a : ChemmolreprgraphNode, b : ChemmolreprgraphNode) -> ChemmolreprgraphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_node_copy(s : ChemmolreprgraphNode) -> ChemmolreprgraphNode {
  let result = chem_mol_repr_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_node_fill(s : ChemmolreprgraphNode, v : Double) -> ChemmolreprgraphNode {
  let result = chem_mol_repr_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_node_min(s : ChemmolreprgraphNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_node_max(s : ChemmolreprgraphNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_node_to_string(s : ChemmolreprgraphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_edge_make(size : Int) -> ChemmolreprgraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_edge_len(s : ChemmolreprgraphEdge) -> Int { s.size }

pub fn chem_mol_repr_graph_edge_get(s : ChemmolreprgraphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_edge_set(s : ChemmolreprgraphEdge, i : Int, v : Double) -> ChemmolreprgraphEdge {
  let result = chem_mol_repr_graph_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_edge_sum(s : ChemmolreprgraphEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_edge_mean(s : ChemmolreprgraphEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_edge_scale(s : ChemmolreprgraphEdge, f : Double) -> ChemmolreprgraphEdge {
  let result = chem_mol_repr_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_edge_add(a : ChemmolreprgraphEdge, b : ChemmolreprgraphEdge) -> ChemmolreprgraphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_edge_copy(s : ChemmolreprgraphEdge) -> ChemmolreprgraphEdge {
  let result = chem_mol_repr_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_edge_fill(s : ChemmolreprgraphEdge, v : Double) -> ChemmolreprgraphEdge {
  let result = chem_mol_repr_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_edge_min(s : ChemmolreprgraphEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_edge_max(s : ChemmolreprgraphEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_edge_to_string(s : ChemmolreprgraphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_path_make(size : Int) -> ChemmolreprgraphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_path_len(s : ChemmolreprgraphPath) -> Int { s.size }

pub fn chem_mol_repr_graph_path_get(s : ChemmolreprgraphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_path_set(s : ChemmolreprgraphPath, i : Int, v : Double) -> ChemmolreprgraphPath {
  let result = chem_mol_repr_graph_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_path_sum(s : ChemmolreprgraphPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_path_mean(s : ChemmolreprgraphPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_path_scale(s : ChemmolreprgraphPath, f : Double) -> ChemmolreprgraphPath {
  let result = chem_mol_repr_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_path_add(a : ChemmolreprgraphPath, b : ChemmolreprgraphPath) -> ChemmolreprgraphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_path_copy(s : ChemmolreprgraphPath) -> ChemmolreprgraphPath {
  let result = chem_mol_repr_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_path_fill(s : ChemmolreprgraphPath, v : Double) -> ChemmolreprgraphPath {
  let result = chem_mol_repr_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_path_min(s : ChemmolreprgraphPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_path_max(s : ChemmolreprgraphPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_path_to_string(s : ChemmolreprgraphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_cluster_make(size : Int) -> ChemmolreprgraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_cluster_len(s : ChemmolreprgraphCluster) -> Int { s.size }

pub fn chem_mol_repr_graph_cluster_get(s : ChemmolreprgraphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_cluster_set(s : ChemmolreprgraphCluster, i : Int, v : Double) -> ChemmolreprgraphCluster {
  let result = chem_mol_repr_graph_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_cluster_sum(s : ChemmolreprgraphCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_cluster_mean(s : ChemmolreprgraphCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_cluster_scale(s : ChemmolreprgraphCluster, f : Double) -> ChemmolreprgraphCluster {
  let result = chem_mol_repr_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_cluster_add(a : ChemmolreprgraphCluster, b : ChemmolreprgraphCluster) -> ChemmolreprgraphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_cluster_copy(s : ChemmolreprgraphCluster) -> ChemmolreprgraphCluster {
  let result = chem_mol_repr_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_cluster_fill(s : ChemmolreprgraphCluster, v : Double) -> ChemmolreprgraphCluster {
  let result = chem_mol_repr_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_cluster_min(s : ChemmolreprgraphCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_cluster_max(s : ChemmolreprgraphCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_cluster_to_string(s : ChemmolreprgraphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_model_make(size : Int) -> ChemmolreprgraphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_model_len(s : ChemmolreprgraphModel) -> Int { s.size }

pub fn chem_mol_repr_graph_model_get(s : ChemmolreprgraphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_model_set(s : ChemmolreprgraphModel, i : Int, v : Double) -> ChemmolreprgraphModel {
  let result = chem_mol_repr_graph_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_model_sum(s : ChemmolreprgraphModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_model_mean(s : ChemmolreprgraphModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_model_scale(s : ChemmolreprgraphModel, f : Double) -> ChemmolreprgraphModel {
  let result = chem_mol_repr_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_model_add(a : ChemmolreprgraphModel, b : ChemmolreprgraphModel) -> ChemmolreprgraphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_model_copy(s : ChemmolreprgraphModel) -> ChemmolreprgraphModel {
  let result = chem_mol_repr_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_model_fill(s : ChemmolreprgraphModel, v : Double) -> ChemmolreprgraphModel {
  let result = chem_mol_repr_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_model_min(s : ChemmolreprgraphModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_model_max(s : ChemmolreprgraphModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_model_to_string(s : ChemmolreprgraphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_layer_make(size : Int) -> ChemmolreprgraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_layer_len(s : ChemmolreprgraphLayer) -> Int { s.size }

pub fn chem_mol_repr_graph_layer_get(s : ChemmolreprgraphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_layer_set(s : ChemmolreprgraphLayer, i : Int, v : Double) -> ChemmolreprgraphLayer {
  let result = chem_mol_repr_graph_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_layer_sum(s : ChemmolreprgraphLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_layer_mean(s : ChemmolreprgraphLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_layer_scale(s : ChemmolreprgraphLayer, f : Double) -> ChemmolreprgraphLayer {
  let result = chem_mol_repr_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_layer_add(a : ChemmolreprgraphLayer, b : ChemmolreprgraphLayer) -> ChemmolreprgraphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_layer_copy(s : ChemmolreprgraphLayer) -> ChemmolreprgraphLayer {
  let result = chem_mol_repr_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_layer_fill(s : ChemmolreprgraphLayer, v : Double) -> ChemmolreprgraphLayer {
  let result = chem_mol_repr_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_layer_min(s : ChemmolreprgraphLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_layer_max(s : ChemmolreprgraphLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_layer_to_string(s : ChemmolreprgraphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_buffer_make(size : Int) -> ChemmolreprgraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_buffer_len(s : ChemmolreprgraphBuffer) -> Int { s.size }

pub fn chem_mol_repr_graph_buffer_get(s : ChemmolreprgraphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_buffer_set(s : ChemmolreprgraphBuffer, i : Int, v : Double) -> ChemmolreprgraphBuffer {
  let result = chem_mol_repr_graph_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_buffer_sum(s : ChemmolreprgraphBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_buffer_mean(s : ChemmolreprgraphBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_buffer_scale(s : ChemmolreprgraphBuffer, f : Double) -> ChemmolreprgraphBuffer {
  let result = chem_mol_repr_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_buffer_add(a : ChemmolreprgraphBuffer, b : ChemmolreprgraphBuffer) -> ChemmolreprgraphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_buffer_copy(s : ChemmolreprgraphBuffer) -> ChemmolreprgraphBuffer {
  let result = chem_mol_repr_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_buffer_fill(s : ChemmolreprgraphBuffer, v : Double) -> ChemmolreprgraphBuffer {
  let result = chem_mol_repr_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_buffer_min(s : ChemmolreprgraphBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_buffer_max(s : ChemmolreprgraphBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_buffer_to_string(s : ChemmolreprgraphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_cursor_make(size : Int) -> ChemmolreprgraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_cursor_len(s : ChemmolreprgraphCursor) -> Int { s.size }

pub fn chem_mol_repr_graph_cursor_get(s : ChemmolreprgraphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_cursor_set(s : ChemmolreprgraphCursor, i : Int, v : Double) -> ChemmolreprgraphCursor {
  let result = chem_mol_repr_graph_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_cursor_sum(s : ChemmolreprgraphCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_cursor_mean(s : ChemmolreprgraphCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_cursor_scale(s : ChemmolreprgraphCursor, f : Double) -> ChemmolreprgraphCursor {
  let result = chem_mol_repr_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_cursor_add(a : ChemmolreprgraphCursor, b : ChemmolreprgraphCursor) -> ChemmolreprgraphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_cursor_copy(s : ChemmolreprgraphCursor) -> ChemmolreprgraphCursor {
  let result = chem_mol_repr_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_cursor_fill(s : ChemmolreprgraphCursor, v : Double) -> ChemmolreprgraphCursor {
  let result = chem_mol_repr_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_cursor_min(s : ChemmolreprgraphCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_cursor_max(s : ChemmolreprgraphCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_cursor_to_string(s : ChemmolreprgraphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_view_make(size : Int) -> ChemmolreprgraphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_view_len(s : ChemmolreprgraphView) -> Int { s.size }

pub fn chem_mol_repr_graph_view_get(s : ChemmolreprgraphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_view_set(s : ChemmolreprgraphView, i : Int, v : Double) -> ChemmolreprgraphView {
  let result = chem_mol_repr_graph_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_view_sum(s : ChemmolreprgraphView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_view_mean(s : ChemmolreprgraphView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_view_scale(s : ChemmolreprgraphView, f : Double) -> ChemmolreprgraphView {
  let result = chem_mol_repr_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_view_add(a : ChemmolreprgraphView, b : ChemmolreprgraphView) -> ChemmolreprgraphView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_view_copy(s : ChemmolreprgraphView) -> ChemmolreprgraphView {
  let result = chem_mol_repr_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_view_fill(s : ChemmolreprgraphView, v : Double) -> ChemmolreprgraphView {
  let result = chem_mol_repr_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_view_min(s : ChemmolreprgraphView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_view_max(s : ChemmolreprgraphView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_view_to_string(s : ChemmolreprgraphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_range_make(size : Int) -> ChemmolreprgraphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_range_len(s : ChemmolreprgraphRange) -> Int { s.size }

pub fn chem_mol_repr_graph_range_get(s : ChemmolreprgraphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_range_set(s : ChemmolreprgraphRange, i : Int, v : Double) -> ChemmolreprgraphRange {
  let result = chem_mol_repr_graph_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_range_sum(s : ChemmolreprgraphRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_range_mean(s : ChemmolreprgraphRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_range_scale(s : ChemmolreprgraphRange, f : Double) -> ChemmolreprgraphRange {
  let result = chem_mol_repr_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_range_add(a : ChemmolreprgraphRange, b : ChemmolreprgraphRange) -> ChemmolreprgraphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_range_copy(s : ChemmolreprgraphRange) -> ChemmolreprgraphRange {
  let result = chem_mol_repr_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_range_fill(s : ChemmolreprgraphRange, v : Double) -> ChemmolreprgraphRange {
  let result = chem_mol_repr_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_range_min(s : ChemmolreprgraphRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_range_max(s : ChemmolreprgraphRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_range_to_string(s : ChemmolreprgraphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprgraphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_graph_slice_make(size : Int) -> ChemmolreprgraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_graph_slice_len(s : ChemmolreprgraphSlice) -> Int { s.size }

pub fn chem_mol_repr_graph_slice_get(s : ChemmolreprgraphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_graph_slice_set(s : ChemmolreprgraphSlice, i : Int, v : Double) -> ChemmolreprgraphSlice {
  let result = chem_mol_repr_graph_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_slice_sum(s : ChemmolreprgraphSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_graph_slice_mean(s : ChemmolreprgraphSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_graph_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_graph_slice_scale(s : ChemmolreprgraphSlice, f : Double) -> ChemmolreprgraphSlice {
  let result = chem_mol_repr_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_graph_slice_add(a : ChemmolreprgraphSlice, b : ChemmolreprgraphSlice) -> ChemmolreprgraphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_graph_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_graph_slice_copy(s : ChemmolreprgraphSlice) -> ChemmolreprgraphSlice {
  let result = chem_mol_repr_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_graph_slice_fill(s : ChemmolreprgraphSlice, v : Double) -> ChemmolreprgraphSlice {
  let result = chem_mol_repr_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_graph_slice_min(s : ChemmolreprgraphSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_slice_max(s : ChemmolreprgraphSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_graph_slice_to_string(s : ChemmolreprgraphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_mol_repr_graph_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_graph_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


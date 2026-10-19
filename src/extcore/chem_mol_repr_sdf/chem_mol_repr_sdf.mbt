///===
/// extcore/chem_mol_repr_sdf

pub(all) struct ChemmolreprsdfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_sdf_make_point(x : Double, y : Double) -> ChemmolreprsdfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_sdf_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprsdfPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_sdf_point_x(pt : ChemmolreprsdfPoint) -> Double { pt.x }

pub fn chem_mol_repr_sdf_point_y(pt : ChemmolreprsdfPoint) -> Double { pt.y }

pub fn chem_mol_repr_sdf_point_z(pt : ChemmolreprsdfPoint) -> Double { pt.z }

pub fn chem_mol_repr_sdf_point_label(pt : ChemmolreprsdfPoint) -> Int { pt.label }

pub fn chem_mol_repr_sdf_point_dist(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_sdf_point_add(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_sdf_point_sub(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_sdf_point_scale(pt : ChemmolreprsdfPoint, s : Double) -> ChemmolreprsdfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_sdf_point_dot(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_sdf_point_cross(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_sdf_point_norm(pt : ChemmolreprsdfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_sdf_point_normalize(pt : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  let n = chem_mol_repr_sdf_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_sdf_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_sdf_point_negate(pt : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_sdf_point_mid(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint) -> ChemmolreprsdfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_sdf_point_lerp(a : ChemmolreprsdfPoint, b : ChemmolreprsdfPoint, t : Double) -> ChemmolreprsdfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_sdf_point_to_string(pt : ChemmolreprsdfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_sdf_make_series(vals : Array[Double], name : String) -> ChemmolreprsdfSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_sdf_series_len(s : ChemmolreprsdfSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_sdf_series_sum(s : ChemmolreprsdfSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_sdf_series_mean(s : ChemmolreprsdfSeries) -> Double {
  let n = chem_mol_repr_sdf_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_sdf_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_sdf_series_min(s : ChemmolreprsdfSeries) -> Double {
  let n = chem_mol_repr_sdf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_series_max(s : ChemmolreprsdfSeries) -> Double {
  let n = chem_mol_repr_sdf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_series_range(s : ChemmolreprsdfSeries) -> Double {
  chem_mol_repr_sdf_series_max(s) - chem_mol_repr_sdf_series_min(s)
}

pub fn chem_mol_repr_sdf_series_var(s : ChemmolreprsdfSeries) -> Double {
  let n = chem_mol_repr_sdf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_sdf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_series_std(s : ChemmolreprsdfSeries) -> Double { @_common.sqrt(chem_mol_repr_sdf_series_var(s)) }

pub fn chem_mol_repr_sdf_series_median(s : ChemmolreprsdfSeries) -> Double {
  let n = chem_mol_repr_sdf_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_sdf_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_sdf_series_scale(s : ChemmolreprsdfSeries, f : Double) -> ChemmolreprsdfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_sdf_series_add(a : ChemmolreprsdfSeries, b : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_sdf_series_sub(a : ChemmolreprsdfSeries, b : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_sdf_series_normalize(s : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let mn = chem_mol_repr_sdf_series_min(s)
  let mx = chem_mol_repr_sdf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_sdf_series_cumsum(s : ChemmolreprsdfSeries) -> ChemmolreprsdfSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_sdf_series_to_string(s : ChemmolreprsdfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprsdfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_sdf_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprsdfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_sdf_matrix_identity(n : Int) -> ChemmolreprsdfMatrix {
  let m = chem_mol_repr_sdf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_sdf_matrix_get(m : ChemmolreprsdfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_sdf_matrix_transpose(m : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_sdf_matrix_add(a : ChemmolreprsdfMatrix, b : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_sdf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_sdf_matrix_scale(m : ChemmolreprsdfMatrix, s : Double) -> ChemmolreprsdfMatrix {
  let result = chem_mol_repr_sdf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_sdf_matrix_multiply(a : ChemmolreprsdfMatrix, b : ChemmolreprsdfMatrix) -> ChemmolreprsdfMatrix {
  if a.cols != b.rows { return chem_mol_repr_sdf_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_sdf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_sdf_matrix_trace(m : ChemmolreprsdfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_sdf_matrix_det(m : ChemmolreprsdfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_sdf_matrix_norm(m : ChemmolreprsdfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_sdf_matrix_to_string(m : ChemmolreprsdfMatrix) -> String {
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

pub(all) struct ChemmolreprsdfVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_sdf_make_vector(comps : Array[Double]) -> ChemmolreprsdfVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_sdf_vector_zero(dim : Int) -> ChemmolreprsdfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_sdf_vector_add(a : ChemmolreprsdfVector, b : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_sdf_vector_sub(a : ChemmolreprsdfVector, b : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_sdf_vector_scale(v : ChemmolreprsdfVector, s : Double) -> ChemmolreprsdfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_sdf_vector_dot(a : ChemmolreprsdfVector, b : ChemmolreprsdfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_sdf_vector_norm(v : ChemmolreprsdfVector) -> Double { @_common.sqrt(chem_mol_repr_sdf_vector_dot(v, v)) }

pub fn chem_mol_repr_sdf_vector_normalize(v : ChemmolreprsdfVector) -> ChemmolreprsdfVector {
  let n = chem_mol_repr_sdf_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_sdf_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_sdf_vector_dist(a : ChemmolreprsdfVector, b : ChemmolreprsdfVector) -> Double {
  chem_mol_repr_sdf_vector_norm(chem_mol_repr_sdf_vector_sub(a, b))
}

pub fn chem_mol_repr_sdf_vector_to_string(v : ChemmolreprsdfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_sdf_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_sdf_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_repr_sdf_var(data)) }

pub fn chem_mol_repr_sdf_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_sdf_mean(a); let mb = chem_mol_repr_sdf_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_sdf_std(a); let sb = chem_mol_repr_sdf_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_sdf_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_sdf_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_sdf_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_sdf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_repr_sdf_mse(pred, labels))
}

pub fn chem_mol_repr_sdf_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_sdf_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_sdf_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_sdf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_sdf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_sdf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_sdf_precision(pred, labels, pos); let r = chem_mol_repr_sdf_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_sdf_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_sdf_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_sdf_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_sdf_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_sdf_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_sdf_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_sdf_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_sdf_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_sdf_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_sdf_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_sdf_min(data); let mx = chem_mol_repr_sdf_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_sdf_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_sdf_mean(data); let sd = chem_mol_repr_sdf_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_sdf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_sdf_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_sdf_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_sdf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolreprsdfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_frame_make(size : Int) -> ChemmolreprsdfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_frame_len(s : ChemmolreprsdfFrame) -> Int { s.size }

pub fn chem_mol_repr_sdf_frame_get(s : ChemmolreprsdfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_frame_set(s : ChemmolreprsdfFrame, i : Int, v : Double) -> ChemmolreprsdfFrame {
  let result = chem_mol_repr_sdf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_frame_sum(s : ChemmolreprsdfFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_frame_mean(s : ChemmolreprsdfFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_frame_scale(s : ChemmolreprsdfFrame, f : Double) -> ChemmolreprsdfFrame {
  let result = chem_mol_repr_sdf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_frame_add(a : ChemmolreprsdfFrame, b : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_frame_copy(s : ChemmolreprsdfFrame) -> ChemmolreprsdfFrame {
  let result = chem_mol_repr_sdf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_frame_fill(s : ChemmolreprsdfFrame, v : Double) -> ChemmolreprsdfFrame {
  let result = chem_mol_repr_sdf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_frame_min(s : ChemmolreprsdfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_frame_max(s : ChemmolreprsdfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_frame_to_string(s : ChemmolreprsdfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_table_make(size : Int) -> ChemmolreprsdfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_table_len(s : ChemmolreprsdfTable) -> Int { s.size }

pub fn chem_mol_repr_sdf_table_get(s : ChemmolreprsdfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_table_set(s : ChemmolreprsdfTable, i : Int, v : Double) -> ChemmolreprsdfTable {
  let result = chem_mol_repr_sdf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_table_sum(s : ChemmolreprsdfTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_table_mean(s : ChemmolreprsdfTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_table_scale(s : ChemmolreprsdfTable, f : Double) -> ChemmolreprsdfTable {
  let result = chem_mol_repr_sdf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_table_add(a : ChemmolreprsdfTable, b : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_table_copy(s : ChemmolreprsdfTable) -> ChemmolreprsdfTable {
  let result = chem_mol_repr_sdf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_table_fill(s : ChemmolreprsdfTable, v : Double) -> ChemmolreprsdfTable {
  let result = chem_mol_repr_sdf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_table_min(s : ChemmolreprsdfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_table_max(s : ChemmolreprsdfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_table_to_string(s : ChemmolreprsdfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_graphn_make(size : Int) -> ChemmolreprsdfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_graphn_len(s : ChemmolreprsdfGraphN) -> Int { s.size }

pub fn chem_mol_repr_sdf_graphn_get(s : ChemmolreprsdfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_graphn_set(s : ChemmolreprsdfGraphN, i : Int, v : Double) -> ChemmolreprsdfGraphN {
  let result = chem_mol_repr_sdf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_graphn_sum(s : ChemmolreprsdfGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_graphn_mean(s : ChemmolreprsdfGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_graphn_scale(s : ChemmolreprsdfGraphN, f : Double) -> ChemmolreprsdfGraphN {
  let result = chem_mol_repr_sdf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_graphn_add(a : ChemmolreprsdfGraphN, b : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_graphn_copy(s : ChemmolreprsdfGraphN) -> ChemmolreprsdfGraphN {
  let result = chem_mol_repr_sdf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_graphn_fill(s : ChemmolreprsdfGraphN, v : Double) -> ChemmolreprsdfGraphN {
  let result = chem_mol_repr_sdf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_graphn_min(s : ChemmolreprsdfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_graphn_max(s : ChemmolreprsdfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_graphn_to_string(s : ChemmolreprsdfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_node_make(size : Int) -> ChemmolreprsdfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_node_len(s : ChemmolreprsdfNode) -> Int { s.size }

pub fn chem_mol_repr_sdf_node_get(s : ChemmolreprsdfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_node_set(s : ChemmolreprsdfNode, i : Int, v : Double) -> ChemmolreprsdfNode {
  let result = chem_mol_repr_sdf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_node_sum(s : ChemmolreprsdfNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_node_mean(s : ChemmolreprsdfNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_node_scale(s : ChemmolreprsdfNode, f : Double) -> ChemmolreprsdfNode {
  let result = chem_mol_repr_sdf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_node_add(a : ChemmolreprsdfNode, b : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_node_copy(s : ChemmolreprsdfNode) -> ChemmolreprsdfNode {
  let result = chem_mol_repr_sdf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_node_fill(s : ChemmolreprsdfNode, v : Double) -> ChemmolreprsdfNode {
  let result = chem_mol_repr_sdf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_node_min(s : ChemmolreprsdfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_node_max(s : ChemmolreprsdfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_node_to_string(s : ChemmolreprsdfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_edge_make(size : Int) -> ChemmolreprsdfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_edge_len(s : ChemmolreprsdfEdge) -> Int { s.size }

pub fn chem_mol_repr_sdf_edge_get(s : ChemmolreprsdfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_edge_set(s : ChemmolreprsdfEdge, i : Int, v : Double) -> ChemmolreprsdfEdge {
  let result = chem_mol_repr_sdf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_edge_sum(s : ChemmolreprsdfEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_edge_mean(s : ChemmolreprsdfEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_edge_scale(s : ChemmolreprsdfEdge, f : Double) -> ChemmolreprsdfEdge {
  let result = chem_mol_repr_sdf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_edge_add(a : ChemmolreprsdfEdge, b : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_edge_copy(s : ChemmolreprsdfEdge) -> ChemmolreprsdfEdge {
  let result = chem_mol_repr_sdf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_edge_fill(s : ChemmolreprsdfEdge, v : Double) -> ChemmolreprsdfEdge {
  let result = chem_mol_repr_sdf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_edge_min(s : ChemmolreprsdfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_edge_max(s : ChemmolreprsdfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_edge_to_string(s : ChemmolreprsdfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_path_make(size : Int) -> ChemmolreprsdfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_path_len(s : ChemmolreprsdfPath) -> Int { s.size }

pub fn chem_mol_repr_sdf_path_get(s : ChemmolreprsdfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_path_set(s : ChemmolreprsdfPath, i : Int, v : Double) -> ChemmolreprsdfPath {
  let result = chem_mol_repr_sdf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_path_sum(s : ChemmolreprsdfPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_path_mean(s : ChemmolreprsdfPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_path_scale(s : ChemmolreprsdfPath, f : Double) -> ChemmolreprsdfPath {
  let result = chem_mol_repr_sdf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_path_add(a : ChemmolreprsdfPath, b : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_path_copy(s : ChemmolreprsdfPath) -> ChemmolreprsdfPath {
  let result = chem_mol_repr_sdf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_path_fill(s : ChemmolreprsdfPath, v : Double) -> ChemmolreprsdfPath {
  let result = chem_mol_repr_sdf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_path_min(s : ChemmolreprsdfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_path_max(s : ChemmolreprsdfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_path_to_string(s : ChemmolreprsdfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cluster_make(size : Int) -> ChemmolreprsdfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_cluster_len(s : ChemmolreprsdfCluster) -> Int { s.size }

pub fn chem_mol_repr_sdf_cluster_get(s : ChemmolreprsdfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_cluster_set(s : ChemmolreprsdfCluster, i : Int, v : Double) -> ChemmolreprsdfCluster {
  let result = chem_mol_repr_sdf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_cluster_sum(s : ChemmolreprsdfCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_cluster_mean(s : ChemmolreprsdfCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_cluster_scale(s : ChemmolreprsdfCluster, f : Double) -> ChemmolreprsdfCluster {
  let result = chem_mol_repr_sdf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_cluster_add(a : ChemmolreprsdfCluster, b : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_cluster_copy(s : ChemmolreprsdfCluster) -> ChemmolreprsdfCluster {
  let result = chem_mol_repr_sdf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_cluster_fill(s : ChemmolreprsdfCluster, v : Double) -> ChemmolreprsdfCluster {
  let result = chem_mol_repr_sdf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_cluster_min(s : ChemmolreprsdfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_cluster_max(s : ChemmolreprsdfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_cluster_to_string(s : ChemmolreprsdfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_model_make(size : Int) -> ChemmolreprsdfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_model_len(s : ChemmolreprsdfModel) -> Int { s.size }

pub fn chem_mol_repr_sdf_model_get(s : ChemmolreprsdfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_model_set(s : ChemmolreprsdfModel, i : Int, v : Double) -> ChemmolreprsdfModel {
  let result = chem_mol_repr_sdf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_model_sum(s : ChemmolreprsdfModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_model_mean(s : ChemmolreprsdfModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_model_scale(s : ChemmolreprsdfModel, f : Double) -> ChemmolreprsdfModel {
  let result = chem_mol_repr_sdf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_model_add(a : ChemmolreprsdfModel, b : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_model_copy(s : ChemmolreprsdfModel) -> ChemmolreprsdfModel {
  let result = chem_mol_repr_sdf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_model_fill(s : ChemmolreprsdfModel, v : Double) -> ChemmolreprsdfModel {
  let result = chem_mol_repr_sdf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_model_min(s : ChemmolreprsdfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_model_max(s : ChemmolreprsdfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_model_to_string(s : ChemmolreprsdfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_layer_make(size : Int) -> ChemmolreprsdfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_layer_len(s : ChemmolreprsdfLayer) -> Int { s.size }

pub fn chem_mol_repr_sdf_layer_get(s : ChemmolreprsdfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_layer_set(s : ChemmolreprsdfLayer, i : Int, v : Double) -> ChemmolreprsdfLayer {
  let result = chem_mol_repr_sdf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_layer_sum(s : ChemmolreprsdfLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_layer_mean(s : ChemmolreprsdfLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_layer_scale(s : ChemmolreprsdfLayer, f : Double) -> ChemmolreprsdfLayer {
  let result = chem_mol_repr_sdf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_layer_add(a : ChemmolreprsdfLayer, b : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_layer_copy(s : ChemmolreprsdfLayer) -> ChemmolreprsdfLayer {
  let result = chem_mol_repr_sdf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_layer_fill(s : ChemmolreprsdfLayer, v : Double) -> ChemmolreprsdfLayer {
  let result = chem_mol_repr_sdf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_layer_min(s : ChemmolreprsdfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_layer_max(s : ChemmolreprsdfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_layer_to_string(s : ChemmolreprsdfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_buffer_make(size : Int) -> ChemmolreprsdfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_buffer_len(s : ChemmolreprsdfBuffer) -> Int { s.size }

pub fn chem_mol_repr_sdf_buffer_get(s : ChemmolreprsdfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_buffer_set(s : ChemmolreprsdfBuffer, i : Int, v : Double) -> ChemmolreprsdfBuffer {
  let result = chem_mol_repr_sdf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_buffer_sum(s : ChemmolreprsdfBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_buffer_mean(s : ChemmolreprsdfBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_buffer_scale(s : ChemmolreprsdfBuffer, f : Double) -> ChemmolreprsdfBuffer {
  let result = chem_mol_repr_sdf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_buffer_add(a : ChemmolreprsdfBuffer, b : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_buffer_copy(s : ChemmolreprsdfBuffer) -> ChemmolreprsdfBuffer {
  let result = chem_mol_repr_sdf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_buffer_fill(s : ChemmolreprsdfBuffer, v : Double) -> ChemmolreprsdfBuffer {
  let result = chem_mol_repr_sdf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_buffer_min(s : ChemmolreprsdfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_buffer_max(s : ChemmolreprsdfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_buffer_to_string(s : ChemmolreprsdfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_cursor_make(size : Int) -> ChemmolreprsdfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_cursor_len(s : ChemmolreprsdfCursor) -> Int { s.size }

pub fn chem_mol_repr_sdf_cursor_get(s : ChemmolreprsdfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_cursor_set(s : ChemmolreprsdfCursor, i : Int, v : Double) -> ChemmolreprsdfCursor {
  let result = chem_mol_repr_sdf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_cursor_sum(s : ChemmolreprsdfCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_cursor_mean(s : ChemmolreprsdfCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_cursor_scale(s : ChemmolreprsdfCursor, f : Double) -> ChemmolreprsdfCursor {
  let result = chem_mol_repr_sdf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_cursor_add(a : ChemmolreprsdfCursor, b : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_cursor_copy(s : ChemmolreprsdfCursor) -> ChemmolreprsdfCursor {
  let result = chem_mol_repr_sdf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_cursor_fill(s : ChemmolreprsdfCursor, v : Double) -> ChemmolreprsdfCursor {
  let result = chem_mol_repr_sdf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_cursor_min(s : ChemmolreprsdfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_cursor_max(s : ChemmolreprsdfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_cursor_to_string(s : ChemmolreprsdfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_view_make(size : Int) -> ChemmolreprsdfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_view_len(s : ChemmolreprsdfView) -> Int { s.size }

pub fn chem_mol_repr_sdf_view_get(s : ChemmolreprsdfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_view_set(s : ChemmolreprsdfView, i : Int, v : Double) -> ChemmolreprsdfView {
  let result = chem_mol_repr_sdf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_view_sum(s : ChemmolreprsdfView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_view_mean(s : ChemmolreprsdfView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_view_scale(s : ChemmolreprsdfView, f : Double) -> ChemmolreprsdfView {
  let result = chem_mol_repr_sdf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_view_add(a : ChemmolreprsdfView, b : ChemmolreprsdfView) -> ChemmolreprsdfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_view_copy(s : ChemmolreprsdfView) -> ChemmolreprsdfView {
  let result = chem_mol_repr_sdf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_view_fill(s : ChemmolreprsdfView, v : Double) -> ChemmolreprsdfView {
  let result = chem_mol_repr_sdf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_view_min(s : ChemmolreprsdfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_view_max(s : ChemmolreprsdfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_view_to_string(s : ChemmolreprsdfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_range_make(size : Int) -> ChemmolreprsdfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_range_len(s : ChemmolreprsdfRange) -> Int { s.size }

pub fn chem_mol_repr_sdf_range_get(s : ChemmolreprsdfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_range_set(s : ChemmolreprsdfRange, i : Int, v : Double) -> ChemmolreprsdfRange {
  let result = chem_mol_repr_sdf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_range_sum(s : ChemmolreprsdfRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_range_mean(s : ChemmolreprsdfRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_range_scale(s : ChemmolreprsdfRange, f : Double) -> ChemmolreprsdfRange {
  let result = chem_mol_repr_sdf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_range_add(a : ChemmolreprsdfRange, b : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_range_copy(s : ChemmolreprsdfRange) -> ChemmolreprsdfRange {
  let result = chem_mol_repr_sdf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_range_fill(s : ChemmolreprsdfRange, v : Double) -> ChemmolreprsdfRange {
  let result = chem_mol_repr_sdf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_range_min(s : ChemmolreprsdfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_range_max(s : ChemmolreprsdfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_range_to_string(s : ChemmolreprsdfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprsdfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_sdf_slice_make(size : Int) -> ChemmolreprsdfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_sdf_slice_len(s : ChemmolreprsdfSlice) -> Int { s.size }

pub fn chem_mol_repr_sdf_slice_get(s : ChemmolreprsdfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_sdf_slice_set(s : ChemmolreprsdfSlice, i : Int, v : Double) -> ChemmolreprsdfSlice {
  let result = chem_mol_repr_sdf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_slice_sum(s : ChemmolreprsdfSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_sdf_slice_mean(s : ChemmolreprsdfSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_sdf_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_sdf_slice_scale(s : ChemmolreprsdfSlice, f : Double) -> ChemmolreprsdfSlice {
  let result = chem_mol_repr_sdf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_sdf_slice_add(a : ChemmolreprsdfSlice, b : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_sdf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_sdf_slice_copy(s : ChemmolreprsdfSlice) -> ChemmolreprsdfSlice {
  let result = chem_mol_repr_sdf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_sdf_slice_fill(s : ChemmolreprsdfSlice, v : Double) -> ChemmolreprsdfSlice {
  let result = chem_mol_repr_sdf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_sdf_slice_min(s : ChemmolreprsdfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_slice_max(s : ChemmolreprsdfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_sdf_slice_to_string(s : ChemmolreprsdfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


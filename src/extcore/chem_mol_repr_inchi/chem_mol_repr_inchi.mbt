///===
/// extcore/chem_mol_repr_inchi

pub(all) struct ChemmolreprinchiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_inchi_make_point(x : Double, y : Double) -> ChemmolreprinchiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_inchi_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprinchiPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_inchi_point_x(pt : ChemmolreprinchiPoint) -> Double { pt.x }

pub fn chem_mol_repr_inchi_point_y(pt : ChemmolreprinchiPoint) -> Double { pt.y }

pub fn chem_mol_repr_inchi_point_z(pt : ChemmolreprinchiPoint) -> Double { pt.z }

pub fn chem_mol_repr_inchi_point_label(pt : ChemmolreprinchiPoint) -> Int { pt.label }

pub fn chem_mol_repr_inchi_point_dist(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_inchi_point_add(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_inchi_point_sub(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_inchi_point_scale(pt : ChemmolreprinchiPoint, s : Double) -> ChemmolreprinchiPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_inchi_point_dot(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_inchi_point_cross(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_inchi_point_norm(pt : ChemmolreprinchiPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_inchi_point_normalize(pt : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  let n = chem_mol_repr_inchi_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_inchi_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_inchi_point_negate(pt : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_inchi_point_mid(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint) -> ChemmolreprinchiPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_inchi_point_lerp(a : ChemmolreprinchiPoint, b : ChemmolreprinchiPoint, t : Double) -> ChemmolreprinchiPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_inchi_point_to_string(pt : ChemmolreprinchiPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprinchiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_inchi_make_series(vals : Array[Double], name : String) -> ChemmolreprinchiSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_inchi_series_len(s : ChemmolreprinchiSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_inchi_series_sum(s : ChemmolreprinchiSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_inchi_series_mean(s : ChemmolreprinchiSeries) -> Double {
  let n = chem_mol_repr_inchi_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_inchi_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_inchi_series_min(s : ChemmolreprinchiSeries) -> Double {
  let n = chem_mol_repr_inchi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_series_max(s : ChemmolreprinchiSeries) -> Double {
  let n = chem_mol_repr_inchi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_series_range(s : ChemmolreprinchiSeries) -> Double {
  chem_mol_repr_inchi_series_max(s) - chem_mol_repr_inchi_series_min(s)
}

pub fn chem_mol_repr_inchi_series_var(s : ChemmolreprinchiSeries) -> Double {
  let n = chem_mol_repr_inchi_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_inchi_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_series_std(s : ChemmolreprinchiSeries) -> Double { @_common.sqrt(chem_mol_repr_inchi_series_var(s)) }

pub fn chem_mol_repr_inchi_series_median(s : ChemmolreprinchiSeries) -> Double {
  let n = chem_mol_repr_inchi_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_inchi_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_inchi_series_scale(s : ChemmolreprinchiSeries, f : Double) -> ChemmolreprinchiSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_inchi_series_add(a : ChemmolreprinchiSeries, b : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_inchi_series_sub(a : ChemmolreprinchiSeries, b : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_inchi_series_normalize(s : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  let mn = chem_mol_repr_inchi_series_min(s)
  let mx = chem_mol_repr_inchi_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_inchi_series_cumsum(s : ChemmolreprinchiSeries) -> ChemmolreprinchiSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_inchi_series_to_string(s : ChemmolreprinchiSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprinchiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_inchi_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprinchiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_inchi_matrix_identity(n : Int) -> ChemmolreprinchiMatrix {
  let m = chem_mol_repr_inchi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_inchi_matrix_get(m : ChemmolreprinchiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_inchi_matrix_transpose(m : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_inchi_matrix_add(a : ChemmolreprinchiMatrix, b : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_inchi_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_inchi_matrix_scale(m : ChemmolreprinchiMatrix, s : Double) -> ChemmolreprinchiMatrix {
  let result = chem_mol_repr_inchi_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_inchi_matrix_multiply(a : ChemmolreprinchiMatrix, b : ChemmolreprinchiMatrix) -> ChemmolreprinchiMatrix {
  if a.cols != b.rows { return chem_mol_repr_inchi_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_inchi_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_inchi_matrix_trace(m : ChemmolreprinchiMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_inchi_matrix_det(m : ChemmolreprinchiMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_inchi_matrix_norm(m : ChemmolreprinchiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_inchi_matrix_to_string(m : ChemmolreprinchiMatrix) -> String {
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

pub(all) struct ChemmolreprinchiVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_inchi_make_vector(comps : Array[Double]) -> ChemmolreprinchiVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_inchi_vector_zero(dim : Int) -> ChemmolreprinchiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_inchi_vector_add(a : ChemmolreprinchiVector, b : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_inchi_vector_sub(a : ChemmolreprinchiVector, b : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_inchi_vector_scale(v : ChemmolreprinchiVector, s : Double) -> ChemmolreprinchiVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_inchi_vector_dot(a : ChemmolreprinchiVector, b : ChemmolreprinchiVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_inchi_vector_norm(v : ChemmolreprinchiVector) -> Double { @_common.sqrt(chem_mol_repr_inchi_vector_dot(v, v)) }

pub fn chem_mol_repr_inchi_vector_normalize(v : ChemmolreprinchiVector) -> ChemmolreprinchiVector {
  let n = chem_mol_repr_inchi_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_inchi_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_inchi_vector_dist(a : ChemmolreprinchiVector, b : ChemmolreprinchiVector) -> Double {
  chem_mol_repr_inchi_vector_norm(chem_mol_repr_inchi_vector_sub(a, b))
}

pub fn chem_mol_repr_inchi_vector_to_string(v : ChemmolreprinchiVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_inchi_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_inchi_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_repr_inchi_var(data)) }

pub fn chem_mol_repr_inchi_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_inchi_mean(a); let mb = chem_mol_repr_inchi_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_inchi_std(a); let sb = chem_mol_repr_inchi_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_inchi_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_inchi_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_inchi_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_inchi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_repr_inchi_mse(pred, labels))
}

pub fn chem_mol_repr_inchi_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_inchi_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_inchi_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_inchi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_inchi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_inchi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_inchi_precision(pred, labels, pos); let r = chem_mol_repr_inchi_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_inchi_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_inchi_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_inchi_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_inchi_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_inchi_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_inchi_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_inchi_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_inchi_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_inchi_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_inchi_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_inchi_min(data); let mx = chem_mol_repr_inchi_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_inchi_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_inchi_mean(data); let sd = chem_mol_repr_inchi_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_inchi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_inchi_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_inchi_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_inchi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolreprinchiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_frame_make(size : Int) -> ChemmolreprinchiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_frame_len(s : ChemmolreprinchiFrame) -> Int { s.size }

pub fn chem_mol_repr_inchi_frame_get(s : ChemmolreprinchiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_frame_set(s : ChemmolreprinchiFrame, i : Int, v : Double) -> ChemmolreprinchiFrame {
  let result = chem_mol_repr_inchi_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_frame_sum(s : ChemmolreprinchiFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_frame_mean(s : ChemmolreprinchiFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_frame_scale(s : ChemmolreprinchiFrame, f : Double) -> ChemmolreprinchiFrame {
  let result = chem_mol_repr_inchi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_frame_add(a : ChemmolreprinchiFrame, b : ChemmolreprinchiFrame) -> ChemmolreprinchiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_frame_copy(s : ChemmolreprinchiFrame) -> ChemmolreprinchiFrame {
  let result = chem_mol_repr_inchi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_frame_fill(s : ChemmolreprinchiFrame, v : Double) -> ChemmolreprinchiFrame {
  let result = chem_mol_repr_inchi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_frame_min(s : ChemmolreprinchiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_frame_max(s : ChemmolreprinchiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_frame_to_string(s : ChemmolreprinchiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_table_make(size : Int) -> ChemmolreprinchiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_table_len(s : ChemmolreprinchiTable) -> Int { s.size }

pub fn chem_mol_repr_inchi_table_get(s : ChemmolreprinchiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_table_set(s : ChemmolreprinchiTable, i : Int, v : Double) -> ChemmolreprinchiTable {
  let result = chem_mol_repr_inchi_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_table_sum(s : ChemmolreprinchiTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_table_mean(s : ChemmolreprinchiTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_table_scale(s : ChemmolreprinchiTable, f : Double) -> ChemmolreprinchiTable {
  let result = chem_mol_repr_inchi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_table_add(a : ChemmolreprinchiTable, b : ChemmolreprinchiTable) -> ChemmolreprinchiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_table_copy(s : ChemmolreprinchiTable) -> ChemmolreprinchiTable {
  let result = chem_mol_repr_inchi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_table_fill(s : ChemmolreprinchiTable, v : Double) -> ChemmolreprinchiTable {
  let result = chem_mol_repr_inchi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_table_min(s : ChemmolreprinchiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_table_max(s : ChemmolreprinchiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_table_to_string(s : ChemmolreprinchiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_graphn_make(size : Int) -> ChemmolreprinchiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_graphn_len(s : ChemmolreprinchiGraphN) -> Int { s.size }

pub fn chem_mol_repr_inchi_graphn_get(s : ChemmolreprinchiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_graphn_set(s : ChemmolreprinchiGraphN, i : Int, v : Double) -> ChemmolreprinchiGraphN {
  let result = chem_mol_repr_inchi_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_graphn_sum(s : ChemmolreprinchiGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_graphn_mean(s : ChemmolreprinchiGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_graphn_scale(s : ChemmolreprinchiGraphN, f : Double) -> ChemmolreprinchiGraphN {
  let result = chem_mol_repr_inchi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_graphn_add(a : ChemmolreprinchiGraphN, b : ChemmolreprinchiGraphN) -> ChemmolreprinchiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_graphn_copy(s : ChemmolreprinchiGraphN) -> ChemmolreprinchiGraphN {
  let result = chem_mol_repr_inchi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_graphn_fill(s : ChemmolreprinchiGraphN, v : Double) -> ChemmolreprinchiGraphN {
  let result = chem_mol_repr_inchi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_graphn_min(s : ChemmolreprinchiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_graphn_max(s : ChemmolreprinchiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_graphn_to_string(s : ChemmolreprinchiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_node_make(size : Int) -> ChemmolreprinchiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_node_len(s : ChemmolreprinchiNode) -> Int { s.size }

pub fn chem_mol_repr_inchi_node_get(s : ChemmolreprinchiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_node_set(s : ChemmolreprinchiNode, i : Int, v : Double) -> ChemmolreprinchiNode {
  let result = chem_mol_repr_inchi_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_node_sum(s : ChemmolreprinchiNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_node_mean(s : ChemmolreprinchiNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_node_scale(s : ChemmolreprinchiNode, f : Double) -> ChemmolreprinchiNode {
  let result = chem_mol_repr_inchi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_node_add(a : ChemmolreprinchiNode, b : ChemmolreprinchiNode) -> ChemmolreprinchiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_node_copy(s : ChemmolreprinchiNode) -> ChemmolreprinchiNode {
  let result = chem_mol_repr_inchi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_node_fill(s : ChemmolreprinchiNode, v : Double) -> ChemmolreprinchiNode {
  let result = chem_mol_repr_inchi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_node_min(s : ChemmolreprinchiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_node_max(s : ChemmolreprinchiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_node_to_string(s : ChemmolreprinchiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_edge_make(size : Int) -> ChemmolreprinchiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_edge_len(s : ChemmolreprinchiEdge) -> Int { s.size }

pub fn chem_mol_repr_inchi_edge_get(s : ChemmolreprinchiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_edge_set(s : ChemmolreprinchiEdge, i : Int, v : Double) -> ChemmolreprinchiEdge {
  let result = chem_mol_repr_inchi_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_edge_sum(s : ChemmolreprinchiEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_edge_mean(s : ChemmolreprinchiEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_edge_scale(s : ChemmolreprinchiEdge, f : Double) -> ChemmolreprinchiEdge {
  let result = chem_mol_repr_inchi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_edge_add(a : ChemmolreprinchiEdge, b : ChemmolreprinchiEdge) -> ChemmolreprinchiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_edge_copy(s : ChemmolreprinchiEdge) -> ChemmolreprinchiEdge {
  let result = chem_mol_repr_inchi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_edge_fill(s : ChemmolreprinchiEdge, v : Double) -> ChemmolreprinchiEdge {
  let result = chem_mol_repr_inchi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_edge_min(s : ChemmolreprinchiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_edge_max(s : ChemmolreprinchiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_edge_to_string(s : ChemmolreprinchiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_path_make(size : Int) -> ChemmolreprinchiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_path_len(s : ChemmolreprinchiPath) -> Int { s.size }

pub fn chem_mol_repr_inchi_path_get(s : ChemmolreprinchiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_path_set(s : ChemmolreprinchiPath, i : Int, v : Double) -> ChemmolreprinchiPath {
  let result = chem_mol_repr_inchi_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_path_sum(s : ChemmolreprinchiPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_path_mean(s : ChemmolreprinchiPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_path_scale(s : ChemmolreprinchiPath, f : Double) -> ChemmolreprinchiPath {
  let result = chem_mol_repr_inchi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_path_add(a : ChemmolreprinchiPath, b : ChemmolreprinchiPath) -> ChemmolreprinchiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_path_copy(s : ChemmolreprinchiPath) -> ChemmolreprinchiPath {
  let result = chem_mol_repr_inchi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_path_fill(s : ChemmolreprinchiPath, v : Double) -> ChemmolreprinchiPath {
  let result = chem_mol_repr_inchi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_path_min(s : ChemmolreprinchiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_path_max(s : ChemmolreprinchiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_path_to_string(s : ChemmolreprinchiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_cluster_make(size : Int) -> ChemmolreprinchiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_cluster_len(s : ChemmolreprinchiCluster) -> Int { s.size }

pub fn chem_mol_repr_inchi_cluster_get(s : ChemmolreprinchiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_cluster_set(s : ChemmolreprinchiCluster, i : Int, v : Double) -> ChemmolreprinchiCluster {
  let result = chem_mol_repr_inchi_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_cluster_sum(s : ChemmolreprinchiCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_cluster_mean(s : ChemmolreprinchiCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_cluster_scale(s : ChemmolreprinchiCluster, f : Double) -> ChemmolreprinchiCluster {
  let result = chem_mol_repr_inchi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_cluster_add(a : ChemmolreprinchiCluster, b : ChemmolreprinchiCluster) -> ChemmolreprinchiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_cluster_copy(s : ChemmolreprinchiCluster) -> ChemmolreprinchiCluster {
  let result = chem_mol_repr_inchi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_cluster_fill(s : ChemmolreprinchiCluster, v : Double) -> ChemmolreprinchiCluster {
  let result = chem_mol_repr_inchi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_cluster_min(s : ChemmolreprinchiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_cluster_max(s : ChemmolreprinchiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_cluster_to_string(s : ChemmolreprinchiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_model_make(size : Int) -> ChemmolreprinchiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_model_len(s : ChemmolreprinchiModel) -> Int { s.size }

pub fn chem_mol_repr_inchi_model_get(s : ChemmolreprinchiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_model_set(s : ChemmolreprinchiModel, i : Int, v : Double) -> ChemmolreprinchiModel {
  let result = chem_mol_repr_inchi_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_model_sum(s : ChemmolreprinchiModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_model_mean(s : ChemmolreprinchiModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_model_scale(s : ChemmolreprinchiModel, f : Double) -> ChemmolreprinchiModel {
  let result = chem_mol_repr_inchi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_model_add(a : ChemmolreprinchiModel, b : ChemmolreprinchiModel) -> ChemmolreprinchiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_model_copy(s : ChemmolreprinchiModel) -> ChemmolreprinchiModel {
  let result = chem_mol_repr_inchi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_model_fill(s : ChemmolreprinchiModel, v : Double) -> ChemmolreprinchiModel {
  let result = chem_mol_repr_inchi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_model_min(s : ChemmolreprinchiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_model_max(s : ChemmolreprinchiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_model_to_string(s : ChemmolreprinchiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_layer_make(size : Int) -> ChemmolreprinchiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_layer_len(s : ChemmolreprinchiLayer) -> Int { s.size }

pub fn chem_mol_repr_inchi_layer_get(s : ChemmolreprinchiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_layer_set(s : ChemmolreprinchiLayer, i : Int, v : Double) -> ChemmolreprinchiLayer {
  let result = chem_mol_repr_inchi_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_layer_sum(s : ChemmolreprinchiLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_layer_mean(s : ChemmolreprinchiLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_layer_scale(s : ChemmolreprinchiLayer, f : Double) -> ChemmolreprinchiLayer {
  let result = chem_mol_repr_inchi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_layer_add(a : ChemmolreprinchiLayer, b : ChemmolreprinchiLayer) -> ChemmolreprinchiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_layer_copy(s : ChemmolreprinchiLayer) -> ChemmolreprinchiLayer {
  let result = chem_mol_repr_inchi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_layer_fill(s : ChemmolreprinchiLayer, v : Double) -> ChemmolreprinchiLayer {
  let result = chem_mol_repr_inchi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_layer_min(s : ChemmolreprinchiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_layer_max(s : ChemmolreprinchiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_layer_to_string(s : ChemmolreprinchiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_buffer_make(size : Int) -> ChemmolreprinchiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_buffer_len(s : ChemmolreprinchiBuffer) -> Int { s.size }

pub fn chem_mol_repr_inchi_buffer_get(s : ChemmolreprinchiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_buffer_set(s : ChemmolreprinchiBuffer, i : Int, v : Double) -> ChemmolreprinchiBuffer {
  let result = chem_mol_repr_inchi_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_buffer_sum(s : ChemmolreprinchiBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_buffer_mean(s : ChemmolreprinchiBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_buffer_scale(s : ChemmolreprinchiBuffer, f : Double) -> ChemmolreprinchiBuffer {
  let result = chem_mol_repr_inchi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_buffer_add(a : ChemmolreprinchiBuffer, b : ChemmolreprinchiBuffer) -> ChemmolreprinchiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_buffer_copy(s : ChemmolreprinchiBuffer) -> ChemmolreprinchiBuffer {
  let result = chem_mol_repr_inchi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_buffer_fill(s : ChemmolreprinchiBuffer, v : Double) -> ChemmolreprinchiBuffer {
  let result = chem_mol_repr_inchi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_buffer_min(s : ChemmolreprinchiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_buffer_max(s : ChemmolreprinchiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_buffer_to_string(s : ChemmolreprinchiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_cursor_make(size : Int) -> ChemmolreprinchiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_cursor_len(s : ChemmolreprinchiCursor) -> Int { s.size }

pub fn chem_mol_repr_inchi_cursor_get(s : ChemmolreprinchiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_cursor_set(s : ChemmolreprinchiCursor, i : Int, v : Double) -> ChemmolreprinchiCursor {
  let result = chem_mol_repr_inchi_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_cursor_sum(s : ChemmolreprinchiCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_cursor_mean(s : ChemmolreprinchiCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_cursor_scale(s : ChemmolreprinchiCursor, f : Double) -> ChemmolreprinchiCursor {
  let result = chem_mol_repr_inchi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_cursor_add(a : ChemmolreprinchiCursor, b : ChemmolreprinchiCursor) -> ChemmolreprinchiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_cursor_copy(s : ChemmolreprinchiCursor) -> ChemmolreprinchiCursor {
  let result = chem_mol_repr_inchi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_cursor_fill(s : ChemmolreprinchiCursor, v : Double) -> ChemmolreprinchiCursor {
  let result = chem_mol_repr_inchi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_cursor_min(s : ChemmolreprinchiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_cursor_max(s : ChemmolreprinchiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_cursor_to_string(s : ChemmolreprinchiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_view_make(size : Int) -> ChemmolreprinchiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_view_len(s : ChemmolreprinchiView) -> Int { s.size }

pub fn chem_mol_repr_inchi_view_get(s : ChemmolreprinchiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_view_set(s : ChemmolreprinchiView, i : Int, v : Double) -> ChemmolreprinchiView {
  let result = chem_mol_repr_inchi_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_view_sum(s : ChemmolreprinchiView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_view_mean(s : ChemmolreprinchiView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_view_scale(s : ChemmolreprinchiView, f : Double) -> ChemmolreprinchiView {
  let result = chem_mol_repr_inchi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_view_add(a : ChemmolreprinchiView, b : ChemmolreprinchiView) -> ChemmolreprinchiView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_view_copy(s : ChemmolreprinchiView) -> ChemmolreprinchiView {
  let result = chem_mol_repr_inchi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_view_fill(s : ChemmolreprinchiView, v : Double) -> ChemmolreprinchiView {
  let result = chem_mol_repr_inchi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_view_min(s : ChemmolreprinchiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_view_max(s : ChemmolreprinchiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_view_to_string(s : ChemmolreprinchiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_range_make(size : Int) -> ChemmolreprinchiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_range_len(s : ChemmolreprinchiRange) -> Int { s.size }

pub fn chem_mol_repr_inchi_range_get(s : ChemmolreprinchiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_range_set(s : ChemmolreprinchiRange, i : Int, v : Double) -> ChemmolreprinchiRange {
  let result = chem_mol_repr_inchi_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_range_sum(s : ChemmolreprinchiRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_range_mean(s : ChemmolreprinchiRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_range_scale(s : ChemmolreprinchiRange, f : Double) -> ChemmolreprinchiRange {
  let result = chem_mol_repr_inchi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_range_add(a : ChemmolreprinchiRange, b : ChemmolreprinchiRange) -> ChemmolreprinchiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_range_copy(s : ChemmolreprinchiRange) -> ChemmolreprinchiRange {
  let result = chem_mol_repr_inchi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_range_fill(s : ChemmolreprinchiRange, v : Double) -> ChemmolreprinchiRange {
  let result = chem_mol_repr_inchi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_range_min(s : ChemmolreprinchiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_range_max(s : ChemmolreprinchiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_range_to_string(s : ChemmolreprinchiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprinchiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_inchi_slice_make(size : Int) -> ChemmolreprinchiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_inchi_slice_len(s : ChemmolreprinchiSlice) -> Int { s.size }

pub fn chem_mol_repr_inchi_slice_get(s : ChemmolreprinchiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_inchi_slice_set(s : ChemmolreprinchiSlice, i : Int, v : Double) -> ChemmolreprinchiSlice {
  let result = chem_mol_repr_inchi_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_slice_sum(s : ChemmolreprinchiSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_inchi_slice_mean(s : ChemmolreprinchiSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_inchi_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_inchi_slice_scale(s : ChemmolreprinchiSlice, f : Double) -> ChemmolreprinchiSlice {
  let result = chem_mol_repr_inchi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_inchi_slice_add(a : ChemmolreprinchiSlice, b : ChemmolreprinchiSlice) -> ChemmolreprinchiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_inchi_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_inchi_slice_copy(s : ChemmolreprinchiSlice) -> ChemmolreprinchiSlice {
  let result = chem_mol_repr_inchi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_inchi_slice_fill(s : ChemmolreprinchiSlice, v : Double) -> ChemmolreprinchiSlice {
  let result = chem_mol_repr_inchi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_inchi_slice_min(s : ChemmolreprinchiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_slice_max(s : ChemmolreprinchiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_inchi_slice_to_string(s : ChemmolreprinchiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


///===
/// extcore/chem_mol_repr_pdb

pub(all) struct ChemmolreprpdbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_pdb_make_point(x : Double, y : Double) -> ChemmolreprpdbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_pdb_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprpdbPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_pdb_point_x(pt : ChemmolreprpdbPoint) -> Double { pt.x }

pub fn chem_mol_repr_pdb_point_y(pt : ChemmolreprpdbPoint) -> Double { pt.y }

pub fn chem_mol_repr_pdb_point_z(pt : ChemmolreprpdbPoint) -> Double { pt.z }

pub fn chem_mol_repr_pdb_point_label(pt : ChemmolreprpdbPoint) -> Int { pt.label }

pub fn chem_mol_repr_pdb_point_dist(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_pdb_point_add(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_pdb_point_sub(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_pdb_point_scale(pt : ChemmolreprpdbPoint, s : Double) -> ChemmolreprpdbPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_pdb_point_dot(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_pdb_point_cross(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_pdb_point_norm(pt : ChemmolreprpdbPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_pdb_point_normalize(pt : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  let n = chem_mol_repr_pdb_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_pdb_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_pdb_point_negate(pt : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_pdb_point_mid(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint) -> ChemmolreprpdbPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_pdb_point_lerp(a : ChemmolreprpdbPoint, b : ChemmolreprpdbPoint, t : Double) -> ChemmolreprpdbPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_pdb_point_to_string(pt : ChemmolreprpdbPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprpdbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_pdb_make_series(vals : Array[Double], name : String) -> ChemmolreprpdbSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_pdb_series_len(s : ChemmolreprpdbSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_pdb_series_sum(s : ChemmolreprpdbSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_pdb_series_mean(s : ChemmolreprpdbSeries) -> Double {
  let n = chem_mol_repr_pdb_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_pdb_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_pdb_series_min(s : ChemmolreprpdbSeries) -> Double {
  let n = chem_mol_repr_pdb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_series_max(s : ChemmolreprpdbSeries) -> Double {
  let n = chem_mol_repr_pdb_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_series_range(s : ChemmolreprpdbSeries) -> Double {
  chem_mol_repr_pdb_series_max(s) - chem_mol_repr_pdb_series_min(s)
}

pub fn chem_mol_repr_pdb_series_var(s : ChemmolreprpdbSeries) -> Double {
  let n = chem_mol_repr_pdb_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_pdb_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_series_std(s : ChemmolreprpdbSeries) -> Double { @_common.sqrt(chem_mol_repr_pdb_series_var(s)) }

pub fn chem_mol_repr_pdb_series_median(s : ChemmolreprpdbSeries) -> Double {
  let n = chem_mol_repr_pdb_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_pdb_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_pdb_series_scale(s : ChemmolreprpdbSeries, f : Double) -> ChemmolreprpdbSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_pdb_series_add(a : ChemmolreprpdbSeries, b : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_pdb_series_sub(a : ChemmolreprpdbSeries, b : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_pdb_series_normalize(s : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  let mn = chem_mol_repr_pdb_series_min(s)
  let mx = chem_mol_repr_pdb_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_pdb_series_cumsum(s : ChemmolreprpdbSeries) -> ChemmolreprpdbSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_pdb_series_to_string(s : ChemmolreprpdbSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprpdbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_pdb_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprpdbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_pdb_matrix_identity(n : Int) -> ChemmolreprpdbMatrix {
  let m = chem_mol_repr_pdb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_pdb_matrix_get(m : ChemmolreprpdbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_pdb_matrix_transpose(m : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  let result = chem_mol_repr_pdb_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_pdb_matrix_add(a : ChemmolreprpdbMatrix, b : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_pdb_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_pdb_matrix_scale(m : ChemmolreprpdbMatrix, s : Double) -> ChemmolreprpdbMatrix {
  let result = chem_mol_repr_pdb_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_pdb_matrix_multiply(a : ChemmolreprpdbMatrix, b : ChemmolreprpdbMatrix) -> ChemmolreprpdbMatrix {
  if a.cols != b.rows { return chem_mol_repr_pdb_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_pdb_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_pdb_matrix_trace(m : ChemmolreprpdbMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_pdb_matrix_det(m : ChemmolreprpdbMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_pdb_matrix_norm(m : ChemmolreprpdbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_pdb_matrix_to_string(m : ChemmolreprpdbMatrix) -> String {
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

pub(all) struct ChemmolreprpdbVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_pdb_make_vector(comps : Array[Double]) -> ChemmolreprpdbVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_pdb_vector_zero(dim : Int) -> ChemmolreprpdbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_pdb_vector_add(a : ChemmolreprpdbVector, b : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_pdb_vector_sub(a : ChemmolreprpdbVector, b : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_pdb_vector_scale(v : ChemmolreprpdbVector, s : Double) -> ChemmolreprpdbVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_pdb_vector_dot(a : ChemmolreprpdbVector, b : ChemmolreprpdbVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_pdb_vector_norm(v : ChemmolreprpdbVector) -> Double { @_common.sqrt(chem_mol_repr_pdb_vector_dot(v, v)) }

pub fn chem_mol_repr_pdb_vector_normalize(v : ChemmolreprpdbVector) -> ChemmolreprpdbVector {
  let n = chem_mol_repr_pdb_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_pdb_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_pdb_vector_dist(a : ChemmolreprpdbVector, b : ChemmolreprpdbVector) -> Double {
  chem_mol_repr_pdb_vector_norm(chem_mol_repr_pdb_vector_sub(a, b))
}

pub fn chem_mol_repr_pdb_vector_to_string(v : ChemmolreprpdbVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_pdb_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_pdb_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_repr_pdb_var(data)) }

pub fn chem_mol_repr_pdb_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_pdb_mean(a); let mb = chem_mol_repr_pdb_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_pdb_std(a); let sb = chem_mol_repr_pdb_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_pdb_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_pdb_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_pdb_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_pdb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_repr_pdb_mse(pred, labels))
}

pub fn chem_mol_repr_pdb_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_pdb_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_pdb_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_pdb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_pdb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_pdb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_pdb_precision(pred, labels, pos); let r = chem_mol_repr_pdb_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_pdb_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_pdb_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_pdb_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_pdb_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_pdb_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_pdb_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_pdb_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_pdb_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_pdb_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_pdb_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_pdb_min(data); let mx = chem_mol_repr_pdb_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_pdb_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_pdb_mean(data); let sd = chem_mol_repr_pdb_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_pdb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_pdb_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_pdb_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_pdb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolreprpdbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_frame_make(size : Int) -> ChemmolreprpdbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_frame_len(s : ChemmolreprpdbFrame) -> Int { s.size }

pub fn chem_mol_repr_pdb_frame_get(s : ChemmolreprpdbFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_frame_set(s : ChemmolreprpdbFrame, i : Int, v : Double) -> ChemmolreprpdbFrame {
  let result = chem_mol_repr_pdb_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_frame_sum(s : ChemmolreprpdbFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_frame_mean(s : ChemmolreprpdbFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_frame_scale(s : ChemmolreprpdbFrame, f : Double) -> ChemmolreprpdbFrame {
  let result = chem_mol_repr_pdb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_frame_add(a : ChemmolreprpdbFrame, b : ChemmolreprpdbFrame) -> ChemmolreprpdbFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_frame_copy(s : ChemmolreprpdbFrame) -> ChemmolreprpdbFrame {
  let result = chem_mol_repr_pdb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_frame_fill(s : ChemmolreprpdbFrame, v : Double) -> ChemmolreprpdbFrame {
  let result = chem_mol_repr_pdb_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_frame_min(s : ChemmolreprpdbFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_frame_max(s : ChemmolreprpdbFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_frame_to_string(s : ChemmolreprpdbFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_table_make(size : Int) -> ChemmolreprpdbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_table_len(s : ChemmolreprpdbTable) -> Int { s.size }

pub fn chem_mol_repr_pdb_table_get(s : ChemmolreprpdbTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_table_set(s : ChemmolreprpdbTable, i : Int, v : Double) -> ChemmolreprpdbTable {
  let result = chem_mol_repr_pdb_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_table_sum(s : ChemmolreprpdbTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_table_mean(s : ChemmolreprpdbTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_table_scale(s : ChemmolreprpdbTable, f : Double) -> ChemmolreprpdbTable {
  let result = chem_mol_repr_pdb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_table_add(a : ChemmolreprpdbTable, b : ChemmolreprpdbTable) -> ChemmolreprpdbTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_table_copy(s : ChemmolreprpdbTable) -> ChemmolreprpdbTable {
  let result = chem_mol_repr_pdb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_table_fill(s : ChemmolreprpdbTable, v : Double) -> ChemmolreprpdbTable {
  let result = chem_mol_repr_pdb_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_table_min(s : ChemmolreprpdbTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_table_max(s : ChemmolreprpdbTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_table_to_string(s : ChemmolreprpdbTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_graphn_make(size : Int) -> ChemmolreprpdbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_graphn_len(s : ChemmolreprpdbGraphN) -> Int { s.size }

pub fn chem_mol_repr_pdb_graphn_get(s : ChemmolreprpdbGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_graphn_set(s : ChemmolreprpdbGraphN, i : Int, v : Double) -> ChemmolreprpdbGraphN {
  let result = chem_mol_repr_pdb_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_graphn_sum(s : ChemmolreprpdbGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_graphn_mean(s : ChemmolreprpdbGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_graphn_scale(s : ChemmolreprpdbGraphN, f : Double) -> ChemmolreprpdbGraphN {
  let result = chem_mol_repr_pdb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_graphn_add(a : ChemmolreprpdbGraphN, b : ChemmolreprpdbGraphN) -> ChemmolreprpdbGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_graphn_copy(s : ChemmolreprpdbGraphN) -> ChemmolreprpdbGraphN {
  let result = chem_mol_repr_pdb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_graphn_fill(s : ChemmolreprpdbGraphN, v : Double) -> ChemmolreprpdbGraphN {
  let result = chem_mol_repr_pdb_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_graphn_min(s : ChemmolreprpdbGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_graphn_max(s : ChemmolreprpdbGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_graphn_to_string(s : ChemmolreprpdbGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_node_make(size : Int) -> ChemmolreprpdbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_node_len(s : ChemmolreprpdbNode) -> Int { s.size }

pub fn chem_mol_repr_pdb_node_get(s : ChemmolreprpdbNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_node_set(s : ChemmolreprpdbNode, i : Int, v : Double) -> ChemmolreprpdbNode {
  let result = chem_mol_repr_pdb_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_node_sum(s : ChemmolreprpdbNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_node_mean(s : ChemmolreprpdbNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_node_scale(s : ChemmolreprpdbNode, f : Double) -> ChemmolreprpdbNode {
  let result = chem_mol_repr_pdb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_node_add(a : ChemmolreprpdbNode, b : ChemmolreprpdbNode) -> ChemmolreprpdbNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_node_copy(s : ChemmolreprpdbNode) -> ChemmolreprpdbNode {
  let result = chem_mol_repr_pdb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_node_fill(s : ChemmolreprpdbNode, v : Double) -> ChemmolreprpdbNode {
  let result = chem_mol_repr_pdb_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_node_min(s : ChemmolreprpdbNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_node_max(s : ChemmolreprpdbNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_node_to_string(s : ChemmolreprpdbNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_edge_make(size : Int) -> ChemmolreprpdbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_edge_len(s : ChemmolreprpdbEdge) -> Int { s.size }

pub fn chem_mol_repr_pdb_edge_get(s : ChemmolreprpdbEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_edge_set(s : ChemmolreprpdbEdge, i : Int, v : Double) -> ChemmolreprpdbEdge {
  let result = chem_mol_repr_pdb_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_edge_sum(s : ChemmolreprpdbEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_edge_mean(s : ChemmolreprpdbEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_edge_scale(s : ChemmolreprpdbEdge, f : Double) -> ChemmolreprpdbEdge {
  let result = chem_mol_repr_pdb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_edge_add(a : ChemmolreprpdbEdge, b : ChemmolreprpdbEdge) -> ChemmolreprpdbEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_edge_copy(s : ChemmolreprpdbEdge) -> ChemmolreprpdbEdge {
  let result = chem_mol_repr_pdb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_edge_fill(s : ChemmolreprpdbEdge, v : Double) -> ChemmolreprpdbEdge {
  let result = chem_mol_repr_pdb_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_edge_min(s : ChemmolreprpdbEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_edge_max(s : ChemmolreprpdbEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_edge_to_string(s : ChemmolreprpdbEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_path_make(size : Int) -> ChemmolreprpdbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_path_len(s : ChemmolreprpdbPath) -> Int { s.size }

pub fn chem_mol_repr_pdb_path_get(s : ChemmolreprpdbPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_path_set(s : ChemmolreprpdbPath, i : Int, v : Double) -> ChemmolreprpdbPath {
  let result = chem_mol_repr_pdb_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_path_sum(s : ChemmolreprpdbPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_path_mean(s : ChemmolreprpdbPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_path_scale(s : ChemmolreprpdbPath, f : Double) -> ChemmolreprpdbPath {
  let result = chem_mol_repr_pdb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_path_add(a : ChemmolreprpdbPath, b : ChemmolreprpdbPath) -> ChemmolreprpdbPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_path_copy(s : ChemmolreprpdbPath) -> ChemmolreprpdbPath {
  let result = chem_mol_repr_pdb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_path_fill(s : ChemmolreprpdbPath, v : Double) -> ChemmolreprpdbPath {
  let result = chem_mol_repr_pdb_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_path_min(s : ChemmolreprpdbPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_path_max(s : ChemmolreprpdbPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_path_to_string(s : ChemmolreprpdbPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_cluster_make(size : Int) -> ChemmolreprpdbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_cluster_len(s : ChemmolreprpdbCluster) -> Int { s.size }

pub fn chem_mol_repr_pdb_cluster_get(s : ChemmolreprpdbCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_cluster_set(s : ChemmolreprpdbCluster, i : Int, v : Double) -> ChemmolreprpdbCluster {
  let result = chem_mol_repr_pdb_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_cluster_sum(s : ChemmolreprpdbCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_cluster_mean(s : ChemmolreprpdbCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_cluster_scale(s : ChemmolreprpdbCluster, f : Double) -> ChemmolreprpdbCluster {
  let result = chem_mol_repr_pdb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_cluster_add(a : ChemmolreprpdbCluster, b : ChemmolreprpdbCluster) -> ChemmolreprpdbCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_cluster_copy(s : ChemmolreprpdbCluster) -> ChemmolreprpdbCluster {
  let result = chem_mol_repr_pdb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_cluster_fill(s : ChemmolreprpdbCluster, v : Double) -> ChemmolreprpdbCluster {
  let result = chem_mol_repr_pdb_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_cluster_min(s : ChemmolreprpdbCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_cluster_max(s : ChemmolreprpdbCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_cluster_to_string(s : ChemmolreprpdbCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_model_make(size : Int) -> ChemmolreprpdbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_model_len(s : ChemmolreprpdbModel) -> Int { s.size }

pub fn chem_mol_repr_pdb_model_get(s : ChemmolreprpdbModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_model_set(s : ChemmolreprpdbModel, i : Int, v : Double) -> ChemmolreprpdbModel {
  let result = chem_mol_repr_pdb_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_model_sum(s : ChemmolreprpdbModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_model_mean(s : ChemmolreprpdbModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_model_scale(s : ChemmolreprpdbModel, f : Double) -> ChemmolreprpdbModel {
  let result = chem_mol_repr_pdb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_model_add(a : ChemmolreprpdbModel, b : ChemmolreprpdbModel) -> ChemmolreprpdbModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_model_copy(s : ChemmolreprpdbModel) -> ChemmolreprpdbModel {
  let result = chem_mol_repr_pdb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_model_fill(s : ChemmolreprpdbModel, v : Double) -> ChemmolreprpdbModel {
  let result = chem_mol_repr_pdb_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_model_min(s : ChemmolreprpdbModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_model_max(s : ChemmolreprpdbModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_model_to_string(s : ChemmolreprpdbModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_layer_make(size : Int) -> ChemmolreprpdbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_layer_len(s : ChemmolreprpdbLayer) -> Int { s.size }

pub fn chem_mol_repr_pdb_layer_get(s : ChemmolreprpdbLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_layer_set(s : ChemmolreprpdbLayer, i : Int, v : Double) -> ChemmolreprpdbLayer {
  let result = chem_mol_repr_pdb_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_layer_sum(s : ChemmolreprpdbLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_layer_mean(s : ChemmolreprpdbLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_layer_scale(s : ChemmolreprpdbLayer, f : Double) -> ChemmolreprpdbLayer {
  let result = chem_mol_repr_pdb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_layer_add(a : ChemmolreprpdbLayer, b : ChemmolreprpdbLayer) -> ChemmolreprpdbLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_layer_copy(s : ChemmolreprpdbLayer) -> ChemmolreprpdbLayer {
  let result = chem_mol_repr_pdb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_layer_fill(s : ChemmolreprpdbLayer, v : Double) -> ChemmolreprpdbLayer {
  let result = chem_mol_repr_pdb_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_layer_min(s : ChemmolreprpdbLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_layer_max(s : ChemmolreprpdbLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_layer_to_string(s : ChemmolreprpdbLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_buffer_make(size : Int) -> ChemmolreprpdbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_buffer_len(s : ChemmolreprpdbBuffer) -> Int { s.size }

pub fn chem_mol_repr_pdb_buffer_get(s : ChemmolreprpdbBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_buffer_set(s : ChemmolreprpdbBuffer, i : Int, v : Double) -> ChemmolreprpdbBuffer {
  let result = chem_mol_repr_pdb_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_buffer_sum(s : ChemmolreprpdbBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_buffer_mean(s : ChemmolreprpdbBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_buffer_scale(s : ChemmolreprpdbBuffer, f : Double) -> ChemmolreprpdbBuffer {
  let result = chem_mol_repr_pdb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_buffer_add(a : ChemmolreprpdbBuffer, b : ChemmolreprpdbBuffer) -> ChemmolreprpdbBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_buffer_copy(s : ChemmolreprpdbBuffer) -> ChemmolreprpdbBuffer {
  let result = chem_mol_repr_pdb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_buffer_fill(s : ChemmolreprpdbBuffer, v : Double) -> ChemmolreprpdbBuffer {
  let result = chem_mol_repr_pdb_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_buffer_min(s : ChemmolreprpdbBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_buffer_max(s : ChemmolreprpdbBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_buffer_to_string(s : ChemmolreprpdbBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_cursor_make(size : Int) -> ChemmolreprpdbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_cursor_len(s : ChemmolreprpdbCursor) -> Int { s.size }

pub fn chem_mol_repr_pdb_cursor_get(s : ChemmolreprpdbCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_cursor_set(s : ChemmolreprpdbCursor, i : Int, v : Double) -> ChemmolreprpdbCursor {
  let result = chem_mol_repr_pdb_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_cursor_sum(s : ChemmolreprpdbCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_cursor_mean(s : ChemmolreprpdbCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_cursor_scale(s : ChemmolreprpdbCursor, f : Double) -> ChemmolreprpdbCursor {
  let result = chem_mol_repr_pdb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_cursor_add(a : ChemmolreprpdbCursor, b : ChemmolreprpdbCursor) -> ChemmolreprpdbCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_cursor_copy(s : ChemmolreprpdbCursor) -> ChemmolreprpdbCursor {
  let result = chem_mol_repr_pdb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_cursor_fill(s : ChemmolreprpdbCursor, v : Double) -> ChemmolreprpdbCursor {
  let result = chem_mol_repr_pdb_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_cursor_min(s : ChemmolreprpdbCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_cursor_max(s : ChemmolreprpdbCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_cursor_to_string(s : ChemmolreprpdbCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_view_make(size : Int) -> ChemmolreprpdbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_view_len(s : ChemmolreprpdbView) -> Int { s.size }

pub fn chem_mol_repr_pdb_view_get(s : ChemmolreprpdbView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_view_set(s : ChemmolreprpdbView, i : Int, v : Double) -> ChemmolreprpdbView {
  let result = chem_mol_repr_pdb_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_view_sum(s : ChemmolreprpdbView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_view_mean(s : ChemmolreprpdbView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_view_scale(s : ChemmolreprpdbView, f : Double) -> ChemmolreprpdbView {
  let result = chem_mol_repr_pdb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_view_add(a : ChemmolreprpdbView, b : ChemmolreprpdbView) -> ChemmolreprpdbView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_view_copy(s : ChemmolreprpdbView) -> ChemmolreprpdbView {
  let result = chem_mol_repr_pdb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_view_fill(s : ChemmolreprpdbView, v : Double) -> ChemmolreprpdbView {
  let result = chem_mol_repr_pdb_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_view_min(s : ChemmolreprpdbView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_view_max(s : ChemmolreprpdbView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_view_to_string(s : ChemmolreprpdbView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_range_make(size : Int) -> ChemmolreprpdbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_range_len(s : ChemmolreprpdbRange) -> Int { s.size }

pub fn chem_mol_repr_pdb_range_get(s : ChemmolreprpdbRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_range_set(s : ChemmolreprpdbRange, i : Int, v : Double) -> ChemmolreprpdbRange {
  let result = chem_mol_repr_pdb_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_range_sum(s : ChemmolreprpdbRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_range_mean(s : ChemmolreprpdbRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_range_scale(s : ChemmolreprpdbRange, f : Double) -> ChemmolreprpdbRange {
  let result = chem_mol_repr_pdb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_range_add(a : ChemmolreprpdbRange, b : ChemmolreprpdbRange) -> ChemmolreprpdbRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_range_copy(s : ChemmolreprpdbRange) -> ChemmolreprpdbRange {
  let result = chem_mol_repr_pdb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_range_fill(s : ChemmolreprpdbRange, v : Double) -> ChemmolreprpdbRange {
  let result = chem_mol_repr_pdb_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_range_min(s : ChemmolreprpdbRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_range_max(s : ChemmolreprpdbRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_range_to_string(s : ChemmolreprpdbRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprpdbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_pdb_slice_make(size : Int) -> ChemmolreprpdbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_pdb_slice_len(s : ChemmolreprpdbSlice) -> Int { s.size }

pub fn chem_mol_repr_pdb_slice_get(s : ChemmolreprpdbSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_pdb_slice_set(s : ChemmolreprpdbSlice, i : Int, v : Double) -> ChemmolreprpdbSlice {
  let result = chem_mol_repr_pdb_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_slice_sum(s : ChemmolreprpdbSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_pdb_slice_mean(s : ChemmolreprpdbSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_pdb_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_pdb_slice_scale(s : ChemmolreprpdbSlice, f : Double) -> ChemmolreprpdbSlice {
  let result = chem_mol_repr_pdb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_pdb_slice_add(a : ChemmolreprpdbSlice, b : ChemmolreprpdbSlice) -> ChemmolreprpdbSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_pdb_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_pdb_slice_copy(s : ChemmolreprpdbSlice) -> ChemmolreprpdbSlice {
  let result = chem_mol_repr_pdb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_pdb_slice_fill(s : ChemmolreprpdbSlice, v : Double) -> ChemmolreprpdbSlice {
  let result = chem_mol_repr_pdb_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_pdb_slice_min(s : ChemmolreprpdbSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_slice_max(s : ChemmolreprpdbSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_pdb_slice_to_string(s : ChemmolreprpdbSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


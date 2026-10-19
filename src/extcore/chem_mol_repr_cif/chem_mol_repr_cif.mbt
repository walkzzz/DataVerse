///===
/// extcore/chem_mol_repr_cif

pub(all) struct ChemmolreprcifPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_cif_make_point(x : Double, y : Double) -> ChemmolreprcifPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_cif_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcifPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_cif_point_x(pt : ChemmolreprcifPoint) -> Double { pt.x }

pub fn chem_mol_repr_cif_point_y(pt : ChemmolreprcifPoint) -> Double { pt.y }

pub fn chem_mol_repr_cif_point_z(pt : ChemmolreprcifPoint) -> Double { pt.z }

pub fn chem_mol_repr_cif_point_label(pt : ChemmolreprcifPoint) -> Int { pt.label }

pub fn chem_mol_repr_cif_point_dist(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_mol_repr_cif_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_cif_point_add(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_cif_point_sub(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_cif_point_scale(pt : ChemmolreprcifPoint, s : Double) -> ChemmolreprcifPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_cif_point_dot(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_cif_point_cross(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_cif_point_norm(pt : ChemmolreprcifPoint) -> Double {
  chem_mol_repr_cif_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_cif_point_normalize(pt : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  let n = chem_mol_repr_cif_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_cif_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_cif_point_negate(pt : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_cif_point_mid(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint) -> ChemmolreprcifPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_cif_point_lerp(a : ChemmolreprcifPoint, b : ChemmolreprcifPoint, t : Double) -> ChemmolreprcifPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_cif_point_to_string(pt : ChemmolreprcifPoint) -> String {
  "(" + chem_mol_repr_cif_dbl(pt.x) + ", " + chem_mol_repr_cif_dbl(pt.y) + ", " + chem_mol_repr_cif_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprcifSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_cif_make_series(vals : Array[Double], name : String) -> ChemmolreprcifSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_cif_series_len(s : ChemmolreprcifSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_cif_series_sum(s : ChemmolreprcifSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_cif_series_mean(s : ChemmolreprcifSeries) -> Double {
  let n = chem_mol_repr_cif_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_cif_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_cif_series_min(s : ChemmolreprcifSeries) -> Double {
  let n = chem_mol_repr_cif_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_series_max(s : ChemmolreprcifSeries) -> Double {
  let n = chem_mol_repr_cif_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_series_range(s : ChemmolreprcifSeries) -> Double {
  chem_mol_repr_cif_series_max(s) - chem_mol_repr_cif_series_min(s)
}

pub fn chem_mol_repr_cif_series_var(s : ChemmolreprcifSeries) -> Double {
  let n = chem_mol_repr_cif_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_cif_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_cif_series_std(s : ChemmolreprcifSeries) -> Double { chem_mol_repr_cif_sqrt(chem_mol_repr_cif_series_var(s)) }

pub fn chem_mol_repr_cif_series_median(s : ChemmolreprcifSeries) -> Double {
  let n = chem_mol_repr_cif_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_cif_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_cif_series_scale(s : ChemmolreprcifSeries, f : Double) -> ChemmolreprcifSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_mol_repr_cif_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_cif_series_add(a : ChemmolreprcifSeries, b : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_cif_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_cif_series_sub(a : ChemmolreprcifSeries, b : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_cif_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_cif_series_normalize(s : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let mn = chem_mol_repr_cif_series_min(s)
  let mx = chem_mol_repr_cif_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_mol_repr_cif_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_cif_series_cumsum(s : ChemmolreprcifSeries) -> ChemmolreprcifSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_mol_repr_cif_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_cif_series_to_string(s : ChemmolreprcifSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_repr_cif_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcifMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_cif_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcifMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_cif_matrix_identity(n : Int) -> ChemmolreprcifMatrix {
  let m = chem_mol_repr_cif_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_cif_matrix_get(m : ChemmolreprcifMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_cif_matrix_transpose(m : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_cif_matrix_add(a : ChemmolreprcifMatrix, b : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_cif_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_cif_matrix_scale(m : ChemmolreprcifMatrix, s : Double) -> ChemmolreprcifMatrix {
  let result = chem_mol_repr_cif_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_cif_matrix_multiply(a : ChemmolreprcifMatrix, b : ChemmolreprcifMatrix) -> ChemmolreprcifMatrix {
  if a.cols != b.rows { return chem_mol_repr_cif_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_cif_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_cif_matrix_trace(m : ChemmolreprcifMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_cif_matrix_det(m : ChemmolreprcifMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_cif_matrix_norm(m : ChemmolreprcifMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_mol_repr_cif_sqrt(sum)
}

pub fn chem_mol_repr_cif_matrix_to_string(m : ChemmolreprcifMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_mol_repr_cif_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolreprcifVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_cif_make_vector(comps : Array[Double]) -> ChemmolreprcifVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_cif_vector_zero(dim : Int) -> ChemmolreprcifVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_cif_vector_add(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_cif_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_cif_vector_sub(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_repr_cif_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_cif_vector_scale(v : ChemmolreprcifVector, s : Double) -> ChemmolreprcifVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_mol_repr_cif_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_cif_vector_dot(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_cif_vector_norm(v : ChemmolreprcifVector) -> Double { chem_mol_repr_cif_sqrt(chem_mol_repr_cif_vector_dot(v, v)) }

pub fn chem_mol_repr_cif_vector_normalize(v : ChemmolreprcifVector) -> ChemmolreprcifVector {
  let n = chem_mol_repr_cif_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_cif_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_cif_vector_dist(a : ChemmolreprcifVector, b : ChemmolreprcifVector) -> Double {
  chem_mol_repr_cif_vector_norm(chem_mol_repr_cif_vector_sub(a, b))
}

pub fn chem_mol_repr_cif_vector_to_string(v : ChemmolreprcifVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_repr_cif_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_cif_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_cif_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_cif_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_cif_std(data : Array[Double]) -> Double { chem_mol_repr_cif_sqrt(chem_mol_repr_cif_var(data)) }

pub fn chem_mol_repr_cif_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_cif_mean(a); let mb = chem_mol_repr_cif_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_cif_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_cif_std(a); let sb = chem_mol_repr_cif_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_cif_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_cif_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_cif_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_cif_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_cif_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_cif_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_mol_repr_cif_sqrt(chem_mol_repr_cif_mse(pred, labels))
}

pub fn chem_mol_repr_cif_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_mol_repr_cif_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_cif_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_cif_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_cif_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_cif_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_cif_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_cif_precision(pred, labels, pos); let r = chem_mol_repr_cif_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_cif_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_cif_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_cif_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_cif_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_cif_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_cif_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_cif_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_cif_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_cif_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_cif_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_cif_min(data); let mx = chem_mol_repr_cif_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_cif_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_cif_mean(data); let sd = chem_mol_repr_cif_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_cif_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_cif_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_cif_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_cif_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_mol_repr_cif_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_mol_repr_cif_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_mol_repr_cif_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_mol_repr_cif_int(x) } else { -chem_mol_repr_cif_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_mol_repr_cif_int(f * 1000000.0) } else { chem_mol_repr_cif_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_mol_repr_cif_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_mol_repr_cif_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemmolreprcifFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_frame_make(size : Int) -> ChemmolreprcifFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_frame_len(s : ChemmolreprcifFrame) -> Int { s.size }

pub fn chem_mol_repr_cif_frame_get(s : ChemmolreprcifFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_frame_set(s : ChemmolreprcifFrame, i : Int, v : Double) -> ChemmolreprcifFrame {
  let result = chem_mol_repr_cif_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_frame_sum(s : ChemmolreprcifFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_frame_mean(s : ChemmolreprcifFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_frame_scale(s : ChemmolreprcifFrame, f : Double) -> ChemmolreprcifFrame {
  let result = chem_mol_repr_cif_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_frame_add(a : ChemmolreprcifFrame, b : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_frame_copy(s : ChemmolreprcifFrame) -> ChemmolreprcifFrame {
  let result = chem_mol_repr_cif_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_frame_fill(s : ChemmolreprcifFrame, v : Double) -> ChemmolreprcifFrame {
  let result = chem_mol_repr_cif_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_frame_min(s : ChemmolreprcifFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_frame_max(s : ChemmolreprcifFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_frame_to_string(s : ChemmolreprcifFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_table_make(size : Int) -> ChemmolreprcifTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_table_len(s : ChemmolreprcifTable) -> Int { s.size }

pub fn chem_mol_repr_cif_table_get(s : ChemmolreprcifTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_table_set(s : ChemmolreprcifTable, i : Int, v : Double) -> ChemmolreprcifTable {
  let result = chem_mol_repr_cif_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_table_sum(s : ChemmolreprcifTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_table_mean(s : ChemmolreprcifTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_table_scale(s : ChemmolreprcifTable, f : Double) -> ChemmolreprcifTable {
  let result = chem_mol_repr_cif_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_table_add(a : ChemmolreprcifTable, b : ChemmolreprcifTable) -> ChemmolreprcifTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_table_copy(s : ChemmolreprcifTable) -> ChemmolreprcifTable {
  let result = chem_mol_repr_cif_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_table_fill(s : ChemmolreprcifTable, v : Double) -> ChemmolreprcifTable {
  let result = chem_mol_repr_cif_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_table_min(s : ChemmolreprcifTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_table_max(s : ChemmolreprcifTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_table_to_string(s : ChemmolreprcifTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_graphn_make(size : Int) -> ChemmolreprcifGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_graphn_len(s : ChemmolreprcifGraphN) -> Int { s.size }

pub fn chem_mol_repr_cif_graphn_get(s : ChemmolreprcifGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_graphn_set(s : ChemmolreprcifGraphN, i : Int, v : Double) -> ChemmolreprcifGraphN {
  let result = chem_mol_repr_cif_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_graphn_sum(s : ChemmolreprcifGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_graphn_mean(s : ChemmolreprcifGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_graphn_scale(s : ChemmolreprcifGraphN, f : Double) -> ChemmolreprcifGraphN {
  let result = chem_mol_repr_cif_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_graphn_add(a : ChemmolreprcifGraphN, b : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_graphn_copy(s : ChemmolreprcifGraphN) -> ChemmolreprcifGraphN {
  let result = chem_mol_repr_cif_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_graphn_fill(s : ChemmolreprcifGraphN, v : Double) -> ChemmolreprcifGraphN {
  let result = chem_mol_repr_cif_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_graphn_min(s : ChemmolreprcifGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_graphn_max(s : ChemmolreprcifGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_graphn_to_string(s : ChemmolreprcifGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_node_make(size : Int) -> ChemmolreprcifNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_node_len(s : ChemmolreprcifNode) -> Int { s.size }

pub fn chem_mol_repr_cif_node_get(s : ChemmolreprcifNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_node_set(s : ChemmolreprcifNode, i : Int, v : Double) -> ChemmolreprcifNode {
  let result = chem_mol_repr_cif_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_node_sum(s : ChemmolreprcifNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_node_mean(s : ChemmolreprcifNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_node_scale(s : ChemmolreprcifNode, f : Double) -> ChemmolreprcifNode {
  let result = chem_mol_repr_cif_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_node_add(a : ChemmolreprcifNode, b : ChemmolreprcifNode) -> ChemmolreprcifNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_node_copy(s : ChemmolreprcifNode) -> ChemmolreprcifNode {
  let result = chem_mol_repr_cif_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_node_fill(s : ChemmolreprcifNode, v : Double) -> ChemmolreprcifNode {
  let result = chem_mol_repr_cif_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_node_min(s : ChemmolreprcifNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_node_max(s : ChemmolreprcifNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_node_to_string(s : ChemmolreprcifNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_edge_make(size : Int) -> ChemmolreprcifEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_edge_len(s : ChemmolreprcifEdge) -> Int { s.size }

pub fn chem_mol_repr_cif_edge_get(s : ChemmolreprcifEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_edge_set(s : ChemmolreprcifEdge, i : Int, v : Double) -> ChemmolreprcifEdge {
  let result = chem_mol_repr_cif_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_edge_sum(s : ChemmolreprcifEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_edge_mean(s : ChemmolreprcifEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_edge_scale(s : ChemmolreprcifEdge, f : Double) -> ChemmolreprcifEdge {
  let result = chem_mol_repr_cif_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_edge_add(a : ChemmolreprcifEdge, b : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_edge_copy(s : ChemmolreprcifEdge) -> ChemmolreprcifEdge {
  let result = chem_mol_repr_cif_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_edge_fill(s : ChemmolreprcifEdge, v : Double) -> ChemmolreprcifEdge {
  let result = chem_mol_repr_cif_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_edge_min(s : ChemmolreprcifEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_edge_max(s : ChemmolreprcifEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_edge_to_string(s : ChemmolreprcifEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_path_make(size : Int) -> ChemmolreprcifPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_path_len(s : ChemmolreprcifPath) -> Int { s.size }

pub fn chem_mol_repr_cif_path_get(s : ChemmolreprcifPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_path_set(s : ChemmolreprcifPath, i : Int, v : Double) -> ChemmolreprcifPath {
  let result = chem_mol_repr_cif_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_path_sum(s : ChemmolreprcifPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_path_mean(s : ChemmolreprcifPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_path_scale(s : ChemmolreprcifPath, f : Double) -> ChemmolreprcifPath {
  let result = chem_mol_repr_cif_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_path_add(a : ChemmolreprcifPath, b : ChemmolreprcifPath) -> ChemmolreprcifPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_path_copy(s : ChemmolreprcifPath) -> ChemmolreprcifPath {
  let result = chem_mol_repr_cif_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_path_fill(s : ChemmolreprcifPath, v : Double) -> ChemmolreprcifPath {
  let result = chem_mol_repr_cif_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_path_min(s : ChemmolreprcifPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_path_max(s : ChemmolreprcifPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_path_to_string(s : ChemmolreprcifPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cluster_make(size : Int) -> ChemmolreprcifCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cluster_len(s : ChemmolreprcifCluster) -> Int { s.size }

pub fn chem_mol_repr_cif_cluster_get(s : ChemmolreprcifCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cluster_set(s : ChemmolreprcifCluster, i : Int, v : Double) -> ChemmolreprcifCluster {
  let result = chem_mol_repr_cif_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_cluster_sum(s : ChemmolreprcifCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_cluster_mean(s : ChemmolreprcifCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_cluster_scale(s : ChemmolreprcifCluster, f : Double) -> ChemmolreprcifCluster {
  let result = chem_mol_repr_cif_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_cluster_add(a : ChemmolreprcifCluster, b : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_cluster_copy(s : ChemmolreprcifCluster) -> ChemmolreprcifCluster {
  let result = chem_mol_repr_cif_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_cluster_fill(s : ChemmolreprcifCluster, v : Double) -> ChemmolreprcifCluster {
  let result = chem_mol_repr_cif_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_cluster_min(s : ChemmolreprcifCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_cluster_max(s : ChemmolreprcifCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_cluster_to_string(s : ChemmolreprcifCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_model_make(size : Int) -> ChemmolreprcifModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_model_len(s : ChemmolreprcifModel) -> Int { s.size }

pub fn chem_mol_repr_cif_model_get(s : ChemmolreprcifModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_model_set(s : ChemmolreprcifModel, i : Int, v : Double) -> ChemmolreprcifModel {
  let result = chem_mol_repr_cif_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_model_sum(s : ChemmolreprcifModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_model_mean(s : ChemmolreprcifModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_model_scale(s : ChemmolreprcifModel, f : Double) -> ChemmolreprcifModel {
  let result = chem_mol_repr_cif_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_model_add(a : ChemmolreprcifModel, b : ChemmolreprcifModel) -> ChemmolreprcifModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_model_copy(s : ChemmolreprcifModel) -> ChemmolreprcifModel {
  let result = chem_mol_repr_cif_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_model_fill(s : ChemmolreprcifModel, v : Double) -> ChemmolreprcifModel {
  let result = chem_mol_repr_cif_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_model_min(s : ChemmolreprcifModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_model_max(s : ChemmolreprcifModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_model_to_string(s : ChemmolreprcifModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_layer_make(size : Int) -> ChemmolreprcifLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_layer_len(s : ChemmolreprcifLayer) -> Int { s.size }

pub fn chem_mol_repr_cif_layer_get(s : ChemmolreprcifLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_layer_set(s : ChemmolreprcifLayer, i : Int, v : Double) -> ChemmolreprcifLayer {
  let result = chem_mol_repr_cif_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_layer_sum(s : ChemmolreprcifLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_layer_mean(s : ChemmolreprcifLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_layer_scale(s : ChemmolreprcifLayer, f : Double) -> ChemmolreprcifLayer {
  let result = chem_mol_repr_cif_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_layer_add(a : ChemmolreprcifLayer, b : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_layer_copy(s : ChemmolreprcifLayer) -> ChemmolreprcifLayer {
  let result = chem_mol_repr_cif_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_layer_fill(s : ChemmolreprcifLayer, v : Double) -> ChemmolreprcifLayer {
  let result = chem_mol_repr_cif_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_layer_min(s : ChemmolreprcifLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_layer_max(s : ChemmolreprcifLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_layer_to_string(s : ChemmolreprcifLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_buffer_make(size : Int) -> ChemmolreprcifBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_buffer_len(s : ChemmolreprcifBuffer) -> Int { s.size }

pub fn chem_mol_repr_cif_buffer_get(s : ChemmolreprcifBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_buffer_set(s : ChemmolreprcifBuffer, i : Int, v : Double) -> ChemmolreprcifBuffer {
  let result = chem_mol_repr_cif_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_buffer_sum(s : ChemmolreprcifBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_buffer_mean(s : ChemmolreprcifBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_buffer_scale(s : ChemmolreprcifBuffer, f : Double) -> ChemmolreprcifBuffer {
  let result = chem_mol_repr_cif_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_buffer_add(a : ChemmolreprcifBuffer, b : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_buffer_copy(s : ChemmolreprcifBuffer) -> ChemmolreprcifBuffer {
  let result = chem_mol_repr_cif_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_buffer_fill(s : ChemmolreprcifBuffer, v : Double) -> ChemmolreprcifBuffer {
  let result = chem_mol_repr_cif_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_buffer_min(s : ChemmolreprcifBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_buffer_max(s : ChemmolreprcifBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_buffer_to_string(s : ChemmolreprcifBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_cursor_make(size : Int) -> ChemmolreprcifCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_cursor_len(s : ChemmolreprcifCursor) -> Int { s.size }

pub fn chem_mol_repr_cif_cursor_get(s : ChemmolreprcifCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_cursor_set(s : ChemmolreprcifCursor, i : Int, v : Double) -> ChemmolreprcifCursor {
  let result = chem_mol_repr_cif_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_cursor_sum(s : ChemmolreprcifCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_cursor_mean(s : ChemmolreprcifCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_cursor_scale(s : ChemmolreprcifCursor, f : Double) -> ChemmolreprcifCursor {
  let result = chem_mol_repr_cif_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_cursor_add(a : ChemmolreprcifCursor, b : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_cursor_copy(s : ChemmolreprcifCursor) -> ChemmolreprcifCursor {
  let result = chem_mol_repr_cif_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_cursor_fill(s : ChemmolreprcifCursor, v : Double) -> ChemmolreprcifCursor {
  let result = chem_mol_repr_cif_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_cursor_min(s : ChemmolreprcifCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_cursor_max(s : ChemmolreprcifCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_cursor_to_string(s : ChemmolreprcifCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_view_make(size : Int) -> ChemmolreprcifView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_view_len(s : ChemmolreprcifView) -> Int { s.size }

pub fn chem_mol_repr_cif_view_get(s : ChemmolreprcifView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_view_set(s : ChemmolreprcifView, i : Int, v : Double) -> ChemmolreprcifView {
  let result = chem_mol_repr_cif_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_view_sum(s : ChemmolreprcifView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_view_mean(s : ChemmolreprcifView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_view_scale(s : ChemmolreprcifView, f : Double) -> ChemmolreprcifView {
  let result = chem_mol_repr_cif_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_view_add(a : ChemmolreprcifView, b : ChemmolreprcifView) -> ChemmolreprcifView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_view_copy(s : ChemmolreprcifView) -> ChemmolreprcifView {
  let result = chem_mol_repr_cif_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_view_fill(s : ChemmolreprcifView, v : Double) -> ChemmolreprcifView {
  let result = chem_mol_repr_cif_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_view_min(s : ChemmolreprcifView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_view_max(s : ChemmolreprcifView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_view_to_string(s : ChemmolreprcifView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_range_make(size : Int) -> ChemmolreprcifRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_range_len(s : ChemmolreprcifRange) -> Int { s.size }

pub fn chem_mol_repr_cif_range_get(s : ChemmolreprcifRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_range_set(s : ChemmolreprcifRange, i : Int, v : Double) -> ChemmolreprcifRange {
  let result = chem_mol_repr_cif_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_range_sum(s : ChemmolreprcifRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_range_mean(s : ChemmolreprcifRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_range_scale(s : ChemmolreprcifRange, f : Double) -> ChemmolreprcifRange {
  let result = chem_mol_repr_cif_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_range_add(a : ChemmolreprcifRange, b : ChemmolreprcifRange) -> ChemmolreprcifRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_range_copy(s : ChemmolreprcifRange) -> ChemmolreprcifRange {
  let result = chem_mol_repr_cif_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_range_fill(s : ChemmolreprcifRange, v : Double) -> ChemmolreprcifRange {
  let result = chem_mol_repr_cif_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_range_min(s : ChemmolreprcifRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_range_max(s : ChemmolreprcifRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_range_to_string(s : ChemmolreprcifRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcifSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_cif_slice_make(size : Int) -> ChemmolreprcifSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_cif_slice_len(s : ChemmolreprcifSlice) -> Int { s.size }

pub fn chem_mol_repr_cif_slice_get(s : ChemmolreprcifSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_cif_slice_set(s : ChemmolreprcifSlice, i : Int, v : Double) -> ChemmolreprcifSlice {
  let result = chem_mol_repr_cif_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_slice_sum(s : ChemmolreprcifSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_cif_slice_mean(s : ChemmolreprcifSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_cif_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_cif_slice_scale(s : ChemmolreprcifSlice, f : Double) -> ChemmolreprcifSlice {
  let result = chem_mol_repr_cif_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_cif_slice_add(a : ChemmolreprcifSlice, b : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_cif_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_cif_slice_copy(s : ChemmolreprcifSlice) -> ChemmolreprcifSlice {
  let result = chem_mol_repr_cif_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_cif_slice_fill(s : ChemmolreprcifSlice, v : Double) -> ChemmolreprcifSlice {
  let result = chem_mol_repr_cif_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_cif_slice_min(s : ChemmolreprcifSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_slice_max(s : ChemmolreprcifSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_cif_slice_to_string(s : ChemmolreprcifSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_mol_repr_cif_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_repr_cif_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


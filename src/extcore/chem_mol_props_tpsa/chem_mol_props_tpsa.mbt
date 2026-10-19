///===
/// extcore/chem_mol_props_tpsa

pub(all) struct ChemmolpropstpsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_tpsa_make_point(x : Double, y : Double) -> ChemmolpropstpsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_tpsa_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropstpsaPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_tpsa_point_x(pt : ChemmolpropstpsaPoint) -> Double { pt.x }

pub fn chem_mol_props_tpsa_point_y(pt : ChemmolpropstpsaPoint) -> Double { pt.y }

pub fn chem_mol_props_tpsa_point_z(pt : ChemmolpropstpsaPoint) -> Double { pt.z }

pub fn chem_mol_props_tpsa_point_label(pt : ChemmolpropstpsaPoint) -> Int { pt.label }

pub fn chem_mol_props_tpsa_point_dist(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_mol_props_tpsa_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_tpsa_point_add(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_tpsa_point_sub(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_tpsa_point_scale(pt : ChemmolpropstpsaPoint, s : Double) -> ChemmolpropstpsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_tpsa_point_dot(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_tpsa_point_cross(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_tpsa_point_norm(pt : ChemmolpropstpsaPoint) -> Double {
  chem_mol_props_tpsa_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_tpsa_point_normalize(pt : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  let n = chem_mol_props_tpsa_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_tpsa_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_tpsa_point_negate(pt : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_tpsa_point_mid(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint) -> ChemmolpropstpsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_tpsa_point_lerp(a : ChemmolpropstpsaPoint, b : ChemmolpropstpsaPoint, t : Double) -> ChemmolpropstpsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_tpsa_point_to_string(pt : ChemmolpropstpsaPoint) -> String {
  "(" + chem_mol_props_tpsa_dbl(pt.x) + ", " + chem_mol_props_tpsa_dbl(pt.y) + ", " + chem_mol_props_tpsa_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_tpsa_make_series(vals : Array[Double], name : String) -> ChemmolpropstpsaSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_tpsa_series_len(s : ChemmolpropstpsaSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_tpsa_series_sum(s : ChemmolpropstpsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_tpsa_series_mean(s : ChemmolpropstpsaSeries) -> Double {
  let n = chem_mol_props_tpsa_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_props_tpsa_series_sum(s) / n.to_double() }
}

pub fn chem_mol_props_tpsa_series_min(s : ChemmolpropstpsaSeries) -> Double {
  let n = chem_mol_props_tpsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_series_max(s : ChemmolpropstpsaSeries) -> Double {
  let n = chem_mol_props_tpsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_series_range(s : ChemmolpropstpsaSeries) -> Double {
  chem_mol_props_tpsa_series_max(s) - chem_mol_props_tpsa_series_min(s)
}

pub fn chem_mol_props_tpsa_series_var(s : ChemmolpropstpsaSeries) -> Double {
  let n = chem_mol_props_tpsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_tpsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_series_std(s : ChemmolpropstpsaSeries) -> Double { chem_mol_props_tpsa_sqrt(chem_mol_props_tpsa_series_var(s)) }

pub fn chem_mol_props_tpsa_series_median(s : ChemmolpropstpsaSeries) -> Double {
  let n = chem_mol_props_tpsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_tpsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_tpsa_series_scale(s : ChemmolpropstpsaSeries, f : Double) -> ChemmolpropstpsaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_mol_props_tpsa_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_tpsa_series_add(a : ChemmolpropstpsaSeries, b : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_tpsa_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_tpsa_series_sub(a : ChemmolpropstpsaSeries, b : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_tpsa_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_tpsa_series_normalize(s : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let mn = chem_mol_props_tpsa_series_min(s)
  let mx = chem_mol_props_tpsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_mol_props_tpsa_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_tpsa_series_cumsum(s : ChemmolpropstpsaSeries) -> ChemmolpropstpsaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_mol_props_tpsa_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_tpsa_series_to_string(s : ChemmolpropstpsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_props_tpsa_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropstpsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_tpsa_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropstpsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_tpsa_matrix_identity(n : Int) -> ChemmolpropstpsaMatrix {
  let m = chem_mol_props_tpsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_tpsa_matrix_get(m : ChemmolpropstpsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_tpsa_matrix_transpose(m : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_tpsa_matrix_add(a : ChemmolpropstpsaMatrix, b : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_tpsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_tpsa_matrix_scale(m : ChemmolpropstpsaMatrix, s : Double) -> ChemmolpropstpsaMatrix {
  let result = chem_mol_props_tpsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_tpsa_matrix_multiply(a : ChemmolpropstpsaMatrix, b : ChemmolpropstpsaMatrix) -> ChemmolpropstpsaMatrix {
  if a.cols != b.rows { return chem_mol_props_tpsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_tpsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_tpsa_matrix_trace(m : ChemmolpropstpsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_tpsa_matrix_det(m : ChemmolpropstpsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_tpsa_matrix_norm(m : ChemmolpropstpsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_mol_props_tpsa_sqrt(sum)
}

pub fn chem_mol_props_tpsa_matrix_to_string(m : ChemmolpropstpsaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_mol_props_tpsa_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolpropstpsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_tpsa_make_vector(comps : Array[Double]) -> ChemmolpropstpsaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_tpsa_vector_zero(dim : Int) -> ChemmolpropstpsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_tpsa_vector_add(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_tpsa_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_tpsa_vector_sub(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_tpsa_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_tpsa_vector_scale(v : ChemmolpropstpsaVector, s : Double) -> ChemmolpropstpsaVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_mol_props_tpsa_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_tpsa_vector_dot(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_tpsa_vector_norm(v : ChemmolpropstpsaVector) -> Double { chem_mol_props_tpsa_sqrt(chem_mol_props_tpsa_vector_dot(v, v)) }

pub fn chem_mol_props_tpsa_vector_normalize(v : ChemmolpropstpsaVector) -> ChemmolpropstpsaVector {
  let n = chem_mol_props_tpsa_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_tpsa_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_tpsa_vector_dist(a : ChemmolpropstpsaVector, b : ChemmolpropstpsaVector) -> Double {
  chem_mol_props_tpsa_vector_norm(chem_mol_props_tpsa_vector_sub(a, b))
}

pub fn chem_mol_props_tpsa_vector_to_string(v : ChemmolpropstpsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_props_tpsa_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_tpsa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_tpsa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_std(data : Array[Double]) -> Double { chem_mol_props_tpsa_sqrt(chem_mol_props_tpsa_var(data)) }

pub fn chem_mol_props_tpsa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_props_tpsa_mean(a); let mb = chem_mol_props_tpsa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_props_tpsa_std(a); let sb = chem_mol_props_tpsa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_props_tpsa_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_props_tpsa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_tpsa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_tpsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_mol_props_tpsa_sqrt(chem_mol_props_tpsa_mse(pred, labels))
}

pub fn chem_mol_props_tpsa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_mol_props_tpsa_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_props_tpsa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_props_tpsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_props_tpsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_props_tpsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_props_tpsa_precision(pred, labels, pos); let r = chem_mol_props_tpsa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_props_tpsa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_props_tpsa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_props_tpsa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_props_tpsa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_props_tpsa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_props_tpsa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_props_tpsa_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_props_tpsa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_props_tpsa_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_props_tpsa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_props_tpsa_min(data); let mx = chem_mol_props_tpsa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_props_tpsa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_props_tpsa_mean(data); let sd = chem_mol_props_tpsa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_props_tpsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_props_tpsa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_props_tpsa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_props_tpsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_mol_props_tpsa_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_mol_props_tpsa_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_mol_props_tpsa_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_mol_props_tpsa_int(x) } else { -chem_mol_props_tpsa_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_mol_props_tpsa_int(f * 1000000.0) } else { chem_mol_props_tpsa_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_mol_props_tpsa_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_mol_props_tpsa_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemmolpropstpsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_frame_make(size : Int) -> ChemmolpropstpsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_frame_len(s : ChemmolpropstpsaFrame) -> Int { s.size }

pub fn chem_mol_props_tpsa_frame_get(s : ChemmolpropstpsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_frame_set(s : ChemmolpropstpsaFrame, i : Int, v : Double) -> ChemmolpropstpsaFrame {
  let result = chem_mol_props_tpsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_frame_sum(s : ChemmolpropstpsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_frame_mean(s : ChemmolpropstpsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_frame_scale(s : ChemmolpropstpsaFrame, f : Double) -> ChemmolpropstpsaFrame {
  let result = chem_mol_props_tpsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_frame_add(a : ChemmolpropstpsaFrame, b : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_frame_copy(s : ChemmolpropstpsaFrame) -> ChemmolpropstpsaFrame {
  let result = chem_mol_props_tpsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_frame_fill(s : ChemmolpropstpsaFrame, v : Double) -> ChemmolpropstpsaFrame {
  let result = chem_mol_props_tpsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_frame_min(s : ChemmolpropstpsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_frame_max(s : ChemmolpropstpsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_frame_to_string(s : ChemmolpropstpsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_table_make(size : Int) -> ChemmolpropstpsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_table_len(s : ChemmolpropstpsaTable) -> Int { s.size }

pub fn chem_mol_props_tpsa_table_get(s : ChemmolpropstpsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_table_set(s : ChemmolpropstpsaTable, i : Int, v : Double) -> ChemmolpropstpsaTable {
  let result = chem_mol_props_tpsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_table_sum(s : ChemmolpropstpsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_table_mean(s : ChemmolpropstpsaTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_table_scale(s : ChemmolpropstpsaTable, f : Double) -> ChemmolpropstpsaTable {
  let result = chem_mol_props_tpsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_table_add(a : ChemmolpropstpsaTable, b : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_table_copy(s : ChemmolpropstpsaTable) -> ChemmolpropstpsaTable {
  let result = chem_mol_props_tpsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_table_fill(s : ChemmolpropstpsaTable, v : Double) -> ChemmolpropstpsaTable {
  let result = chem_mol_props_tpsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_table_min(s : ChemmolpropstpsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_table_max(s : ChemmolpropstpsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_table_to_string(s : ChemmolpropstpsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_graphn_make(size : Int) -> ChemmolpropstpsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_graphn_len(s : ChemmolpropstpsaGraphN) -> Int { s.size }

pub fn chem_mol_props_tpsa_graphn_get(s : ChemmolpropstpsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_graphn_set(s : ChemmolpropstpsaGraphN, i : Int, v : Double) -> ChemmolpropstpsaGraphN {
  let result = chem_mol_props_tpsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_graphn_sum(s : ChemmolpropstpsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_graphn_mean(s : ChemmolpropstpsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_graphn_scale(s : ChemmolpropstpsaGraphN, f : Double) -> ChemmolpropstpsaGraphN {
  let result = chem_mol_props_tpsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_graphn_add(a : ChemmolpropstpsaGraphN, b : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_graphn_copy(s : ChemmolpropstpsaGraphN) -> ChemmolpropstpsaGraphN {
  let result = chem_mol_props_tpsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_graphn_fill(s : ChemmolpropstpsaGraphN, v : Double) -> ChemmolpropstpsaGraphN {
  let result = chem_mol_props_tpsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_graphn_min(s : ChemmolpropstpsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_graphn_max(s : ChemmolpropstpsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_graphn_to_string(s : ChemmolpropstpsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_node_make(size : Int) -> ChemmolpropstpsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_node_len(s : ChemmolpropstpsaNode) -> Int { s.size }

pub fn chem_mol_props_tpsa_node_get(s : ChemmolpropstpsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_node_set(s : ChemmolpropstpsaNode, i : Int, v : Double) -> ChemmolpropstpsaNode {
  let result = chem_mol_props_tpsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_node_sum(s : ChemmolpropstpsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_node_mean(s : ChemmolpropstpsaNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_node_scale(s : ChemmolpropstpsaNode, f : Double) -> ChemmolpropstpsaNode {
  let result = chem_mol_props_tpsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_node_add(a : ChemmolpropstpsaNode, b : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_node_copy(s : ChemmolpropstpsaNode) -> ChemmolpropstpsaNode {
  let result = chem_mol_props_tpsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_node_fill(s : ChemmolpropstpsaNode, v : Double) -> ChemmolpropstpsaNode {
  let result = chem_mol_props_tpsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_node_min(s : ChemmolpropstpsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_node_max(s : ChemmolpropstpsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_node_to_string(s : ChemmolpropstpsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_edge_make(size : Int) -> ChemmolpropstpsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_edge_len(s : ChemmolpropstpsaEdge) -> Int { s.size }

pub fn chem_mol_props_tpsa_edge_get(s : ChemmolpropstpsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_edge_set(s : ChemmolpropstpsaEdge, i : Int, v : Double) -> ChemmolpropstpsaEdge {
  let result = chem_mol_props_tpsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_edge_sum(s : ChemmolpropstpsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_edge_mean(s : ChemmolpropstpsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_edge_scale(s : ChemmolpropstpsaEdge, f : Double) -> ChemmolpropstpsaEdge {
  let result = chem_mol_props_tpsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_edge_add(a : ChemmolpropstpsaEdge, b : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_edge_copy(s : ChemmolpropstpsaEdge) -> ChemmolpropstpsaEdge {
  let result = chem_mol_props_tpsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_edge_fill(s : ChemmolpropstpsaEdge, v : Double) -> ChemmolpropstpsaEdge {
  let result = chem_mol_props_tpsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_edge_min(s : ChemmolpropstpsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_edge_max(s : ChemmolpropstpsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_edge_to_string(s : ChemmolpropstpsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_path_make(size : Int) -> ChemmolpropstpsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_path_len(s : ChemmolpropstpsaPath) -> Int { s.size }

pub fn chem_mol_props_tpsa_path_get(s : ChemmolpropstpsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_path_set(s : ChemmolpropstpsaPath, i : Int, v : Double) -> ChemmolpropstpsaPath {
  let result = chem_mol_props_tpsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_path_sum(s : ChemmolpropstpsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_path_mean(s : ChemmolpropstpsaPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_path_scale(s : ChemmolpropstpsaPath, f : Double) -> ChemmolpropstpsaPath {
  let result = chem_mol_props_tpsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_path_add(a : ChemmolpropstpsaPath, b : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_path_copy(s : ChemmolpropstpsaPath) -> ChemmolpropstpsaPath {
  let result = chem_mol_props_tpsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_path_fill(s : ChemmolpropstpsaPath, v : Double) -> ChemmolpropstpsaPath {
  let result = chem_mol_props_tpsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_path_min(s : ChemmolpropstpsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_path_max(s : ChemmolpropstpsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_path_to_string(s : ChemmolpropstpsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cluster_make(size : Int) -> ChemmolpropstpsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cluster_len(s : ChemmolpropstpsaCluster) -> Int { s.size }

pub fn chem_mol_props_tpsa_cluster_get(s : ChemmolpropstpsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cluster_set(s : ChemmolpropstpsaCluster, i : Int, v : Double) -> ChemmolpropstpsaCluster {
  let result = chem_mol_props_tpsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_cluster_sum(s : ChemmolpropstpsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_cluster_mean(s : ChemmolpropstpsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_cluster_scale(s : ChemmolpropstpsaCluster, f : Double) -> ChemmolpropstpsaCluster {
  let result = chem_mol_props_tpsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_cluster_add(a : ChemmolpropstpsaCluster, b : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_cluster_copy(s : ChemmolpropstpsaCluster) -> ChemmolpropstpsaCluster {
  let result = chem_mol_props_tpsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_cluster_fill(s : ChemmolpropstpsaCluster, v : Double) -> ChemmolpropstpsaCluster {
  let result = chem_mol_props_tpsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_cluster_min(s : ChemmolpropstpsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_cluster_max(s : ChemmolpropstpsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_cluster_to_string(s : ChemmolpropstpsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_model_make(size : Int) -> ChemmolpropstpsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_model_len(s : ChemmolpropstpsaModel) -> Int { s.size }

pub fn chem_mol_props_tpsa_model_get(s : ChemmolpropstpsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_model_set(s : ChemmolpropstpsaModel, i : Int, v : Double) -> ChemmolpropstpsaModel {
  let result = chem_mol_props_tpsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_model_sum(s : ChemmolpropstpsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_model_mean(s : ChemmolpropstpsaModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_model_scale(s : ChemmolpropstpsaModel, f : Double) -> ChemmolpropstpsaModel {
  let result = chem_mol_props_tpsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_model_add(a : ChemmolpropstpsaModel, b : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_model_copy(s : ChemmolpropstpsaModel) -> ChemmolpropstpsaModel {
  let result = chem_mol_props_tpsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_model_fill(s : ChemmolpropstpsaModel, v : Double) -> ChemmolpropstpsaModel {
  let result = chem_mol_props_tpsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_model_min(s : ChemmolpropstpsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_model_max(s : ChemmolpropstpsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_model_to_string(s : ChemmolpropstpsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_layer_make(size : Int) -> ChemmolpropstpsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_layer_len(s : ChemmolpropstpsaLayer) -> Int { s.size }

pub fn chem_mol_props_tpsa_layer_get(s : ChemmolpropstpsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_layer_set(s : ChemmolpropstpsaLayer, i : Int, v : Double) -> ChemmolpropstpsaLayer {
  let result = chem_mol_props_tpsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_layer_sum(s : ChemmolpropstpsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_layer_mean(s : ChemmolpropstpsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_layer_scale(s : ChemmolpropstpsaLayer, f : Double) -> ChemmolpropstpsaLayer {
  let result = chem_mol_props_tpsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_layer_add(a : ChemmolpropstpsaLayer, b : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_layer_copy(s : ChemmolpropstpsaLayer) -> ChemmolpropstpsaLayer {
  let result = chem_mol_props_tpsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_layer_fill(s : ChemmolpropstpsaLayer, v : Double) -> ChemmolpropstpsaLayer {
  let result = chem_mol_props_tpsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_layer_min(s : ChemmolpropstpsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_layer_max(s : ChemmolpropstpsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_layer_to_string(s : ChemmolpropstpsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_buffer_make(size : Int) -> ChemmolpropstpsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_buffer_len(s : ChemmolpropstpsaBuffer) -> Int { s.size }

pub fn chem_mol_props_tpsa_buffer_get(s : ChemmolpropstpsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_buffer_set(s : ChemmolpropstpsaBuffer, i : Int, v : Double) -> ChemmolpropstpsaBuffer {
  let result = chem_mol_props_tpsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_buffer_sum(s : ChemmolpropstpsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_buffer_mean(s : ChemmolpropstpsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_buffer_scale(s : ChemmolpropstpsaBuffer, f : Double) -> ChemmolpropstpsaBuffer {
  let result = chem_mol_props_tpsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_buffer_add(a : ChemmolpropstpsaBuffer, b : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_buffer_copy(s : ChemmolpropstpsaBuffer) -> ChemmolpropstpsaBuffer {
  let result = chem_mol_props_tpsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_buffer_fill(s : ChemmolpropstpsaBuffer, v : Double) -> ChemmolpropstpsaBuffer {
  let result = chem_mol_props_tpsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_buffer_min(s : ChemmolpropstpsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_buffer_max(s : ChemmolpropstpsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_buffer_to_string(s : ChemmolpropstpsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_cursor_make(size : Int) -> ChemmolpropstpsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_cursor_len(s : ChemmolpropstpsaCursor) -> Int { s.size }

pub fn chem_mol_props_tpsa_cursor_get(s : ChemmolpropstpsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_cursor_set(s : ChemmolpropstpsaCursor, i : Int, v : Double) -> ChemmolpropstpsaCursor {
  let result = chem_mol_props_tpsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_cursor_sum(s : ChemmolpropstpsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_cursor_mean(s : ChemmolpropstpsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_cursor_scale(s : ChemmolpropstpsaCursor, f : Double) -> ChemmolpropstpsaCursor {
  let result = chem_mol_props_tpsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_cursor_add(a : ChemmolpropstpsaCursor, b : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_cursor_copy(s : ChemmolpropstpsaCursor) -> ChemmolpropstpsaCursor {
  let result = chem_mol_props_tpsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_cursor_fill(s : ChemmolpropstpsaCursor, v : Double) -> ChemmolpropstpsaCursor {
  let result = chem_mol_props_tpsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_cursor_min(s : ChemmolpropstpsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_cursor_max(s : ChemmolpropstpsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_cursor_to_string(s : ChemmolpropstpsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_view_make(size : Int) -> ChemmolpropstpsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_view_len(s : ChemmolpropstpsaView) -> Int { s.size }

pub fn chem_mol_props_tpsa_view_get(s : ChemmolpropstpsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_view_set(s : ChemmolpropstpsaView, i : Int, v : Double) -> ChemmolpropstpsaView {
  let result = chem_mol_props_tpsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_view_sum(s : ChemmolpropstpsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_view_mean(s : ChemmolpropstpsaView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_view_scale(s : ChemmolpropstpsaView, f : Double) -> ChemmolpropstpsaView {
  let result = chem_mol_props_tpsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_view_add(a : ChemmolpropstpsaView, b : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_view_copy(s : ChemmolpropstpsaView) -> ChemmolpropstpsaView {
  let result = chem_mol_props_tpsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_view_fill(s : ChemmolpropstpsaView, v : Double) -> ChemmolpropstpsaView {
  let result = chem_mol_props_tpsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_view_min(s : ChemmolpropstpsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_view_max(s : ChemmolpropstpsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_view_to_string(s : ChemmolpropstpsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_range_make(size : Int) -> ChemmolpropstpsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_range_len(s : ChemmolpropstpsaRange) -> Int { s.size }

pub fn chem_mol_props_tpsa_range_get(s : ChemmolpropstpsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_range_set(s : ChemmolpropstpsaRange, i : Int, v : Double) -> ChemmolpropstpsaRange {
  let result = chem_mol_props_tpsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_range_sum(s : ChemmolpropstpsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_range_mean(s : ChemmolpropstpsaRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_range_scale(s : ChemmolpropstpsaRange, f : Double) -> ChemmolpropstpsaRange {
  let result = chem_mol_props_tpsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_range_add(a : ChemmolpropstpsaRange, b : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_range_copy(s : ChemmolpropstpsaRange) -> ChemmolpropstpsaRange {
  let result = chem_mol_props_tpsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_range_fill(s : ChemmolpropstpsaRange, v : Double) -> ChemmolpropstpsaRange {
  let result = chem_mol_props_tpsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_range_min(s : ChemmolpropstpsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_range_max(s : ChemmolpropstpsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_range_to_string(s : ChemmolpropstpsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropstpsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_tpsa_slice_make(size : Int) -> ChemmolpropstpsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_tpsa_slice_len(s : ChemmolpropstpsaSlice) -> Int { s.size }

pub fn chem_mol_props_tpsa_slice_get(s : ChemmolpropstpsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_tpsa_slice_set(s : ChemmolpropstpsaSlice, i : Int, v : Double) -> ChemmolpropstpsaSlice {
  let result = chem_mol_props_tpsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_slice_sum(s : ChemmolpropstpsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_tpsa_slice_mean(s : ChemmolpropstpsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_tpsa_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_tpsa_slice_scale(s : ChemmolpropstpsaSlice, f : Double) -> ChemmolpropstpsaSlice {
  let result = chem_mol_props_tpsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_tpsa_slice_add(a : ChemmolpropstpsaSlice, b : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_tpsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_tpsa_slice_copy(s : ChemmolpropstpsaSlice) -> ChemmolpropstpsaSlice {
  let result = chem_mol_props_tpsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_tpsa_slice_fill(s : ChemmolpropstpsaSlice, v : Double) -> ChemmolpropstpsaSlice {
  let result = chem_mol_props_tpsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_tpsa_slice_min(s : ChemmolpropstpsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_slice_max(s : ChemmolpropstpsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_tpsa_slice_to_string(s : ChemmolpropstpsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_mol_props_tpsa_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_tpsa_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


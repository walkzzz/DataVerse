///===
/// extcore/opt_convex_l_bfgs

pub(all) struct OptconvexlbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_l_bfgs_make_point(x : Double, y : Double) -> OptconvexlbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_l_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexlbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_l_bfgs_point_x(pt : OptconvexlbfgsPoint) -> Double { pt.x }

pub fn opt_convex_l_bfgs_point_y(pt : OptconvexlbfgsPoint) -> Double { pt.y }

pub fn opt_convex_l_bfgs_point_z(pt : OptconvexlbfgsPoint) -> Double { pt.z }

pub fn opt_convex_l_bfgs_point_label(pt : OptconvexlbfgsPoint) -> Int { pt.label }

pub fn opt_convex_l_bfgs_point_dist(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_convex_l_bfgs_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_l_bfgs_point_add(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_l_bfgs_point_sub(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_l_bfgs_point_scale(pt : OptconvexlbfgsPoint, s : Double) -> OptconvexlbfgsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_l_bfgs_point_dot(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_l_bfgs_point_cross(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_l_bfgs_point_norm(pt : OptconvexlbfgsPoint) -> Double {
  opt_convex_l_bfgs_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_l_bfgs_point_normalize(pt : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  let n = opt_convex_l_bfgs_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_l_bfgs_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_l_bfgs_point_negate(pt : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_l_bfgs_point_mid(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_l_bfgs_point_lerp(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint, t : Double) -> OptconvexlbfgsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_l_bfgs_point_to_string(pt : OptconvexlbfgsPoint) -> String {
  "(" + opt_convex_l_bfgs_dbl(pt.x) + ", " + opt_convex_l_bfgs_dbl(pt.y) + ", " + opt_convex_l_bfgs_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_l_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexlbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_l_bfgs_series_len(s : OptconvexlbfgsSeries) -> Int { s.vals.length() }

pub fn opt_convex_l_bfgs_series_sum(s : OptconvexlbfgsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_l_bfgs_series_mean(s : OptconvexlbfgsSeries) -> Double {
  let n = opt_convex_l_bfgs_series_len(s)
  if n == 0 { 0.0 } else { opt_convex_l_bfgs_series_sum(s) / n.to_double() }
}

pub fn opt_convex_l_bfgs_series_min(s : OptconvexlbfgsSeries) -> Double {
  let n = opt_convex_l_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_series_max(s : OptconvexlbfgsSeries) -> Double {
  let n = opt_convex_l_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_series_range(s : OptconvexlbfgsSeries) -> Double {
  opt_convex_l_bfgs_series_max(s) - opt_convex_l_bfgs_series_min(s)
}

pub fn opt_convex_l_bfgs_series_var(s : OptconvexlbfgsSeries) -> Double {
  let n = opt_convex_l_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_convex_l_bfgs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_series_std(s : OptconvexlbfgsSeries) -> Double { opt_convex_l_bfgs_sqrt(opt_convex_l_bfgs_series_var(s)) }

pub fn opt_convex_l_bfgs_series_median(s : OptconvexlbfgsSeries) -> Double {
  let n = opt_convex_l_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_l_bfgs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_l_bfgs_series_scale(s : OptconvexlbfgsSeries, f : Double) -> OptconvexlbfgsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_convex_l_bfgs_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_l_bfgs_series_add(a : OptconvexlbfgsSeries, b : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_convex_l_bfgs_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_l_bfgs_series_sub(a : OptconvexlbfgsSeries, b : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_convex_l_bfgs_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_l_bfgs_series_normalize(s : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let mn = opt_convex_l_bfgs_series_min(s)
  let mx = opt_convex_l_bfgs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_convex_l_bfgs_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_l_bfgs_series_cumsum(s : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_convex_l_bfgs_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_l_bfgs_series_to_string(s : OptconvexlbfgsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_convex_l_bfgs_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_l_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_l_bfgs_matrix_identity(n : Int) -> OptconvexlbfgsMatrix {
  let m = opt_convex_l_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_l_bfgs_matrix_get(m : OptconvexlbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_l_bfgs_matrix_transpose(m : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_l_bfgs_matrix_add(a : OptconvexlbfgsMatrix, b : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_l_bfgs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_l_bfgs_matrix_scale(m : OptconvexlbfgsMatrix, s : Double) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_l_bfgs_matrix_multiply(a : OptconvexlbfgsMatrix, b : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if a.cols != b.rows { return opt_convex_l_bfgs_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_l_bfgs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_l_bfgs_matrix_trace(m : OptconvexlbfgsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_l_bfgs_matrix_det(m : OptconvexlbfgsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_l_bfgs_matrix_norm(m : OptconvexlbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_convex_l_bfgs_sqrt(sum)
}

pub fn opt_convex_l_bfgs_matrix_to_string(m : OptconvexlbfgsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_convex_l_bfgs_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptconvexlbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_l_bfgs_make_vector(comps : Array[Double]) -> OptconvexlbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_l_bfgs_vector_zero(dim : Int) -> OptconvexlbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_l_bfgs_vector_add(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_convex_l_bfgs_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_l_bfgs_vector_sub(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_convex_l_bfgs_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_l_bfgs_vector_scale(v : OptconvexlbfgsVector, s : Double) -> OptconvexlbfgsVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_convex_l_bfgs_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_l_bfgs_vector_dot(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_l_bfgs_vector_norm(v : OptconvexlbfgsVector) -> Double { opt_convex_l_bfgs_sqrt(opt_convex_l_bfgs_vector_dot(v, v)) }

pub fn opt_convex_l_bfgs_vector_normalize(v : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = opt_convex_l_bfgs_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_l_bfgs_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_l_bfgs_vector_dist(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> Double {
  opt_convex_l_bfgs_vector_norm(opt_convex_l_bfgs_vector_sub(a, b))
}

pub fn opt_convex_l_bfgs_vector_to_string(v : OptconvexlbfgsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_convex_l_bfgs_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_l_bfgs_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_convex_l_bfgs_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_std(data : Array[Double]) -> Double { opt_convex_l_bfgs_sqrt(opt_convex_l_bfgs_var(data)) }

pub fn opt_convex_l_bfgs_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_convex_l_bfgs_mean(a); let mb = opt_convex_l_bfgs_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_convex_l_bfgs_std(a); let sb = opt_convex_l_bfgs_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_convex_l_bfgs_cov(a, b) / (sa * sb) }
}

pub fn opt_convex_l_bfgs_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_l_bfgs_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_l_bfgs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_convex_l_bfgs_sqrt(opt_convex_l_bfgs_mse(pred, labels))
}

pub fn opt_convex_l_bfgs_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_convex_l_bfgs_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_convex_l_bfgs_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_convex_l_bfgs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_convex_l_bfgs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_convex_l_bfgs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_convex_l_bfgs_precision(pred, labels, pos); let r = opt_convex_l_bfgs_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_convex_l_bfgs_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_convex_l_bfgs_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_convex_l_bfgs_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_convex_l_bfgs_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_convex_l_bfgs_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_convex_l_bfgs_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_convex_l_bfgs_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_convex_l_bfgs_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_convex_l_bfgs_fibonacci(n : Int) -> Int {
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

pub fn opt_convex_l_bfgs_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_convex_l_bfgs_min(data); let mx = opt_convex_l_bfgs_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_convex_l_bfgs_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_convex_l_bfgs_mean(data); let sd = opt_convex_l_bfgs_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_convex_l_bfgs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_convex_l_bfgs_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_convex_l_bfgs_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_convex_l_bfgs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_convex_l_bfgs_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_convex_l_bfgs_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_convex_l_bfgs_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_convex_l_bfgs_int(x) } else { -opt_convex_l_bfgs_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_convex_l_bfgs_int(f * 1000000.0) } else { opt_convex_l_bfgs_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_convex_l_bfgs_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_convex_l_bfgs_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptconvexlbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_frame_make(size : Int) -> OptconvexlbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_frame_len(s : OptconvexlbfgsFrame) -> Int { s.size }

pub fn opt_convex_l_bfgs_frame_get(s : OptconvexlbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_frame_set(s : OptconvexlbfgsFrame, i : Int, v : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_frame_sum(s : OptconvexlbfgsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_frame_mean(s : OptconvexlbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_frame_scale(s : OptconvexlbfgsFrame, f : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_frame_add(a : OptconvexlbfgsFrame, b : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_frame_copy(s : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_frame_fill(s : OptconvexlbfgsFrame, v : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_frame_min(s : OptconvexlbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_frame_max(s : OptconvexlbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_frame_to_string(s : OptconvexlbfgsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_table_make(size : Int) -> OptconvexlbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_table_len(s : OptconvexlbfgsTable) -> Int { s.size }

pub fn opt_convex_l_bfgs_table_get(s : OptconvexlbfgsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_table_set(s : OptconvexlbfgsTable, i : Int, v : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_table_sum(s : OptconvexlbfgsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_table_mean(s : OptconvexlbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_table_scale(s : OptconvexlbfgsTable, f : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_table_add(a : OptconvexlbfgsTable, b : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_table_copy(s : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_table_fill(s : OptconvexlbfgsTable, v : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_table_min(s : OptconvexlbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_table_max(s : OptconvexlbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_table_to_string(s : OptconvexlbfgsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_graphn_make(size : Int) -> OptconvexlbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_graphn_len(s : OptconvexlbfgsGraphN) -> Int { s.size }

pub fn opt_convex_l_bfgs_graphn_get(s : OptconvexlbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_graphn_set(s : OptconvexlbfgsGraphN, i : Int, v : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_graphn_sum(s : OptconvexlbfgsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_graphn_mean(s : OptconvexlbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_graphn_scale(s : OptconvexlbfgsGraphN, f : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_graphn_add(a : OptconvexlbfgsGraphN, b : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_graphn_copy(s : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_graphn_fill(s : OptconvexlbfgsGraphN, v : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_graphn_min(s : OptconvexlbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_graphn_max(s : OptconvexlbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_graphn_to_string(s : OptconvexlbfgsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_node_make(size : Int) -> OptconvexlbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_node_len(s : OptconvexlbfgsNode) -> Int { s.size }

pub fn opt_convex_l_bfgs_node_get(s : OptconvexlbfgsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_node_set(s : OptconvexlbfgsNode, i : Int, v : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_node_sum(s : OptconvexlbfgsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_node_mean(s : OptconvexlbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_node_scale(s : OptconvexlbfgsNode, f : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_node_add(a : OptconvexlbfgsNode, b : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_node_copy(s : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_node_fill(s : OptconvexlbfgsNode, v : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_node_min(s : OptconvexlbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_node_max(s : OptconvexlbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_node_to_string(s : OptconvexlbfgsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_edge_make(size : Int) -> OptconvexlbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_edge_len(s : OptconvexlbfgsEdge) -> Int { s.size }

pub fn opt_convex_l_bfgs_edge_get(s : OptconvexlbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_edge_set(s : OptconvexlbfgsEdge, i : Int, v : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_edge_sum(s : OptconvexlbfgsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_edge_mean(s : OptconvexlbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_edge_scale(s : OptconvexlbfgsEdge, f : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_edge_add(a : OptconvexlbfgsEdge, b : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_edge_copy(s : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_edge_fill(s : OptconvexlbfgsEdge, v : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_edge_min(s : OptconvexlbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_edge_max(s : OptconvexlbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_edge_to_string(s : OptconvexlbfgsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_path_make(size : Int) -> OptconvexlbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_path_len(s : OptconvexlbfgsPath) -> Int { s.size }

pub fn opt_convex_l_bfgs_path_get(s : OptconvexlbfgsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_path_set(s : OptconvexlbfgsPath, i : Int, v : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_path_sum(s : OptconvexlbfgsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_path_mean(s : OptconvexlbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_path_scale(s : OptconvexlbfgsPath, f : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_path_add(a : OptconvexlbfgsPath, b : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_path_copy(s : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_path_fill(s : OptconvexlbfgsPath, v : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_path_min(s : OptconvexlbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_path_max(s : OptconvexlbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_path_to_string(s : OptconvexlbfgsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cluster_make(size : Int) -> OptconvexlbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cluster_len(s : OptconvexlbfgsCluster) -> Int { s.size }

pub fn opt_convex_l_bfgs_cluster_get(s : OptconvexlbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cluster_set(s : OptconvexlbfgsCluster, i : Int, v : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cluster_sum(s : OptconvexlbfgsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_cluster_mean(s : OptconvexlbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_cluster_scale(s : OptconvexlbfgsCluster, f : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_cluster_add(a : OptconvexlbfgsCluster, b : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cluster_copy(s : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cluster_fill(s : OptconvexlbfgsCluster, v : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cluster_min(s : OptconvexlbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_cluster_max(s : OptconvexlbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_cluster_to_string(s : OptconvexlbfgsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_model_make(size : Int) -> OptconvexlbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_model_len(s : OptconvexlbfgsModel) -> Int { s.size }

pub fn opt_convex_l_bfgs_model_get(s : OptconvexlbfgsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_model_set(s : OptconvexlbfgsModel, i : Int, v : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_model_sum(s : OptconvexlbfgsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_model_mean(s : OptconvexlbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_model_scale(s : OptconvexlbfgsModel, f : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_model_add(a : OptconvexlbfgsModel, b : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_model_copy(s : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_model_fill(s : OptconvexlbfgsModel, v : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_model_min(s : OptconvexlbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_model_max(s : OptconvexlbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_model_to_string(s : OptconvexlbfgsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_layer_make(size : Int) -> OptconvexlbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_layer_len(s : OptconvexlbfgsLayer) -> Int { s.size }

pub fn opt_convex_l_bfgs_layer_get(s : OptconvexlbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_layer_set(s : OptconvexlbfgsLayer, i : Int, v : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_layer_sum(s : OptconvexlbfgsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_layer_mean(s : OptconvexlbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_layer_scale(s : OptconvexlbfgsLayer, f : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_layer_add(a : OptconvexlbfgsLayer, b : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_layer_copy(s : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_layer_fill(s : OptconvexlbfgsLayer, v : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_layer_min(s : OptconvexlbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_layer_max(s : OptconvexlbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_layer_to_string(s : OptconvexlbfgsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_buffer_make(size : Int) -> OptconvexlbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_buffer_len(s : OptconvexlbfgsBuffer) -> Int { s.size }

pub fn opt_convex_l_bfgs_buffer_get(s : OptconvexlbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_buffer_set(s : OptconvexlbfgsBuffer, i : Int, v : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_buffer_sum(s : OptconvexlbfgsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_buffer_mean(s : OptconvexlbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_buffer_scale(s : OptconvexlbfgsBuffer, f : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_buffer_add(a : OptconvexlbfgsBuffer, b : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_buffer_copy(s : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_buffer_fill(s : OptconvexlbfgsBuffer, v : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_buffer_min(s : OptconvexlbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_buffer_max(s : OptconvexlbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_buffer_to_string(s : OptconvexlbfgsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cursor_make(size : Int) -> OptconvexlbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cursor_len(s : OptconvexlbfgsCursor) -> Int { s.size }

pub fn opt_convex_l_bfgs_cursor_get(s : OptconvexlbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cursor_set(s : OptconvexlbfgsCursor, i : Int, v : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cursor_sum(s : OptconvexlbfgsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_cursor_mean(s : OptconvexlbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_cursor_scale(s : OptconvexlbfgsCursor, f : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_cursor_add(a : OptconvexlbfgsCursor, b : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cursor_copy(s : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cursor_fill(s : OptconvexlbfgsCursor, v : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cursor_min(s : OptconvexlbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_cursor_max(s : OptconvexlbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_cursor_to_string(s : OptconvexlbfgsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_view_make(size : Int) -> OptconvexlbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_view_len(s : OptconvexlbfgsView) -> Int { s.size }

pub fn opt_convex_l_bfgs_view_get(s : OptconvexlbfgsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_view_set(s : OptconvexlbfgsView, i : Int, v : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_view_sum(s : OptconvexlbfgsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_view_mean(s : OptconvexlbfgsView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_view_scale(s : OptconvexlbfgsView, f : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_view_add(a : OptconvexlbfgsView, b : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_view_copy(s : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_view_fill(s : OptconvexlbfgsView, v : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_view_min(s : OptconvexlbfgsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_view_max(s : OptconvexlbfgsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_view_to_string(s : OptconvexlbfgsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_range_make(size : Int) -> OptconvexlbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_range_len(s : OptconvexlbfgsRange) -> Int { s.size }

pub fn opt_convex_l_bfgs_range_get(s : OptconvexlbfgsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_range_set(s : OptconvexlbfgsRange, i : Int, v : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_range_sum(s : OptconvexlbfgsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_range_mean(s : OptconvexlbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_range_scale(s : OptconvexlbfgsRange, f : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_range_add(a : OptconvexlbfgsRange, b : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_range_copy(s : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_range_fill(s : OptconvexlbfgsRange, v : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_range_min(s : OptconvexlbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_range_max(s : OptconvexlbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_range_to_string(s : OptconvexlbfgsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_slice_make(size : Int) -> OptconvexlbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_slice_len(s : OptconvexlbfgsSlice) -> Int { s.size }

pub fn opt_convex_l_bfgs_slice_get(s : OptconvexlbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_slice_set(s : OptconvexlbfgsSlice, i : Int, v : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_slice_sum(s : OptconvexlbfgsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_l_bfgs_slice_mean(s : OptconvexlbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_l_bfgs_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_l_bfgs_slice_scale(s : OptconvexlbfgsSlice, f : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_slice_add(a : OptconvexlbfgsSlice, b : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_slice_copy(s : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_slice_fill(s : OptconvexlbfgsSlice, v : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_slice_min(s : OptconvexlbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_slice_max(s : OptconvexlbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_l_bfgs_slice_to_string(s : OptconvexlbfgsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_convex_l_bfgs_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_convex_l_bfgs_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


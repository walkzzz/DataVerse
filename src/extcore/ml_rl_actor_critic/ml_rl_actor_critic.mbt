///===
/// extcore/ml_rl_actor_critic

pub(all) struct MlrlactorcriticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_actor_critic_make_point(x : Double, y : Double) -> MlrlactorcriticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_actor_critic_make_point3(x : Double, y : Double, z : Double) -> MlrlactorcriticPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_actor_critic_point_x(pt : MlrlactorcriticPoint) -> Double { pt.x }

pub fn ml_rl_actor_critic_point_y(pt : MlrlactorcriticPoint) -> Double { pt.y }

pub fn ml_rl_actor_critic_point_z(pt : MlrlactorcriticPoint) -> Double { pt.z }

pub fn ml_rl_actor_critic_point_label(pt : MlrlactorcriticPoint) -> Int { pt.label }

pub fn ml_rl_actor_critic_point_dist(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_actor_critic_point_add(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_actor_critic_point_sub(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_actor_critic_point_scale(pt : MlrlactorcriticPoint, s : Double) -> MlrlactorcriticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_actor_critic_point_dot(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_actor_critic_point_cross(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_actor_critic_point_norm(pt : MlrlactorcriticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_actor_critic_point_normalize(pt : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  let n = ml_rl_actor_critic_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_actor_critic_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_actor_critic_point_negate(pt : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_actor_critic_point_mid(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint) -> MlrlactorcriticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_actor_critic_point_lerp(a : MlrlactorcriticPoint, b : MlrlactorcriticPoint, t : Double) -> MlrlactorcriticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_actor_critic_point_to_string(pt : MlrlactorcriticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlactorcriticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_actor_critic_make_series(vals : Array[Double], name : String) -> MlrlactorcriticSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_actor_critic_series_len(s : MlrlactorcriticSeries) -> Int { s.vals.length() }

pub fn ml_rl_actor_critic_series_sum(s : MlrlactorcriticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_actor_critic_series_mean(s : MlrlactorcriticSeries) -> Double {
  let n = ml_rl_actor_critic_series_len(s)
  if n == 0 { 0.0 } else { ml_rl_actor_critic_series_sum(s) / n.to_double() }
}

pub fn ml_rl_actor_critic_series_min(s : MlrlactorcriticSeries) -> Double {
  let n = ml_rl_actor_critic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_series_max(s : MlrlactorcriticSeries) -> Double {
  let n = ml_rl_actor_critic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_series_range(s : MlrlactorcriticSeries) -> Double {
  ml_rl_actor_critic_series_max(s) - ml_rl_actor_critic_series_min(s)
}

pub fn ml_rl_actor_critic_series_var(s : MlrlactorcriticSeries) -> Double {
  let n = ml_rl_actor_critic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_rl_actor_critic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_rl_actor_critic_series_std(s : MlrlactorcriticSeries) -> Double { @_common.sqrt(ml_rl_actor_critic_series_var(s)) }

pub fn ml_rl_actor_critic_series_median(s : MlrlactorcriticSeries) -> Double {
  let n = ml_rl_actor_critic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_actor_critic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_actor_critic_series_scale(s : MlrlactorcriticSeries, f : Double) -> MlrlactorcriticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_actor_critic_series_add(a : MlrlactorcriticSeries, b : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_actor_critic_series_sub(a : MlrlactorcriticSeries, b : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_actor_critic_series_normalize(s : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let mn = ml_rl_actor_critic_series_min(s)
  let mx = ml_rl_actor_critic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_actor_critic_series_cumsum(s : MlrlactorcriticSeries) -> MlrlactorcriticSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_actor_critic_series_to_string(s : MlrlactorcriticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlactorcriticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_actor_critic_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlactorcriticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_actor_critic_matrix_identity(n : Int) -> MlrlactorcriticMatrix {
  let m = ml_rl_actor_critic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_actor_critic_matrix_get(m : MlrlactorcriticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_actor_critic_matrix_transpose(m : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_actor_critic_matrix_add(a : MlrlactorcriticMatrix, b : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_actor_critic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_actor_critic_matrix_scale(m : MlrlactorcriticMatrix, s : Double) -> MlrlactorcriticMatrix {
  let result = ml_rl_actor_critic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_actor_critic_matrix_multiply(a : MlrlactorcriticMatrix, b : MlrlactorcriticMatrix) -> MlrlactorcriticMatrix {
  if a.cols != b.rows { return ml_rl_actor_critic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_actor_critic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_actor_critic_matrix_trace(m : MlrlactorcriticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_actor_critic_matrix_det(m : MlrlactorcriticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_actor_critic_matrix_norm(m : MlrlactorcriticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_actor_critic_matrix_to_string(m : MlrlactorcriticMatrix) -> String {
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

pub(all) struct MlrlactorcriticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_actor_critic_make_vector(comps : Array[Double]) -> MlrlactorcriticVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_actor_critic_vector_zero(dim : Int) -> MlrlactorcriticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_actor_critic_vector_add(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_actor_critic_vector_sub(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_actor_critic_vector_scale(v : MlrlactorcriticVector, s : Double) -> MlrlactorcriticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_actor_critic_vector_dot(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_actor_critic_vector_norm(v : MlrlactorcriticVector) -> Double { @_common.sqrt(ml_rl_actor_critic_vector_dot(v, v)) }

pub fn ml_rl_actor_critic_vector_normalize(v : MlrlactorcriticVector) -> MlrlactorcriticVector {
  let n = ml_rl_actor_critic_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_actor_critic_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_actor_critic_vector_dist(a : MlrlactorcriticVector, b : MlrlactorcriticVector) -> Double {
  ml_rl_actor_critic_vector_norm(ml_rl_actor_critic_vector_sub(a, b))
}

pub fn ml_rl_actor_critic_vector_to_string(v : MlrlactorcriticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_actor_critic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_rl_actor_critic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_rl_actor_critic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_actor_critic_std(data : Array[Double]) -> Double { @_common.sqrt(ml_rl_actor_critic_var(data)) }

pub fn ml_rl_actor_critic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_rl_actor_critic_mean(a); let mb = ml_rl_actor_critic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_rl_actor_critic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_rl_actor_critic_std(a); let sb = ml_rl_actor_critic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_rl_actor_critic_cov(a, b) / (sa * sb) }
}

pub fn ml_rl_actor_critic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_actor_critic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_actor_critic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_rl_actor_critic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_actor_critic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_rl_actor_critic_mse(pred, labels))
}

pub fn ml_rl_actor_critic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_rl_actor_critic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_rl_actor_critic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_rl_actor_critic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_rl_actor_critic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_rl_actor_critic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_rl_actor_critic_precision(pred, labels, pos); let r = ml_rl_actor_critic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_rl_actor_critic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_rl_actor_critic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_rl_actor_critic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_rl_actor_critic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_rl_actor_critic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_rl_actor_critic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_rl_actor_critic_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_rl_actor_critic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_rl_actor_critic_fibonacci(n : Int) -> Int {
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

pub fn ml_rl_actor_critic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_rl_actor_critic_min(data); let mx = ml_rl_actor_critic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_rl_actor_critic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_rl_actor_critic_mean(data); let sd = ml_rl_actor_critic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_rl_actor_critic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_rl_actor_critic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_rl_actor_critic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_rl_actor_critic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlrlactorcriticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_frame_make(size : Int) -> MlrlactorcriticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_frame_len(s : MlrlactorcriticFrame) -> Int { s.size }

pub fn ml_rl_actor_critic_frame_get(s : MlrlactorcriticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_frame_set(s : MlrlactorcriticFrame, i : Int, v : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_frame_sum(s : MlrlactorcriticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_frame_mean(s : MlrlactorcriticFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_frame_scale(s : MlrlactorcriticFrame, f : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_frame_add(a : MlrlactorcriticFrame, b : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_frame_copy(s : MlrlactorcriticFrame) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_frame_fill(s : MlrlactorcriticFrame, v : Double) -> MlrlactorcriticFrame {
  let result = ml_rl_actor_critic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_frame_min(s : MlrlactorcriticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_frame_max(s : MlrlactorcriticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_frame_to_string(s : MlrlactorcriticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_table_make(size : Int) -> MlrlactorcriticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_table_len(s : MlrlactorcriticTable) -> Int { s.size }

pub fn ml_rl_actor_critic_table_get(s : MlrlactorcriticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_table_set(s : MlrlactorcriticTable, i : Int, v : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_table_sum(s : MlrlactorcriticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_table_mean(s : MlrlactorcriticTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_table_scale(s : MlrlactorcriticTable, f : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_table_add(a : MlrlactorcriticTable, b : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_table_copy(s : MlrlactorcriticTable) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_table_fill(s : MlrlactorcriticTable, v : Double) -> MlrlactorcriticTable {
  let result = ml_rl_actor_critic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_table_min(s : MlrlactorcriticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_table_max(s : MlrlactorcriticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_table_to_string(s : MlrlactorcriticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_graphn_make(size : Int) -> MlrlactorcriticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_graphn_len(s : MlrlactorcriticGraphN) -> Int { s.size }

pub fn ml_rl_actor_critic_graphn_get(s : MlrlactorcriticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_graphn_set(s : MlrlactorcriticGraphN, i : Int, v : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_graphn_sum(s : MlrlactorcriticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_graphn_mean(s : MlrlactorcriticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_graphn_scale(s : MlrlactorcriticGraphN, f : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_graphn_add(a : MlrlactorcriticGraphN, b : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_graphn_copy(s : MlrlactorcriticGraphN) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_graphn_fill(s : MlrlactorcriticGraphN, v : Double) -> MlrlactorcriticGraphN {
  let result = ml_rl_actor_critic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_graphn_min(s : MlrlactorcriticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_graphn_max(s : MlrlactorcriticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_graphn_to_string(s : MlrlactorcriticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_node_make(size : Int) -> MlrlactorcriticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_node_len(s : MlrlactorcriticNode) -> Int { s.size }

pub fn ml_rl_actor_critic_node_get(s : MlrlactorcriticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_node_set(s : MlrlactorcriticNode, i : Int, v : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_node_sum(s : MlrlactorcriticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_node_mean(s : MlrlactorcriticNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_node_scale(s : MlrlactorcriticNode, f : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_node_add(a : MlrlactorcriticNode, b : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_node_copy(s : MlrlactorcriticNode) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_node_fill(s : MlrlactorcriticNode, v : Double) -> MlrlactorcriticNode {
  let result = ml_rl_actor_critic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_node_min(s : MlrlactorcriticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_node_max(s : MlrlactorcriticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_node_to_string(s : MlrlactorcriticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_edge_make(size : Int) -> MlrlactorcriticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_edge_len(s : MlrlactorcriticEdge) -> Int { s.size }

pub fn ml_rl_actor_critic_edge_get(s : MlrlactorcriticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_edge_set(s : MlrlactorcriticEdge, i : Int, v : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_edge_sum(s : MlrlactorcriticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_edge_mean(s : MlrlactorcriticEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_edge_scale(s : MlrlactorcriticEdge, f : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_edge_add(a : MlrlactorcriticEdge, b : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_edge_copy(s : MlrlactorcriticEdge) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_edge_fill(s : MlrlactorcriticEdge, v : Double) -> MlrlactorcriticEdge {
  let result = ml_rl_actor_critic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_edge_min(s : MlrlactorcriticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_edge_max(s : MlrlactorcriticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_edge_to_string(s : MlrlactorcriticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_path_make(size : Int) -> MlrlactorcriticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_path_len(s : MlrlactorcriticPath) -> Int { s.size }

pub fn ml_rl_actor_critic_path_get(s : MlrlactorcriticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_path_set(s : MlrlactorcriticPath, i : Int, v : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_path_sum(s : MlrlactorcriticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_path_mean(s : MlrlactorcriticPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_path_scale(s : MlrlactorcriticPath, f : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_path_add(a : MlrlactorcriticPath, b : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_path_copy(s : MlrlactorcriticPath) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_path_fill(s : MlrlactorcriticPath, v : Double) -> MlrlactorcriticPath {
  let result = ml_rl_actor_critic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_path_min(s : MlrlactorcriticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_path_max(s : MlrlactorcriticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_path_to_string(s : MlrlactorcriticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cluster_make(size : Int) -> MlrlactorcriticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cluster_len(s : MlrlactorcriticCluster) -> Int { s.size }

pub fn ml_rl_actor_critic_cluster_get(s : MlrlactorcriticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cluster_set(s : MlrlactorcriticCluster, i : Int, v : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cluster_sum(s : MlrlactorcriticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_cluster_mean(s : MlrlactorcriticCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_cluster_scale(s : MlrlactorcriticCluster, f : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_cluster_add(a : MlrlactorcriticCluster, b : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_cluster_copy(s : MlrlactorcriticCluster) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_cluster_fill(s : MlrlactorcriticCluster, v : Double) -> MlrlactorcriticCluster {
  let result = ml_rl_actor_critic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cluster_min(s : MlrlactorcriticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_cluster_max(s : MlrlactorcriticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_cluster_to_string(s : MlrlactorcriticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_model_make(size : Int) -> MlrlactorcriticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_model_len(s : MlrlactorcriticModel) -> Int { s.size }

pub fn ml_rl_actor_critic_model_get(s : MlrlactorcriticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_model_set(s : MlrlactorcriticModel, i : Int, v : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_model_sum(s : MlrlactorcriticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_model_mean(s : MlrlactorcriticModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_model_scale(s : MlrlactorcriticModel, f : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_model_add(a : MlrlactorcriticModel, b : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_model_copy(s : MlrlactorcriticModel) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_model_fill(s : MlrlactorcriticModel, v : Double) -> MlrlactorcriticModel {
  let result = ml_rl_actor_critic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_model_min(s : MlrlactorcriticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_model_max(s : MlrlactorcriticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_model_to_string(s : MlrlactorcriticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_layer_make(size : Int) -> MlrlactorcriticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_layer_len(s : MlrlactorcriticLayer) -> Int { s.size }

pub fn ml_rl_actor_critic_layer_get(s : MlrlactorcriticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_layer_set(s : MlrlactorcriticLayer, i : Int, v : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_layer_sum(s : MlrlactorcriticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_layer_mean(s : MlrlactorcriticLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_layer_scale(s : MlrlactorcriticLayer, f : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_layer_add(a : MlrlactorcriticLayer, b : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_layer_copy(s : MlrlactorcriticLayer) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_layer_fill(s : MlrlactorcriticLayer, v : Double) -> MlrlactorcriticLayer {
  let result = ml_rl_actor_critic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_layer_min(s : MlrlactorcriticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_layer_max(s : MlrlactorcriticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_layer_to_string(s : MlrlactorcriticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_buffer_make(size : Int) -> MlrlactorcriticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_buffer_len(s : MlrlactorcriticBuffer) -> Int { s.size }

pub fn ml_rl_actor_critic_buffer_get(s : MlrlactorcriticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_buffer_set(s : MlrlactorcriticBuffer, i : Int, v : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_buffer_sum(s : MlrlactorcriticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_buffer_mean(s : MlrlactorcriticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_buffer_scale(s : MlrlactorcriticBuffer, f : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_buffer_add(a : MlrlactorcriticBuffer, b : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_buffer_copy(s : MlrlactorcriticBuffer) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_buffer_fill(s : MlrlactorcriticBuffer, v : Double) -> MlrlactorcriticBuffer {
  let result = ml_rl_actor_critic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_buffer_min(s : MlrlactorcriticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_buffer_max(s : MlrlactorcriticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_buffer_to_string(s : MlrlactorcriticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_cursor_make(size : Int) -> MlrlactorcriticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_cursor_len(s : MlrlactorcriticCursor) -> Int { s.size }

pub fn ml_rl_actor_critic_cursor_get(s : MlrlactorcriticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_cursor_set(s : MlrlactorcriticCursor, i : Int, v : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cursor_sum(s : MlrlactorcriticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_cursor_mean(s : MlrlactorcriticCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_cursor_scale(s : MlrlactorcriticCursor, f : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_cursor_add(a : MlrlactorcriticCursor, b : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_cursor_copy(s : MlrlactorcriticCursor) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_cursor_fill(s : MlrlactorcriticCursor, v : Double) -> MlrlactorcriticCursor {
  let result = ml_rl_actor_critic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_cursor_min(s : MlrlactorcriticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_cursor_max(s : MlrlactorcriticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_cursor_to_string(s : MlrlactorcriticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_view_make(size : Int) -> MlrlactorcriticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_view_len(s : MlrlactorcriticView) -> Int { s.size }

pub fn ml_rl_actor_critic_view_get(s : MlrlactorcriticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_view_set(s : MlrlactorcriticView, i : Int, v : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_view_sum(s : MlrlactorcriticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_view_mean(s : MlrlactorcriticView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_view_scale(s : MlrlactorcriticView, f : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_view_add(a : MlrlactorcriticView, b : MlrlactorcriticView) -> MlrlactorcriticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_view_copy(s : MlrlactorcriticView) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_view_fill(s : MlrlactorcriticView, v : Double) -> MlrlactorcriticView {
  let result = ml_rl_actor_critic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_view_min(s : MlrlactorcriticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_view_max(s : MlrlactorcriticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_view_to_string(s : MlrlactorcriticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_range_make(size : Int) -> MlrlactorcriticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_range_len(s : MlrlactorcriticRange) -> Int { s.size }

pub fn ml_rl_actor_critic_range_get(s : MlrlactorcriticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_range_set(s : MlrlactorcriticRange, i : Int, v : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_range_sum(s : MlrlactorcriticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_range_mean(s : MlrlactorcriticRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_range_scale(s : MlrlactorcriticRange, f : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_range_add(a : MlrlactorcriticRange, b : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_range_copy(s : MlrlactorcriticRange) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_range_fill(s : MlrlactorcriticRange, v : Double) -> MlrlactorcriticRange {
  let result = ml_rl_actor_critic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_range_min(s : MlrlactorcriticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_range_max(s : MlrlactorcriticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_range_to_string(s : MlrlactorcriticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlactorcriticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_actor_critic_slice_make(size : Int) -> MlrlactorcriticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_actor_critic_slice_len(s : MlrlactorcriticSlice) -> Int { s.size }

pub fn ml_rl_actor_critic_slice_get(s : MlrlactorcriticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_actor_critic_slice_set(s : MlrlactorcriticSlice, i : Int, v : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_slice_sum(s : MlrlactorcriticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_actor_critic_slice_mean(s : MlrlactorcriticSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_actor_critic_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_actor_critic_slice_scale(s : MlrlactorcriticSlice, f : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_actor_critic_slice_add(a : MlrlactorcriticSlice, b : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_actor_critic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_actor_critic_slice_copy(s : MlrlactorcriticSlice) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_actor_critic_slice_fill(s : MlrlactorcriticSlice, v : Double) -> MlrlactorcriticSlice {
  let result = ml_rl_actor_critic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_actor_critic_slice_min(s : MlrlactorcriticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_slice_max(s : MlrlactorcriticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_actor_critic_slice_to_string(s : MlrlactorcriticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


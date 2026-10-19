///===
/// extcore/ml_ensemble_voting

pub(all) struct MlensemblevotingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_voting_make_point(x : Double, y : Double) -> MlensemblevotingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_voting_make_point3(x : Double, y : Double, z : Double) -> MlensemblevotingPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_voting_point_x(pt : MlensemblevotingPoint) -> Double { pt.x }

pub fn ml_ensemble_voting_point_y(pt : MlensemblevotingPoint) -> Double { pt.y }

pub fn ml_ensemble_voting_point_z(pt : MlensemblevotingPoint) -> Double { pt.z }

pub fn ml_ensemble_voting_point_label(pt : MlensemblevotingPoint) -> Int { pt.label }

pub fn ml_ensemble_voting_point_dist(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_voting_point_add(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_voting_point_sub(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_voting_point_scale(pt : MlensemblevotingPoint, s : Double) -> MlensemblevotingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_voting_point_dot(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_voting_point_cross(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_voting_point_norm(pt : MlensemblevotingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_voting_point_normalize(pt : MlensemblevotingPoint) -> MlensemblevotingPoint {
  let n = ml_ensemble_voting_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_voting_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_voting_point_negate(pt : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_voting_point_mid(a : MlensemblevotingPoint, b : MlensemblevotingPoint) -> MlensemblevotingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_voting_point_lerp(a : MlensemblevotingPoint, b : MlensemblevotingPoint, t : Double) -> MlensemblevotingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_voting_point_to_string(pt : MlensemblevotingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensemblevotingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_voting_make_series(vals : Array[Double], name : String) -> MlensemblevotingSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_voting_series_len(s : MlensemblevotingSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_voting_series_sum(s : MlensemblevotingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_voting_series_mean(s : MlensemblevotingSeries) -> Double {
  let n = ml_ensemble_voting_series_len(s)
  if n == 0 { 0.0 } else { ml_ensemble_voting_series_sum(s) / n.to_double() }
}

pub fn ml_ensemble_voting_series_min(s : MlensemblevotingSeries) -> Double {
  let n = ml_ensemble_voting_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_voting_series_max(s : MlensemblevotingSeries) -> Double {
  let n = ml_ensemble_voting_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_ensemble_voting_series_range(s : MlensemblevotingSeries) -> Double {
  ml_ensemble_voting_series_max(s) - ml_ensemble_voting_series_min(s)
}

pub fn ml_ensemble_voting_series_var(s : MlensemblevotingSeries) -> Double {
  let n = ml_ensemble_voting_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_voting_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_ensemble_voting_series_std(s : MlensemblevotingSeries) -> Double { @_common.sqrt(ml_ensemble_voting_series_var(s)) }

pub fn ml_ensemble_voting_series_median(s : MlensemblevotingSeries) -> Double {
  let n = ml_ensemble_voting_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_voting_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_voting_series_scale(s : MlensemblevotingSeries, f : Double) -> MlensemblevotingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_voting_series_add(a : MlensemblevotingSeries, b : MlensemblevotingSeries) -> MlensemblevotingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_voting_series_sub(a : MlensemblevotingSeries, b : MlensemblevotingSeries) -> MlensemblevotingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_voting_series_normalize(s : MlensemblevotingSeries) -> MlensemblevotingSeries {
  let mn = ml_ensemble_voting_series_min(s)
  let mx = ml_ensemble_voting_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_voting_series_cumsum(s : MlensemblevotingSeries) -> MlensemblevotingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_voting_series_to_string(s : MlensemblevotingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensemblevotingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_voting_make_matrix(rows : Int, cols : Int, val : Double) -> MlensemblevotingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_voting_matrix_identity(n : Int) -> MlensemblevotingMatrix {
  let m = ml_ensemble_voting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_voting_matrix_get(m : MlensemblevotingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_voting_matrix_transpose(m : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  let result = ml_ensemble_voting_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_voting_matrix_add(a : MlensemblevotingMatrix, b : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_voting_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_voting_matrix_scale(m : MlensemblevotingMatrix, s : Double) -> MlensemblevotingMatrix {
  let result = ml_ensemble_voting_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_voting_matrix_multiply(a : MlensemblevotingMatrix, b : MlensemblevotingMatrix) -> MlensemblevotingMatrix {
  if a.cols != b.rows { return ml_ensemble_voting_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_voting_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_voting_matrix_trace(m : MlensemblevotingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_voting_matrix_det(m : MlensemblevotingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_voting_matrix_norm(m : MlensemblevotingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_voting_matrix_to_string(m : MlensemblevotingMatrix) -> String {
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

pub(all) struct MlensemblevotingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_voting_make_vector(comps : Array[Double]) -> MlensemblevotingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_voting_vector_zero(dim : Int) -> MlensemblevotingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_voting_vector_add(a : MlensemblevotingVector, b : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_voting_vector_sub(a : MlensemblevotingVector, b : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_voting_vector_scale(v : MlensemblevotingVector, s : Double) -> MlensemblevotingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_voting_vector_dot(a : MlensemblevotingVector, b : MlensemblevotingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_voting_vector_norm(v : MlensemblevotingVector) -> Double { @_common.sqrt(ml_ensemble_voting_vector_dot(v, v)) }

pub fn ml_ensemble_voting_vector_normalize(v : MlensemblevotingVector) -> MlensemblevotingVector {
  let n = ml_ensemble_voting_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_voting_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_voting_vector_dist(a : MlensemblevotingVector, b : MlensemblevotingVector) -> Double {
  ml_ensemble_voting_vector_norm(ml_ensemble_voting_vector_sub(a, b))
}

pub fn ml_ensemble_voting_vector_to_string(v : MlensemblevotingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_voting_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_voting_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_ensemble_voting_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_voting_std(data : Array[Double]) -> Double { @_common.sqrt(ml_ensemble_voting_var(data)) }

pub fn ml_ensemble_voting_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_ensemble_voting_mean(a); let mb = ml_ensemble_voting_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_voting_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_ensemble_voting_std(a); let sb = ml_ensemble_voting_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_ensemble_voting_cov(a, b) / (sa * sb) }
}

pub fn ml_ensemble_voting_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_ensemble_voting_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_ensemble_voting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_ensemble_voting_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_voting_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_ensemble_voting_mse(pred, labels))
}

pub fn ml_ensemble_voting_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_ensemble_voting_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_ensemble_voting_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_ensemble_voting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_ensemble_voting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_ensemble_voting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_ensemble_voting_precision(pred, labels, pos); let r = ml_ensemble_voting_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_ensemble_voting_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_ensemble_voting_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_ensemble_voting_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_ensemble_voting_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_ensemble_voting_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_ensemble_voting_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_ensemble_voting_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_ensemble_voting_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_ensemble_voting_fibonacci(n : Int) -> Int {
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

pub fn ml_ensemble_voting_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_ensemble_voting_min(data); let mx = ml_ensemble_voting_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_ensemble_voting_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_ensemble_voting_mean(data); let sd = ml_ensemble_voting_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_ensemble_voting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_ensemble_voting_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_ensemble_voting_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_ensemble_voting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlensemblevotingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_frame_make(size : Int) -> MlensemblevotingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_frame_len(s : MlensemblevotingFrame) -> Int { s.size }

pub fn ml_ensemble_voting_frame_get(s : MlensemblevotingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_frame_set(s : MlensemblevotingFrame, i : Int, v : Double) -> MlensemblevotingFrame {
  let result = ml_ensemble_voting_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_frame_sum(s : MlensemblevotingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_frame_mean(s : MlensemblevotingFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_frame_scale(s : MlensemblevotingFrame, f : Double) -> MlensemblevotingFrame {
  let result = ml_ensemble_voting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_frame_add(a : MlensemblevotingFrame, b : MlensemblevotingFrame) -> MlensemblevotingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_frame_copy(s : MlensemblevotingFrame) -> MlensemblevotingFrame {
  let result = ml_ensemble_voting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_frame_fill(s : MlensemblevotingFrame, v : Double) -> MlensemblevotingFrame {
  let result = ml_ensemble_voting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_frame_min(s : MlensemblevotingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_frame_max(s : MlensemblevotingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_frame_to_string(s : MlensemblevotingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_table_make(size : Int) -> MlensemblevotingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_table_len(s : MlensemblevotingTable) -> Int { s.size }

pub fn ml_ensemble_voting_table_get(s : MlensemblevotingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_table_set(s : MlensemblevotingTable, i : Int, v : Double) -> MlensemblevotingTable {
  let result = ml_ensemble_voting_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_table_sum(s : MlensemblevotingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_table_mean(s : MlensemblevotingTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_table_scale(s : MlensemblevotingTable, f : Double) -> MlensemblevotingTable {
  let result = ml_ensemble_voting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_table_add(a : MlensemblevotingTable, b : MlensemblevotingTable) -> MlensemblevotingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_table_copy(s : MlensemblevotingTable) -> MlensemblevotingTable {
  let result = ml_ensemble_voting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_table_fill(s : MlensemblevotingTable, v : Double) -> MlensemblevotingTable {
  let result = ml_ensemble_voting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_table_min(s : MlensemblevotingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_table_max(s : MlensemblevotingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_table_to_string(s : MlensemblevotingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_graphn_make(size : Int) -> MlensemblevotingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_graphn_len(s : MlensemblevotingGraphN) -> Int { s.size }

pub fn ml_ensemble_voting_graphn_get(s : MlensemblevotingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_graphn_set(s : MlensemblevotingGraphN, i : Int, v : Double) -> MlensemblevotingGraphN {
  let result = ml_ensemble_voting_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_graphn_sum(s : MlensemblevotingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_graphn_mean(s : MlensemblevotingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_graphn_scale(s : MlensemblevotingGraphN, f : Double) -> MlensemblevotingGraphN {
  let result = ml_ensemble_voting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_graphn_add(a : MlensemblevotingGraphN, b : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_graphn_copy(s : MlensemblevotingGraphN) -> MlensemblevotingGraphN {
  let result = ml_ensemble_voting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_graphn_fill(s : MlensemblevotingGraphN, v : Double) -> MlensemblevotingGraphN {
  let result = ml_ensemble_voting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_graphn_min(s : MlensemblevotingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_graphn_max(s : MlensemblevotingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_graphn_to_string(s : MlensemblevotingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_node_make(size : Int) -> MlensemblevotingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_node_len(s : MlensemblevotingNode) -> Int { s.size }

pub fn ml_ensemble_voting_node_get(s : MlensemblevotingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_node_set(s : MlensemblevotingNode, i : Int, v : Double) -> MlensemblevotingNode {
  let result = ml_ensemble_voting_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_node_sum(s : MlensemblevotingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_node_mean(s : MlensemblevotingNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_node_scale(s : MlensemblevotingNode, f : Double) -> MlensemblevotingNode {
  let result = ml_ensemble_voting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_node_add(a : MlensemblevotingNode, b : MlensemblevotingNode) -> MlensemblevotingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_node_copy(s : MlensemblevotingNode) -> MlensemblevotingNode {
  let result = ml_ensemble_voting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_node_fill(s : MlensemblevotingNode, v : Double) -> MlensemblevotingNode {
  let result = ml_ensemble_voting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_node_min(s : MlensemblevotingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_node_max(s : MlensemblevotingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_node_to_string(s : MlensemblevotingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_edge_make(size : Int) -> MlensemblevotingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_edge_len(s : MlensemblevotingEdge) -> Int { s.size }

pub fn ml_ensemble_voting_edge_get(s : MlensemblevotingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_edge_set(s : MlensemblevotingEdge, i : Int, v : Double) -> MlensemblevotingEdge {
  let result = ml_ensemble_voting_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_edge_sum(s : MlensemblevotingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_edge_mean(s : MlensemblevotingEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_edge_scale(s : MlensemblevotingEdge, f : Double) -> MlensemblevotingEdge {
  let result = ml_ensemble_voting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_edge_add(a : MlensemblevotingEdge, b : MlensemblevotingEdge) -> MlensemblevotingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_edge_copy(s : MlensemblevotingEdge) -> MlensemblevotingEdge {
  let result = ml_ensemble_voting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_edge_fill(s : MlensemblevotingEdge, v : Double) -> MlensemblevotingEdge {
  let result = ml_ensemble_voting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_edge_min(s : MlensemblevotingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_edge_max(s : MlensemblevotingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_edge_to_string(s : MlensemblevotingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_path_make(size : Int) -> MlensemblevotingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_path_len(s : MlensemblevotingPath) -> Int { s.size }

pub fn ml_ensemble_voting_path_get(s : MlensemblevotingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_path_set(s : MlensemblevotingPath, i : Int, v : Double) -> MlensemblevotingPath {
  let result = ml_ensemble_voting_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_path_sum(s : MlensemblevotingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_path_mean(s : MlensemblevotingPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_path_scale(s : MlensemblevotingPath, f : Double) -> MlensemblevotingPath {
  let result = ml_ensemble_voting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_path_add(a : MlensemblevotingPath, b : MlensemblevotingPath) -> MlensemblevotingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_path_copy(s : MlensemblevotingPath) -> MlensemblevotingPath {
  let result = ml_ensemble_voting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_path_fill(s : MlensemblevotingPath, v : Double) -> MlensemblevotingPath {
  let result = ml_ensemble_voting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_path_min(s : MlensemblevotingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_path_max(s : MlensemblevotingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_path_to_string(s : MlensemblevotingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cluster_make(size : Int) -> MlensemblevotingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_cluster_len(s : MlensemblevotingCluster) -> Int { s.size }

pub fn ml_ensemble_voting_cluster_get(s : MlensemblevotingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_cluster_set(s : MlensemblevotingCluster, i : Int, v : Double) -> MlensemblevotingCluster {
  let result = ml_ensemble_voting_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_cluster_sum(s : MlensemblevotingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_cluster_mean(s : MlensemblevotingCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_cluster_scale(s : MlensemblevotingCluster, f : Double) -> MlensemblevotingCluster {
  let result = ml_ensemble_voting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_cluster_add(a : MlensemblevotingCluster, b : MlensemblevotingCluster) -> MlensemblevotingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_cluster_copy(s : MlensemblevotingCluster) -> MlensemblevotingCluster {
  let result = ml_ensemble_voting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_cluster_fill(s : MlensemblevotingCluster, v : Double) -> MlensemblevotingCluster {
  let result = ml_ensemble_voting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_cluster_min(s : MlensemblevotingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_cluster_max(s : MlensemblevotingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_cluster_to_string(s : MlensemblevotingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_model_make(size : Int) -> MlensemblevotingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_model_len(s : MlensemblevotingModel) -> Int { s.size }

pub fn ml_ensemble_voting_model_get(s : MlensemblevotingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_model_set(s : MlensemblevotingModel, i : Int, v : Double) -> MlensemblevotingModel {
  let result = ml_ensemble_voting_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_model_sum(s : MlensemblevotingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_model_mean(s : MlensemblevotingModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_model_scale(s : MlensemblevotingModel, f : Double) -> MlensemblevotingModel {
  let result = ml_ensemble_voting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_model_add(a : MlensemblevotingModel, b : MlensemblevotingModel) -> MlensemblevotingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_model_copy(s : MlensemblevotingModel) -> MlensemblevotingModel {
  let result = ml_ensemble_voting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_model_fill(s : MlensemblevotingModel, v : Double) -> MlensemblevotingModel {
  let result = ml_ensemble_voting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_model_min(s : MlensemblevotingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_model_max(s : MlensemblevotingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_model_to_string(s : MlensemblevotingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_layer_make(size : Int) -> MlensemblevotingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_layer_len(s : MlensemblevotingLayer) -> Int { s.size }

pub fn ml_ensemble_voting_layer_get(s : MlensemblevotingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_layer_set(s : MlensemblevotingLayer, i : Int, v : Double) -> MlensemblevotingLayer {
  let result = ml_ensemble_voting_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_layer_sum(s : MlensemblevotingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_layer_mean(s : MlensemblevotingLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_layer_scale(s : MlensemblevotingLayer, f : Double) -> MlensemblevotingLayer {
  let result = ml_ensemble_voting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_layer_add(a : MlensemblevotingLayer, b : MlensemblevotingLayer) -> MlensemblevotingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_layer_copy(s : MlensemblevotingLayer) -> MlensemblevotingLayer {
  let result = ml_ensemble_voting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_layer_fill(s : MlensemblevotingLayer, v : Double) -> MlensemblevotingLayer {
  let result = ml_ensemble_voting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_layer_min(s : MlensemblevotingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_layer_max(s : MlensemblevotingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_layer_to_string(s : MlensemblevotingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_buffer_make(size : Int) -> MlensemblevotingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_buffer_len(s : MlensemblevotingBuffer) -> Int { s.size }

pub fn ml_ensemble_voting_buffer_get(s : MlensemblevotingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_buffer_set(s : MlensemblevotingBuffer, i : Int, v : Double) -> MlensemblevotingBuffer {
  let result = ml_ensemble_voting_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_buffer_sum(s : MlensemblevotingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_buffer_mean(s : MlensemblevotingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_buffer_scale(s : MlensemblevotingBuffer, f : Double) -> MlensemblevotingBuffer {
  let result = ml_ensemble_voting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_buffer_add(a : MlensemblevotingBuffer, b : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_buffer_copy(s : MlensemblevotingBuffer) -> MlensemblevotingBuffer {
  let result = ml_ensemble_voting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_buffer_fill(s : MlensemblevotingBuffer, v : Double) -> MlensemblevotingBuffer {
  let result = ml_ensemble_voting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_buffer_min(s : MlensemblevotingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_buffer_max(s : MlensemblevotingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_buffer_to_string(s : MlensemblevotingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_cursor_make(size : Int) -> MlensemblevotingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_cursor_len(s : MlensemblevotingCursor) -> Int { s.size }

pub fn ml_ensemble_voting_cursor_get(s : MlensemblevotingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_cursor_set(s : MlensemblevotingCursor, i : Int, v : Double) -> MlensemblevotingCursor {
  let result = ml_ensemble_voting_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_cursor_sum(s : MlensemblevotingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_cursor_mean(s : MlensemblevotingCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_cursor_scale(s : MlensemblevotingCursor, f : Double) -> MlensemblevotingCursor {
  let result = ml_ensemble_voting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_cursor_add(a : MlensemblevotingCursor, b : MlensemblevotingCursor) -> MlensemblevotingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_cursor_copy(s : MlensemblevotingCursor) -> MlensemblevotingCursor {
  let result = ml_ensemble_voting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_cursor_fill(s : MlensemblevotingCursor, v : Double) -> MlensemblevotingCursor {
  let result = ml_ensemble_voting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_cursor_min(s : MlensemblevotingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_cursor_max(s : MlensemblevotingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_cursor_to_string(s : MlensemblevotingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_view_make(size : Int) -> MlensemblevotingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_view_len(s : MlensemblevotingView) -> Int { s.size }

pub fn ml_ensemble_voting_view_get(s : MlensemblevotingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_view_set(s : MlensemblevotingView, i : Int, v : Double) -> MlensemblevotingView {
  let result = ml_ensemble_voting_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_view_sum(s : MlensemblevotingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_view_mean(s : MlensemblevotingView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_view_scale(s : MlensemblevotingView, f : Double) -> MlensemblevotingView {
  let result = ml_ensemble_voting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_view_add(a : MlensemblevotingView, b : MlensemblevotingView) -> MlensemblevotingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_view_copy(s : MlensemblevotingView) -> MlensemblevotingView {
  let result = ml_ensemble_voting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_view_fill(s : MlensemblevotingView, v : Double) -> MlensemblevotingView {
  let result = ml_ensemble_voting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_view_min(s : MlensemblevotingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_view_max(s : MlensemblevotingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_view_to_string(s : MlensemblevotingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_range_make(size : Int) -> MlensemblevotingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_range_len(s : MlensemblevotingRange) -> Int { s.size }

pub fn ml_ensemble_voting_range_get(s : MlensemblevotingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_range_set(s : MlensemblevotingRange, i : Int, v : Double) -> MlensemblevotingRange {
  let result = ml_ensemble_voting_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_range_sum(s : MlensemblevotingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_range_mean(s : MlensemblevotingRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_range_scale(s : MlensemblevotingRange, f : Double) -> MlensemblevotingRange {
  let result = ml_ensemble_voting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_range_add(a : MlensemblevotingRange, b : MlensemblevotingRange) -> MlensemblevotingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_range_copy(s : MlensemblevotingRange) -> MlensemblevotingRange {
  let result = ml_ensemble_voting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_range_fill(s : MlensemblevotingRange, v : Double) -> MlensemblevotingRange {
  let result = ml_ensemble_voting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_range_min(s : MlensemblevotingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_range_max(s : MlensemblevotingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_range_to_string(s : MlensemblevotingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensemblevotingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_voting_slice_make(size : Int) -> MlensemblevotingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_voting_slice_len(s : MlensemblevotingSlice) -> Int { s.size }

pub fn ml_ensemble_voting_slice_get(s : MlensemblevotingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_voting_slice_set(s : MlensemblevotingSlice, i : Int, v : Double) -> MlensemblevotingSlice {
  let result = ml_ensemble_voting_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_slice_sum(s : MlensemblevotingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_voting_slice_mean(s : MlensemblevotingSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_voting_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_voting_slice_scale(s : MlensemblevotingSlice, f : Double) -> MlensemblevotingSlice {
  let result = ml_ensemble_voting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_voting_slice_add(a : MlensemblevotingSlice, b : MlensemblevotingSlice) -> MlensemblevotingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_voting_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_voting_slice_copy(s : MlensemblevotingSlice) -> MlensemblevotingSlice {
  let result = ml_ensemble_voting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_voting_slice_fill(s : MlensemblevotingSlice, v : Double) -> MlensemblevotingSlice {
  let result = ml_ensemble_voting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_voting_slice_min(s : MlensemblevotingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_slice_max(s : MlensemblevotingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_voting_slice_to_string(s : MlensemblevotingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


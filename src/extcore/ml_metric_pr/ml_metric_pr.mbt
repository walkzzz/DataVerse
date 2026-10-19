///===
/// extcore/ml_metric_pr

pub(all) struct MlmetricprPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_pr_make_point(x : Double, y : Double) -> MlmetricprPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_pr_make_point3(x : Double, y : Double, z : Double) -> MlmetricprPoint {
  { x, y, z, label: 0 }
}

pub fn ml_metric_pr_point_x(pt : MlmetricprPoint) -> Double { pt.x }

pub fn ml_metric_pr_point_y(pt : MlmetricprPoint) -> Double { pt.y }

pub fn ml_metric_pr_point_z(pt : MlmetricprPoint) -> Double { pt.z }

pub fn ml_metric_pr_point_label(pt : MlmetricprPoint) -> Int { pt.label }

pub fn ml_metric_pr_point_dist(a : MlmetricprPoint, b : MlmetricprPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_metric_pr_point_add(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_metric_pr_point_sub(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_metric_pr_point_scale(pt : MlmetricprPoint, s : Double) -> MlmetricprPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_metric_pr_point_dot(a : MlmetricprPoint, b : MlmetricprPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_metric_pr_point_cross(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_metric_pr_point_norm(pt : MlmetricprPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_metric_pr_point_normalize(pt : MlmetricprPoint) -> MlmetricprPoint {
  let n = ml_metric_pr_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_metric_pr_point_scale(pt, 1.0 / n) }
}

pub fn ml_metric_pr_point_negate(pt : MlmetricprPoint) -> MlmetricprPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_metric_pr_point_mid(a : MlmetricprPoint, b : MlmetricprPoint) -> MlmetricprPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_metric_pr_point_lerp(a : MlmetricprPoint, b : MlmetricprPoint, t : Double) -> MlmetricprPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_metric_pr_point_to_string(pt : MlmetricprPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlmetricprSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_pr_make_series(vals : Array[Double], name : String) -> MlmetricprSeries {
  { vals, name, meta: 0 }
}

pub fn ml_metric_pr_series_len(s : MlmetricprSeries) -> Int { s.vals.length() }

pub fn ml_metric_pr_series_sum(s : MlmetricprSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_metric_pr_series_mean(s : MlmetricprSeries) -> Double {
  let n = ml_metric_pr_series_len(s)
  if n == 0 { 0.0 } else { ml_metric_pr_series_sum(s) / n.to_double() }
}

pub fn ml_metric_pr_series_min(s : MlmetricprSeries) -> Double {
  let n = ml_metric_pr_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_pr_series_max(s : MlmetricprSeries) -> Double {
  let n = ml_metric_pr_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_metric_pr_series_range(s : MlmetricprSeries) -> Double {
  ml_metric_pr_series_max(s) - ml_metric_pr_series_min(s)
}

pub fn ml_metric_pr_series_var(s : MlmetricprSeries) -> Double {
  let n = ml_metric_pr_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_metric_pr_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_metric_pr_series_std(s : MlmetricprSeries) -> Double { @_common.sqrt(ml_metric_pr_series_var(s)) }

pub fn ml_metric_pr_series_median(s : MlmetricprSeries) -> Double {
  let n = ml_metric_pr_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_pr_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_pr_series_scale(s : MlmetricprSeries, f : Double) -> MlmetricprSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_metric_pr_series_add(a : MlmetricprSeries, b : MlmetricprSeries) -> MlmetricprSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_metric_pr_series_sub(a : MlmetricprSeries, b : MlmetricprSeries) -> MlmetricprSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_metric_pr_series_normalize(s : MlmetricprSeries) -> MlmetricprSeries {
  let mn = ml_metric_pr_series_min(s)
  let mx = ml_metric_pr_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_metric_pr_series_cumsum(s : MlmetricprSeries) -> MlmetricprSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_metric_pr_series_to_string(s : MlmetricprSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricprMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_pr_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricprMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_pr_matrix_identity(n : Int) -> MlmetricprMatrix {
  let m = ml_metric_pr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_metric_pr_matrix_get(m : MlmetricprMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_metric_pr_matrix_transpose(m : MlmetricprMatrix) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_metric_pr_matrix_add(a : MlmetricprMatrix, b : MlmetricprMatrix) -> MlmetricprMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_metric_pr_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_metric_pr_matrix_scale(m : MlmetricprMatrix, s : Double) -> MlmetricprMatrix {
  let result = ml_metric_pr_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_metric_pr_matrix_multiply(a : MlmetricprMatrix, b : MlmetricprMatrix) -> MlmetricprMatrix {
  if a.cols != b.rows { return ml_metric_pr_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_metric_pr_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_metric_pr_matrix_trace(m : MlmetricprMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_metric_pr_matrix_det(m : MlmetricprMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_metric_pr_matrix_norm(m : MlmetricprMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_metric_pr_matrix_to_string(m : MlmetricprMatrix) -> String {
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

pub(all) struct MlmetricprVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_pr_make_vector(comps : Array[Double]) -> MlmetricprVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_pr_vector_zero(dim : Int) -> MlmetricprVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_metric_pr_vector_add(a : MlmetricprVector, b : MlmetricprVector) -> MlmetricprVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_pr_vector_sub(a : MlmetricprVector, b : MlmetricprVector) -> MlmetricprVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_metric_pr_vector_scale(v : MlmetricprVector, s : Double) -> MlmetricprVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_metric_pr_vector_dot(a : MlmetricprVector, b : MlmetricprVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_metric_pr_vector_norm(v : MlmetricprVector) -> Double { @_common.sqrt(ml_metric_pr_vector_dot(v, v)) }

pub fn ml_metric_pr_vector_normalize(v : MlmetricprVector) -> MlmetricprVector {
  let n = ml_metric_pr_vector_norm(v)
  if n < 0.0000001 { v } else { ml_metric_pr_vector_scale(v, 1.0 / n) }
}

pub fn ml_metric_pr_vector_dist(a : MlmetricprVector, b : MlmetricprVector) -> Double {
  ml_metric_pr_vector_norm(ml_metric_pr_vector_sub(a, b))
}

pub fn ml_metric_pr_vector_to_string(v : MlmetricprVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_pr_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_metric_pr_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_metric_pr_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_pr_std(data : Array[Double]) -> Double { @_common.sqrt(ml_metric_pr_var(data)) }

pub fn ml_metric_pr_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_metric_pr_mean(a); let mb = ml_metric_pr_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_metric_pr_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_metric_pr_std(a); let sb = ml_metric_pr_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_metric_pr_cov(a, b) / (sa * sb) }
}

pub fn ml_metric_pr_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_metric_pr_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_metric_pr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_metric_pr_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_metric_pr_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_metric_pr_mse(pred, labels))
}

pub fn ml_metric_pr_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_metric_pr_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_metric_pr_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_metric_pr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_metric_pr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_metric_pr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_metric_pr_precision(pred, labels, pos); let r = ml_metric_pr_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_metric_pr_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_metric_pr_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_metric_pr_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_metric_pr_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_metric_pr_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_metric_pr_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_metric_pr_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_metric_pr_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_metric_pr_fibonacci(n : Int) -> Int {
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

pub fn ml_metric_pr_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_metric_pr_min(data); let mx = ml_metric_pr_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_metric_pr_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_metric_pr_mean(data); let sd = ml_metric_pr_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_metric_pr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_metric_pr_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_metric_pr_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_metric_pr_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_metric_pr_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_metric_pr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlmetricprFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_frame_make(size : Int) -> MlmetricprFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_frame_len(s : MlmetricprFrame) -> Int { s.size }

pub fn ml_metric_pr_frame_get(s : MlmetricprFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_frame_set(s : MlmetricprFrame, i : Int, v : Double) -> MlmetricprFrame {
  let result = ml_metric_pr_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_frame_sum(s : MlmetricprFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_frame_mean(s : MlmetricprFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_frame_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_frame_scale(s : MlmetricprFrame, f : Double) -> MlmetricprFrame {
  let result = ml_metric_pr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_frame_add(a : MlmetricprFrame, b : MlmetricprFrame) -> MlmetricprFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_frame_copy(s : MlmetricprFrame) -> MlmetricprFrame {
  let result = ml_metric_pr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_frame_fill(s : MlmetricprFrame, v : Double) -> MlmetricprFrame {
  let result = ml_metric_pr_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_frame_min(s : MlmetricprFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_frame_max(s : MlmetricprFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_frame_to_string(s : MlmetricprFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_table_make(size : Int) -> MlmetricprTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_table_len(s : MlmetricprTable) -> Int { s.size }

pub fn ml_metric_pr_table_get(s : MlmetricprTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_table_set(s : MlmetricprTable, i : Int, v : Double) -> MlmetricprTable {
  let result = ml_metric_pr_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_table_sum(s : MlmetricprTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_table_mean(s : MlmetricprTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_table_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_table_scale(s : MlmetricprTable, f : Double) -> MlmetricprTable {
  let result = ml_metric_pr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_table_add(a : MlmetricprTable, b : MlmetricprTable) -> MlmetricprTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_table_copy(s : MlmetricprTable) -> MlmetricprTable {
  let result = ml_metric_pr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_table_fill(s : MlmetricprTable, v : Double) -> MlmetricprTable {
  let result = ml_metric_pr_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_table_min(s : MlmetricprTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_table_max(s : MlmetricprTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_table_to_string(s : MlmetricprTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_graphn_make(size : Int) -> MlmetricprGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_graphn_len(s : MlmetricprGraphN) -> Int { s.size }

pub fn ml_metric_pr_graphn_get(s : MlmetricprGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_graphn_set(s : MlmetricprGraphN, i : Int, v : Double) -> MlmetricprGraphN {
  let result = ml_metric_pr_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_graphn_sum(s : MlmetricprGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_graphn_mean(s : MlmetricprGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_graphn_scale(s : MlmetricprGraphN, f : Double) -> MlmetricprGraphN {
  let result = ml_metric_pr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_graphn_add(a : MlmetricprGraphN, b : MlmetricprGraphN) -> MlmetricprGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_graphn_copy(s : MlmetricprGraphN) -> MlmetricprGraphN {
  let result = ml_metric_pr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_graphn_fill(s : MlmetricprGraphN, v : Double) -> MlmetricprGraphN {
  let result = ml_metric_pr_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_graphn_min(s : MlmetricprGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_graphn_max(s : MlmetricprGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_graphn_to_string(s : MlmetricprGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_node_make(size : Int) -> MlmetricprNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_node_len(s : MlmetricprNode) -> Int { s.size }

pub fn ml_metric_pr_node_get(s : MlmetricprNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_node_set(s : MlmetricprNode, i : Int, v : Double) -> MlmetricprNode {
  let result = ml_metric_pr_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_node_sum(s : MlmetricprNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_node_mean(s : MlmetricprNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_node_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_node_scale(s : MlmetricprNode, f : Double) -> MlmetricprNode {
  let result = ml_metric_pr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_node_add(a : MlmetricprNode, b : MlmetricprNode) -> MlmetricprNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_node_copy(s : MlmetricprNode) -> MlmetricprNode {
  let result = ml_metric_pr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_node_fill(s : MlmetricprNode, v : Double) -> MlmetricprNode {
  let result = ml_metric_pr_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_node_min(s : MlmetricprNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_node_max(s : MlmetricprNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_node_to_string(s : MlmetricprNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_edge_make(size : Int) -> MlmetricprEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_edge_len(s : MlmetricprEdge) -> Int { s.size }

pub fn ml_metric_pr_edge_get(s : MlmetricprEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_edge_set(s : MlmetricprEdge, i : Int, v : Double) -> MlmetricprEdge {
  let result = ml_metric_pr_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_edge_sum(s : MlmetricprEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_edge_mean(s : MlmetricprEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_edge_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_edge_scale(s : MlmetricprEdge, f : Double) -> MlmetricprEdge {
  let result = ml_metric_pr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_edge_add(a : MlmetricprEdge, b : MlmetricprEdge) -> MlmetricprEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_edge_copy(s : MlmetricprEdge) -> MlmetricprEdge {
  let result = ml_metric_pr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_edge_fill(s : MlmetricprEdge, v : Double) -> MlmetricprEdge {
  let result = ml_metric_pr_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_edge_min(s : MlmetricprEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_edge_max(s : MlmetricprEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_edge_to_string(s : MlmetricprEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_path_make(size : Int) -> MlmetricprPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_path_len(s : MlmetricprPath) -> Int { s.size }

pub fn ml_metric_pr_path_get(s : MlmetricprPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_path_set(s : MlmetricprPath, i : Int, v : Double) -> MlmetricprPath {
  let result = ml_metric_pr_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_path_sum(s : MlmetricprPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_path_mean(s : MlmetricprPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_path_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_path_scale(s : MlmetricprPath, f : Double) -> MlmetricprPath {
  let result = ml_metric_pr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_path_add(a : MlmetricprPath, b : MlmetricprPath) -> MlmetricprPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_path_copy(s : MlmetricprPath) -> MlmetricprPath {
  let result = ml_metric_pr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_path_fill(s : MlmetricprPath, v : Double) -> MlmetricprPath {
  let result = ml_metric_pr_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_path_min(s : MlmetricprPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_path_max(s : MlmetricprPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_path_to_string(s : MlmetricprPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cluster_make(size : Int) -> MlmetricprCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_cluster_len(s : MlmetricprCluster) -> Int { s.size }

pub fn ml_metric_pr_cluster_get(s : MlmetricprCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_cluster_set(s : MlmetricprCluster, i : Int, v : Double) -> MlmetricprCluster {
  let result = ml_metric_pr_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_cluster_sum(s : MlmetricprCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_cluster_mean(s : MlmetricprCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_cluster_scale(s : MlmetricprCluster, f : Double) -> MlmetricprCluster {
  let result = ml_metric_pr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_cluster_add(a : MlmetricprCluster, b : MlmetricprCluster) -> MlmetricprCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_cluster_copy(s : MlmetricprCluster) -> MlmetricprCluster {
  let result = ml_metric_pr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_cluster_fill(s : MlmetricprCluster, v : Double) -> MlmetricprCluster {
  let result = ml_metric_pr_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_cluster_min(s : MlmetricprCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_cluster_max(s : MlmetricprCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_cluster_to_string(s : MlmetricprCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_model_make(size : Int) -> MlmetricprModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_model_len(s : MlmetricprModel) -> Int { s.size }

pub fn ml_metric_pr_model_get(s : MlmetricprModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_model_set(s : MlmetricprModel, i : Int, v : Double) -> MlmetricprModel {
  let result = ml_metric_pr_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_model_sum(s : MlmetricprModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_model_mean(s : MlmetricprModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_model_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_model_scale(s : MlmetricprModel, f : Double) -> MlmetricprModel {
  let result = ml_metric_pr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_model_add(a : MlmetricprModel, b : MlmetricprModel) -> MlmetricprModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_model_copy(s : MlmetricprModel) -> MlmetricprModel {
  let result = ml_metric_pr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_model_fill(s : MlmetricprModel, v : Double) -> MlmetricprModel {
  let result = ml_metric_pr_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_model_min(s : MlmetricprModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_model_max(s : MlmetricprModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_model_to_string(s : MlmetricprModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_layer_make(size : Int) -> MlmetricprLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_layer_len(s : MlmetricprLayer) -> Int { s.size }

pub fn ml_metric_pr_layer_get(s : MlmetricprLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_layer_set(s : MlmetricprLayer, i : Int, v : Double) -> MlmetricprLayer {
  let result = ml_metric_pr_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_layer_sum(s : MlmetricprLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_layer_mean(s : MlmetricprLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_layer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_layer_scale(s : MlmetricprLayer, f : Double) -> MlmetricprLayer {
  let result = ml_metric_pr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_layer_add(a : MlmetricprLayer, b : MlmetricprLayer) -> MlmetricprLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_layer_copy(s : MlmetricprLayer) -> MlmetricprLayer {
  let result = ml_metric_pr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_layer_fill(s : MlmetricprLayer, v : Double) -> MlmetricprLayer {
  let result = ml_metric_pr_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_layer_min(s : MlmetricprLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_layer_max(s : MlmetricprLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_layer_to_string(s : MlmetricprLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_buffer_make(size : Int) -> MlmetricprBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_buffer_len(s : MlmetricprBuffer) -> Int { s.size }

pub fn ml_metric_pr_buffer_get(s : MlmetricprBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_buffer_set(s : MlmetricprBuffer, i : Int, v : Double) -> MlmetricprBuffer {
  let result = ml_metric_pr_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_buffer_sum(s : MlmetricprBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_buffer_mean(s : MlmetricprBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_buffer_scale(s : MlmetricprBuffer, f : Double) -> MlmetricprBuffer {
  let result = ml_metric_pr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_buffer_add(a : MlmetricprBuffer, b : MlmetricprBuffer) -> MlmetricprBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_buffer_copy(s : MlmetricprBuffer) -> MlmetricprBuffer {
  let result = ml_metric_pr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_buffer_fill(s : MlmetricprBuffer, v : Double) -> MlmetricprBuffer {
  let result = ml_metric_pr_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_buffer_min(s : MlmetricprBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_buffer_max(s : MlmetricprBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_buffer_to_string(s : MlmetricprBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_cursor_make(size : Int) -> MlmetricprCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_cursor_len(s : MlmetricprCursor) -> Int { s.size }

pub fn ml_metric_pr_cursor_get(s : MlmetricprCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_cursor_set(s : MlmetricprCursor, i : Int, v : Double) -> MlmetricprCursor {
  let result = ml_metric_pr_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_cursor_sum(s : MlmetricprCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_cursor_mean(s : MlmetricprCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_cursor_scale(s : MlmetricprCursor, f : Double) -> MlmetricprCursor {
  let result = ml_metric_pr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_cursor_add(a : MlmetricprCursor, b : MlmetricprCursor) -> MlmetricprCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_cursor_copy(s : MlmetricprCursor) -> MlmetricprCursor {
  let result = ml_metric_pr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_cursor_fill(s : MlmetricprCursor, v : Double) -> MlmetricprCursor {
  let result = ml_metric_pr_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_cursor_min(s : MlmetricprCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_cursor_max(s : MlmetricprCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_cursor_to_string(s : MlmetricprCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_view_make(size : Int) -> MlmetricprView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_view_len(s : MlmetricprView) -> Int { s.size }

pub fn ml_metric_pr_view_get(s : MlmetricprView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_view_set(s : MlmetricprView, i : Int, v : Double) -> MlmetricprView {
  let result = ml_metric_pr_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_view_sum(s : MlmetricprView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_view_mean(s : MlmetricprView) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_view_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_view_scale(s : MlmetricprView, f : Double) -> MlmetricprView {
  let result = ml_metric_pr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_view_add(a : MlmetricprView, b : MlmetricprView) -> MlmetricprView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_view_copy(s : MlmetricprView) -> MlmetricprView {
  let result = ml_metric_pr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_view_fill(s : MlmetricprView, v : Double) -> MlmetricprView {
  let result = ml_metric_pr_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_view_min(s : MlmetricprView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_view_max(s : MlmetricprView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_view_to_string(s : MlmetricprView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_range_make(size : Int) -> MlmetricprRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_range_len(s : MlmetricprRange) -> Int { s.size }

pub fn ml_metric_pr_range_get(s : MlmetricprRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_range_set(s : MlmetricprRange, i : Int, v : Double) -> MlmetricprRange {
  let result = ml_metric_pr_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_range_sum(s : MlmetricprRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_range_mean(s : MlmetricprRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_range_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_range_scale(s : MlmetricprRange, f : Double) -> MlmetricprRange {
  let result = ml_metric_pr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_range_add(a : MlmetricprRange, b : MlmetricprRange) -> MlmetricprRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_range_copy(s : MlmetricprRange) -> MlmetricprRange {
  let result = ml_metric_pr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_range_fill(s : MlmetricprRange, v : Double) -> MlmetricprRange {
  let result = ml_metric_pr_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_range_min(s : MlmetricprRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_range_max(s : MlmetricprRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_range_to_string(s : MlmetricprRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricprSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_pr_slice_make(size : Int) -> MlmetricprSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_pr_slice_len(s : MlmetricprSlice) -> Int { s.size }

pub fn ml_metric_pr_slice_get(s : MlmetricprSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_pr_slice_set(s : MlmetricprSlice, i : Int, v : Double) -> MlmetricprSlice {
  let result = ml_metric_pr_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_slice_sum(s : MlmetricprSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_metric_pr_slice_mean(s : MlmetricprSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_metric_pr_slice_sum(s) / s.size.to_double() }
}

pub fn ml_metric_pr_slice_scale(s : MlmetricprSlice, f : Double) -> MlmetricprSlice {
  let result = ml_metric_pr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_metric_pr_slice_add(a : MlmetricprSlice, b : MlmetricprSlice) -> MlmetricprSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_metric_pr_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_metric_pr_slice_copy(s : MlmetricprSlice) -> MlmetricprSlice {
  let result = ml_metric_pr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_metric_pr_slice_fill(s : MlmetricprSlice, v : Double) -> MlmetricprSlice {
  let result = ml_metric_pr_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_metric_pr_slice_min(s : MlmetricprSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_slice_max(s : MlmetricprSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_metric_pr_slice_to_string(s : MlmetricprSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


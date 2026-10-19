///===
/// extcore/ml_cluster_optics

pub(all) struct MlclusteropticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_optics_make_point(x : Double, y : Double) -> MlclusteropticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_optics_make_point3(x : Double, y : Double, z : Double) -> MlclusteropticsPoint {
  { x, y, z, label: 0 }
}

pub fn ml_cluster_optics_point_x(pt : MlclusteropticsPoint) -> Double { pt.x }

pub fn ml_cluster_optics_point_y(pt : MlclusteropticsPoint) -> Double { pt.y }

pub fn ml_cluster_optics_point_z(pt : MlclusteropticsPoint) -> Double { pt.z }

pub fn ml_cluster_optics_point_label(pt : MlclusteropticsPoint) -> Int { pt.label }

pub fn ml_cluster_optics_point_dist(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_cluster_optics_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_cluster_optics_point_add(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_cluster_optics_point_sub(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_cluster_optics_point_scale(pt : MlclusteropticsPoint, s : Double) -> MlclusteropticsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_cluster_optics_point_dot(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_cluster_optics_point_cross(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_cluster_optics_point_norm(pt : MlclusteropticsPoint) -> Double {
  ml_cluster_optics_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_cluster_optics_point_normalize(pt : MlclusteropticsPoint) -> MlclusteropticsPoint {
  let n = ml_cluster_optics_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_cluster_optics_point_scale(pt, 1.0 / n) }
}

pub fn ml_cluster_optics_point_negate(pt : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_cluster_optics_point_mid(a : MlclusteropticsPoint, b : MlclusteropticsPoint) -> MlclusteropticsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_cluster_optics_point_lerp(a : MlclusteropticsPoint, b : MlclusteropticsPoint, t : Double) -> MlclusteropticsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_cluster_optics_point_to_string(pt : MlclusteropticsPoint) -> String {
  "(" + ml_cluster_optics_dbl(pt.x) + ", " + ml_cluster_optics_dbl(pt.y) + ", " + ml_cluster_optics_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclusteropticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_optics_make_series(vals : Array[Double], name : String) -> MlclusteropticsSeries {
  { vals, name, meta: 0 }
}

pub fn ml_cluster_optics_series_len(s : MlclusteropticsSeries) -> Int { s.vals.length() }

pub fn ml_cluster_optics_series_sum(s : MlclusteropticsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_cluster_optics_series_mean(s : MlclusteropticsSeries) -> Double {
  let n = ml_cluster_optics_series_len(s)
  if n == 0 { 0.0 } else { ml_cluster_optics_series_sum(s) / n.to_double() }
}

pub fn ml_cluster_optics_series_min(s : MlclusteropticsSeries) -> Double {
  let n = ml_cluster_optics_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_optics_series_max(s : MlclusteropticsSeries) -> Double {
  let n = ml_cluster_optics_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_cluster_optics_series_range(s : MlclusteropticsSeries) -> Double {
  ml_cluster_optics_series_max(s) - ml_cluster_optics_series_min(s)
}

pub fn ml_cluster_optics_series_var(s : MlclusteropticsSeries) -> Double {
  let n = ml_cluster_optics_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_cluster_optics_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_cluster_optics_series_std(s : MlclusteropticsSeries) -> Double { ml_cluster_optics_sqrt(ml_cluster_optics_series_var(s)) }

pub fn ml_cluster_optics_series_median(s : MlclusteropticsSeries) -> Double {
  let n = ml_cluster_optics_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_optics_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_optics_series_scale(s : MlclusteropticsSeries, f : Double) -> MlclusteropticsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_cluster_optics_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_cluster_optics_series_add(a : MlclusteropticsSeries, b : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_cluster_optics_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_cluster_optics_series_sub(a : MlclusteropticsSeries, b : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_cluster_optics_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_cluster_optics_series_normalize(s : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let mn = ml_cluster_optics_series_min(s)
  let mx = ml_cluster_optics_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_cluster_optics_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_cluster_optics_series_cumsum(s : MlclusteropticsSeries) -> MlclusteropticsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_cluster_optics_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_cluster_optics_series_to_string(s : MlclusteropticsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_cluster_optics_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteropticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_optics_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteropticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_optics_matrix_identity(n : Int) -> MlclusteropticsMatrix {
  let m = ml_cluster_optics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_cluster_optics_matrix_get(m : MlclusteropticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_cluster_optics_matrix_transpose(m : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_cluster_optics_matrix_add(a : MlclusteropticsMatrix, b : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_cluster_optics_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_cluster_optics_matrix_scale(m : MlclusteropticsMatrix, s : Double) -> MlclusteropticsMatrix {
  let result = ml_cluster_optics_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_cluster_optics_matrix_multiply(a : MlclusteropticsMatrix, b : MlclusteropticsMatrix) -> MlclusteropticsMatrix {
  if a.cols != b.rows { return ml_cluster_optics_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_cluster_optics_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_cluster_optics_matrix_trace(m : MlclusteropticsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_cluster_optics_matrix_det(m : MlclusteropticsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_cluster_optics_matrix_norm(m : MlclusteropticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_cluster_optics_sqrt(sum)
}

pub fn ml_cluster_optics_matrix_to_string(m : MlclusteropticsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_cluster_optics_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlclusteropticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_optics_make_vector(comps : Array[Double]) -> MlclusteropticsVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_optics_vector_zero(dim : Int) -> MlclusteropticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_cluster_optics_vector_add(a : MlclusteropticsVector, b : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_cluster_optics_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_optics_vector_sub(a : MlclusteropticsVector, b : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_cluster_optics_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_cluster_optics_vector_scale(v : MlclusteropticsVector, s : Double) -> MlclusteropticsVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_cluster_optics_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_cluster_optics_vector_dot(a : MlclusteropticsVector, b : MlclusteropticsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_cluster_optics_vector_norm(v : MlclusteropticsVector) -> Double { ml_cluster_optics_sqrt(ml_cluster_optics_vector_dot(v, v)) }

pub fn ml_cluster_optics_vector_normalize(v : MlclusteropticsVector) -> MlclusteropticsVector {
  let n = ml_cluster_optics_vector_norm(v)
  if n < 0.0000001 { v } else { ml_cluster_optics_vector_scale(v, 1.0 / n) }
}

pub fn ml_cluster_optics_vector_dist(a : MlclusteropticsVector, b : MlclusteropticsVector) -> Double {
  ml_cluster_optics_vector_norm(ml_cluster_optics_vector_sub(a, b))
}

pub fn ml_cluster_optics_vector_to_string(v : MlclusteropticsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_cluster_optics_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_optics_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_cluster_optics_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_cluster_optics_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_optics_std(data : Array[Double]) -> Double { ml_cluster_optics_sqrt(ml_cluster_optics_var(data)) }

pub fn ml_cluster_optics_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_cluster_optics_mean(a); let mb = ml_cluster_optics_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_optics_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_cluster_optics_std(a); let sb = ml_cluster_optics_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_cluster_optics_cov(a, b) / (sa * sb) }
}

pub fn ml_cluster_optics_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_cluster_optics_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_cluster_optics_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_cluster_optics_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_cluster_optics_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_cluster_optics_sqrt(ml_cluster_optics_mse(pred, labels))
}

pub fn ml_cluster_optics_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_cluster_optics_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_cluster_optics_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_cluster_optics_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_cluster_optics_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_cluster_optics_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_cluster_optics_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_cluster_optics_precision(pred, labels, pos); let r = ml_cluster_optics_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_cluster_optics_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_cluster_optics_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_cluster_optics_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_cluster_optics_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_cluster_optics_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_cluster_optics_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_cluster_optics_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_cluster_optics_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_cluster_optics_fibonacci(n : Int) -> Int {
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

pub fn ml_cluster_optics_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_cluster_optics_min(data); let mx = ml_cluster_optics_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_cluster_optics_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_cluster_optics_mean(data); let sd = ml_cluster_optics_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_cluster_optics_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_cluster_optics_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_optics_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_cluster_optics_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_cluster_optics_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_cluster_optics_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_cluster_optics_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_cluster_optics_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_cluster_optics_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_cluster_optics_int(x) } else { -ml_cluster_optics_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_cluster_optics_int(f * 1000000.0) } else { ml_cluster_optics_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_cluster_optics_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_cluster_optics_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlclusteropticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_frame_make(size : Int) -> MlclusteropticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_frame_len(s : MlclusteropticsFrame) -> Int { s.size }

pub fn ml_cluster_optics_frame_get(s : MlclusteropticsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_frame_set(s : MlclusteropticsFrame, i : Int, v : Double) -> MlclusteropticsFrame {
  let result = ml_cluster_optics_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_frame_sum(s : MlclusteropticsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_frame_mean(s : MlclusteropticsFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_frame_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_frame_scale(s : MlclusteropticsFrame, f : Double) -> MlclusteropticsFrame {
  let result = ml_cluster_optics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_frame_add(a : MlclusteropticsFrame, b : MlclusteropticsFrame) -> MlclusteropticsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_frame_copy(s : MlclusteropticsFrame) -> MlclusteropticsFrame {
  let result = ml_cluster_optics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_frame_fill(s : MlclusteropticsFrame, v : Double) -> MlclusteropticsFrame {
  let result = ml_cluster_optics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_frame_min(s : MlclusteropticsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_frame_max(s : MlclusteropticsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_frame_to_string(s : MlclusteropticsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_table_make(size : Int) -> MlclusteropticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_table_len(s : MlclusteropticsTable) -> Int { s.size }

pub fn ml_cluster_optics_table_get(s : MlclusteropticsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_table_set(s : MlclusteropticsTable, i : Int, v : Double) -> MlclusteropticsTable {
  let result = ml_cluster_optics_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_table_sum(s : MlclusteropticsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_table_mean(s : MlclusteropticsTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_table_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_table_scale(s : MlclusteropticsTable, f : Double) -> MlclusteropticsTable {
  let result = ml_cluster_optics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_table_add(a : MlclusteropticsTable, b : MlclusteropticsTable) -> MlclusteropticsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_table_copy(s : MlclusteropticsTable) -> MlclusteropticsTable {
  let result = ml_cluster_optics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_table_fill(s : MlclusteropticsTable, v : Double) -> MlclusteropticsTable {
  let result = ml_cluster_optics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_table_min(s : MlclusteropticsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_table_max(s : MlclusteropticsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_table_to_string(s : MlclusteropticsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_graphn_make(size : Int) -> MlclusteropticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_graphn_len(s : MlclusteropticsGraphN) -> Int { s.size }

pub fn ml_cluster_optics_graphn_get(s : MlclusteropticsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_graphn_set(s : MlclusteropticsGraphN, i : Int, v : Double) -> MlclusteropticsGraphN {
  let result = ml_cluster_optics_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_graphn_sum(s : MlclusteropticsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_graphn_mean(s : MlclusteropticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_graphn_scale(s : MlclusteropticsGraphN, f : Double) -> MlclusteropticsGraphN {
  let result = ml_cluster_optics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_graphn_add(a : MlclusteropticsGraphN, b : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_graphn_copy(s : MlclusteropticsGraphN) -> MlclusteropticsGraphN {
  let result = ml_cluster_optics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_graphn_fill(s : MlclusteropticsGraphN, v : Double) -> MlclusteropticsGraphN {
  let result = ml_cluster_optics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_graphn_min(s : MlclusteropticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_graphn_max(s : MlclusteropticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_graphn_to_string(s : MlclusteropticsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_node_make(size : Int) -> MlclusteropticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_node_len(s : MlclusteropticsNode) -> Int { s.size }

pub fn ml_cluster_optics_node_get(s : MlclusteropticsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_node_set(s : MlclusteropticsNode, i : Int, v : Double) -> MlclusteropticsNode {
  let result = ml_cluster_optics_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_node_sum(s : MlclusteropticsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_node_mean(s : MlclusteropticsNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_node_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_node_scale(s : MlclusteropticsNode, f : Double) -> MlclusteropticsNode {
  let result = ml_cluster_optics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_node_add(a : MlclusteropticsNode, b : MlclusteropticsNode) -> MlclusteropticsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_node_copy(s : MlclusteropticsNode) -> MlclusteropticsNode {
  let result = ml_cluster_optics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_node_fill(s : MlclusteropticsNode, v : Double) -> MlclusteropticsNode {
  let result = ml_cluster_optics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_node_min(s : MlclusteropticsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_node_max(s : MlclusteropticsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_node_to_string(s : MlclusteropticsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_edge_make(size : Int) -> MlclusteropticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_edge_len(s : MlclusteropticsEdge) -> Int { s.size }

pub fn ml_cluster_optics_edge_get(s : MlclusteropticsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_edge_set(s : MlclusteropticsEdge, i : Int, v : Double) -> MlclusteropticsEdge {
  let result = ml_cluster_optics_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_edge_sum(s : MlclusteropticsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_edge_mean(s : MlclusteropticsEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_edge_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_edge_scale(s : MlclusteropticsEdge, f : Double) -> MlclusteropticsEdge {
  let result = ml_cluster_optics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_edge_add(a : MlclusteropticsEdge, b : MlclusteropticsEdge) -> MlclusteropticsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_edge_copy(s : MlclusteropticsEdge) -> MlclusteropticsEdge {
  let result = ml_cluster_optics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_edge_fill(s : MlclusteropticsEdge, v : Double) -> MlclusteropticsEdge {
  let result = ml_cluster_optics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_edge_min(s : MlclusteropticsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_edge_max(s : MlclusteropticsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_edge_to_string(s : MlclusteropticsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_path_make(size : Int) -> MlclusteropticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_path_len(s : MlclusteropticsPath) -> Int { s.size }

pub fn ml_cluster_optics_path_get(s : MlclusteropticsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_path_set(s : MlclusteropticsPath, i : Int, v : Double) -> MlclusteropticsPath {
  let result = ml_cluster_optics_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_path_sum(s : MlclusteropticsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_path_mean(s : MlclusteropticsPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_path_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_path_scale(s : MlclusteropticsPath, f : Double) -> MlclusteropticsPath {
  let result = ml_cluster_optics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_path_add(a : MlclusteropticsPath, b : MlclusteropticsPath) -> MlclusteropticsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_path_copy(s : MlclusteropticsPath) -> MlclusteropticsPath {
  let result = ml_cluster_optics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_path_fill(s : MlclusteropticsPath, v : Double) -> MlclusteropticsPath {
  let result = ml_cluster_optics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_path_min(s : MlclusteropticsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_path_max(s : MlclusteropticsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_path_to_string(s : MlclusteropticsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cluster_make(size : Int) -> MlclusteropticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_cluster_len(s : MlclusteropticsCluster) -> Int { s.size }

pub fn ml_cluster_optics_cluster_get(s : MlclusteropticsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_cluster_set(s : MlclusteropticsCluster, i : Int, v : Double) -> MlclusteropticsCluster {
  let result = ml_cluster_optics_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_cluster_sum(s : MlclusteropticsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_cluster_mean(s : MlclusteropticsCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_cluster_scale(s : MlclusteropticsCluster, f : Double) -> MlclusteropticsCluster {
  let result = ml_cluster_optics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_cluster_add(a : MlclusteropticsCluster, b : MlclusteropticsCluster) -> MlclusteropticsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_cluster_copy(s : MlclusteropticsCluster) -> MlclusteropticsCluster {
  let result = ml_cluster_optics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_cluster_fill(s : MlclusteropticsCluster, v : Double) -> MlclusteropticsCluster {
  let result = ml_cluster_optics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_cluster_min(s : MlclusteropticsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_cluster_max(s : MlclusteropticsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_cluster_to_string(s : MlclusteropticsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_model_make(size : Int) -> MlclusteropticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_model_len(s : MlclusteropticsModel) -> Int { s.size }

pub fn ml_cluster_optics_model_get(s : MlclusteropticsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_model_set(s : MlclusteropticsModel, i : Int, v : Double) -> MlclusteropticsModel {
  let result = ml_cluster_optics_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_model_sum(s : MlclusteropticsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_model_mean(s : MlclusteropticsModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_model_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_model_scale(s : MlclusteropticsModel, f : Double) -> MlclusteropticsModel {
  let result = ml_cluster_optics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_model_add(a : MlclusteropticsModel, b : MlclusteropticsModel) -> MlclusteropticsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_model_copy(s : MlclusteropticsModel) -> MlclusteropticsModel {
  let result = ml_cluster_optics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_model_fill(s : MlclusteropticsModel, v : Double) -> MlclusteropticsModel {
  let result = ml_cluster_optics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_model_min(s : MlclusteropticsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_model_max(s : MlclusteropticsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_model_to_string(s : MlclusteropticsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_layer_make(size : Int) -> MlclusteropticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_layer_len(s : MlclusteropticsLayer) -> Int { s.size }

pub fn ml_cluster_optics_layer_get(s : MlclusteropticsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_layer_set(s : MlclusteropticsLayer, i : Int, v : Double) -> MlclusteropticsLayer {
  let result = ml_cluster_optics_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_layer_sum(s : MlclusteropticsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_layer_mean(s : MlclusteropticsLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_layer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_layer_scale(s : MlclusteropticsLayer, f : Double) -> MlclusteropticsLayer {
  let result = ml_cluster_optics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_layer_add(a : MlclusteropticsLayer, b : MlclusteropticsLayer) -> MlclusteropticsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_layer_copy(s : MlclusteropticsLayer) -> MlclusteropticsLayer {
  let result = ml_cluster_optics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_layer_fill(s : MlclusteropticsLayer, v : Double) -> MlclusteropticsLayer {
  let result = ml_cluster_optics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_layer_min(s : MlclusteropticsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_layer_max(s : MlclusteropticsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_layer_to_string(s : MlclusteropticsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_buffer_make(size : Int) -> MlclusteropticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_buffer_len(s : MlclusteropticsBuffer) -> Int { s.size }

pub fn ml_cluster_optics_buffer_get(s : MlclusteropticsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_buffer_set(s : MlclusteropticsBuffer, i : Int, v : Double) -> MlclusteropticsBuffer {
  let result = ml_cluster_optics_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_buffer_sum(s : MlclusteropticsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_buffer_mean(s : MlclusteropticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_buffer_scale(s : MlclusteropticsBuffer, f : Double) -> MlclusteropticsBuffer {
  let result = ml_cluster_optics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_buffer_add(a : MlclusteropticsBuffer, b : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_buffer_copy(s : MlclusteropticsBuffer) -> MlclusteropticsBuffer {
  let result = ml_cluster_optics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_buffer_fill(s : MlclusteropticsBuffer, v : Double) -> MlclusteropticsBuffer {
  let result = ml_cluster_optics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_buffer_min(s : MlclusteropticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_buffer_max(s : MlclusteropticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_buffer_to_string(s : MlclusteropticsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_cursor_make(size : Int) -> MlclusteropticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_cursor_len(s : MlclusteropticsCursor) -> Int { s.size }

pub fn ml_cluster_optics_cursor_get(s : MlclusteropticsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_cursor_set(s : MlclusteropticsCursor, i : Int, v : Double) -> MlclusteropticsCursor {
  let result = ml_cluster_optics_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_cursor_sum(s : MlclusteropticsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_cursor_mean(s : MlclusteropticsCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_cursor_scale(s : MlclusteropticsCursor, f : Double) -> MlclusteropticsCursor {
  let result = ml_cluster_optics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_cursor_add(a : MlclusteropticsCursor, b : MlclusteropticsCursor) -> MlclusteropticsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_cursor_copy(s : MlclusteropticsCursor) -> MlclusteropticsCursor {
  let result = ml_cluster_optics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_cursor_fill(s : MlclusteropticsCursor, v : Double) -> MlclusteropticsCursor {
  let result = ml_cluster_optics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_cursor_min(s : MlclusteropticsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_cursor_max(s : MlclusteropticsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_cursor_to_string(s : MlclusteropticsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_view_make(size : Int) -> MlclusteropticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_view_len(s : MlclusteropticsView) -> Int { s.size }

pub fn ml_cluster_optics_view_get(s : MlclusteropticsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_view_set(s : MlclusteropticsView, i : Int, v : Double) -> MlclusteropticsView {
  let result = ml_cluster_optics_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_view_sum(s : MlclusteropticsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_view_mean(s : MlclusteropticsView) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_view_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_view_scale(s : MlclusteropticsView, f : Double) -> MlclusteropticsView {
  let result = ml_cluster_optics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_view_add(a : MlclusteropticsView, b : MlclusteropticsView) -> MlclusteropticsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_view_copy(s : MlclusteropticsView) -> MlclusteropticsView {
  let result = ml_cluster_optics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_view_fill(s : MlclusteropticsView, v : Double) -> MlclusteropticsView {
  let result = ml_cluster_optics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_view_min(s : MlclusteropticsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_view_max(s : MlclusteropticsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_view_to_string(s : MlclusteropticsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_range_make(size : Int) -> MlclusteropticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_range_len(s : MlclusteropticsRange) -> Int { s.size }

pub fn ml_cluster_optics_range_get(s : MlclusteropticsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_range_set(s : MlclusteropticsRange, i : Int, v : Double) -> MlclusteropticsRange {
  let result = ml_cluster_optics_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_range_sum(s : MlclusteropticsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_range_mean(s : MlclusteropticsRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_range_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_range_scale(s : MlclusteropticsRange, f : Double) -> MlclusteropticsRange {
  let result = ml_cluster_optics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_range_add(a : MlclusteropticsRange, b : MlclusteropticsRange) -> MlclusteropticsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_range_copy(s : MlclusteropticsRange) -> MlclusteropticsRange {
  let result = ml_cluster_optics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_range_fill(s : MlclusteropticsRange, v : Double) -> MlclusteropticsRange {
  let result = ml_cluster_optics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_range_min(s : MlclusteropticsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_range_max(s : MlclusteropticsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_range_to_string(s : MlclusteropticsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteropticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_optics_slice_make(size : Int) -> MlclusteropticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_optics_slice_len(s : MlclusteropticsSlice) -> Int { s.size }

pub fn ml_cluster_optics_slice_get(s : MlclusteropticsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_optics_slice_set(s : MlclusteropticsSlice, i : Int, v : Double) -> MlclusteropticsSlice {
  let result = ml_cluster_optics_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_slice_sum(s : MlclusteropticsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_cluster_optics_slice_mean(s : MlclusteropticsSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_cluster_optics_slice_sum(s) / s.size.to_double() }
}

pub fn ml_cluster_optics_slice_scale(s : MlclusteropticsSlice, f : Double) -> MlclusteropticsSlice {
  let result = ml_cluster_optics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_cluster_optics_slice_add(a : MlclusteropticsSlice, b : MlclusteropticsSlice) -> MlclusteropticsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_cluster_optics_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_cluster_optics_slice_copy(s : MlclusteropticsSlice) -> MlclusteropticsSlice {
  let result = ml_cluster_optics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_cluster_optics_slice_fill(s : MlclusteropticsSlice, v : Double) -> MlclusteropticsSlice {
  let result = ml_cluster_optics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_cluster_optics_slice_min(s : MlclusteropticsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_slice_max(s : MlclusteropticsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_cluster_optics_slice_to_string(s : MlclusteropticsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_cluster_optics_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_cluster_optics_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


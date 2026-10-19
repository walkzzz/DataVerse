///===
/// extcore/ml_regress_elastic

pub(all) struct MlregresselasticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_elastic_make_point(x : Double, y : Double) -> MlregresselasticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_elastic_make_point3(x : Double, y : Double, z : Double) -> MlregresselasticPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_elastic_point_x(pt : MlregresselasticPoint) -> Double { pt.x }

pub fn ml_regress_elastic_point_y(pt : MlregresselasticPoint) -> Double { pt.y }

pub fn ml_regress_elastic_point_z(pt : MlregresselasticPoint) -> Double { pt.z }

pub fn ml_regress_elastic_point_label(pt : MlregresselasticPoint) -> Int { pt.label }

pub fn ml_regress_elastic_point_dist(a : MlregresselasticPoint, b : MlregresselasticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_regress_elastic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_elastic_point_add(a : MlregresselasticPoint, b : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_elastic_point_sub(a : MlregresselasticPoint, b : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_elastic_point_scale(pt : MlregresselasticPoint, s : Double) -> MlregresselasticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_elastic_point_dot(a : MlregresselasticPoint, b : MlregresselasticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_elastic_point_cross(a : MlregresselasticPoint, b : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_elastic_point_norm(pt : MlregresselasticPoint) -> Double {
  ml_regress_elastic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_elastic_point_normalize(pt : MlregresselasticPoint) -> MlregresselasticPoint {
  let n = ml_regress_elastic_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_elastic_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_elastic_point_negate(pt : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_elastic_point_mid(a : MlregresselasticPoint, b : MlregresselasticPoint) -> MlregresselasticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_elastic_point_lerp(a : MlregresselasticPoint, b : MlregresselasticPoint, t : Double) -> MlregresselasticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_elastic_point_to_string(pt : MlregresselasticPoint) -> String {
  "(" + ml_regress_elastic_dbl(pt.x) + ", " + ml_regress_elastic_dbl(pt.y) + ", " + ml_regress_elastic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresselasticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_elastic_make_series(vals : Array[Double], name : String) -> MlregresselasticSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_elastic_series_len(s : MlregresselasticSeries) -> Int { s.vals.length() }

pub fn ml_regress_elastic_series_sum(s : MlregresselasticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_elastic_series_mean(s : MlregresselasticSeries) -> Double {
  let n = ml_regress_elastic_series_len(s)
  if n == 0 { 0.0 } else { ml_regress_elastic_series_sum(s) / n.to_double() }
}

pub fn ml_regress_elastic_series_min(s : MlregresselasticSeries) -> Double {
  let n = ml_regress_elastic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_elastic_series_max(s : MlregresselasticSeries) -> Double {
  let n = ml_regress_elastic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_elastic_series_range(s : MlregresselasticSeries) -> Double {
  ml_regress_elastic_series_max(s) - ml_regress_elastic_series_min(s)
}

pub fn ml_regress_elastic_series_var(s : MlregresselasticSeries) -> Double {
  let n = ml_regress_elastic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_regress_elastic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_regress_elastic_series_std(s : MlregresselasticSeries) -> Double { ml_regress_elastic_sqrt(ml_regress_elastic_series_var(s)) }

pub fn ml_regress_elastic_series_median(s : MlregresselasticSeries) -> Double {
  let n = ml_regress_elastic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_elastic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_elastic_series_scale(s : MlregresselasticSeries, f : Double) -> MlregresselasticSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_regress_elastic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_elastic_series_add(a : MlregresselasticSeries, b : MlregresselasticSeries) -> MlregresselasticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_regress_elastic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_elastic_series_sub(a : MlregresselasticSeries, b : MlregresselasticSeries) -> MlregresselasticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_regress_elastic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_elastic_series_normalize(s : MlregresselasticSeries) -> MlregresselasticSeries {
  let mn = ml_regress_elastic_series_min(s)
  let mx = ml_regress_elastic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_regress_elastic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_elastic_series_cumsum(s : MlregresselasticSeries) -> MlregresselasticSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_regress_elastic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_elastic_series_to_string(s : MlregresselasticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_regress_elastic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresselasticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_elastic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresselasticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_elastic_matrix_identity(n : Int) -> MlregresselasticMatrix {
  let m = ml_regress_elastic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_elastic_matrix_get(m : MlregresselasticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_elastic_matrix_transpose(m : MlregresselasticMatrix) -> MlregresselasticMatrix {
  let result = ml_regress_elastic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_elastic_matrix_add(a : MlregresselasticMatrix, b : MlregresselasticMatrix) -> MlregresselasticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_elastic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_elastic_matrix_scale(m : MlregresselasticMatrix, s : Double) -> MlregresselasticMatrix {
  let result = ml_regress_elastic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_elastic_matrix_multiply(a : MlregresselasticMatrix, b : MlregresselasticMatrix) -> MlregresselasticMatrix {
  if a.cols != b.rows { return ml_regress_elastic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_elastic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_elastic_matrix_trace(m : MlregresselasticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_elastic_matrix_det(m : MlregresselasticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_elastic_matrix_norm(m : MlregresselasticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_regress_elastic_sqrt(sum)
}

pub fn ml_regress_elastic_matrix_to_string(m : MlregresselasticMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_regress_elastic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlregresselasticVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_elastic_make_vector(comps : Array[Double]) -> MlregresselasticVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_elastic_vector_zero(dim : Int) -> MlregresselasticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_elastic_vector_add(a : MlregresselasticVector, b : MlregresselasticVector) -> MlregresselasticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_regress_elastic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_elastic_vector_sub(a : MlregresselasticVector, b : MlregresselasticVector) -> MlregresselasticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_regress_elastic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_elastic_vector_scale(v : MlregresselasticVector, s : Double) -> MlregresselasticVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_regress_elastic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_elastic_vector_dot(a : MlregresselasticVector, b : MlregresselasticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_elastic_vector_norm(v : MlregresselasticVector) -> Double { ml_regress_elastic_sqrt(ml_regress_elastic_vector_dot(v, v)) }

pub fn ml_regress_elastic_vector_normalize(v : MlregresselasticVector) -> MlregresselasticVector {
  let n = ml_regress_elastic_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_elastic_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_elastic_vector_dist(a : MlregresselasticVector, b : MlregresselasticVector) -> Double {
  ml_regress_elastic_vector_norm(ml_regress_elastic_vector_sub(a, b))
}

pub fn ml_regress_elastic_vector_to_string(v : MlregresselasticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_regress_elastic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_elastic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_regress_elastic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_regress_elastic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_elastic_std(data : Array[Double]) -> Double { ml_regress_elastic_sqrt(ml_regress_elastic_var(data)) }

pub fn ml_regress_elastic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_regress_elastic_mean(a); let mb = ml_regress_elastic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_regress_elastic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_regress_elastic_std(a); let sb = ml_regress_elastic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_regress_elastic_cov(a, b) / (sa * sb) }
}

pub fn ml_regress_elastic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_elastic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_elastic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_regress_elastic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_regress_elastic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_regress_elastic_sqrt(ml_regress_elastic_mse(pred, labels))
}

pub fn ml_regress_elastic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_regress_elastic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_regress_elastic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_regress_elastic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_regress_elastic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_regress_elastic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_regress_elastic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_regress_elastic_precision(pred, labels, pos); let r = ml_regress_elastic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_regress_elastic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_regress_elastic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_regress_elastic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_regress_elastic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_regress_elastic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_regress_elastic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_regress_elastic_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_regress_elastic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_regress_elastic_fibonacci(n : Int) -> Int {
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

pub fn ml_regress_elastic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_regress_elastic_min(data); let mx = ml_regress_elastic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_regress_elastic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_regress_elastic_mean(data); let sd = ml_regress_elastic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_regress_elastic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_regress_elastic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_regress_elastic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_regress_elastic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_regress_elastic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_regress_elastic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_regress_elastic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_regress_elastic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_regress_elastic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_regress_elastic_int(x) } else { -ml_regress_elastic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_regress_elastic_int(f * 1000000.0) } else { ml_regress_elastic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_regress_elastic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_regress_elastic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlregresselasticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_frame_make(size : Int) -> MlregresselasticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_frame_len(s : MlregresselasticFrame) -> Int { s.size }

pub fn ml_regress_elastic_frame_get(s : MlregresselasticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_frame_set(s : MlregresselasticFrame, i : Int, v : Double) -> MlregresselasticFrame {
  let result = ml_regress_elastic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_frame_sum(s : MlregresselasticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_frame_mean(s : MlregresselasticFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_frame_scale(s : MlregresselasticFrame, f : Double) -> MlregresselasticFrame {
  let result = ml_regress_elastic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_frame_add(a : MlregresselasticFrame, b : MlregresselasticFrame) -> MlregresselasticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_frame_copy(s : MlregresselasticFrame) -> MlregresselasticFrame {
  let result = ml_regress_elastic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_frame_fill(s : MlregresselasticFrame, v : Double) -> MlregresselasticFrame {
  let result = ml_regress_elastic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_frame_min(s : MlregresselasticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_frame_max(s : MlregresselasticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_frame_to_string(s : MlregresselasticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_table_make(size : Int) -> MlregresselasticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_table_len(s : MlregresselasticTable) -> Int { s.size }

pub fn ml_regress_elastic_table_get(s : MlregresselasticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_table_set(s : MlregresselasticTable, i : Int, v : Double) -> MlregresselasticTable {
  let result = ml_regress_elastic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_table_sum(s : MlregresselasticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_table_mean(s : MlregresselasticTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_table_scale(s : MlregresselasticTable, f : Double) -> MlregresselasticTable {
  let result = ml_regress_elastic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_table_add(a : MlregresselasticTable, b : MlregresselasticTable) -> MlregresselasticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_table_copy(s : MlregresselasticTable) -> MlregresselasticTable {
  let result = ml_regress_elastic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_table_fill(s : MlregresselasticTable, v : Double) -> MlregresselasticTable {
  let result = ml_regress_elastic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_table_min(s : MlregresselasticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_table_max(s : MlregresselasticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_table_to_string(s : MlregresselasticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_graphn_make(size : Int) -> MlregresselasticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_graphn_len(s : MlregresselasticGraphN) -> Int { s.size }

pub fn ml_regress_elastic_graphn_get(s : MlregresselasticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_graphn_set(s : MlregresselasticGraphN, i : Int, v : Double) -> MlregresselasticGraphN {
  let result = ml_regress_elastic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_graphn_sum(s : MlregresselasticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_graphn_mean(s : MlregresselasticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_graphn_scale(s : MlregresselasticGraphN, f : Double) -> MlregresselasticGraphN {
  let result = ml_regress_elastic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_graphn_add(a : MlregresselasticGraphN, b : MlregresselasticGraphN) -> MlregresselasticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_graphn_copy(s : MlregresselasticGraphN) -> MlregresselasticGraphN {
  let result = ml_regress_elastic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_graphn_fill(s : MlregresselasticGraphN, v : Double) -> MlregresselasticGraphN {
  let result = ml_regress_elastic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_graphn_min(s : MlregresselasticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_graphn_max(s : MlregresselasticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_graphn_to_string(s : MlregresselasticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_node_make(size : Int) -> MlregresselasticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_node_len(s : MlregresselasticNode) -> Int { s.size }

pub fn ml_regress_elastic_node_get(s : MlregresselasticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_node_set(s : MlregresselasticNode, i : Int, v : Double) -> MlregresselasticNode {
  let result = ml_regress_elastic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_node_sum(s : MlregresselasticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_node_mean(s : MlregresselasticNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_node_scale(s : MlregresselasticNode, f : Double) -> MlregresselasticNode {
  let result = ml_regress_elastic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_node_add(a : MlregresselasticNode, b : MlregresselasticNode) -> MlregresselasticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_node_copy(s : MlregresselasticNode) -> MlregresselasticNode {
  let result = ml_regress_elastic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_node_fill(s : MlregresselasticNode, v : Double) -> MlregresselasticNode {
  let result = ml_regress_elastic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_node_min(s : MlregresselasticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_node_max(s : MlregresselasticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_node_to_string(s : MlregresselasticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_edge_make(size : Int) -> MlregresselasticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_edge_len(s : MlregresselasticEdge) -> Int { s.size }

pub fn ml_regress_elastic_edge_get(s : MlregresselasticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_edge_set(s : MlregresselasticEdge, i : Int, v : Double) -> MlregresselasticEdge {
  let result = ml_regress_elastic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_edge_sum(s : MlregresselasticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_edge_mean(s : MlregresselasticEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_edge_scale(s : MlregresselasticEdge, f : Double) -> MlregresselasticEdge {
  let result = ml_regress_elastic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_edge_add(a : MlregresselasticEdge, b : MlregresselasticEdge) -> MlregresselasticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_edge_copy(s : MlregresselasticEdge) -> MlregresselasticEdge {
  let result = ml_regress_elastic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_edge_fill(s : MlregresselasticEdge, v : Double) -> MlregresselasticEdge {
  let result = ml_regress_elastic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_edge_min(s : MlregresselasticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_edge_max(s : MlregresselasticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_edge_to_string(s : MlregresselasticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_path_make(size : Int) -> MlregresselasticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_path_len(s : MlregresselasticPath) -> Int { s.size }

pub fn ml_regress_elastic_path_get(s : MlregresselasticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_path_set(s : MlregresselasticPath, i : Int, v : Double) -> MlregresselasticPath {
  let result = ml_regress_elastic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_path_sum(s : MlregresselasticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_path_mean(s : MlregresselasticPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_path_scale(s : MlregresselasticPath, f : Double) -> MlregresselasticPath {
  let result = ml_regress_elastic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_path_add(a : MlregresselasticPath, b : MlregresselasticPath) -> MlregresselasticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_path_copy(s : MlregresselasticPath) -> MlregresselasticPath {
  let result = ml_regress_elastic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_path_fill(s : MlregresselasticPath, v : Double) -> MlregresselasticPath {
  let result = ml_regress_elastic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_path_min(s : MlregresselasticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_path_max(s : MlregresselasticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_path_to_string(s : MlregresselasticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_cluster_make(size : Int) -> MlregresselasticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_cluster_len(s : MlregresselasticCluster) -> Int { s.size }

pub fn ml_regress_elastic_cluster_get(s : MlregresselasticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_cluster_set(s : MlregresselasticCluster, i : Int, v : Double) -> MlregresselasticCluster {
  let result = ml_regress_elastic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_cluster_sum(s : MlregresselasticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_cluster_mean(s : MlregresselasticCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_cluster_scale(s : MlregresselasticCluster, f : Double) -> MlregresselasticCluster {
  let result = ml_regress_elastic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_cluster_add(a : MlregresselasticCluster, b : MlregresselasticCluster) -> MlregresselasticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_cluster_copy(s : MlregresselasticCluster) -> MlregresselasticCluster {
  let result = ml_regress_elastic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_cluster_fill(s : MlregresselasticCluster, v : Double) -> MlregresselasticCluster {
  let result = ml_regress_elastic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_cluster_min(s : MlregresselasticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_cluster_max(s : MlregresselasticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_cluster_to_string(s : MlregresselasticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_model_make(size : Int) -> MlregresselasticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_model_len(s : MlregresselasticModel) -> Int { s.size }

pub fn ml_regress_elastic_model_get(s : MlregresselasticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_model_set(s : MlregresselasticModel, i : Int, v : Double) -> MlregresselasticModel {
  let result = ml_regress_elastic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_model_sum(s : MlregresselasticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_model_mean(s : MlregresselasticModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_model_scale(s : MlregresselasticModel, f : Double) -> MlregresselasticModel {
  let result = ml_regress_elastic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_model_add(a : MlregresselasticModel, b : MlregresselasticModel) -> MlregresselasticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_model_copy(s : MlregresselasticModel) -> MlregresselasticModel {
  let result = ml_regress_elastic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_model_fill(s : MlregresselasticModel, v : Double) -> MlregresselasticModel {
  let result = ml_regress_elastic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_model_min(s : MlregresselasticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_model_max(s : MlregresselasticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_model_to_string(s : MlregresselasticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_layer_make(size : Int) -> MlregresselasticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_layer_len(s : MlregresselasticLayer) -> Int { s.size }

pub fn ml_regress_elastic_layer_get(s : MlregresselasticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_layer_set(s : MlregresselasticLayer, i : Int, v : Double) -> MlregresselasticLayer {
  let result = ml_regress_elastic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_layer_sum(s : MlregresselasticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_layer_mean(s : MlregresselasticLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_layer_scale(s : MlregresselasticLayer, f : Double) -> MlregresselasticLayer {
  let result = ml_regress_elastic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_layer_add(a : MlregresselasticLayer, b : MlregresselasticLayer) -> MlregresselasticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_layer_copy(s : MlregresselasticLayer) -> MlregresselasticLayer {
  let result = ml_regress_elastic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_layer_fill(s : MlregresselasticLayer, v : Double) -> MlregresselasticLayer {
  let result = ml_regress_elastic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_layer_min(s : MlregresselasticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_layer_max(s : MlregresselasticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_layer_to_string(s : MlregresselasticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_buffer_make(size : Int) -> MlregresselasticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_buffer_len(s : MlregresselasticBuffer) -> Int { s.size }

pub fn ml_regress_elastic_buffer_get(s : MlregresselasticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_buffer_set(s : MlregresselasticBuffer, i : Int, v : Double) -> MlregresselasticBuffer {
  let result = ml_regress_elastic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_buffer_sum(s : MlregresselasticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_buffer_mean(s : MlregresselasticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_buffer_scale(s : MlregresselasticBuffer, f : Double) -> MlregresselasticBuffer {
  let result = ml_regress_elastic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_buffer_add(a : MlregresselasticBuffer, b : MlregresselasticBuffer) -> MlregresselasticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_buffer_copy(s : MlregresselasticBuffer) -> MlregresselasticBuffer {
  let result = ml_regress_elastic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_buffer_fill(s : MlregresselasticBuffer, v : Double) -> MlregresselasticBuffer {
  let result = ml_regress_elastic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_buffer_min(s : MlregresselasticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_buffer_max(s : MlregresselasticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_buffer_to_string(s : MlregresselasticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_cursor_make(size : Int) -> MlregresselasticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_cursor_len(s : MlregresselasticCursor) -> Int { s.size }

pub fn ml_regress_elastic_cursor_get(s : MlregresselasticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_cursor_set(s : MlregresselasticCursor, i : Int, v : Double) -> MlregresselasticCursor {
  let result = ml_regress_elastic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_cursor_sum(s : MlregresselasticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_cursor_mean(s : MlregresselasticCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_cursor_scale(s : MlregresselasticCursor, f : Double) -> MlregresselasticCursor {
  let result = ml_regress_elastic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_cursor_add(a : MlregresselasticCursor, b : MlregresselasticCursor) -> MlregresselasticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_cursor_copy(s : MlregresselasticCursor) -> MlregresselasticCursor {
  let result = ml_regress_elastic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_cursor_fill(s : MlregresselasticCursor, v : Double) -> MlregresselasticCursor {
  let result = ml_regress_elastic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_cursor_min(s : MlregresselasticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_cursor_max(s : MlregresselasticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_cursor_to_string(s : MlregresselasticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_view_make(size : Int) -> MlregresselasticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_view_len(s : MlregresselasticView) -> Int { s.size }

pub fn ml_regress_elastic_view_get(s : MlregresselasticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_view_set(s : MlregresselasticView, i : Int, v : Double) -> MlregresselasticView {
  let result = ml_regress_elastic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_view_sum(s : MlregresselasticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_view_mean(s : MlregresselasticView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_view_scale(s : MlregresselasticView, f : Double) -> MlregresselasticView {
  let result = ml_regress_elastic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_view_add(a : MlregresselasticView, b : MlregresselasticView) -> MlregresselasticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_view_copy(s : MlregresselasticView) -> MlregresselasticView {
  let result = ml_regress_elastic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_view_fill(s : MlregresselasticView, v : Double) -> MlregresselasticView {
  let result = ml_regress_elastic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_view_min(s : MlregresselasticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_view_max(s : MlregresselasticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_view_to_string(s : MlregresselasticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_range_make(size : Int) -> MlregresselasticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_range_len(s : MlregresselasticRange) -> Int { s.size }

pub fn ml_regress_elastic_range_get(s : MlregresselasticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_range_set(s : MlregresselasticRange, i : Int, v : Double) -> MlregresselasticRange {
  let result = ml_regress_elastic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_range_sum(s : MlregresselasticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_range_mean(s : MlregresselasticRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_range_scale(s : MlregresselasticRange, f : Double) -> MlregresselasticRange {
  let result = ml_regress_elastic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_range_add(a : MlregresselasticRange, b : MlregresselasticRange) -> MlregresselasticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_range_copy(s : MlregresselasticRange) -> MlregresselasticRange {
  let result = ml_regress_elastic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_range_fill(s : MlregresselasticRange, v : Double) -> MlregresselasticRange {
  let result = ml_regress_elastic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_range_min(s : MlregresselasticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_range_max(s : MlregresselasticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_range_to_string(s : MlregresselasticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresselasticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_elastic_slice_make(size : Int) -> MlregresselasticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_elastic_slice_len(s : MlregresselasticSlice) -> Int { s.size }

pub fn ml_regress_elastic_slice_get(s : MlregresselasticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_elastic_slice_set(s : MlregresselasticSlice, i : Int, v : Double) -> MlregresselasticSlice {
  let result = ml_regress_elastic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_slice_sum(s : MlregresselasticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_elastic_slice_mean(s : MlregresselasticSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_elastic_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_elastic_slice_scale(s : MlregresselasticSlice, f : Double) -> MlregresselasticSlice {
  let result = ml_regress_elastic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_elastic_slice_add(a : MlregresselasticSlice, b : MlregresselasticSlice) -> MlregresselasticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_elastic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_elastic_slice_copy(s : MlregresselasticSlice) -> MlregresselasticSlice {
  let result = ml_regress_elastic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_elastic_slice_fill(s : MlregresselasticSlice, v : Double) -> MlregresselasticSlice {
  let result = ml_regress_elastic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_elastic_slice_min(s : MlregresselasticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_slice_max(s : MlregresselasticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_elastic_slice_to_string(s : MlregresselasticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_regress_elastic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_regress_elastic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/opt_meta_cmaes

pub(all) struct OptmetacmaesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_cmaes_make_point(x : Double, y : Double) -> OptmetacmaesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_cmaes_make_point3(x : Double, y : Double, z : Double) -> OptmetacmaesPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_cmaes_point_x(pt : OptmetacmaesPoint) -> Double { pt.x }

pub fn opt_meta_cmaes_point_y(pt : OptmetacmaesPoint) -> Double { pt.y }

pub fn opt_meta_cmaes_point_z(pt : OptmetacmaesPoint) -> Double { pt.z }

pub fn opt_meta_cmaes_point_label(pt : OptmetacmaesPoint) -> Int { pt.label }

pub fn opt_meta_cmaes_point_dist(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_meta_cmaes_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_cmaes_point_add(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_cmaes_point_sub(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_cmaes_point_scale(pt : OptmetacmaesPoint, s : Double) -> OptmetacmaesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_cmaes_point_dot(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_cmaes_point_cross(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_cmaes_point_norm(pt : OptmetacmaesPoint) -> Double {
  opt_meta_cmaes_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_cmaes_point_normalize(pt : OptmetacmaesPoint) -> OptmetacmaesPoint {
  let n = opt_meta_cmaes_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_cmaes_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_cmaes_point_negate(pt : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_cmaes_point_mid(a : OptmetacmaesPoint, b : OptmetacmaesPoint) -> OptmetacmaesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_cmaes_point_lerp(a : OptmetacmaesPoint, b : OptmetacmaesPoint, t : Double) -> OptmetacmaesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_cmaes_point_to_string(pt : OptmetacmaesPoint) -> String {
  "(" + opt_meta_cmaes_dbl(pt.x) + ", " + opt_meta_cmaes_dbl(pt.y) + ", " + opt_meta_cmaes_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetacmaesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_cmaes_make_series(vals : Array[Double], name : String) -> OptmetacmaesSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_cmaes_series_len(s : OptmetacmaesSeries) -> Int { s.vals.length() }

pub fn opt_meta_cmaes_series_sum(s : OptmetacmaesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_cmaes_series_mean(s : OptmetacmaesSeries) -> Double {
  let n = opt_meta_cmaes_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_cmaes_series_sum(s) / n.to_double() }
}

pub fn opt_meta_cmaes_series_min(s : OptmetacmaesSeries) -> Double {
  let n = opt_meta_cmaes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_cmaes_series_max(s : OptmetacmaesSeries) -> Double {
  let n = opt_meta_cmaes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_cmaes_series_range(s : OptmetacmaesSeries) -> Double {
  opt_meta_cmaes_series_max(s) - opt_meta_cmaes_series_min(s)
}

pub fn opt_meta_cmaes_series_var(s : OptmetacmaesSeries) -> Double {
  let n = opt_meta_cmaes_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_cmaes_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_cmaes_series_std(s : OptmetacmaesSeries) -> Double { opt_meta_cmaes_sqrt(opt_meta_cmaes_series_var(s)) }

pub fn opt_meta_cmaes_series_median(s : OptmetacmaesSeries) -> Double {
  let n = opt_meta_cmaes_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_cmaes_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_cmaes_series_scale(s : OptmetacmaesSeries, f : Double) -> OptmetacmaesSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_meta_cmaes_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_cmaes_series_add(a : OptmetacmaesSeries, b : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_cmaes_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_cmaes_series_sub(a : OptmetacmaesSeries, b : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_cmaes_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_cmaes_series_normalize(s : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let mn = opt_meta_cmaes_series_min(s)
  let mx = opt_meta_cmaes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_meta_cmaes_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_cmaes_series_cumsum(s : OptmetacmaesSeries) -> OptmetacmaesSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_meta_cmaes_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_cmaes_series_to_string(s : OptmetacmaesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_cmaes_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetacmaesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_cmaes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetacmaesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_cmaes_matrix_identity(n : Int) -> OptmetacmaesMatrix {
  let m = opt_meta_cmaes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_cmaes_matrix_get(m : OptmetacmaesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_cmaes_matrix_transpose(m : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_cmaes_matrix_add(a : OptmetacmaesMatrix, b : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_cmaes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_cmaes_matrix_scale(m : OptmetacmaesMatrix, s : Double) -> OptmetacmaesMatrix {
  let result = opt_meta_cmaes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_cmaes_matrix_multiply(a : OptmetacmaesMatrix, b : OptmetacmaesMatrix) -> OptmetacmaesMatrix {
  if a.cols != b.rows { return opt_meta_cmaes_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_cmaes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_cmaes_matrix_trace(m : OptmetacmaesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_cmaes_matrix_det(m : OptmetacmaesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_cmaes_matrix_norm(m : OptmetacmaesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_meta_cmaes_sqrt(sum)
}

pub fn opt_meta_cmaes_matrix_to_string(m : OptmetacmaesMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_meta_cmaes_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetacmaesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_cmaes_make_vector(comps : Array[Double]) -> OptmetacmaesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_cmaes_vector_zero(dim : Int) -> OptmetacmaesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_cmaes_vector_add(a : OptmetacmaesVector, b : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_cmaes_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_cmaes_vector_sub(a : OptmetacmaesVector, b : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_cmaes_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_cmaes_vector_scale(v : OptmetacmaesVector, s : Double) -> OptmetacmaesVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_meta_cmaes_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_cmaes_vector_dot(a : OptmetacmaesVector, b : OptmetacmaesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_cmaes_vector_norm(v : OptmetacmaesVector) -> Double { opt_meta_cmaes_sqrt(opt_meta_cmaes_vector_dot(v, v)) }

pub fn opt_meta_cmaes_vector_normalize(v : OptmetacmaesVector) -> OptmetacmaesVector {
  let n = opt_meta_cmaes_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_cmaes_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_cmaes_vector_dist(a : OptmetacmaesVector, b : OptmetacmaesVector) -> Double {
  opt_meta_cmaes_vector_norm(opt_meta_cmaes_vector_sub(a, b))
}

pub fn opt_meta_cmaes_vector_to_string(v : OptmetacmaesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_cmaes_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_cmaes_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_cmaes_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_cmaes_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_cmaes_std(data : Array[Double]) -> Double { opt_meta_cmaes_sqrt(opt_meta_cmaes_var(data)) }

pub fn opt_meta_cmaes_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_cmaes_mean(a); let mb = opt_meta_cmaes_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_cmaes_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_cmaes_std(a); let sb = opt_meta_cmaes_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_cmaes_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_cmaes_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_cmaes_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_cmaes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_cmaes_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_cmaes_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_meta_cmaes_sqrt(opt_meta_cmaes_mse(pred, labels))
}

pub fn opt_meta_cmaes_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_meta_cmaes_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_cmaes_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_cmaes_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_cmaes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_cmaes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_cmaes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_cmaes_precision(pred, labels, pos); let r = opt_meta_cmaes_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_cmaes_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_cmaes_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_cmaes_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_cmaes_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_cmaes_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_cmaes_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_cmaes_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_cmaes_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_cmaes_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_cmaes_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_cmaes_min(data); let mx = opt_meta_cmaes_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_cmaes_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_cmaes_mean(data); let sd = opt_meta_cmaes_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_cmaes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_cmaes_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_cmaes_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_cmaes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_meta_cmaes_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_meta_cmaes_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_meta_cmaes_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_meta_cmaes_int(x) } else { -opt_meta_cmaes_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_meta_cmaes_int(f * 1000000.0) } else { opt_meta_cmaes_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_meta_cmaes_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_meta_cmaes_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptmetacmaesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_frame_make(size : Int) -> OptmetacmaesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_frame_len(s : OptmetacmaesFrame) -> Int { s.size }

pub fn opt_meta_cmaes_frame_get(s : OptmetacmaesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_frame_set(s : OptmetacmaesFrame, i : Int, v : Double) -> OptmetacmaesFrame {
  let result = opt_meta_cmaes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_frame_sum(s : OptmetacmaesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_frame_mean(s : OptmetacmaesFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_frame_scale(s : OptmetacmaesFrame, f : Double) -> OptmetacmaesFrame {
  let result = opt_meta_cmaes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_frame_add(a : OptmetacmaesFrame, b : OptmetacmaesFrame) -> OptmetacmaesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_frame_copy(s : OptmetacmaesFrame) -> OptmetacmaesFrame {
  let result = opt_meta_cmaes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_frame_fill(s : OptmetacmaesFrame, v : Double) -> OptmetacmaesFrame {
  let result = opt_meta_cmaes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_frame_min(s : OptmetacmaesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_frame_max(s : OptmetacmaesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_frame_to_string(s : OptmetacmaesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_table_make(size : Int) -> OptmetacmaesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_table_len(s : OptmetacmaesTable) -> Int { s.size }

pub fn opt_meta_cmaes_table_get(s : OptmetacmaesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_table_set(s : OptmetacmaesTable, i : Int, v : Double) -> OptmetacmaesTable {
  let result = opt_meta_cmaes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_table_sum(s : OptmetacmaesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_table_mean(s : OptmetacmaesTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_table_scale(s : OptmetacmaesTable, f : Double) -> OptmetacmaesTable {
  let result = opt_meta_cmaes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_table_add(a : OptmetacmaesTable, b : OptmetacmaesTable) -> OptmetacmaesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_table_copy(s : OptmetacmaesTable) -> OptmetacmaesTable {
  let result = opt_meta_cmaes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_table_fill(s : OptmetacmaesTable, v : Double) -> OptmetacmaesTable {
  let result = opt_meta_cmaes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_table_min(s : OptmetacmaesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_table_max(s : OptmetacmaesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_table_to_string(s : OptmetacmaesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_graphn_make(size : Int) -> OptmetacmaesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_graphn_len(s : OptmetacmaesGraphN) -> Int { s.size }

pub fn opt_meta_cmaes_graphn_get(s : OptmetacmaesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_graphn_set(s : OptmetacmaesGraphN, i : Int, v : Double) -> OptmetacmaesGraphN {
  let result = opt_meta_cmaes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_graphn_sum(s : OptmetacmaesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_graphn_mean(s : OptmetacmaesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_graphn_scale(s : OptmetacmaesGraphN, f : Double) -> OptmetacmaesGraphN {
  let result = opt_meta_cmaes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_graphn_add(a : OptmetacmaesGraphN, b : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_graphn_copy(s : OptmetacmaesGraphN) -> OptmetacmaesGraphN {
  let result = opt_meta_cmaes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_graphn_fill(s : OptmetacmaesGraphN, v : Double) -> OptmetacmaesGraphN {
  let result = opt_meta_cmaes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_graphn_min(s : OptmetacmaesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_graphn_max(s : OptmetacmaesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_graphn_to_string(s : OptmetacmaesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_node_make(size : Int) -> OptmetacmaesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_node_len(s : OptmetacmaesNode) -> Int { s.size }

pub fn opt_meta_cmaes_node_get(s : OptmetacmaesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_node_set(s : OptmetacmaesNode, i : Int, v : Double) -> OptmetacmaesNode {
  let result = opt_meta_cmaes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_node_sum(s : OptmetacmaesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_node_mean(s : OptmetacmaesNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_node_scale(s : OptmetacmaesNode, f : Double) -> OptmetacmaesNode {
  let result = opt_meta_cmaes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_node_add(a : OptmetacmaesNode, b : OptmetacmaesNode) -> OptmetacmaesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_node_copy(s : OptmetacmaesNode) -> OptmetacmaesNode {
  let result = opt_meta_cmaes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_node_fill(s : OptmetacmaesNode, v : Double) -> OptmetacmaesNode {
  let result = opt_meta_cmaes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_node_min(s : OptmetacmaesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_node_max(s : OptmetacmaesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_node_to_string(s : OptmetacmaesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_edge_make(size : Int) -> OptmetacmaesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_edge_len(s : OptmetacmaesEdge) -> Int { s.size }

pub fn opt_meta_cmaes_edge_get(s : OptmetacmaesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_edge_set(s : OptmetacmaesEdge, i : Int, v : Double) -> OptmetacmaesEdge {
  let result = opt_meta_cmaes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_edge_sum(s : OptmetacmaesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_edge_mean(s : OptmetacmaesEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_edge_scale(s : OptmetacmaesEdge, f : Double) -> OptmetacmaesEdge {
  let result = opt_meta_cmaes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_edge_add(a : OptmetacmaesEdge, b : OptmetacmaesEdge) -> OptmetacmaesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_edge_copy(s : OptmetacmaesEdge) -> OptmetacmaesEdge {
  let result = opt_meta_cmaes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_edge_fill(s : OptmetacmaesEdge, v : Double) -> OptmetacmaesEdge {
  let result = opt_meta_cmaes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_edge_min(s : OptmetacmaesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_edge_max(s : OptmetacmaesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_edge_to_string(s : OptmetacmaesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_path_make(size : Int) -> OptmetacmaesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_path_len(s : OptmetacmaesPath) -> Int { s.size }

pub fn opt_meta_cmaes_path_get(s : OptmetacmaesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_path_set(s : OptmetacmaesPath, i : Int, v : Double) -> OptmetacmaesPath {
  let result = opt_meta_cmaes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_path_sum(s : OptmetacmaesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_path_mean(s : OptmetacmaesPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_path_scale(s : OptmetacmaesPath, f : Double) -> OptmetacmaesPath {
  let result = opt_meta_cmaes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_path_add(a : OptmetacmaesPath, b : OptmetacmaesPath) -> OptmetacmaesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_path_copy(s : OptmetacmaesPath) -> OptmetacmaesPath {
  let result = opt_meta_cmaes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_path_fill(s : OptmetacmaesPath, v : Double) -> OptmetacmaesPath {
  let result = opt_meta_cmaes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_path_min(s : OptmetacmaesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_path_max(s : OptmetacmaesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_path_to_string(s : OptmetacmaesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cluster_make(size : Int) -> OptmetacmaesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cluster_len(s : OptmetacmaesCluster) -> Int { s.size }

pub fn opt_meta_cmaes_cluster_get(s : OptmetacmaesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cluster_set(s : OptmetacmaesCluster, i : Int, v : Double) -> OptmetacmaesCluster {
  let result = opt_meta_cmaes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_cluster_sum(s : OptmetacmaesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_cluster_mean(s : OptmetacmaesCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_cluster_scale(s : OptmetacmaesCluster, f : Double) -> OptmetacmaesCluster {
  let result = opt_meta_cmaes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_cluster_add(a : OptmetacmaesCluster, b : OptmetacmaesCluster) -> OptmetacmaesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_cluster_copy(s : OptmetacmaesCluster) -> OptmetacmaesCluster {
  let result = opt_meta_cmaes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_cluster_fill(s : OptmetacmaesCluster, v : Double) -> OptmetacmaesCluster {
  let result = opt_meta_cmaes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_cluster_min(s : OptmetacmaesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_cluster_max(s : OptmetacmaesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_cluster_to_string(s : OptmetacmaesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_model_make(size : Int) -> OptmetacmaesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_model_len(s : OptmetacmaesModel) -> Int { s.size }

pub fn opt_meta_cmaes_model_get(s : OptmetacmaesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_model_set(s : OptmetacmaesModel, i : Int, v : Double) -> OptmetacmaesModel {
  let result = opt_meta_cmaes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_model_sum(s : OptmetacmaesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_model_mean(s : OptmetacmaesModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_model_scale(s : OptmetacmaesModel, f : Double) -> OptmetacmaesModel {
  let result = opt_meta_cmaes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_model_add(a : OptmetacmaesModel, b : OptmetacmaesModel) -> OptmetacmaesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_model_copy(s : OptmetacmaesModel) -> OptmetacmaesModel {
  let result = opt_meta_cmaes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_model_fill(s : OptmetacmaesModel, v : Double) -> OptmetacmaesModel {
  let result = opt_meta_cmaes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_model_min(s : OptmetacmaesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_model_max(s : OptmetacmaesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_model_to_string(s : OptmetacmaesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_layer_make(size : Int) -> OptmetacmaesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_layer_len(s : OptmetacmaesLayer) -> Int { s.size }

pub fn opt_meta_cmaes_layer_get(s : OptmetacmaesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_layer_set(s : OptmetacmaesLayer, i : Int, v : Double) -> OptmetacmaesLayer {
  let result = opt_meta_cmaes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_layer_sum(s : OptmetacmaesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_layer_mean(s : OptmetacmaesLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_layer_scale(s : OptmetacmaesLayer, f : Double) -> OptmetacmaesLayer {
  let result = opt_meta_cmaes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_layer_add(a : OptmetacmaesLayer, b : OptmetacmaesLayer) -> OptmetacmaesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_layer_copy(s : OptmetacmaesLayer) -> OptmetacmaesLayer {
  let result = opt_meta_cmaes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_layer_fill(s : OptmetacmaesLayer, v : Double) -> OptmetacmaesLayer {
  let result = opt_meta_cmaes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_layer_min(s : OptmetacmaesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_layer_max(s : OptmetacmaesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_layer_to_string(s : OptmetacmaesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_buffer_make(size : Int) -> OptmetacmaesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_buffer_len(s : OptmetacmaesBuffer) -> Int { s.size }

pub fn opt_meta_cmaes_buffer_get(s : OptmetacmaesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_buffer_set(s : OptmetacmaesBuffer, i : Int, v : Double) -> OptmetacmaesBuffer {
  let result = opt_meta_cmaes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_buffer_sum(s : OptmetacmaesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_buffer_mean(s : OptmetacmaesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_buffer_scale(s : OptmetacmaesBuffer, f : Double) -> OptmetacmaesBuffer {
  let result = opt_meta_cmaes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_buffer_add(a : OptmetacmaesBuffer, b : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_buffer_copy(s : OptmetacmaesBuffer) -> OptmetacmaesBuffer {
  let result = opt_meta_cmaes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_buffer_fill(s : OptmetacmaesBuffer, v : Double) -> OptmetacmaesBuffer {
  let result = opt_meta_cmaes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_buffer_min(s : OptmetacmaesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_buffer_max(s : OptmetacmaesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_buffer_to_string(s : OptmetacmaesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_cursor_make(size : Int) -> OptmetacmaesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_cursor_len(s : OptmetacmaesCursor) -> Int { s.size }

pub fn opt_meta_cmaes_cursor_get(s : OptmetacmaesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_cursor_set(s : OptmetacmaesCursor, i : Int, v : Double) -> OptmetacmaesCursor {
  let result = opt_meta_cmaes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_cursor_sum(s : OptmetacmaesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_cursor_mean(s : OptmetacmaesCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_cursor_scale(s : OptmetacmaesCursor, f : Double) -> OptmetacmaesCursor {
  let result = opt_meta_cmaes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_cursor_add(a : OptmetacmaesCursor, b : OptmetacmaesCursor) -> OptmetacmaesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_cursor_copy(s : OptmetacmaesCursor) -> OptmetacmaesCursor {
  let result = opt_meta_cmaes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_cursor_fill(s : OptmetacmaesCursor, v : Double) -> OptmetacmaesCursor {
  let result = opt_meta_cmaes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_cursor_min(s : OptmetacmaesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_cursor_max(s : OptmetacmaesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_cursor_to_string(s : OptmetacmaesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_view_make(size : Int) -> OptmetacmaesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_view_len(s : OptmetacmaesView) -> Int { s.size }

pub fn opt_meta_cmaes_view_get(s : OptmetacmaesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_view_set(s : OptmetacmaesView, i : Int, v : Double) -> OptmetacmaesView {
  let result = opt_meta_cmaes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_view_sum(s : OptmetacmaesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_view_mean(s : OptmetacmaesView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_view_scale(s : OptmetacmaesView, f : Double) -> OptmetacmaesView {
  let result = opt_meta_cmaes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_view_add(a : OptmetacmaesView, b : OptmetacmaesView) -> OptmetacmaesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_view_copy(s : OptmetacmaesView) -> OptmetacmaesView {
  let result = opt_meta_cmaes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_view_fill(s : OptmetacmaesView, v : Double) -> OptmetacmaesView {
  let result = opt_meta_cmaes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_view_min(s : OptmetacmaesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_view_max(s : OptmetacmaesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_view_to_string(s : OptmetacmaesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_range_make(size : Int) -> OptmetacmaesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_range_len(s : OptmetacmaesRange) -> Int { s.size }

pub fn opt_meta_cmaes_range_get(s : OptmetacmaesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_range_set(s : OptmetacmaesRange, i : Int, v : Double) -> OptmetacmaesRange {
  let result = opt_meta_cmaes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_range_sum(s : OptmetacmaesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_range_mean(s : OptmetacmaesRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_range_scale(s : OptmetacmaesRange, f : Double) -> OptmetacmaesRange {
  let result = opt_meta_cmaes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_range_add(a : OptmetacmaesRange, b : OptmetacmaesRange) -> OptmetacmaesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_range_copy(s : OptmetacmaesRange) -> OptmetacmaesRange {
  let result = opt_meta_cmaes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_range_fill(s : OptmetacmaesRange, v : Double) -> OptmetacmaesRange {
  let result = opt_meta_cmaes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_range_min(s : OptmetacmaesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_range_max(s : OptmetacmaesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_range_to_string(s : OptmetacmaesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetacmaesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_cmaes_slice_make(size : Int) -> OptmetacmaesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_cmaes_slice_len(s : OptmetacmaesSlice) -> Int { s.size }

pub fn opt_meta_cmaes_slice_get(s : OptmetacmaesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_cmaes_slice_set(s : OptmetacmaesSlice, i : Int, v : Double) -> OptmetacmaesSlice {
  let result = opt_meta_cmaes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_slice_sum(s : OptmetacmaesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_cmaes_slice_mean(s : OptmetacmaesSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_cmaes_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_cmaes_slice_scale(s : OptmetacmaesSlice, f : Double) -> OptmetacmaesSlice {
  let result = opt_meta_cmaes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_cmaes_slice_add(a : OptmetacmaesSlice, b : OptmetacmaesSlice) -> OptmetacmaesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_cmaes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_cmaes_slice_copy(s : OptmetacmaesSlice) -> OptmetacmaesSlice {
  let result = opt_meta_cmaes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_cmaes_slice_fill(s : OptmetacmaesSlice, v : Double) -> OptmetacmaesSlice {
  let result = opt_meta_cmaes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_cmaes_slice_min(s : OptmetacmaesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_slice_max(s : OptmetacmaesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_cmaes_slice_to_string(s : OptmetacmaesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_meta_cmaes_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_cmaes_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/opt_meta_bayes

pub(all) struct OptmetabayesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_bayes_make_point(x : Double, y : Double) -> OptmetabayesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_bayes_make_point3(x : Double, y : Double, z : Double) -> OptmetabayesPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_bayes_point_x(pt : OptmetabayesPoint) -> Double { pt.x }

pub fn opt_meta_bayes_point_y(pt : OptmetabayesPoint) -> Double { pt.y }

pub fn opt_meta_bayes_point_z(pt : OptmetabayesPoint) -> Double { pt.z }

pub fn opt_meta_bayes_point_label(pt : OptmetabayesPoint) -> Int { pt.label }

pub fn opt_meta_bayes_point_dist(a : OptmetabayesPoint, b : OptmetabayesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_bayes_point_add(a : OptmetabayesPoint, b : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_bayes_point_sub(a : OptmetabayesPoint, b : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_bayes_point_scale(pt : OptmetabayesPoint, s : Double) -> OptmetabayesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_bayes_point_dot(a : OptmetabayesPoint, b : OptmetabayesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_bayes_point_cross(a : OptmetabayesPoint, b : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_bayes_point_norm(pt : OptmetabayesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_bayes_point_normalize(pt : OptmetabayesPoint) -> OptmetabayesPoint {
  let n = opt_meta_bayes_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_bayes_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_bayes_point_negate(pt : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_bayes_point_mid(a : OptmetabayesPoint, b : OptmetabayesPoint) -> OptmetabayesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_bayes_point_lerp(a : OptmetabayesPoint, b : OptmetabayesPoint, t : Double) -> OptmetabayesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_bayes_point_to_string(pt : OptmetabayesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetabayesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_bayes_make_series(vals : Array[Double], name : String) -> OptmetabayesSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_bayes_series_len(s : OptmetabayesSeries) -> Int { s.vals.length() }

pub fn opt_meta_bayes_series_sum(s : OptmetabayesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_bayes_series_mean(s : OptmetabayesSeries) -> Double {
  let n = opt_meta_bayes_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_bayes_series_sum(s) / n.to_double() }
}

pub fn opt_meta_bayes_series_min(s : OptmetabayesSeries) -> Double {
  let n = opt_meta_bayes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_bayes_series_max(s : OptmetabayesSeries) -> Double {
  let n = opt_meta_bayes_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_bayes_series_range(s : OptmetabayesSeries) -> Double {
  opt_meta_bayes_series_max(s) - opt_meta_bayes_series_min(s)
}

pub fn opt_meta_bayes_series_var(s : OptmetabayesSeries) -> Double {
  let n = opt_meta_bayes_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_bayes_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_bayes_series_std(s : OptmetabayesSeries) -> Double { @_common.sqrt(opt_meta_bayes_series_var(s)) }

pub fn opt_meta_bayes_series_median(s : OptmetabayesSeries) -> Double {
  let n = opt_meta_bayes_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_bayes_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_bayes_series_scale(s : OptmetabayesSeries, f : Double) -> OptmetabayesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_bayes_series_add(a : OptmetabayesSeries, b : OptmetabayesSeries) -> OptmetabayesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_bayes_series_sub(a : OptmetabayesSeries, b : OptmetabayesSeries) -> OptmetabayesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_bayes_series_normalize(s : OptmetabayesSeries) -> OptmetabayesSeries {
  let mn = opt_meta_bayes_series_min(s)
  let mx = opt_meta_bayes_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_bayes_series_cumsum(s : OptmetabayesSeries) -> OptmetabayesSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_bayes_series_to_string(s : OptmetabayesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetabayesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_bayes_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetabayesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_bayes_matrix_identity(n : Int) -> OptmetabayesMatrix {
  let m = opt_meta_bayes_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_bayes_matrix_get(m : OptmetabayesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_bayes_matrix_transpose(m : OptmetabayesMatrix) -> OptmetabayesMatrix {
  let result = opt_meta_bayes_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_bayes_matrix_add(a : OptmetabayesMatrix, b : OptmetabayesMatrix) -> OptmetabayesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_bayes_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_bayes_matrix_scale(m : OptmetabayesMatrix, s : Double) -> OptmetabayesMatrix {
  let result = opt_meta_bayes_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_bayes_matrix_multiply(a : OptmetabayesMatrix, b : OptmetabayesMatrix) -> OptmetabayesMatrix {
  if a.cols != b.rows { return opt_meta_bayes_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_bayes_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_bayes_matrix_trace(m : OptmetabayesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_bayes_matrix_det(m : OptmetabayesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_bayes_matrix_norm(m : OptmetabayesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_meta_bayes_matrix_to_string(m : OptmetabayesMatrix) -> String {
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

pub(all) struct OptmetabayesVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_bayes_make_vector(comps : Array[Double]) -> OptmetabayesVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_bayes_vector_zero(dim : Int) -> OptmetabayesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_bayes_vector_add(a : OptmetabayesVector, b : OptmetabayesVector) -> OptmetabayesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_bayes_vector_sub(a : OptmetabayesVector, b : OptmetabayesVector) -> OptmetabayesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_bayes_vector_scale(v : OptmetabayesVector, s : Double) -> OptmetabayesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_bayes_vector_dot(a : OptmetabayesVector, b : OptmetabayesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_bayes_vector_norm(v : OptmetabayesVector) -> Double { @_common.sqrt(opt_meta_bayes_vector_dot(v, v)) }

pub fn opt_meta_bayes_vector_normalize(v : OptmetabayesVector) -> OptmetabayesVector {
  let n = opt_meta_bayes_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_bayes_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_bayes_vector_dist(a : OptmetabayesVector, b : OptmetabayesVector) -> Double {
  opt_meta_bayes_vector_norm(opt_meta_bayes_vector_sub(a, b))
}

pub fn opt_meta_bayes_vector_to_string(v : OptmetabayesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_bayes_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_bayes_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_bayes_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_bayes_std(data : Array[Double]) -> Double { @_common.sqrt(opt_meta_bayes_var(data)) }

pub fn opt_meta_bayes_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_bayes_mean(a); let mb = opt_meta_bayes_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_bayes_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_bayes_std(a); let sb = opt_meta_bayes_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_bayes_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_bayes_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_bayes_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_bayes_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_bayes_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_bayes_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(opt_meta_bayes_mse(pred, labels))
}

pub fn opt_meta_bayes_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_bayes_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_bayes_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_bayes_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_bayes_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_bayes_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_bayes_precision(pred, labels, pos); let r = opt_meta_bayes_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_bayes_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_bayes_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_bayes_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_bayes_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_bayes_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_bayes_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_bayes_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_bayes_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_bayes_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_bayes_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_bayes_min(data); let mx = opt_meta_bayes_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_bayes_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_bayes_mean(data); let sd = opt_meta_bayes_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_bayes_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_bayes_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_bayes_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_bayes_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_bayes_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_bayes_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct OptmetabayesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_frame_make(size : Int) -> OptmetabayesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_frame_len(s : OptmetabayesFrame) -> Int { s.size }

pub fn opt_meta_bayes_frame_get(s : OptmetabayesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_frame_set(s : OptmetabayesFrame, i : Int, v : Double) -> OptmetabayesFrame {
  let result = opt_meta_bayes_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_frame_sum(s : OptmetabayesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_frame_mean(s : OptmetabayesFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_frame_scale(s : OptmetabayesFrame, f : Double) -> OptmetabayesFrame {
  let result = opt_meta_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_frame_add(a : OptmetabayesFrame, b : OptmetabayesFrame) -> OptmetabayesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_frame_copy(s : OptmetabayesFrame) -> OptmetabayesFrame {
  let result = opt_meta_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_frame_fill(s : OptmetabayesFrame, v : Double) -> OptmetabayesFrame {
  let result = opt_meta_bayes_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_frame_min(s : OptmetabayesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_frame_max(s : OptmetabayesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_frame_to_string(s : OptmetabayesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_table_make(size : Int) -> OptmetabayesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_table_len(s : OptmetabayesTable) -> Int { s.size }

pub fn opt_meta_bayes_table_get(s : OptmetabayesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_table_set(s : OptmetabayesTable, i : Int, v : Double) -> OptmetabayesTable {
  let result = opt_meta_bayes_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_table_sum(s : OptmetabayesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_table_mean(s : OptmetabayesTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_table_scale(s : OptmetabayesTable, f : Double) -> OptmetabayesTable {
  let result = opt_meta_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_table_add(a : OptmetabayesTable, b : OptmetabayesTable) -> OptmetabayesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_table_copy(s : OptmetabayesTable) -> OptmetabayesTable {
  let result = opt_meta_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_table_fill(s : OptmetabayesTable, v : Double) -> OptmetabayesTable {
  let result = opt_meta_bayes_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_table_min(s : OptmetabayesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_table_max(s : OptmetabayesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_table_to_string(s : OptmetabayesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_graphn_make(size : Int) -> OptmetabayesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_graphn_len(s : OptmetabayesGraphN) -> Int { s.size }

pub fn opt_meta_bayes_graphn_get(s : OptmetabayesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_graphn_set(s : OptmetabayesGraphN, i : Int, v : Double) -> OptmetabayesGraphN {
  let result = opt_meta_bayes_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_graphn_sum(s : OptmetabayesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_graphn_mean(s : OptmetabayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_graphn_scale(s : OptmetabayesGraphN, f : Double) -> OptmetabayesGraphN {
  let result = opt_meta_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_graphn_add(a : OptmetabayesGraphN, b : OptmetabayesGraphN) -> OptmetabayesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_graphn_copy(s : OptmetabayesGraphN) -> OptmetabayesGraphN {
  let result = opt_meta_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_graphn_fill(s : OptmetabayesGraphN, v : Double) -> OptmetabayesGraphN {
  let result = opt_meta_bayes_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_graphn_min(s : OptmetabayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_graphn_max(s : OptmetabayesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_graphn_to_string(s : OptmetabayesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_node_make(size : Int) -> OptmetabayesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_node_len(s : OptmetabayesNode) -> Int { s.size }

pub fn opt_meta_bayes_node_get(s : OptmetabayesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_node_set(s : OptmetabayesNode, i : Int, v : Double) -> OptmetabayesNode {
  let result = opt_meta_bayes_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_node_sum(s : OptmetabayesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_node_mean(s : OptmetabayesNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_node_scale(s : OptmetabayesNode, f : Double) -> OptmetabayesNode {
  let result = opt_meta_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_node_add(a : OptmetabayesNode, b : OptmetabayesNode) -> OptmetabayesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_node_copy(s : OptmetabayesNode) -> OptmetabayesNode {
  let result = opt_meta_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_node_fill(s : OptmetabayesNode, v : Double) -> OptmetabayesNode {
  let result = opt_meta_bayes_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_node_min(s : OptmetabayesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_node_max(s : OptmetabayesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_node_to_string(s : OptmetabayesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_edge_make(size : Int) -> OptmetabayesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_edge_len(s : OptmetabayesEdge) -> Int { s.size }

pub fn opt_meta_bayes_edge_get(s : OptmetabayesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_edge_set(s : OptmetabayesEdge, i : Int, v : Double) -> OptmetabayesEdge {
  let result = opt_meta_bayes_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_edge_sum(s : OptmetabayesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_edge_mean(s : OptmetabayesEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_edge_scale(s : OptmetabayesEdge, f : Double) -> OptmetabayesEdge {
  let result = opt_meta_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_edge_add(a : OptmetabayesEdge, b : OptmetabayesEdge) -> OptmetabayesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_edge_copy(s : OptmetabayesEdge) -> OptmetabayesEdge {
  let result = opt_meta_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_edge_fill(s : OptmetabayesEdge, v : Double) -> OptmetabayesEdge {
  let result = opt_meta_bayes_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_edge_min(s : OptmetabayesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_edge_max(s : OptmetabayesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_edge_to_string(s : OptmetabayesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_path_make(size : Int) -> OptmetabayesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_path_len(s : OptmetabayesPath) -> Int { s.size }

pub fn opt_meta_bayes_path_get(s : OptmetabayesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_path_set(s : OptmetabayesPath, i : Int, v : Double) -> OptmetabayesPath {
  let result = opt_meta_bayes_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_path_sum(s : OptmetabayesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_path_mean(s : OptmetabayesPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_path_scale(s : OptmetabayesPath, f : Double) -> OptmetabayesPath {
  let result = opt_meta_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_path_add(a : OptmetabayesPath, b : OptmetabayesPath) -> OptmetabayesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_path_copy(s : OptmetabayesPath) -> OptmetabayesPath {
  let result = opt_meta_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_path_fill(s : OptmetabayesPath, v : Double) -> OptmetabayesPath {
  let result = opt_meta_bayes_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_path_min(s : OptmetabayesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_path_max(s : OptmetabayesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_path_to_string(s : OptmetabayesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cluster_make(size : Int) -> OptmetabayesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_cluster_len(s : OptmetabayesCluster) -> Int { s.size }

pub fn opt_meta_bayes_cluster_get(s : OptmetabayesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_cluster_set(s : OptmetabayesCluster, i : Int, v : Double) -> OptmetabayesCluster {
  let result = opt_meta_bayes_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_cluster_sum(s : OptmetabayesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_cluster_mean(s : OptmetabayesCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_cluster_scale(s : OptmetabayesCluster, f : Double) -> OptmetabayesCluster {
  let result = opt_meta_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_cluster_add(a : OptmetabayesCluster, b : OptmetabayesCluster) -> OptmetabayesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_cluster_copy(s : OptmetabayesCluster) -> OptmetabayesCluster {
  let result = opt_meta_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_cluster_fill(s : OptmetabayesCluster, v : Double) -> OptmetabayesCluster {
  let result = opt_meta_bayes_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_cluster_min(s : OptmetabayesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_cluster_max(s : OptmetabayesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_cluster_to_string(s : OptmetabayesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_model_make(size : Int) -> OptmetabayesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_model_len(s : OptmetabayesModel) -> Int { s.size }

pub fn opt_meta_bayes_model_get(s : OptmetabayesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_model_set(s : OptmetabayesModel, i : Int, v : Double) -> OptmetabayesModel {
  let result = opt_meta_bayes_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_model_sum(s : OptmetabayesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_model_mean(s : OptmetabayesModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_model_scale(s : OptmetabayesModel, f : Double) -> OptmetabayesModel {
  let result = opt_meta_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_model_add(a : OptmetabayesModel, b : OptmetabayesModel) -> OptmetabayesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_model_copy(s : OptmetabayesModel) -> OptmetabayesModel {
  let result = opt_meta_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_model_fill(s : OptmetabayesModel, v : Double) -> OptmetabayesModel {
  let result = opt_meta_bayes_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_model_min(s : OptmetabayesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_model_max(s : OptmetabayesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_model_to_string(s : OptmetabayesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_layer_make(size : Int) -> OptmetabayesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_layer_len(s : OptmetabayesLayer) -> Int { s.size }

pub fn opt_meta_bayes_layer_get(s : OptmetabayesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_layer_set(s : OptmetabayesLayer, i : Int, v : Double) -> OptmetabayesLayer {
  let result = opt_meta_bayes_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_layer_sum(s : OptmetabayesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_layer_mean(s : OptmetabayesLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_layer_scale(s : OptmetabayesLayer, f : Double) -> OptmetabayesLayer {
  let result = opt_meta_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_layer_add(a : OptmetabayesLayer, b : OptmetabayesLayer) -> OptmetabayesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_layer_copy(s : OptmetabayesLayer) -> OptmetabayesLayer {
  let result = opt_meta_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_layer_fill(s : OptmetabayesLayer, v : Double) -> OptmetabayesLayer {
  let result = opt_meta_bayes_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_layer_min(s : OptmetabayesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_layer_max(s : OptmetabayesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_layer_to_string(s : OptmetabayesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_buffer_make(size : Int) -> OptmetabayesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_buffer_len(s : OptmetabayesBuffer) -> Int { s.size }

pub fn opt_meta_bayes_buffer_get(s : OptmetabayesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_buffer_set(s : OptmetabayesBuffer, i : Int, v : Double) -> OptmetabayesBuffer {
  let result = opt_meta_bayes_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_buffer_sum(s : OptmetabayesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_buffer_mean(s : OptmetabayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_buffer_scale(s : OptmetabayesBuffer, f : Double) -> OptmetabayesBuffer {
  let result = opt_meta_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_buffer_add(a : OptmetabayesBuffer, b : OptmetabayesBuffer) -> OptmetabayesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_buffer_copy(s : OptmetabayesBuffer) -> OptmetabayesBuffer {
  let result = opt_meta_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_buffer_fill(s : OptmetabayesBuffer, v : Double) -> OptmetabayesBuffer {
  let result = opt_meta_bayes_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_buffer_min(s : OptmetabayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_buffer_max(s : OptmetabayesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_buffer_to_string(s : OptmetabayesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_cursor_make(size : Int) -> OptmetabayesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_cursor_len(s : OptmetabayesCursor) -> Int { s.size }

pub fn opt_meta_bayes_cursor_get(s : OptmetabayesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_cursor_set(s : OptmetabayesCursor, i : Int, v : Double) -> OptmetabayesCursor {
  let result = opt_meta_bayes_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_cursor_sum(s : OptmetabayesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_cursor_mean(s : OptmetabayesCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_cursor_scale(s : OptmetabayesCursor, f : Double) -> OptmetabayesCursor {
  let result = opt_meta_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_cursor_add(a : OptmetabayesCursor, b : OptmetabayesCursor) -> OptmetabayesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_cursor_copy(s : OptmetabayesCursor) -> OptmetabayesCursor {
  let result = opt_meta_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_cursor_fill(s : OptmetabayesCursor, v : Double) -> OptmetabayesCursor {
  let result = opt_meta_bayes_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_cursor_min(s : OptmetabayesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_cursor_max(s : OptmetabayesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_cursor_to_string(s : OptmetabayesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_view_make(size : Int) -> OptmetabayesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_view_len(s : OptmetabayesView) -> Int { s.size }

pub fn opt_meta_bayes_view_get(s : OptmetabayesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_view_set(s : OptmetabayesView, i : Int, v : Double) -> OptmetabayesView {
  let result = opt_meta_bayes_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_view_sum(s : OptmetabayesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_view_mean(s : OptmetabayesView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_view_scale(s : OptmetabayesView, f : Double) -> OptmetabayesView {
  let result = opt_meta_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_view_add(a : OptmetabayesView, b : OptmetabayesView) -> OptmetabayesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_view_copy(s : OptmetabayesView) -> OptmetabayesView {
  let result = opt_meta_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_view_fill(s : OptmetabayesView, v : Double) -> OptmetabayesView {
  let result = opt_meta_bayes_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_view_min(s : OptmetabayesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_view_max(s : OptmetabayesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_view_to_string(s : OptmetabayesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_range_make(size : Int) -> OptmetabayesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_range_len(s : OptmetabayesRange) -> Int { s.size }

pub fn opt_meta_bayes_range_get(s : OptmetabayesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_range_set(s : OptmetabayesRange, i : Int, v : Double) -> OptmetabayesRange {
  let result = opt_meta_bayes_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_range_sum(s : OptmetabayesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_range_mean(s : OptmetabayesRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_range_scale(s : OptmetabayesRange, f : Double) -> OptmetabayesRange {
  let result = opt_meta_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_range_add(a : OptmetabayesRange, b : OptmetabayesRange) -> OptmetabayesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_range_copy(s : OptmetabayesRange) -> OptmetabayesRange {
  let result = opt_meta_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_range_fill(s : OptmetabayesRange, v : Double) -> OptmetabayesRange {
  let result = opt_meta_bayes_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_range_min(s : OptmetabayesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_range_max(s : OptmetabayesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_range_to_string(s : OptmetabayesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetabayesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_bayes_slice_make(size : Int) -> OptmetabayesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_bayes_slice_len(s : OptmetabayesSlice) -> Int { s.size }

pub fn opt_meta_bayes_slice_get(s : OptmetabayesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_bayes_slice_set(s : OptmetabayesSlice, i : Int, v : Double) -> OptmetabayesSlice {
  let result = opt_meta_bayes_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_slice_sum(s : OptmetabayesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_bayes_slice_mean(s : OptmetabayesSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_bayes_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_bayes_slice_scale(s : OptmetabayesSlice, f : Double) -> OptmetabayesSlice {
  let result = opt_meta_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_bayes_slice_add(a : OptmetabayesSlice, b : OptmetabayesSlice) -> OptmetabayesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_bayes_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_bayes_slice_copy(s : OptmetabayesSlice) -> OptmetabayesSlice {
  let result = opt_meta_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_bayes_slice_fill(s : OptmetabayesSlice, v : Double) -> OptmetabayesSlice {
  let result = opt_meta_bayes_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_bayes_slice_min(s : OptmetabayesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_slice_max(s : OptmetabayesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_bayes_slice_to_string(s : OptmetabayesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


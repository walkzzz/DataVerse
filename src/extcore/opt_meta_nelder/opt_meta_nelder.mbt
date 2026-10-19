///===
/// extcore/opt_meta_nelder

pub(all) struct OptmetanelderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_nelder_make_point(x : Double, y : Double) -> OptmetanelderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_nelder_make_point3(x : Double, y : Double, z : Double) -> OptmetanelderPoint {
  { x, y, z, label: 0 }
}

pub fn opt_meta_nelder_point_x(pt : OptmetanelderPoint) -> Double { pt.x }

pub fn opt_meta_nelder_point_y(pt : OptmetanelderPoint) -> Double { pt.y }

pub fn opt_meta_nelder_point_z(pt : OptmetanelderPoint) -> Double { pt.z }

pub fn opt_meta_nelder_point_label(pt : OptmetanelderPoint) -> Int { pt.label }

pub fn opt_meta_nelder_point_dist(a : OptmetanelderPoint, b : OptmetanelderPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_meta_nelder_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_meta_nelder_point_add(a : OptmetanelderPoint, b : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_meta_nelder_point_sub(a : OptmetanelderPoint, b : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_meta_nelder_point_scale(pt : OptmetanelderPoint, s : Double) -> OptmetanelderPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_meta_nelder_point_dot(a : OptmetanelderPoint, b : OptmetanelderPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_meta_nelder_point_cross(a : OptmetanelderPoint, b : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_meta_nelder_point_norm(pt : OptmetanelderPoint) -> Double {
  opt_meta_nelder_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_meta_nelder_point_normalize(pt : OptmetanelderPoint) -> OptmetanelderPoint {
  let n = opt_meta_nelder_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_meta_nelder_point_scale(pt, 1.0 / n) }
}

pub fn opt_meta_nelder_point_negate(pt : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_meta_nelder_point_mid(a : OptmetanelderPoint, b : OptmetanelderPoint) -> OptmetanelderPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_meta_nelder_point_lerp(a : OptmetanelderPoint, b : OptmetanelderPoint, t : Double) -> OptmetanelderPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_meta_nelder_point_to_string(pt : OptmetanelderPoint) -> String {
  "(" + opt_meta_nelder_dbl(pt.x) + ", " + opt_meta_nelder_dbl(pt.y) + ", " + opt_meta_nelder_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptmetanelderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_nelder_make_series(vals : Array[Double], name : String) -> OptmetanelderSeries {
  { vals, name, meta: 0 }
}

pub fn opt_meta_nelder_series_len(s : OptmetanelderSeries) -> Int { s.vals.length() }

pub fn opt_meta_nelder_series_sum(s : OptmetanelderSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_meta_nelder_series_mean(s : OptmetanelderSeries) -> Double {
  let n = opt_meta_nelder_series_len(s)
  if n == 0 { 0.0 } else { opt_meta_nelder_series_sum(s) / n.to_double() }
}

pub fn opt_meta_nelder_series_min(s : OptmetanelderSeries) -> Double {
  let n = opt_meta_nelder_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_nelder_series_max(s : OptmetanelderSeries) -> Double {
  let n = opt_meta_nelder_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_meta_nelder_series_range(s : OptmetanelderSeries) -> Double {
  opt_meta_nelder_series_max(s) - opt_meta_nelder_series_min(s)
}

pub fn opt_meta_nelder_series_var(s : OptmetanelderSeries) -> Double {
  let n = opt_meta_nelder_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_meta_nelder_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_meta_nelder_series_std(s : OptmetanelderSeries) -> Double { opt_meta_nelder_sqrt(opt_meta_nelder_series_var(s)) }

pub fn opt_meta_nelder_series_median(s : OptmetanelderSeries) -> Double {
  let n = opt_meta_nelder_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_nelder_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_nelder_series_scale(s : OptmetanelderSeries, f : Double) -> OptmetanelderSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_meta_nelder_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_meta_nelder_series_add(a : OptmetanelderSeries, b : OptmetanelderSeries) -> OptmetanelderSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_nelder_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_meta_nelder_series_sub(a : OptmetanelderSeries, b : OptmetanelderSeries) -> OptmetanelderSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_meta_nelder_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_meta_nelder_series_normalize(s : OptmetanelderSeries) -> OptmetanelderSeries {
  let mn = opt_meta_nelder_series_min(s)
  let mx = opt_meta_nelder_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_meta_nelder_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_meta_nelder_series_cumsum(s : OptmetanelderSeries) -> OptmetanelderSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_meta_nelder_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_meta_nelder_series_to_string(s : OptmetanelderSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_nelder_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetanelderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_nelder_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetanelderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_nelder_matrix_identity(n : Int) -> OptmetanelderMatrix {
  let m = opt_meta_nelder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_meta_nelder_matrix_get(m : OptmetanelderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_meta_nelder_matrix_transpose(m : OptmetanelderMatrix) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_meta_nelder_matrix_add(a : OptmetanelderMatrix, b : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_meta_nelder_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_meta_nelder_matrix_scale(m : OptmetanelderMatrix, s : Double) -> OptmetanelderMatrix {
  let result = opt_meta_nelder_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_meta_nelder_matrix_multiply(a : OptmetanelderMatrix, b : OptmetanelderMatrix) -> OptmetanelderMatrix {
  if a.cols != b.rows { return opt_meta_nelder_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_meta_nelder_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_meta_nelder_matrix_trace(m : OptmetanelderMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_meta_nelder_matrix_det(m : OptmetanelderMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_meta_nelder_matrix_norm(m : OptmetanelderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_meta_nelder_sqrt(sum)
}

pub fn opt_meta_nelder_matrix_to_string(m : OptmetanelderMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_meta_nelder_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptmetanelderVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_nelder_make_vector(comps : Array[Double]) -> OptmetanelderVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_nelder_vector_zero(dim : Int) -> OptmetanelderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_meta_nelder_vector_add(a : OptmetanelderVector, b : OptmetanelderVector) -> OptmetanelderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_nelder_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_nelder_vector_sub(a : OptmetanelderVector, b : OptmetanelderVector) -> OptmetanelderVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_meta_nelder_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_meta_nelder_vector_scale(v : OptmetanelderVector, s : Double) -> OptmetanelderVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_meta_nelder_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_meta_nelder_vector_dot(a : OptmetanelderVector, b : OptmetanelderVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_meta_nelder_vector_norm(v : OptmetanelderVector) -> Double { opt_meta_nelder_sqrt(opt_meta_nelder_vector_dot(v, v)) }

pub fn opt_meta_nelder_vector_normalize(v : OptmetanelderVector) -> OptmetanelderVector {
  let n = opt_meta_nelder_vector_norm(v)
  if n < 0.0000001 { v } else { opt_meta_nelder_vector_scale(v, 1.0 / n) }
}

pub fn opt_meta_nelder_vector_dist(a : OptmetanelderVector, b : OptmetanelderVector) -> Double {
  opt_meta_nelder_vector_norm(opt_meta_nelder_vector_sub(a, b))
}

pub fn opt_meta_nelder_vector_to_string(v : OptmetanelderVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_meta_nelder_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_nelder_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_meta_nelder_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_meta_nelder_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_nelder_std(data : Array[Double]) -> Double { opt_meta_nelder_sqrt(opt_meta_nelder_var(data)) }

pub fn opt_meta_nelder_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_meta_nelder_mean(a); let mb = opt_meta_nelder_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_meta_nelder_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_meta_nelder_std(a); let sb = opt_meta_nelder_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_meta_nelder_cov(a, b) / (sa * sb) }
}

pub fn opt_meta_nelder_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_meta_nelder_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_meta_nelder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_meta_nelder_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_meta_nelder_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_meta_nelder_sqrt(opt_meta_nelder_mse(pred, labels))
}

pub fn opt_meta_nelder_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_meta_nelder_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_meta_nelder_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_meta_nelder_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_meta_nelder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_meta_nelder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_meta_nelder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_meta_nelder_precision(pred, labels, pos); let r = opt_meta_nelder_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_meta_nelder_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_meta_nelder_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_meta_nelder_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_meta_nelder_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_meta_nelder_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_meta_nelder_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_meta_nelder_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_meta_nelder_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_meta_nelder_fibonacci(n : Int) -> Int {
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

pub fn opt_meta_nelder_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_meta_nelder_min(data); let mx = opt_meta_nelder_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_meta_nelder_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_meta_nelder_mean(data); let sd = opt_meta_nelder_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_meta_nelder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_meta_nelder_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_meta_nelder_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_meta_nelder_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_meta_nelder_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_meta_nelder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_meta_nelder_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_meta_nelder_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_meta_nelder_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_meta_nelder_int(x) } else { -opt_meta_nelder_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_meta_nelder_int(f * 1000000.0) } else { opt_meta_nelder_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_meta_nelder_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_meta_nelder_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptmetanelderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_frame_make(size : Int) -> OptmetanelderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_frame_len(s : OptmetanelderFrame) -> Int { s.size }

pub fn opt_meta_nelder_frame_get(s : OptmetanelderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_frame_set(s : OptmetanelderFrame, i : Int, v : Double) -> OptmetanelderFrame {
  let result = opt_meta_nelder_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_frame_sum(s : OptmetanelderFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_frame_mean(s : OptmetanelderFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_frame_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_frame_scale(s : OptmetanelderFrame, f : Double) -> OptmetanelderFrame {
  let result = opt_meta_nelder_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_frame_add(a : OptmetanelderFrame, b : OptmetanelderFrame) -> OptmetanelderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_frame_copy(s : OptmetanelderFrame) -> OptmetanelderFrame {
  let result = opt_meta_nelder_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_frame_fill(s : OptmetanelderFrame, v : Double) -> OptmetanelderFrame {
  let result = opt_meta_nelder_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_frame_min(s : OptmetanelderFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_frame_max(s : OptmetanelderFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_frame_to_string(s : OptmetanelderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_table_make(size : Int) -> OptmetanelderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_table_len(s : OptmetanelderTable) -> Int { s.size }

pub fn opt_meta_nelder_table_get(s : OptmetanelderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_table_set(s : OptmetanelderTable, i : Int, v : Double) -> OptmetanelderTable {
  let result = opt_meta_nelder_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_table_sum(s : OptmetanelderTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_table_mean(s : OptmetanelderTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_table_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_table_scale(s : OptmetanelderTable, f : Double) -> OptmetanelderTable {
  let result = opt_meta_nelder_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_table_add(a : OptmetanelderTable, b : OptmetanelderTable) -> OptmetanelderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_table_copy(s : OptmetanelderTable) -> OptmetanelderTable {
  let result = opt_meta_nelder_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_table_fill(s : OptmetanelderTable, v : Double) -> OptmetanelderTable {
  let result = opt_meta_nelder_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_table_min(s : OptmetanelderTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_table_max(s : OptmetanelderTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_table_to_string(s : OptmetanelderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_graphn_make(size : Int) -> OptmetanelderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_graphn_len(s : OptmetanelderGraphN) -> Int { s.size }

pub fn opt_meta_nelder_graphn_get(s : OptmetanelderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_graphn_set(s : OptmetanelderGraphN, i : Int, v : Double) -> OptmetanelderGraphN {
  let result = opt_meta_nelder_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_graphn_sum(s : OptmetanelderGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_graphn_mean(s : OptmetanelderGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_graphn_scale(s : OptmetanelderGraphN, f : Double) -> OptmetanelderGraphN {
  let result = opt_meta_nelder_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_graphn_add(a : OptmetanelderGraphN, b : OptmetanelderGraphN) -> OptmetanelderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_graphn_copy(s : OptmetanelderGraphN) -> OptmetanelderGraphN {
  let result = opt_meta_nelder_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_graphn_fill(s : OptmetanelderGraphN, v : Double) -> OptmetanelderGraphN {
  let result = opt_meta_nelder_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_graphn_min(s : OptmetanelderGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_graphn_max(s : OptmetanelderGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_graphn_to_string(s : OptmetanelderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_node_make(size : Int) -> OptmetanelderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_node_len(s : OptmetanelderNode) -> Int { s.size }

pub fn opt_meta_nelder_node_get(s : OptmetanelderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_node_set(s : OptmetanelderNode, i : Int, v : Double) -> OptmetanelderNode {
  let result = opt_meta_nelder_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_node_sum(s : OptmetanelderNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_node_mean(s : OptmetanelderNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_node_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_node_scale(s : OptmetanelderNode, f : Double) -> OptmetanelderNode {
  let result = opt_meta_nelder_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_node_add(a : OptmetanelderNode, b : OptmetanelderNode) -> OptmetanelderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_node_copy(s : OptmetanelderNode) -> OptmetanelderNode {
  let result = opt_meta_nelder_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_node_fill(s : OptmetanelderNode, v : Double) -> OptmetanelderNode {
  let result = opt_meta_nelder_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_node_min(s : OptmetanelderNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_node_max(s : OptmetanelderNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_node_to_string(s : OptmetanelderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_edge_make(size : Int) -> OptmetanelderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_edge_len(s : OptmetanelderEdge) -> Int { s.size }

pub fn opt_meta_nelder_edge_get(s : OptmetanelderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_edge_set(s : OptmetanelderEdge, i : Int, v : Double) -> OptmetanelderEdge {
  let result = opt_meta_nelder_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_edge_sum(s : OptmetanelderEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_edge_mean(s : OptmetanelderEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_edge_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_edge_scale(s : OptmetanelderEdge, f : Double) -> OptmetanelderEdge {
  let result = opt_meta_nelder_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_edge_add(a : OptmetanelderEdge, b : OptmetanelderEdge) -> OptmetanelderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_edge_copy(s : OptmetanelderEdge) -> OptmetanelderEdge {
  let result = opt_meta_nelder_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_edge_fill(s : OptmetanelderEdge, v : Double) -> OptmetanelderEdge {
  let result = opt_meta_nelder_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_edge_min(s : OptmetanelderEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_edge_max(s : OptmetanelderEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_edge_to_string(s : OptmetanelderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_path_make(size : Int) -> OptmetanelderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_path_len(s : OptmetanelderPath) -> Int { s.size }

pub fn opt_meta_nelder_path_get(s : OptmetanelderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_path_set(s : OptmetanelderPath, i : Int, v : Double) -> OptmetanelderPath {
  let result = opt_meta_nelder_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_path_sum(s : OptmetanelderPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_path_mean(s : OptmetanelderPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_path_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_path_scale(s : OptmetanelderPath, f : Double) -> OptmetanelderPath {
  let result = opt_meta_nelder_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_path_add(a : OptmetanelderPath, b : OptmetanelderPath) -> OptmetanelderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_path_copy(s : OptmetanelderPath) -> OptmetanelderPath {
  let result = opt_meta_nelder_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_path_fill(s : OptmetanelderPath, v : Double) -> OptmetanelderPath {
  let result = opt_meta_nelder_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_path_min(s : OptmetanelderPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_path_max(s : OptmetanelderPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_path_to_string(s : OptmetanelderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cluster_make(size : Int) -> OptmetanelderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_cluster_len(s : OptmetanelderCluster) -> Int { s.size }

pub fn opt_meta_nelder_cluster_get(s : OptmetanelderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_cluster_set(s : OptmetanelderCluster, i : Int, v : Double) -> OptmetanelderCluster {
  let result = opt_meta_nelder_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_cluster_sum(s : OptmetanelderCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_cluster_mean(s : OptmetanelderCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_cluster_scale(s : OptmetanelderCluster, f : Double) -> OptmetanelderCluster {
  let result = opt_meta_nelder_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_cluster_add(a : OptmetanelderCluster, b : OptmetanelderCluster) -> OptmetanelderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_cluster_copy(s : OptmetanelderCluster) -> OptmetanelderCluster {
  let result = opt_meta_nelder_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_cluster_fill(s : OptmetanelderCluster, v : Double) -> OptmetanelderCluster {
  let result = opt_meta_nelder_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_cluster_min(s : OptmetanelderCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_cluster_max(s : OptmetanelderCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_cluster_to_string(s : OptmetanelderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_model_make(size : Int) -> OptmetanelderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_model_len(s : OptmetanelderModel) -> Int { s.size }

pub fn opt_meta_nelder_model_get(s : OptmetanelderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_model_set(s : OptmetanelderModel, i : Int, v : Double) -> OptmetanelderModel {
  let result = opt_meta_nelder_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_model_sum(s : OptmetanelderModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_model_mean(s : OptmetanelderModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_model_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_model_scale(s : OptmetanelderModel, f : Double) -> OptmetanelderModel {
  let result = opt_meta_nelder_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_model_add(a : OptmetanelderModel, b : OptmetanelderModel) -> OptmetanelderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_model_copy(s : OptmetanelderModel) -> OptmetanelderModel {
  let result = opt_meta_nelder_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_model_fill(s : OptmetanelderModel, v : Double) -> OptmetanelderModel {
  let result = opt_meta_nelder_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_model_min(s : OptmetanelderModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_model_max(s : OptmetanelderModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_model_to_string(s : OptmetanelderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_layer_make(size : Int) -> OptmetanelderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_layer_len(s : OptmetanelderLayer) -> Int { s.size }

pub fn opt_meta_nelder_layer_get(s : OptmetanelderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_layer_set(s : OptmetanelderLayer, i : Int, v : Double) -> OptmetanelderLayer {
  let result = opt_meta_nelder_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_layer_sum(s : OptmetanelderLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_layer_mean(s : OptmetanelderLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_layer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_layer_scale(s : OptmetanelderLayer, f : Double) -> OptmetanelderLayer {
  let result = opt_meta_nelder_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_layer_add(a : OptmetanelderLayer, b : OptmetanelderLayer) -> OptmetanelderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_layer_copy(s : OptmetanelderLayer) -> OptmetanelderLayer {
  let result = opt_meta_nelder_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_layer_fill(s : OptmetanelderLayer, v : Double) -> OptmetanelderLayer {
  let result = opt_meta_nelder_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_layer_min(s : OptmetanelderLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_layer_max(s : OptmetanelderLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_layer_to_string(s : OptmetanelderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_buffer_make(size : Int) -> OptmetanelderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_buffer_len(s : OptmetanelderBuffer) -> Int { s.size }

pub fn opt_meta_nelder_buffer_get(s : OptmetanelderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_buffer_set(s : OptmetanelderBuffer, i : Int, v : Double) -> OptmetanelderBuffer {
  let result = opt_meta_nelder_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_buffer_sum(s : OptmetanelderBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_buffer_mean(s : OptmetanelderBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_buffer_scale(s : OptmetanelderBuffer, f : Double) -> OptmetanelderBuffer {
  let result = opt_meta_nelder_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_buffer_add(a : OptmetanelderBuffer, b : OptmetanelderBuffer) -> OptmetanelderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_buffer_copy(s : OptmetanelderBuffer) -> OptmetanelderBuffer {
  let result = opt_meta_nelder_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_buffer_fill(s : OptmetanelderBuffer, v : Double) -> OptmetanelderBuffer {
  let result = opt_meta_nelder_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_buffer_min(s : OptmetanelderBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_buffer_max(s : OptmetanelderBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_buffer_to_string(s : OptmetanelderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_cursor_make(size : Int) -> OptmetanelderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_cursor_len(s : OptmetanelderCursor) -> Int { s.size }

pub fn opt_meta_nelder_cursor_get(s : OptmetanelderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_cursor_set(s : OptmetanelderCursor, i : Int, v : Double) -> OptmetanelderCursor {
  let result = opt_meta_nelder_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_cursor_sum(s : OptmetanelderCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_cursor_mean(s : OptmetanelderCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_cursor_scale(s : OptmetanelderCursor, f : Double) -> OptmetanelderCursor {
  let result = opt_meta_nelder_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_cursor_add(a : OptmetanelderCursor, b : OptmetanelderCursor) -> OptmetanelderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_cursor_copy(s : OptmetanelderCursor) -> OptmetanelderCursor {
  let result = opt_meta_nelder_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_cursor_fill(s : OptmetanelderCursor, v : Double) -> OptmetanelderCursor {
  let result = opt_meta_nelder_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_cursor_min(s : OptmetanelderCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_cursor_max(s : OptmetanelderCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_cursor_to_string(s : OptmetanelderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_view_make(size : Int) -> OptmetanelderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_view_len(s : OptmetanelderView) -> Int { s.size }

pub fn opt_meta_nelder_view_get(s : OptmetanelderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_view_set(s : OptmetanelderView, i : Int, v : Double) -> OptmetanelderView {
  let result = opt_meta_nelder_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_view_sum(s : OptmetanelderView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_view_mean(s : OptmetanelderView) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_view_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_view_scale(s : OptmetanelderView, f : Double) -> OptmetanelderView {
  let result = opt_meta_nelder_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_view_add(a : OptmetanelderView, b : OptmetanelderView) -> OptmetanelderView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_view_copy(s : OptmetanelderView) -> OptmetanelderView {
  let result = opt_meta_nelder_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_view_fill(s : OptmetanelderView, v : Double) -> OptmetanelderView {
  let result = opt_meta_nelder_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_view_min(s : OptmetanelderView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_view_max(s : OptmetanelderView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_view_to_string(s : OptmetanelderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_range_make(size : Int) -> OptmetanelderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_range_len(s : OptmetanelderRange) -> Int { s.size }

pub fn opt_meta_nelder_range_get(s : OptmetanelderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_range_set(s : OptmetanelderRange, i : Int, v : Double) -> OptmetanelderRange {
  let result = opt_meta_nelder_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_range_sum(s : OptmetanelderRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_range_mean(s : OptmetanelderRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_range_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_range_scale(s : OptmetanelderRange, f : Double) -> OptmetanelderRange {
  let result = opt_meta_nelder_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_range_add(a : OptmetanelderRange, b : OptmetanelderRange) -> OptmetanelderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_range_copy(s : OptmetanelderRange) -> OptmetanelderRange {
  let result = opt_meta_nelder_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_range_fill(s : OptmetanelderRange, v : Double) -> OptmetanelderRange {
  let result = opt_meta_nelder_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_range_min(s : OptmetanelderRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_range_max(s : OptmetanelderRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_range_to_string(s : OptmetanelderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetanelderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_nelder_slice_make(size : Int) -> OptmetanelderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_nelder_slice_len(s : OptmetanelderSlice) -> Int { s.size }

pub fn opt_meta_nelder_slice_get(s : OptmetanelderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_nelder_slice_set(s : OptmetanelderSlice, i : Int, v : Double) -> OptmetanelderSlice {
  let result = opt_meta_nelder_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_slice_sum(s : OptmetanelderSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_meta_nelder_slice_mean(s : OptmetanelderSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_meta_nelder_slice_sum(s) / s.size.to_double() }
}

pub fn opt_meta_nelder_slice_scale(s : OptmetanelderSlice, f : Double) -> OptmetanelderSlice {
  let result = opt_meta_nelder_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_meta_nelder_slice_add(a : OptmetanelderSlice, b : OptmetanelderSlice) -> OptmetanelderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_meta_nelder_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_meta_nelder_slice_copy(s : OptmetanelderSlice) -> OptmetanelderSlice {
  let result = opt_meta_nelder_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_meta_nelder_slice_fill(s : OptmetanelderSlice, v : Double) -> OptmetanelderSlice {
  let result = opt_meta_nelder_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_meta_nelder_slice_min(s : OptmetanelderSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_slice_max(s : OptmetanelderSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_meta_nelder_slice_to_string(s : OptmetanelderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_meta_nelder_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_meta_nelder_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/math_numerical_diff

pub(all) struct MathnumericaldiffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_diff_make_point(x : Double, y : Double) -> MathnumericaldiffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_diff_make_point3(x : Double, y : Double, z : Double) -> MathnumericaldiffPoint {
  { x, y, z, label: 0 }
}

pub fn math_numerical_diff_point_x(pt : MathnumericaldiffPoint) -> Double { pt.x }

pub fn math_numerical_diff_point_y(pt : MathnumericaldiffPoint) -> Double { pt.y }

pub fn math_numerical_diff_point_z(pt : MathnumericaldiffPoint) -> Double { pt.z }

pub fn math_numerical_diff_point_label(pt : MathnumericaldiffPoint) -> Int { pt.label }

pub fn math_numerical_diff_point_dist(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_numerical_diff_point_add(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_numerical_diff_point_sub(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_numerical_diff_point_scale(pt : MathnumericaldiffPoint, s : Double) -> MathnumericaldiffPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_numerical_diff_point_dot(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_numerical_diff_point_cross(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_numerical_diff_point_norm(pt : MathnumericaldiffPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_numerical_diff_point_normalize(pt : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  let n = math_numerical_diff_point_norm(pt)
  if n < 0.0000001 { pt } else { math_numerical_diff_point_scale(pt, 1.0 / n) }
}

pub fn math_numerical_diff_point_negate(pt : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_numerical_diff_point_mid(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_numerical_diff_point_lerp(a : MathnumericaldiffPoint, b : MathnumericaldiffPoint, t : Double) -> MathnumericaldiffPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_numerical_diff_point_to_string(pt : MathnumericaldiffPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathnumericaldiffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_diff_make_series(vals : Array[Double], name : String) -> MathnumericaldiffSeries {
  { vals, name, meta: 0 }
}

pub fn math_numerical_diff_series_len(s : MathnumericaldiffSeries) -> Int { s.vals.length() }

pub fn math_numerical_diff_series_sum(s : MathnumericaldiffSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_numerical_diff_series_mean(s : MathnumericaldiffSeries) -> Double {
  let n = math_numerical_diff_series_len(s)
  if n == 0 { 0.0 } else { math_numerical_diff_series_sum(s) / n.to_double() }
}

pub fn math_numerical_diff_series_min(s : MathnumericaldiffSeries) -> Double {
  let n = math_numerical_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_numerical_diff_series_max(s : MathnumericaldiffSeries) -> Double {
  let n = math_numerical_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_numerical_diff_series_range(s : MathnumericaldiffSeries) -> Double {
  math_numerical_diff_series_max(s) - math_numerical_diff_series_min(s)
}

pub fn math_numerical_diff_series_var(s : MathnumericaldiffSeries) -> Double {
  let n = math_numerical_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_numerical_diff_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_numerical_diff_series_std(s : MathnumericaldiffSeries) -> Double { @_common.sqrt(math_numerical_diff_series_var(s)) }

pub fn math_numerical_diff_series_median(s : MathnumericaldiffSeries) -> Double {
  let n = math_numerical_diff_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_numerical_diff_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_numerical_diff_series_scale(s : MathnumericaldiffSeries, f : Double) -> MathnumericaldiffSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_numerical_diff_series_add(a : MathnumericaldiffSeries, b : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_numerical_diff_series_sub(a : MathnumericaldiffSeries, b : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_numerical_diff_series_normalize(s : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let mn = math_numerical_diff_series_min(s)
  let mx = math_numerical_diff_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_numerical_diff_series_cumsum(s : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_numerical_diff_series_to_string(s : MathnumericaldiffSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericaldiffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericaldiffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_numerical_diff_matrix_identity(n : Int) -> MathnumericaldiffMatrix {
  let m = math_numerical_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_numerical_diff_matrix_get(m : MathnumericaldiffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_numerical_diff_matrix_transpose(m : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_numerical_diff_matrix_add(a : MathnumericaldiffMatrix, b : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_numerical_diff_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_numerical_diff_matrix_scale(m : MathnumericaldiffMatrix, s : Double) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_numerical_diff_matrix_multiply(a : MathnumericaldiffMatrix, b : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if a.cols != b.rows { return math_numerical_diff_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_numerical_diff_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_numerical_diff_matrix_trace(m : MathnumericaldiffMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_numerical_diff_matrix_det(m : MathnumericaldiffMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_numerical_diff_matrix_norm(m : MathnumericaldiffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_numerical_diff_matrix_to_string(m : MathnumericaldiffMatrix) -> String {
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

pub(all) struct MathnumericaldiffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_diff_make_vector(comps : Array[Double]) -> MathnumericaldiffVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_diff_vector_zero(dim : Int) -> MathnumericaldiffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_numerical_diff_vector_add(a : MathnumericaldiffVector, b : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_numerical_diff_vector_sub(a : MathnumericaldiffVector, b : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_numerical_diff_vector_scale(v : MathnumericaldiffVector, s : Double) -> MathnumericaldiffVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_numerical_diff_vector_dot(a : MathnumericaldiffVector, b : MathnumericaldiffVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_numerical_diff_vector_norm(v : MathnumericaldiffVector) -> Double { @_common.sqrt(math_numerical_diff_vector_dot(v, v)) }

pub fn math_numerical_diff_vector_normalize(v : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = math_numerical_diff_vector_norm(v)
  if n < 0.0000001 { v } else { math_numerical_diff_vector_scale(v, 1.0 / n) }
}

pub fn math_numerical_diff_vector_dist(a : MathnumericaldiffVector, b : MathnumericaldiffVector) -> Double {
  math_numerical_diff_vector_norm(math_numerical_diff_vector_sub(a, b))
}

pub fn math_numerical_diff_vector_to_string(v : MathnumericaldiffVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_numerical_diff_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_numerical_diff_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_numerical_diff_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_numerical_diff_std(data : Array[Double]) -> Double { @_common.sqrt(math_numerical_diff_var(data)) }

pub fn math_numerical_diff_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_numerical_diff_mean(a); let mb = math_numerical_diff_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_numerical_diff_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_numerical_diff_std(a); let sb = math_numerical_diff_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_numerical_diff_cov(a, b) / (sa * sb) }
}

pub fn math_numerical_diff_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_numerical_diff_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_numerical_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_numerical_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_numerical_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(math_numerical_diff_mse(pred, labels))
}

pub fn math_numerical_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_numerical_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_numerical_diff_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_numerical_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_numerical_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_numerical_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_numerical_diff_precision(pred, labels, pos); let r = math_numerical_diff_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_numerical_diff_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_numerical_diff_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_numerical_diff_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_numerical_diff_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_numerical_diff_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_numerical_diff_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_numerical_diff_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_numerical_diff_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_numerical_diff_fibonacci(n : Int) -> Int {
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

pub fn math_numerical_diff_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_numerical_diff_min(data); let mx = math_numerical_diff_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_numerical_diff_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_numerical_diff_mean(data); let sd = math_numerical_diff_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_numerical_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_numerical_diff_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_numerical_diff_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_numerical_diff_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_numerical_diff_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_numerical_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MathnumericaldiffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_frame_make(size : Int) -> MathnumericaldiffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_frame_len(s : MathnumericaldiffFrame) -> Int { s.size }

pub fn math_numerical_diff_frame_get(s : MathnumericaldiffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_frame_set(s : MathnumericaldiffFrame, i : Int, v : Double) -> MathnumericaldiffFrame {
  let result = math_numerical_diff_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_frame_sum(s : MathnumericaldiffFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_frame_mean(s : MathnumericaldiffFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_frame_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_frame_scale(s : MathnumericaldiffFrame, f : Double) -> MathnumericaldiffFrame {
  let result = math_numerical_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_frame_add(a : MathnumericaldiffFrame, b : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_frame_copy(s : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  let result = math_numerical_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_frame_fill(s : MathnumericaldiffFrame, v : Double) -> MathnumericaldiffFrame {
  let result = math_numerical_diff_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_frame_min(s : MathnumericaldiffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_frame_max(s : MathnumericaldiffFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_frame_to_string(s : MathnumericaldiffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_table_make(size : Int) -> MathnumericaldiffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_table_len(s : MathnumericaldiffTable) -> Int { s.size }

pub fn math_numerical_diff_table_get(s : MathnumericaldiffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_table_set(s : MathnumericaldiffTable, i : Int, v : Double) -> MathnumericaldiffTable {
  let result = math_numerical_diff_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_table_sum(s : MathnumericaldiffTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_table_mean(s : MathnumericaldiffTable) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_table_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_table_scale(s : MathnumericaldiffTable, f : Double) -> MathnumericaldiffTable {
  let result = math_numerical_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_table_add(a : MathnumericaldiffTable, b : MathnumericaldiffTable) -> MathnumericaldiffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_table_copy(s : MathnumericaldiffTable) -> MathnumericaldiffTable {
  let result = math_numerical_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_table_fill(s : MathnumericaldiffTable, v : Double) -> MathnumericaldiffTable {
  let result = math_numerical_diff_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_table_min(s : MathnumericaldiffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_table_max(s : MathnumericaldiffTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_table_to_string(s : MathnumericaldiffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_graphn_make(size : Int) -> MathnumericaldiffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_graphn_len(s : MathnumericaldiffGraphN) -> Int { s.size }

pub fn math_numerical_diff_graphn_get(s : MathnumericaldiffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_graphn_set(s : MathnumericaldiffGraphN, i : Int, v : Double) -> MathnumericaldiffGraphN {
  let result = math_numerical_diff_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_graphn_sum(s : MathnumericaldiffGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_graphn_mean(s : MathnumericaldiffGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_graphn_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_graphn_scale(s : MathnumericaldiffGraphN, f : Double) -> MathnumericaldiffGraphN {
  let result = math_numerical_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_graphn_add(a : MathnumericaldiffGraphN, b : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_graphn_copy(s : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  let result = math_numerical_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_graphn_fill(s : MathnumericaldiffGraphN, v : Double) -> MathnumericaldiffGraphN {
  let result = math_numerical_diff_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_graphn_min(s : MathnumericaldiffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_graphn_max(s : MathnumericaldiffGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_graphn_to_string(s : MathnumericaldiffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_node_make(size : Int) -> MathnumericaldiffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_node_len(s : MathnumericaldiffNode) -> Int { s.size }

pub fn math_numerical_diff_node_get(s : MathnumericaldiffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_node_set(s : MathnumericaldiffNode, i : Int, v : Double) -> MathnumericaldiffNode {
  let result = math_numerical_diff_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_node_sum(s : MathnumericaldiffNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_node_mean(s : MathnumericaldiffNode) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_node_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_node_scale(s : MathnumericaldiffNode, f : Double) -> MathnumericaldiffNode {
  let result = math_numerical_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_node_add(a : MathnumericaldiffNode, b : MathnumericaldiffNode) -> MathnumericaldiffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_node_copy(s : MathnumericaldiffNode) -> MathnumericaldiffNode {
  let result = math_numerical_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_node_fill(s : MathnumericaldiffNode, v : Double) -> MathnumericaldiffNode {
  let result = math_numerical_diff_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_node_min(s : MathnumericaldiffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_node_max(s : MathnumericaldiffNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_node_to_string(s : MathnumericaldiffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_edge_make(size : Int) -> MathnumericaldiffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_edge_len(s : MathnumericaldiffEdge) -> Int { s.size }

pub fn math_numerical_diff_edge_get(s : MathnumericaldiffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_edge_set(s : MathnumericaldiffEdge, i : Int, v : Double) -> MathnumericaldiffEdge {
  let result = math_numerical_diff_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_edge_sum(s : MathnumericaldiffEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_edge_mean(s : MathnumericaldiffEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_edge_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_edge_scale(s : MathnumericaldiffEdge, f : Double) -> MathnumericaldiffEdge {
  let result = math_numerical_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_edge_add(a : MathnumericaldiffEdge, b : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_edge_copy(s : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  let result = math_numerical_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_edge_fill(s : MathnumericaldiffEdge, v : Double) -> MathnumericaldiffEdge {
  let result = math_numerical_diff_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_edge_min(s : MathnumericaldiffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_edge_max(s : MathnumericaldiffEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_edge_to_string(s : MathnumericaldiffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_path_make(size : Int) -> MathnumericaldiffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_path_len(s : MathnumericaldiffPath) -> Int { s.size }

pub fn math_numerical_diff_path_get(s : MathnumericaldiffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_path_set(s : MathnumericaldiffPath, i : Int, v : Double) -> MathnumericaldiffPath {
  let result = math_numerical_diff_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_path_sum(s : MathnumericaldiffPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_path_mean(s : MathnumericaldiffPath) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_path_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_path_scale(s : MathnumericaldiffPath, f : Double) -> MathnumericaldiffPath {
  let result = math_numerical_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_path_add(a : MathnumericaldiffPath, b : MathnumericaldiffPath) -> MathnumericaldiffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_path_copy(s : MathnumericaldiffPath) -> MathnumericaldiffPath {
  let result = math_numerical_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_path_fill(s : MathnumericaldiffPath, v : Double) -> MathnumericaldiffPath {
  let result = math_numerical_diff_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_path_min(s : MathnumericaldiffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_path_max(s : MathnumericaldiffPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_path_to_string(s : MathnumericaldiffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cluster_make(size : Int) -> MathnumericaldiffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_cluster_len(s : MathnumericaldiffCluster) -> Int { s.size }

pub fn math_numerical_diff_cluster_get(s : MathnumericaldiffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_cluster_set(s : MathnumericaldiffCluster, i : Int, v : Double) -> MathnumericaldiffCluster {
  let result = math_numerical_diff_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_cluster_sum(s : MathnumericaldiffCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_cluster_mean(s : MathnumericaldiffCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_cluster_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_cluster_scale(s : MathnumericaldiffCluster, f : Double) -> MathnumericaldiffCluster {
  let result = math_numerical_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_cluster_add(a : MathnumericaldiffCluster, b : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_cluster_copy(s : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  let result = math_numerical_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_cluster_fill(s : MathnumericaldiffCluster, v : Double) -> MathnumericaldiffCluster {
  let result = math_numerical_diff_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_cluster_min(s : MathnumericaldiffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_cluster_max(s : MathnumericaldiffCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_cluster_to_string(s : MathnumericaldiffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_model_make(size : Int) -> MathnumericaldiffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_model_len(s : MathnumericaldiffModel) -> Int { s.size }

pub fn math_numerical_diff_model_get(s : MathnumericaldiffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_model_set(s : MathnumericaldiffModel, i : Int, v : Double) -> MathnumericaldiffModel {
  let result = math_numerical_diff_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_model_sum(s : MathnumericaldiffModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_model_mean(s : MathnumericaldiffModel) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_model_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_model_scale(s : MathnumericaldiffModel, f : Double) -> MathnumericaldiffModel {
  let result = math_numerical_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_model_add(a : MathnumericaldiffModel, b : MathnumericaldiffModel) -> MathnumericaldiffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_model_copy(s : MathnumericaldiffModel) -> MathnumericaldiffModel {
  let result = math_numerical_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_model_fill(s : MathnumericaldiffModel, v : Double) -> MathnumericaldiffModel {
  let result = math_numerical_diff_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_model_min(s : MathnumericaldiffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_model_max(s : MathnumericaldiffModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_model_to_string(s : MathnumericaldiffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_layer_make(size : Int) -> MathnumericaldiffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_layer_len(s : MathnumericaldiffLayer) -> Int { s.size }

pub fn math_numerical_diff_layer_get(s : MathnumericaldiffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_layer_set(s : MathnumericaldiffLayer, i : Int, v : Double) -> MathnumericaldiffLayer {
  let result = math_numerical_diff_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_layer_sum(s : MathnumericaldiffLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_layer_mean(s : MathnumericaldiffLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_layer_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_layer_scale(s : MathnumericaldiffLayer, f : Double) -> MathnumericaldiffLayer {
  let result = math_numerical_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_layer_add(a : MathnumericaldiffLayer, b : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_layer_copy(s : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  let result = math_numerical_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_layer_fill(s : MathnumericaldiffLayer, v : Double) -> MathnumericaldiffLayer {
  let result = math_numerical_diff_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_layer_min(s : MathnumericaldiffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_layer_max(s : MathnumericaldiffLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_layer_to_string(s : MathnumericaldiffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_buffer_make(size : Int) -> MathnumericaldiffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_buffer_len(s : MathnumericaldiffBuffer) -> Int { s.size }

pub fn math_numerical_diff_buffer_get(s : MathnumericaldiffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_buffer_set(s : MathnumericaldiffBuffer, i : Int, v : Double) -> MathnumericaldiffBuffer {
  let result = math_numerical_diff_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_buffer_sum(s : MathnumericaldiffBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_buffer_mean(s : MathnumericaldiffBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_buffer_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_buffer_scale(s : MathnumericaldiffBuffer, f : Double) -> MathnumericaldiffBuffer {
  let result = math_numerical_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_buffer_add(a : MathnumericaldiffBuffer, b : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_buffer_copy(s : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  let result = math_numerical_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_buffer_fill(s : MathnumericaldiffBuffer, v : Double) -> MathnumericaldiffBuffer {
  let result = math_numerical_diff_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_buffer_min(s : MathnumericaldiffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_buffer_max(s : MathnumericaldiffBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_buffer_to_string(s : MathnumericaldiffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cursor_make(size : Int) -> MathnumericaldiffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_cursor_len(s : MathnumericaldiffCursor) -> Int { s.size }

pub fn math_numerical_diff_cursor_get(s : MathnumericaldiffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_cursor_set(s : MathnumericaldiffCursor, i : Int, v : Double) -> MathnumericaldiffCursor {
  let result = math_numerical_diff_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_cursor_sum(s : MathnumericaldiffCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_cursor_mean(s : MathnumericaldiffCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_cursor_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_cursor_scale(s : MathnumericaldiffCursor, f : Double) -> MathnumericaldiffCursor {
  let result = math_numerical_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_cursor_add(a : MathnumericaldiffCursor, b : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_cursor_copy(s : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  let result = math_numerical_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_cursor_fill(s : MathnumericaldiffCursor, v : Double) -> MathnumericaldiffCursor {
  let result = math_numerical_diff_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_cursor_min(s : MathnumericaldiffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_cursor_max(s : MathnumericaldiffCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_cursor_to_string(s : MathnumericaldiffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_view_make(size : Int) -> MathnumericaldiffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_view_len(s : MathnumericaldiffView) -> Int { s.size }

pub fn math_numerical_diff_view_get(s : MathnumericaldiffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_view_set(s : MathnumericaldiffView, i : Int, v : Double) -> MathnumericaldiffView {
  let result = math_numerical_diff_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_view_sum(s : MathnumericaldiffView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_view_mean(s : MathnumericaldiffView) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_view_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_view_scale(s : MathnumericaldiffView, f : Double) -> MathnumericaldiffView {
  let result = math_numerical_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_view_add(a : MathnumericaldiffView, b : MathnumericaldiffView) -> MathnumericaldiffView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_view_copy(s : MathnumericaldiffView) -> MathnumericaldiffView {
  let result = math_numerical_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_view_fill(s : MathnumericaldiffView, v : Double) -> MathnumericaldiffView {
  let result = math_numerical_diff_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_view_min(s : MathnumericaldiffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_view_max(s : MathnumericaldiffView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_view_to_string(s : MathnumericaldiffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_range_make(size : Int) -> MathnumericaldiffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_range_len(s : MathnumericaldiffRange) -> Int { s.size }

pub fn math_numerical_diff_range_get(s : MathnumericaldiffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_range_set(s : MathnumericaldiffRange, i : Int, v : Double) -> MathnumericaldiffRange {
  let result = math_numerical_diff_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_range_sum(s : MathnumericaldiffRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_range_mean(s : MathnumericaldiffRange) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_range_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_range_scale(s : MathnumericaldiffRange, f : Double) -> MathnumericaldiffRange {
  let result = math_numerical_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_range_add(a : MathnumericaldiffRange, b : MathnumericaldiffRange) -> MathnumericaldiffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_range_copy(s : MathnumericaldiffRange) -> MathnumericaldiffRange {
  let result = math_numerical_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_range_fill(s : MathnumericaldiffRange, v : Double) -> MathnumericaldiffRange {
  let result = math_numerical_diff_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_range_min(s : MathnumericaldiffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_range_max(s : MathnumericaldiffRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_range_to_string(s : MathnumericaldiffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_slice_make(size : Int) -> MathnumericaldiffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_slice_len(s : MathnumericaldiffSlice) -> Int { s.size }

pub fn math_numerical_diff_slice_get(s : MathnumericaldiffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_slice_set(s : MathnumericaldiffSlice, i : Int, v : Double) -> MathnumericaldiffSlice {
  let result = math_numerical_diff_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_slice_sum(s : MathnumericaldiffSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_diff_slice_mean(s : MathnumericaldiffSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_diff_slice_sum(s) / s.size.to_double() }
}

pub fn math_numerical_diff_slice_scale(s : MathnumericaldiffSlice, f : Double) -> MathnumericaldiffSlice {
  let result = math_numerical_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_diff_slice_add(a : MathnumericaldiffSlice, b : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_diff_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_diff_slice_copy(s : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  let result = math_numerical_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_diff_slice_fill(s : MathnumericaldiffSlice, v : Double) -> MathnumericaldiffSlice {
  let result = math_numerical_diff_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_diff_slice_min(s : MathnumericaldiffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_slice_max(s : MathnumericaldiffSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_diff_slice_to_string(s : MathnumericaldiffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


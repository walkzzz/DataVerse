///===
/// extcore/math_complementarity

pub(all) struct MathcomplementarityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_complementarity_make_point(x : Double, y : Double) -> MathcomplementarityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_complementarity_make_point3(x : Double, y : Double, z : Double) -> MathcomplementarityPoint {
  { x, y, z, label: 0 }
}

pub fn math_complementarity_point_x(pt : MathcomplementarityPoint) -> Double { pt.x }

pub fn math_complementarity_point_y(pt : MathcomplementarityPoint) -> Double { pt.y }

pub fn math_complementarity_point_z(pt : MathcomplementarityPoint) -> Double { pt.z }

pub fn math_complementarity_point_label(pt : MathcomplementarityPoint) -> Int { pt.label }

pub fn math_complementarity_point_dist(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  math_complementarity_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_complementarity_point_add(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_complementarity_point_sub(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_complementarity_point_scale(pt : MathcomplementarityPoint, s : Double) -> MathcomplementarityPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_complementarity_point_dot(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_complementarity_point_cross(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_complementarity_point_norm(pt : MathcomplementarityPoint) -> Double {
  math_complementarity_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_complementarity_point_normalize(pt : MathcomplementarityPoint) -> MathcomplementarityPoint {
  let n = math_complementarity_point_norm(pt)
  if n < 0.0000001 { pt } else { math_complementarity_point_scale(pt, 1.0 / n) }
}

pub fn math_complementarity_point_negate(pt : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_complementarity_point_mid(a : MathcomplementarityPoint, b : MathcomplementarityPoint) -> MathcomplementarityPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_complementarity_point_lerp(a : MathcomplementarityPoint, b : MathcomplementarityPoint, t : Double) -> MathcomplementarityPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_complementarity_point_to_string(pt : MathcomplementarityPoint) -> String {
  "(" + math_complementarity_dbl(pt.x) + ", " + math_complementarity_dbl(pt.y) + ", " + math_complementarity_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathcomplementaritySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_complementarity_make_series(vals : Array[Double], name : String) -> MathcomplementaritySeries {
  { vals, name, meta: 0 }
}

pub fn math_complementarity_series_len(s : MathcomplementaritySeries) -> Int { s.vals.length() }

pub fn math_complementarity_series_sum(s : MathcomplementaritySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_complementarity_series_mean(s : MathcomplementaritySeries) -> Double {
  let n = math_complementarity_series_len(s)
  if n == 0 { 0.0 } else { math_complementarity_series_sum(s) / n.to_double() }
}

pub fn math_complementarity_series_min(s : MathcomplementaritySeries) -> Double {
  let n = math_complementarity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_complementarity_series_max(s : MathcomplementaritySeries) -> Double {
  let n = math_complementarity_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_complementarity_series_range(s : MathcomplementaritySeries) -> Double {
  math_complementarity_series_max(s) - math_complementarity_series_min(s)
}

pub fn math_complementarity_series_var(s : MathcomplementaritySeries) -> Double {
  let n = math_complementarity_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_complementarity_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_complementarity_series_std(s : MathcomplementaritySeries) -> Double { math_complementarity_sqrt(math_complementarity_series_var(s)) }

pub fn math_complementarity_series_median(s : MathcomplementaritySeries) -> Double {
  let n = math_complementarity_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_complementarity_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_complementarity_series_scale(s : MathcomplementaritySeries, f : Double) -> MathcomplementaritySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = math_complementarity_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_complementarity_series_add(a : MathcomplementaritySeries, b : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_complementarity_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_complementarity_series_sub(a : MathcomplementaritySeries, b : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = math_complementarity_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_complementarity_series_normalize(s : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let mn = math_complementarity_series_min(s)
  let mx = math_complementarity_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = math_complementarity_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_complementarity_series_cumsum(s : MathcomplementaritySeries) -> MathcomplementaritySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = math_complementarity_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_complementarity_series_to_string(s : MathcomplementaritySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_complementarity_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcomplementarityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_complementarity_make_matrix(rows : Int, cols : Int, val : Double) -> MathcomplementarityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_complementarity_matrix_identity(n : Int) -> MathcomplementarityMatrix {
  let m = math_complementarity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_complementarity_matrix_get(m : MathcomplementarityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_complementarity_matrix_transpose(m : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_complementarity_matrix_add(a : MathcomplementarityMatrix, b : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_complementarity_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_complementarity_matrix_scale(m : MathcomplementarityMatrix, s : Double) -> MathcomplementarityMatrix {
  let result = math_complementarity_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_complementarity_matrix_multiply(a : MathcomplementarityMatrix, b : MathcomplementarityMatrix) -> MathcomplementarityMatrix {
  if a.cols != b.rows { return math_complementarity_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_complementarity_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_complementarity_matrix_trace(m : MathcomplementarityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_complementarity_matrix_det(m : MathcomplementarityMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_complementarity_matrix_norm(m : MathcomplementarityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  math_complementarity_sqrt(sum)
}

pub fn math_complementarity_matrix_to_string(m : MathcomplementarityMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + math_complementarity_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MathcomplementarityVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_complementarity_make_vector(comps : Array[Double]) -> MathcomplementarityVector {
  { comps, dim: comps.length() }
}

pub fn math_complementarity_vector_zero(dim : Int) -> MathcomplementarityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_complementarity_vector_add(a : MathcomplementarityVector, b : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_complementarity_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_complementarity_vector_sub(a : MathcomplementarityVector, b : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = math_complementarity_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_complementarity_vector_scale(v : MathcomplementarityVector, s : Double) -> MathcomplementarityVector {
  let mut result = []
  for i in 0..<v.dim { result = math_complementarity_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_complementarity_vector_dot(a : MathcomplementarityVector, b : MathcomplementarityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_complementarity_vector_norm(v : MathcomplementarityVector) -> Double { math_complementarity_sqrt(math_complementarity_vector_dot(v, v)) }

pub fn math_complementarity_vector_normalize(v : MathcomplementarityVector) -> MathcomplementarityVector {
  let n = math_complementarity_vector_norm(v)
  if n < 0.0000001 { v } else { math_complementarity_vector_scale(v, 1.0 / n) }
}

pub fn math_complementarity_vector_dist(a : MathcomplementarityVector, b : MathcomplementarityVector) -> Double {
  math_complementarity_vector_norm(math_complementarity_vector_sub(a, b))
}

pub fn math_complementarity_vector_to_string(v : MathcomplementarityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + math_complementarity_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_complementarity_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn math_complementarity_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = math_complementarity_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_complementarity_std(data : Array[Double]) -> Double { math_complementarity_sqrt(math_complementarity_var(data)) }

pub fn math_complementarity_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = math_complementarity_mean(a); let mb = math_complementarity_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn math_complementarity_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = math_complementarity_std(a); let sb = math_complementarity_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { math_complementarity_cov(a, b) / (sa * sb) }
}

pub fn math_complementarity_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = math_complementarity_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_complementarity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn math_complementarity_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn math_complementarity_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  math_complementarity_sqrt(math_complementarity_mse(pred, labels))
}

pub fn math_complementarity_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + math_complementarity_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn math_complementarity_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = math_complementarity_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn math_complementarity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn math_complementarity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn math_complementarity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = math_complementarity_precision(pred, labels, pos); let r = math_complementarity_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn math_complementarity_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn math_complementarity_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = math_complementarity_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn math_complementarity_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn math_complementarity_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn math_complementarity_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = math_complementarity_gcd(a, b)
    (a / g) * b
  }
}

pub fn math_complementarity_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn math_complementarity_fibonacci(n : Int) -> Int {
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

pub fn math_complementarity_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = math_complementarity_min(data); let mx = math_complementarity_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn math_complementarity_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = math_complementarity_mean(data); let sd = math_complementarity_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn math_complementarity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn math_complementarity_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn math_complementarity_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn math_complementarity_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn math_complementarity_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn math_complementarity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn math_complementarity_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn math_complementarity_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn math_complementarity_dbl(x : Double) -> String {
  let i = if x >= 0.0 { math_complementarity_int(x) } else { -math_complementarity_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { math_complementarity_int(f * 1000000.0) } else { math_complementarity_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn math_complementarity_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn math_complementarity_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MathcomplementarityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_frame_make(size : Int) -> MathcomplementarityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_frame_len(s : MathcomplementarityFrame) -> Int { s.size }

pub fn math_complementarity_frame_get(s : MathcomplementarityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_frame_set(s : MathcomplementarityFrame, i : Int, v : Double) -> MathcomplementarityFrame {
  let result = math_complementarity_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_frame_sum(s : MathcomplementarityFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_frame_mean(s : MathcomplementarityFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_frame_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_frame_scale(s : MathcomplementarityFrame, f : Double) -> MathcomplementarityFrame {
  let result = math_complementarity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_frame_add(a : MathcomplementarityFrame, b : MathcomplementarityFrame) -> MathcomplementarityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_frame_copy(s : MathcomplementarityFrame) -> MathcomplementarityFrame {
  let result = math_complementarity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_frame_fill(s : MathcomplementarityFrame, v : Double) -> MathcomplementarityFrame {
  let result = math_complementarity_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_frame_min(s : MathcomplementarityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_frame_max(s : MathcomplementarityFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_frame_to_string(s : MathcomplementarityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_table_make(size : Int) -> MathcomplementarityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_table_len(s : MathcomplementarityTable) -> Int { s.size }

pub fn math_complementarity_table_get(s : MathcomplementarityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_table_set(s : MathcomplementarityTable, i : Int, v : Double) -> MathcomplementarityTable {
  let result = math_complementarity_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_table_sum(s : MathcomplementarityTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_table_mean(s : MathcomplementarityTable) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_table_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_table_scale(s : MathcomplementarityTable, f : Double) -> MathcomplementarityTable {
  let result = math_complementarity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_table_add(a : MathcomplementarityTable, b : MathcomplementarityTable) -> MathcomplementarityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_table_copy(s : MathcomplementarityTable) -> MathcomplementarityTable {
  let result = math_complementarity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_table_fill(s : MathcomplementarityTable, v : Double) -> MathcomplementarityTable {
  let result = math_complementarity_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_table_min(s : MathcomplementarityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_table_max(s : MathcomplementarityTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_table_to_string(s : MathcomplementarityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_graphn_make(size : Int) -> MathcomplementarityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_graphn_len(s : MathcomplementarityGraphN) -> Int { s.size }

pub fn math_complementarity_graphn_get(s : MathcomplementarityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_graphn_set(s : MathcomplementarityGraphN, i : Int, v : Double) -> MathcomplementarityGraphN {
  let result = math_complementarity_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_graphn_sum(s : MathcomplementarityGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_graphn_mean(s : MathcomplementarityGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_graphn_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_graphn_scale(s : MathcomplementarityGraphN, f : Double) -> MathcomplementarityGraphN {
  let result = math_complementarity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_graphn_add(a : MathcomplementarityGraphN, b : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_graphn_copy(s : MathcomplementarityGraphN) -> MathcomplementarityGraphN {
  let result = math_complementarity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_graphn_fill(s : MathcomplementarityGraphN, v : Double) -> MathcomplementarityGraphN {
  let result = math_complementarity_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_graphn_min(s : MathcomplementarityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_graphn_max(s : MathcomplementarityGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_graphn_to_string(s : MathcomplementarityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_node_make(size : Int) -> MathcomplementarityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_node_len(s : MathcomplementarityNode) -> Int { s.size }

pub fn math_complementarity_node_get(s : MathcomplementarityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_node_set(s : MathcomplementarityNode, i : Int, v : Double) -> MathcomplementarityNode {
  let result = math_complementarity_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_node_sum(s : MathcomplementarityNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_node_mean(s : MathcomplementarityNode) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_node_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_node_scale(s : MathcomplementarityNode, f : Double) -> MathcomplementarityNode {
  let result = math_complementarity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_node_add(a : MathcomplementarityNode, b : MathcomplementarityNode) -> MathcomplementarityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_node_copy(s : MathcomplementarityNode) -> MathcomplementarityNode {
  let result = math_complementarity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_node_fill(s : MathcomplementarityNode, v : Double) -> MathcomplementarityNode {
  let result = math_complementarity_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_node_min(s : MathcomplementarityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_node_max(s : MathcomplementarityNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_node_to_string(s : MathcomplementarityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_edge_make(size : Int) -> MathcomplementarityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_edge_len(s : MathcomplementarityEdge) -> Int { s.size }

pub fn math_complementarity_edge_get(s : MathcomplementarityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_edge_set(s : MathcomplementarityEdge, i : Int, v : Double) -> MathcomplementarityEdge {
  let result = math_complementarity_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_edge_sum(s : MathcomplementarityEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_edge_mean(s : MathcomplementarityEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_edge_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_edge_scale(s : MathcomplementarityEdge, f : Double) -> MathcomplementarityEdge {
  let result = math_complementarity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_edge_add(a : MathcomplementarityEdge, b : MathcomplementarityEdge) -> MathcomplementarityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_edge_copy(s : MathcomplementarityEdge) -> MathcomplementarityEdge {
  let result = math_complementarity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_edge_fill(s : MathcomplementarityEdge, v : Double) -> MathcomplementarityEdge {
  let result = math_complementarity_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_edge_min(s : MathcomplementarityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_edge_max(s : MathcomplementarityEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_edge_to_string(s : MathcomplementarityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_path_make(size : Int) -> MathcomplementarityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_path_len(s : MathcomplementarityPath) -> Int { s.size }

pub fn math_complementarity_path_get(s : MathcomplementarityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_path_set(s : MathcomplementarityPath, i : Int, v : Double) -> MathcomplementarityPath {
  let result = math_complementarity_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_path_sum(s : MathcomplementarityPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_path_mean(s : MathcomplementarityPath) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_path_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_path_scale(s : MathcomplementarityPath, f : Double) -> MathcomplementarityPath {
  let result = math_complementarity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_path_add(a : MathcomplementarityPath, b : MathcomplementarityPath) -> MathcomplementarityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_path_copy(s : MathcomplementarityPath) -> MathcomplementarityPath {
  let result = math_complementarity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_path_fill(s : MathcomplementarityPath, v : Double) -> MathcomplementarityPath {
  let result = math_complementarity_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_path_min(s : MathcomplementarityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_path_max(s : MathcomplementarityPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_path_to_string(s : MathcomplementarityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cluster_make(size : Int) -> MathcomplementarityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_cluster_len(s : MathcomplementarityCluster) -> Int { s.size }

pub fn math_complementarity_cluster_get(s : MathcomplementarityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_cluster_set(s : MathcomplementarityCluster, i : Int, v : Double) -> MathcomplementarityCluster {
  let result = math_complementarity_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_cluster_sum(s : MathcomplementarityCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_cluster_mean(s : MathcomplementarityCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_cluster_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_cluster_scale(s : MathcomplementarityCluster, f : Double) -> MathcomplementarityCluster {
  let result = math_complementarity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_cluster_add(a : MathcomplementarityCluster, b : MathcomplementarityCluster) -> MathcomplementarityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_cluster_copy(s : MathcomplementarityCluster) -> MathcomplementarityCluster {
  let result = math_complementarity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_cluster_fill(s : MathcomplementarityCluster, v : Double) -> MathcomplementarityCluster {
  let result = math_complementarity_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_cluster_min(s : MathcomplementarityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_cluster_max(s : MathcomplementarityCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_cluster_to_string(s : MathcomplementarityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_model_make(size : Int) -> MathcomplementarityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_model_len(s : MathcomplementarityModel) -> Int { s.size }

pub fn math_complementarity_model_get(s : MathcomplementarityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_model_set(s : MathcomplementarityModel, i : Int, v : Double) -> MathcomplementarityModel {
  let result = math_complementarity_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_model_sum(s : MathcomplementarityModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_model_mean(s : MathcomplementarityModel) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_model_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_model_scale(s : MathcomplementarityModel, f : Double) -> MathcomplementarityModel {
  let result = math_complementarity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_model_add(a : MathcomplementarityModel, b : MathcomplementarityModel) -> MathcomplementarityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_model_copy(s : MathcomplementarityModel) -> MathcomplementarityModel {
  let result = math_complementarity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_model_fill(s : MathcomplementarityModel, v : Double) -> MathcomplementarityModel {
  let result = math_complementarity_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_model_min(s : MathcomplementarityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_model_max(s : MathcomplementarityModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_model_to_string(s : MathcomplementarityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_layer_make(size : Int) -> MathcomplementarityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_layer_len(s : MathcomplementarityLayer) -> Int { s.size }

pub fn math_complementarity_layer_get(s : MathcomplementarityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_layer_set(s : MathcomplementarityLayer, i : Int, v : Double) -> MathcomplementarityLayer {
  let result = math_complementarity_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_layer_sum(s : MathcomplementarityLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_layer_mean(s : MathcomplementarityLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_layer_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_layer_scale(s : MathcomplementarityLayer, f : Double) -> MathcomplementarityLayer {
  let result = math_complementarity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_layer_add(a : MathcomplementarityLayer, b : MathcomplementarityLayer) -> MathcomplementarityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_layer_copy(s : MathcomplementarityLayer) -> MathcomplementarityLayer {
  let result = math_complementarity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_layer_fill(s : MathcomplementarityLayer, v : Double) -> MathcomplementarityLayer {
  let result = math_complementarity_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_layer_min(s : MathcomplementarityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_layer_max(s : MathcomplementarityLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_layer_to_string(s : MathcomplementarityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_buffer_make(size : Int) -> MathcomplementarityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_buffer_len(s : MathcomplementarityBuffer) -> Int { s.size }

pub fn math_complementarity_buffer_get(s : MathcomplementarityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_buffer_set(s : MathcomplementarityBuffer, i : Int, v : Double) -> MathcomplementarityBuffer {
  let result = math_complementarity_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_buffer_sum(s : MathcomplementarityBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_buffer_mean(s : MathcomplementarityBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_buffer_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_buffer_scale(s : MathcomplementarityBuffer, f : Double) -> MathcomplementarityBuffer {
  let result = math_complementarity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_buffer_add(a : MathcomplementarityBuffer, b : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_buffer_copy(s : MathcomplementarityBuffer) -> MathcomplementarityBuffer {
  let result = math_complementarity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_buffer_fill(s : MathcomplementarityBuffer, v : Double) -> MathcomplementarityBuffer {
  let result = math_complementarity_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_buffer_min(s : MathcomplementarityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_buffer_max(s : MathcomplementarityBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_buffer_to_string(s : MathcomplementarityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_cursor_make(size : Int) -> MathcomplementarityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_cursor_len(s : MathcomplementarityCursor) -> Int { s.size }

pub fn math_complementarity_cursor_get(s : MathcomplementarityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_cursor_set(s : MathcomplementarityCursor, i : Int, v : Double) -> MathcomplementarityCursor {
  let result = math_complementarity_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_cursor_sum(s : MathcomplementarityCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_cursor_mean(s : MathcomplementarityCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_cursor_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_cursor_scale(s : MathcomplementarityCursor, f : Double) -> MathcomplementarityCursor {
  let result = math_complementarity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_cursor_add(a : MathcomplementarityCursor, b : MathcomplementarityCursor) -> MathcomplementarityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_cursor_copy(s : MathcomplementarityCursor) -> MathcomplementarityCursor {
  let result = math_complementarity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_cursor_fill(s : MathcomplementarityCursor, v : Double) -> MathcomplementarityCursor {
  let result = math_complementarity_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_cursor_min(s : MathcomplementarityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_cursor_max(s : MathcomplementarityCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_cursor_to_string(s : MathcomplementarityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_view_make(size : Int) -> MathcomplementarityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_view_len(s : MathcomplementarityView) -> Int { s.size }

pub fn math_complementarity_view_get(s : MathcomplementarityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_view_set(s : MathcomplementarityView, i : Int, v : Double) -> MathcomplementarityView {
  let result = math_complementarity_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_view_sum(s : MathcomplementarityView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_view_mean(s : MathcomplementarityView) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_view_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_view_scale(s : MathcomplementarityView, f : Double) -> MathcomplementarityView {
  let result = math_complementarity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_view_add(a : MathcomplementarityView, b : MathcomplementarityView) -> MathcomplementarityView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_view_copy(s : MathcomplementarityView) -> MathcomplementarityView {
  let result = math_complementarity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_view_fill(s : MathcomplementarityView, v : Double) -> MathcomplementarityView {
  let result = math_complementarity_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_view_min(s : MathcomplementarityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_view_max(s : MathcomplementarityView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_view_to_string(s : MathcomplementarityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementarityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_range_make(size : Int) -> MathcomplementarityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_range_len(s : MathcomplementarityRange) -> Int { s.size }

pub fn math_complementarity_range_get(s : MathcomplementarityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_range_set(s : MathcomplementarityRange, i : Int, v : Double) -> MathcomplementarityRange {
  let result = math_complementarity_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_range_sum(s : MathcomplementarityRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_range_mean(s : MathcomplementarityRange) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_range_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_range_scale(s : MathcomplementarityRange, f : Double) -> MathcomplementarityRange {
  let result = math_complementarity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_range_add(a : MathcomplementarityRange, b : MathcomplementarityRange) -> MathcomplementarityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_range_copy(s : MathcomplementarityRange) -> MathcomplementarityRange {
  let result = math_complementarity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_range_fill(s : MathcomplementarityRange, v : Double) -> MathcomplementarityRange {
  let result = math_complementarity_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_range_min(s : MathcomplementarityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_range_max(s : MathcomplementarityRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_range_to_string(s : MathcomplementarityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcomplementaritySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_complementarity_slice_make(size : Int) -> MathcomplementaritySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_complementarity_slice_len(s : MathcomplementaritySlice) -> Int { s.size }

pub fn math_complementarity_slice_get(s : MathcomplementaritySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_complementarity_slice_set(s : MathcomplementaritySlice, i : Int, v : Double) -> MathcomplementaritySlice {
  let result = math_complementarity_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_slice_sum(s : MathcomplementaritySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_complementarity_slice_mean(s : MathcomplementaritySlice) -> Double {
  if s.size == 0 { 0.0 } else { math_complementarity_slice_sum(s) / s.size.to_double() }
}

pub fn math_complementarity_slice_scale(s : MathcomplementaritySlice, f : Double) -> MathcomplementaritySlice {
  let result = math_complementarity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_complementarity_slice_add(a : MathcomplementaritySlice, b : MathcomplementaritySlice) -> MathcomplementaritySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_complementarity_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_complementarity_slice_copy(s : MathcomplementaritySlice) -> MathcomplementaritySlice {
  let result = math_complementarity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_complementarity_slice_fill(s : MathcomplementaritySlice, v : Double) -> MathcomplementaritySlice {
  let result = math_complementarity_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_complementarity_slice_min(s : MathcomplementaritySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_slice_max(s : MathcomplementaritySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_complementarity_slice_to_string(s : MathcomplementaritySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn math_complementarity_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn math_complementarity_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


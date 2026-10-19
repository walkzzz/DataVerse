///===
/// extcore/ml_classify_knn

pub(all) struct MlclassifyknnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_knn_make_point(x : Double, y : Double) -> MlclassifyknnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_knn_make_point3(x : Double, y : Double, z : Double) -> MlclassifyknnPoint {
  { x, y, z, label: 0 }
}

pub fn ml_classify_knn_point_x(pt : MlclassifyknnPoint) -> Double { pt.x }

pub fn ml_classify_knn_point_y(pt : MlclassifyknnPoint) -> Double { pt.y }

pub fn ml_classify_knn_point_z(pt : MlclassifyknnPoint) -> Double { pt.z }

pub fn ml_classify_knn_point_label(pt : MlclassifyknnPoint) -> Int { pt.label }

pub fn ml_classify_knn_point_dist(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_classify_knn_point_add(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_classify_knn_point_sub(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_classify_knn_point_scale(pt : MlclassifyknnPoint, s : Double) -> MlclassifyknnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_classify_knn_point_dot(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_classify_knn_point_cross(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_classify_knn_point_norm(pt : MlclassifyknnPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_classify_knn_point_normalize(pt : MlclassifyknnPoint) -> MlclassifyknnPoint {
  let n = ml_classify_knn_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_classify_knn_point_scale(pt, 1.0 / n) }
}

pub fn ml_classify_knn_point_negate(pt : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_classify_knn_point_mid(a : MlclassifyknnPoint, b : MlclassifyknnPoint) -> MlclassifyknnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_classify_knn_point_lerp(a : MlclassifyknnPoint, b : MlclassifyknnPoint, t : Double) -> MlclassifyknnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_classify_knn_point_to_string(pt : MlclassifyknnPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlclassifyknnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_knn_make_series(vals : Array[Double], name : String) -> MlclassifyknnSeries {
  { vals, name, meta: 0 }
}

pub fn ml_classify_knn_series_len(s : MlclassifyknnSeries) -> Int { s.vals.length() }

pub fn ml_classify_knn_series_sum(s : MlclassifyknnSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_classify_knn_series_mean(s : MlclassifyknnSeries) -> Double {
  let n = ml_classify_knn_series_len(s)
  if n == 0 { 0.0 } else { ml_classify_knn_series_sum(s) / n.to_double() }
}

pub fn ml_classify_knn_series_min(s : MlclassifyknnSeries) -> Double {
  let n = ml_classify_knn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_knn_series_max(s : MlclassifyknnSeries) -> Double {
  let n = ml_classify_knn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_classify_knn_series_range(s : MlclassifyknnSeries) -> Double {
  ml_classify_knn_series_max(s) - ml_classify_knn_series_min(s)
}

pub fn ml_classify_knn_series_var(s : MlclassifyknnSeries) -> Double {
  let n = ml_classify_knn_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_classify_knn_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_classify_knn_series_std(s : MlclassifyknnSeries) -> Double { @_common.sqrt(ml_classify_knn_series_var(s)) }

pub fn ml_classify_knn_series_median(s : MlclassifyknnSeries) -> Double {
  let n = ml_classify_knn_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_knn_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_knn_series_scale(s : MlclassifyknnSeries, f : Double) -> MlclassifyknnSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_classify_knn_series_add(a : MlclassifyknnSeries, b : MlclassifyknnSeries) -> MlclassifyknnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_classify_knn_series_sub(a : MlclassifyknnSeries, b : MlclassifyknnSeries) -> MlclassifyknnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_classify_knn_series_normalize(s : MlclassifyknnSeries) -> MlclassifyknnSeries {
  let mn = ml_classify_knn_series_min(s)
  let mx = ml_classify_knn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_classify_knn_series_cumsum(s : MlclassifyknnSeries) -> MlclassifyknnSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_classify_knn_series_to_string(s : MlclassifyknnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyknnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_knn_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyknnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_knn_matrix_identity(n : Int) -> MlclassifyknnMatrix {
  let m = ml_classify_knn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_classify_knn_matrix_get(m : MlclassifyknnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_classify_knn_matrix_transpose(m : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  let result = ml_classify_knn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_classify_knn_matrix_add(a : MlclassifyknnMatrix, b : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_classify_knn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_classify_knn_matrix_scale(m : MlclassifyknnMatrix, s : Double) -> MlclassifyknnMatrix {
  let result = ml_classify_knn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_classify_knn_matrix_multiply(a : MlclassifyknnMatrix, b : MlclassifyknnMatrix) -> MlclassifyknnMatrix {
  if a.cols != b.rows { return ml_classify_knn_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_classify_knn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_classify_knn_matrix_trace(m : MlclassifyknnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_classify_knn_matrix_det(m : MlclassifyknnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_classify_knn_matrix_norm(m : MlclassifyknnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_classify_knn_matrix_to_string(m : MlclassifyknnMatrix) -> String {
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

pub(all) struct MlclassifyknnVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_knn_make_vector(comps : Array[Double]) -> MlclassifyknnVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_knn_vector_zero(dim : Int) -> MlclassifyknnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_classify_knn_vector_add(a : MlclassifyknnVector, b : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_knn_vector_sub(a : MlclassifyknnVector, b : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_classify_knn_vector_scale(v : MlclassifyknnVector, s : Double) -> MlclassifyknnVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_classify_knn_vector_dot(a : MlclassifyknnVector, b : MlclassifyknnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_classify_knn_vector_norm(v : MlclassifyknnVector) -> Double { @_common.sqrt(ml_classify_knn_vector_dot(v, v)) }

pub fn ml_classify_knn_vector_normalize(v : MlclassifyknnVector) -> MlclassifyknnVector {
  let n = ml_classify_knn_vector_norm(v)
  if n < 0.0000001 { v } else { ml_classify_knn_vector_scale(v, 1.0 / n) }
}

pub fn ml_classify_knn_vector_dist(a : MlclassifyknnVector, b : MlclassifyknnVector) -> Double {
  ml_classify_knn_vector_norm(ml_classify_knn_vector_sub(a, b))
}

pub fn ml_classify_knn_vector_to_string(v : MlclassifyknnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_knn_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_classify_knn_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_classify_knn_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_knn_std(data : Array[Double]) -> Double { @_common.sqrt(ml_classify_knn_var(data)) }

pub fn ml_classify_knn_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_classify_knn_mean(a); let mb = ml_classify_knn_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_classify_knn_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_classify_knn_std(a); let sb = ml_classify_knn_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_classify_knn_cov(a, b) / (sa * sb) }
}

pub fn ml_classify_knn_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_classify_knn_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_classify_knn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_classify_knn_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_classify_knn_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_classify_knn_mse(pred, labels))
}

pub fn ml_classify_knn_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_classify_knn_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_classify_knn_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_classify_knn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_classify_knn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_classify_knn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_classify_knn_precision(pred, labels, pos); let r = ml_classify_knn_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_classify_knn_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_classify_knn_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_classify_knn_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_classify_knn_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_classify_knn_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_classify_knn_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_classify_knn_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_classify_knn_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_classify_knn_fibonacci(n : Int) -> Int {
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

pub fn ml_classify_knn_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_classify_knn_min(data); let mx = ml_classify_knn_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_classify_knn_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_classify_knn_mean(data); let sd = ml_classify_knn_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_classify_knn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_classify_knn_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_classify_knn_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_classify_knn_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_classify_knn_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_classify_knn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlclassifyknnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_frame_make(size : Int) -> MlclassifyknnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_frame_len(s : MlclassifyknnFrame) -> Int { s.size }

pub fn ml_classify_knn_frame_get(s : MlclassifyknnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_frame_set(s : MlclassifyknnFrame, i : Int, v : Double) -> MlclassifyknnFrame {
  let result = ml_classify_knn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_frame_sum(s : MlclassifyknnFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_frame_mean(s : MlclassifyknnFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_frame_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_frame_scale(s : MlclassifyknnFrame, f : Double) -> MlclassifyknnFrame {
  let result = ml_classify_knn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_frame_add(a : MlclassifyknnFrame, b : MlclassifyknnFrame) -> MlclassifyknnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_frame_copy(s : MlclassifyknnFrame) -> MlclassifyknnFrame {
  let result = ml_classify_knn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_frame_fill(s : MlclassifyknnFrame, v : Double) -> MlclassifyknnFrame {
  let result = ml_classify_knn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_frame_min(s : MlclassifyknnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_frame_max(s : MlclassifyknnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_frame_to_string(s : MlclassifyknnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_table_make(size : Int) -> MlclassifyknnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_table_len(s : MlclassifyknnTable) -> Int { s.size }

pub fn ml_classify_knn_table_get(s : MlclassifyknnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_table_set(s : MlclassifyknnTable, i : Int, v : Double) -> MlclassifyknnTable {
  let result = ml_classify_knn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_table_sum(s : MlclassifyknnTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_table_mean(s : MlclassifyknnTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_table_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_table_scale(s : MlclassifyknnTable, f : Double) -> MlclassifyknnTable {
  let result = ml_classify_knn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_table_add(a : MlclassifyknnTable, b : MlclassifyknnTable) -> MlclassifyknnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_table_copy(s : MlclassifyknnTable) -> MlclassifyknnTable {
  let result = ml_classify_knn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_table_fill(s : MlclassifyknnTable, v : Double) -> MlclassifyknnTable {
  let result = ml_classify_knn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_table_min(s : MlclassifyknnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_table_max(s : MlclassifyknnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_table_to_string(s : MlclassifyknnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_graphn_make(size : Int) -> MlclassifyknnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_graphn_len(s : MlclassifyknnGraphN) -> Int { s.size }

pub fn ml_classify_knn_graphn_get(s : MlclassifyknnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_graphn_set(s : MlclassifyknnGraphN, i : Int, v : Double) -> MlclassifyknnGraphN {
  let result = ml_classify_knn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_graphn_sum(s : MlclassifyknnGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_graphn_mean(s : MlclassifyknnGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_graphn_scale(s : MlclassifyknnGraphN, f : Double) -> MlclassifyknnGraphN {
  let result = ml_classify_knn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_graphn_add(a : MlclassifyknnGraphN, b : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_graphn_copy(s : MlclassifyknnGraphN) -> MlclassifyknnGraphN {
  let result = ml_classify_knn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_graphn_fill(s : MlclassifyknnGraphN, v : Double) -> MlclassifyknnGraphN {
  let result = ml_classify_knn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_graphn_min(s : MlclassifyknnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_graphn_max(s : MlclassifyknnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_graphn_to_string(s : MlclassifyknnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_node_make(size : Int) -> MlclassifyknnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_node_len(s : MlclassifyknnNode) -> Int { s.size }

pub fn ml_classify_knn_node_get(s : MlclassifyknnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_node_set(s : MlclassifyknnNode, i : Int, v : Double) -> MlclassifyknnNode {
  let result = ml_classify_knn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_node_sum(s : MlclassifyknnNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_node_mean(s : MlclassifyknnNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_node_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_node_scale(s : MlclassifyknnNode, f : Double) -> MlclassifyknnNode {
  let result = ml_classify_knn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_node_add(a : MlclassifyknnNode, b : MlclassifyknnNode) -> MlclassifyknnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_node_copy(s : MlclassifyknnNode) -> MlclassifyknnNode {
  let result = ml_classify_knn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_node_fill(s : MlclassifyknnNode, v : Double) -> MlclassifyknnNode {
  let result = ml_classify_knn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_node_min(s : MlclassifyknnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_node_max(s : MlclassifyknnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_node_to_string(s : MlclassifyknnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_edge_make(size : Int) -> MlclassifyknnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_edge_len(s : MlclassifyknnEdge) -> Int { s.size }

pub fn ml_classify_knn_edge_get(s : MlclassifyknnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_edge_set(s : MlclassifyknnEdge, i : Int, v : Double) -> MlclassifyknnEdge {
  let result = ml_classify_knn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_edge_sum(s : MlclassifyknnEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_edge_mean(s : MlclassifyknnEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_edge_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_edge_scale(s : MlclassifyknnEdge, f : Double) -> MlclassifyknnEdge {
  let result = ml_classify_knn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_edge_add(a : MlclassifyknnEdge, b : MlclassifyknnEdge) -> MlclassifyknnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_edge_copy(s : MlclassifyknnEdge) -> MlclassifyknnEdge {
  let result = ml_classify_knn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_edge_fill(s : MlclassifyknnEdge, v : Double) -> MlclassifyknnEdge {
  let result = ml_classify_knn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_edge_min(s : MlclassifyknnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_edge_max(s : MlclassifyknnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_edge_to_string(s : MlclassifyknnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_path_make(size : Int) -> MlclassifyknnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_path_len(s : MlclassifyknnPath) -> Int { s.size }

pub fn ml_classify_knn_path_get(s : MlclassifyknnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_path_set(s : MlclassifyknnPath, i : Int, v : Double) -> MlclassifyknnPath {
  let result = ml_classify_knn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_path_sum(s : MlclassifyknnPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_path_mean(s : MlclassifyknnPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_path_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_path_scale(s : MlclassifyknnPath, f : Double) -> MlclassifyknnPath {
  let result = ml_classify_knn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_path_add(a : MlclassifyknnPath, b : MlclassifyknnPath) -> MlclassifyknnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_path_copy(s : MlclassifyknnPath) -> MlclassifyknnPath {
  let result = ml_classify_knn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_path_fill(s : MlclassifyknnPath, v : Double) -> MlclassifyknnPath {
  let result = ml_classify_knn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_path_min(s : MlclassifyknnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_path_max(s : MlclassifyknnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_path_to_string(s : MlclassifyknnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cluster_make(size : Int) -> MlclassifyknnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_cluster_len(s : MlclassifyknnCluster) -> Int { s.size }

pub fn ml_classify_knn_cluster_get(s : MlclassifyknnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_cluster_set(s : MlclassifyknnCluster, i : Int, v : Double) -> MlclassifyknnCluster {
  let result = ml_classify_knn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_cluster_sum(s : MlclassifyknnCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_cluster_mean(s : MlclassifyknnCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_cluster_scale(s : MlclassifyknnCluster, f : Double) -> MlclassifyknnCluster {
  let result = ml_classify_knn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_cluster_add(a : MlclassifyknnCluster, b : MlclassifyknnCluster) -> MlclassifyknnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_cluster_copy(s : MlclassifyknnCluster) -> MlclassifyknnCluster {
  let result = ml_classify_knn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_cluster_fill(s : MlclassifyknnCluster, v : Double) -> MlclassifyknnCluster {
  let result = ml_classify_knn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_cluster_min(s : MlclassifyknnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_cluster_max(s : MlclassifyknnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_cluster_to_string(s : MlclassifyknnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_model_make(size : Int) -> MlclassifyknnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_model_len(s : MlclassifyknnModel) -> Int { s.size }

pub fn ml_classify_knn_model_get(s : MlclassifyknnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_model_set(s : MlclassifyknnModel, i : Int, v : Double) -> MlclassifyknnModel {
  let result = ml_classify_knn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_model_sum(s : MlclassifyknnModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_model_mean(s : MlclassifyknnModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_model_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_model_scale(s : MlclassifyknnModel, f : Double) -> MlclassifyknnModel {
  let result = ml_classify_knn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_model_add(a : MlclassifyknnModel, b : MlclassifyknnModel) -> MlclassifyknnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_model_copy(s : MlclassifyknnModel) -> MlclassifyknnModel {
  let result = ml_classify_knn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_model_fill(s : MlclassifyknnModel, v : Double) -> MlclassifyknnModel {
  let result = ml_classify_knn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_model_min(s : MlclassifyknnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_model_max(s : MlclassifyknnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_model_to_string(s : MlclassifyknnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_layer_make(size : Int) -> MlclassifyknnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_layer_len(s : MlclassifyknnLayer) -> Int { s.size }

pub fn ml_classify_knn_layer_get(s : MlclassifyknnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_layer_set(s : MlclassifyknnLayer, i : Int, v : Double) -> MlclassifyknnLayer {
  let result = ml_classify_knn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_layer_sum(s : MlclassifyknnLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_layer_mean(s : MlclassifyknnLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_layer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_layer_scale(s : MlclassifyknnLayer, f : Double) -> MlclassifyknnLayer {
  let result = ml_classify_knn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_layer_add(a : MlclassifyknnLayer, b : MlclassifyknnLayer) -> MlclassifyknnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_layer_copy(s : MlclassifyknnLayer) -> MlclassifyknnLayer {
  let result = ml_classify_knn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_layer_fill(s : MlclassifyknnLayer, v : Double) -> MlclassifyknnLayer {
  let result = ml_classify_knn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_layer_min(s : MlclassifyknnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_layer_max(s : MlclassifyknnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_layer_to_string(s : MlclassifyknnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_buffer_make(size : Int) -> MlclassifyknnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_buffer_len(s : MlclassifyknnBuffer) -> Int { s.size }

pub fn ml_classify_knn_buffer_get(s : MlclassifyknnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_buffer_set(s : MlclassifyknnBuffer, i : Int, v : Double) -> MlclassifyknnBuffer {
  let result = ml_classify_knn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_buffer_sum(s : MlclassifyknnBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_buffer_mean(s : MlclassifyknnBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_buffer_scale(s : MlclassifyknnBuffer, f : Double) -> MlclassifyknnBuffer {
  let result = ml_classify_knn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_buffer_add(a : MlclassifyknnBuffer, b : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_buffer_copy(s : MlclassifyknnBuffer) -> MlclassifyknnBuffer {
  let result = ml_classify_knn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_buffer_fill(s : MlclassifyknnBuffer, v : Double) -> MlclassifyknnBuffer {
  let result = ml_classify_knn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_buffer_min(s : MlclassifyknnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_buffer_max(s : MlclassifyknnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_buffer_to_string(s : MlclassifyknnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_cursor_make(size : Int) -> MlclassifyknnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_cursor_len(s : MlclassifyknnCursor) -> Int { s.size }

pub fn ml_classify_knn_cursor_get(s : MlclassifyknnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_cursor_set(s : MlclassifyknnCursor, i : Int, v : Double) -> MlclassifyknnCursor {
  let result = ml_classify_knn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_cursor_sum(s : MlclassifyknnCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_cursor_mean(s : MlclassifyknnCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_cursor_scale(s : MlclassifyknnCursor, f : Double) -> MlclassifyknnCursor {
  let result = ml_classify_knn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_cursor_add(a : MlclassifyknnCursor, b : MlclassifyknnCursor) -> MlclassifyknnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_cursor_copy(s : MlclassifyknnCursor) -> MlclassifyknnCursor {
  let result = ml_classify_knn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_cursor_fill(s : MlclassifyknnCursor, v : Double) -> MlclassifyknnCursor {
  let result = ml_classify_knn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_cursor_min(s : MlclassifyknnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_cursor_max(s : MlclassifyknnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_cursor_to_string(s : MlclassifyknnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_view_make(size : Int) -> MlclassifyknnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_view_len(s : MlclassifyknnView) -> Int { s.size }

pub fn ml_classify_knn_view_get(s : MlclassifyknnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_view_set(s : MlclassifyknnView, i : Int, v : Double) -> MlclassifyknnView {
  let result = ml_classify_knn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_view_sum(s : MlclassifyknnView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_view_mean(s : MlclassifyknnView) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_view_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_view_scale(s : MlclassifyknnView, f : Double) -> MlclassifyknnView {
  let result = ml_classify_knn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_view_add(a : MlclassifyknnView, b : MlclassifyknnView) -> MlclassifyknnView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_view_copy(s : MlclassifyknnView) -> MlclassifyknnView {
  let result = ml_classify_knn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_view_fill(s : MlclassifyknnView, v : Double) -> MlclassifyknnView {
  let result = ml_classify_knn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_view_min(s : MlclassifyknnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_view_max(s : MlclassifyknnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_view_to_string(s : MlclassifyknnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_range_make(size : Int) -> MlclassifyknnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_range_len(s : MlclassifyknnRange) -> Int { s.size }

pub fn ml_classify_knn_range_get(s : MlclassifyknnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_range_set(s : MlclassifyknnRange, i : Int, v : Double) -> MlclassifyknnRange {
  let result = ml_classify_knn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_range_sum(s : MlclassifyknnRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_range_mean(s : MlclassifyknnRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_range_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_range_scale(s : MlclassifyknnRange, f : Double) -> MlclassifyknnRange {
  let result = ml_classify_knn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_range_add(a : MlclassifyknnRange, b : MlclassifyknnRange) -> MlclassifyknnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_range_copy(s : MlclassifyknnRange) -> MlclassifyknnRange {
  let result = ml_classify_knn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_range_fill(s : MlclassifyknnRange, v : Double) -> MlclassifyknnRange {
  let result = ml_classify_knn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_range_min(s : MlclassifyknnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_range_max(s : MlclassifyknnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_range_to_string(s : MlclassifyknnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyknnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_knn_slice_make(size : Int) -> MlclassifyknnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_knn_slice_len(s : MlclassifyknnSlice) -> Int { s.size }

pub fn ml_classify_knn_slice_get(s : MlclassifyknnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_knn_slice_set(s : MlclassifyknnSlice, i : Int, v : Double) -> MlclassifyknnSlice {
  let result = ml_classify_knn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_slice_sum(s : MlclassifyknnSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_classify_knn_slice_mean(s : MlclassifyknnSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_classify_knn_slice_sum(s) / s.size.to_double() }
}

pub fn ml_classify_knn_slice_scale(s : MlclassifyknnSlice, f : Double) -> MlclassifyknnSlice {
  let result = ml_classify_knn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_classify_knn_slice_add(a : MlclassifyknnSlice, b : MlclassifyknnSlice) -> MlclassifyknnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_classify_knn_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_classify_knn_slice_copy(s : MlclassifyknnSlice) -> MlclassifyknnSlice {
  let result = ml_classify_knn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_classify_knn_slice_fill(s : MlclassifyknnSlice, v : Double) -> MlclassifyknnSlice {
  let result = ml_classify_knn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_classify_knn_slice_min(s : MlclassifyknnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_slice_max(s : MlclassifyknnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_classify_knn_slice_to_string(s : MlclassifyknnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


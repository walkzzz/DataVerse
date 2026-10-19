///===
/// extcore/ml_feature_pca

pub(all) struct MlfeaturepcaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_pca_make_point(x : Double, y : Double) -> MlfeaturepcaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_pca_make_point3(x : Double, y : Double, z : Double) -> MlfeaturepcaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_feature_pca_point_x(pt : MlfeaturepcaPoint) -> Double { pt.x }

pub fn ml_feature_pca_point_y(pt : MlfeaturepcaPoint) -> Double { pt.y }

pub fn ml_feature_pca_point_z(pt : MlfeaturepcaPoint) -> Double { pt.z }

pub fn ml_feature_pca_point_label(pt : MlfeaturepcaPoint) -> Int { pt.label }

pub fn ml_feature_pca_point_dist(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_feature_pca_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_feature_pca_point_add(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_feature_pca_point_sub(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_feature_pca_point_scale(pt : MlfeaturepcaPoint, s : Double) -> MlfeaturepcaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_feature_pca_point_dot(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_feature_pca_point_cross(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_feature_pca_point_norm(pt : MlfeaturepcaPoint) -> Double {
  ml_feature_pca_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_feature_pca_point_normalize(pt : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  let n = ml_feature_pca_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_feature_pca_point_scale(pt, 1.0 / n) }
}

pub fn ml_feature_pca_point_negate(pt : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_feature_pca_point_mid(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint) -> MlfeaturepcaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_feature_pca_point_lerp(a : MlfeaturepcaPoint, b : MlfeaturepcaPoint, t : Double) -> MlfeaturepcaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_feature_pca_point_to_string(pt : MlfeaturepcaPoint) -> String {
  "(" + ml_feature_pca_dbl(pt.x) + ", " + ml_feature_pca_dbl(pt.y) + ", " + ml_feature_pca_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlfeaturepcaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_pca_make_series(vals : Array[Double], name : String) -> MlfeaturepcaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_feature_pca_series_len(s : MlfeaturepcaSeries) -> Int { s.vals.length() }

pub fn ml_feature_pca_series_sum(s : MlfeaturepcaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_feature_pca_series_mean(s : MlfeaturepcaSeries) -> Double {
  let n = ml_feature_pca_series_len(s)
  if n == 0 { 0.0 } else { ml_feature_pca_series_sum(s) / n.to_double() }
}

pub fn ml_feature_pca_series_min(s : MlfeaturepcaSeries) -> Double {
  let n = ml_feature_pca_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_pca_series_max(s : MlfeaturepcaSeries) -> Double {
  let n = ml_feature_pca_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_feature_pca_series_range(s : MlfeaturepcaSeries) -> Double {
  ml_feature_pca_series_max(s) - ml_feature_pca_series_min(s)
}

pub fn ml_feature_pca_series_var(s : MlfeaturepcaSeries) -> Double {
  let n = ml_feature_pca_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_feature_pca_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_feature_pca_series_std(s : MlfeaturepcaSeries) -> Double { ml_feature_pca_sqrt(ml_feature_pca_series_var(s)) }

pub fn ml_feature_pca_series_median(s : MlfeaturepcaSeries) -> Double {
  let n = ml_feature_pca_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_pca_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_pca_series_scale(s : MlfeaturepcaSeries, f : Double) -> MlfeaturepcaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_feature_pca_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_feature_pca_series_add(a : MlfeaturepcaSeries, b : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_feature_pca_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_feature_pca_series_sub(a : MlfeaturepcaSeries, b : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_feature_pca_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_feature_pca_series_normalize(s : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let mn = ml_feature_pca_series_min(s)
  let mx = ml_feature_pca_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_feature_pca_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_feature_pca_series_cumsum(s : MlfeaturepcaSeries) -> MlfeaturepcaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_feature_pca_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_feature_pca_series_to_string(s : MlfeaturepcaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_feature_pca_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturepcaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_pca_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturepcaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_pca_matrix_identity(n : Int) -> MlfeaturepcaMatrix {
  let m = ml_feature_pca_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_feature_pca_matrix_get(m : MlfeaturepcaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_feature_pca_matrix_transpose(m : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_feature_pca_matrix_add(a : MlfeaturepcaMatrix, b : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_feature_pca_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_feature_pca_matrix_scale(m : MlfeaturepcaMatrix, s : Double) -> MlfeaturepcaMatrix {
  let result = ml_feature_pca_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_feature_pca_matrix_multiply(a : MlfeaturepcaMatrix, b : MlfeaturepcaMatrix) -> MlfeaturepcaMatrix {
  if a.cols != b.rows { return ml_feature_pca_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_feature_pca_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_feature_pca_matrix_trace(m : MlfeaturepcaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_feature_pca_matrix_det(m : MlfeaturepcaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_feature_pca_matrix_norm(m : MlfeaturepcaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_feature_pca_sqrt(sum)
}

pub fn ml_feature_pca_matrix_to_string(m : MlfeaturepcaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_feature_pca_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlfeaturepcaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_pca_make_vector(comps : Array[Double]) -> MlfeaturepcaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_pca_vector_zero(dim : Int) -> MlfeaturepcaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_feature_pca_vector_add(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_feature_pca_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_pca_vector_sub(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_feature_pca_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_feature_pca_vector_scale(v : MlfeaturepcaVector, s : Double) -> MlfeaturepcaVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_feature_pca_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_feature_pca_vector_dot(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_feature_pca_vector_norm(v : MlfeaturepcaVector) -> Double { ml_feature_pca_sqrt(ml_feature_pca_vector_dot(v, v)) }

pub fn ml_feature_pca_vector_normalize(v : MlfeaturepcaVector) -> MlfeaturepcaVector {
  let n = ml_feature_pca_vector_norm(v)
  if n < 0.0000001 { v } else { ml_feature_pca_vector_scale(v, 1.0 / n) }
}

pub fn ml_feature_pca_vector_dist(a : MlfeaturepcaVector, b : MlfeaturepcaVector) -> Double {
  ml_feature_pca_vector_norm(ml_feature_pca_vector_sub(a, b))
}

pub fn ml_feature_pca_vector_to_string(v : MlfeaturepcaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_feature_pca_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_pca_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_feature_pca_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_feature_pca_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_feature_pca_std(data : Array[Double]) -> Double { ml_feature_pca_sqrt(ml_feature_pca_var(data)) }

pub fn ml_feature_pca_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_feature_pca_mean(a); let mb = ml_feature_pca_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_feature_pca_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_feature_pca_std(a); let sb = ml_feature_pca_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_feature_pca_cov(a, b) / (sa * sb) }
}

pub fn ml_feature_pca_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_feature_pca_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_feature_pca_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_feature_pca_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_feature_pca_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_feature_pca_sqrt(ml_feature_pca_mse(pred, labels))
}

pub fn ml_feature_pca_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_feature_pca_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_feature_pca_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_feature_pca_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_feature_pca_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_feature_pca_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_feature_pca_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_feature_pca_precision(pred, labels, pos); let r = ml_feature_pca_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_feature_pca_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_feature_pca_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_feature_pca_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_feature_pca_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_feature_pca_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_feature_pca_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_feature_pca_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_feature_pca_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_feature_pca_fibonacci(n : Int) -> Int {
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

pub fn ml_feature_pca_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_feature_pca_min(data); let mx = ml_feature_pca_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_feature_pca_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_feature_pca_mean(data); let sd = ml_feature_pca_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_feature_pca_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_feature_pca_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_feature_pca_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_feature_pca_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_feature_pca_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_feature_pca_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_feature_pca_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_feature_pca_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_feature_pca_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_feature_pca_int(x) } else { -ml_feature_pca_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_feature_pca_int(f * 1000000.0) } else { ml_feature_pca_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_feature_pca_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_feature_pca_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlfeaturepcaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_frame_make(size : Int) -> MlfeaturepcaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_frame_len(s : MlfeaturepcaFrame) -> Int { s.size }

pub fn ml_feature_pca_frame_get(s : MlfeaturepcaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_frame_set(s : MlfeaturepcaFrame, i : Int, v : Double) -> MlfeaturepcaFrame {
  let result = ml_feature_pca_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_frame_sum(s : MlfeaturepcaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_frame_mean(s : MlfeaturepcaFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_frame_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_frame_scale(s : MlfeaturepcaFrame, f : Double) -> MlfeaturepcaFrame {
  let result = ml_feature_pca_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_frame_add(a : MlfeaturepcaFrame, b : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_frame_copy(s : MlfeaturepcaFrame) -> MlfeaturepcaFrame {
  let result = ml_feature_pca_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_frame_fill(s : MlfeaturepcaFrame, v : Double) -> MlfeaturepcaFrame {
  let result = ml_feature_pca_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_frame_min(s : MlfeaturepcaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_frame_max(s : MlfeaturepcaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_frame_to_string(s : MlfeaturepcaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_table_make(size : Int) -> MlfeaturepcaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_table_len(s : MlfeaturepcaTable) -> Int { s.size }

pub fn ml_feature_pca_table_get(s : MlfeaturepcaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_table_set(s : MlfeaturepcaTable, i : Int, v : Double) -> MlfeaturepcaTable {
  let result = ml_feature_pca_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_table_sum(s : MlfeaturepcaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_table_mean(s : MlfeaturepcaTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_table_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_table_scale(s : MlfeaturepcaTable, f : Double) -> MlfeaturepcaTable {
  let result = ml_feature_pca_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_table_add(a : MlfeaturepcaTable, b : MlfeaturepcaTable) -> MlfeaturepcaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_table_copy(s : MlfeaturepcaTable) -> MlfeaturepcaTable {
  let result = ml_feature_pca_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_table_fill(s : MlfeaturepcaTable, v : Double) -> MlfeaturepcaTable {
  let result = ml_feature_pca_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_table_min(s : MlfeaturepcaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_table_max(s : MlfeaturepcaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_table_to_string(s : MlfeaturepcaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_graphn_make(size : Int) -> MlfeaturepcaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_graphn_len(s : MlfeaturepcaGraphN) -> Int { s.size }

pub fn ml_feature_pca_graphn_get(s : MlfeaturepcaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_graphn_set(s : MlfeaturepcaGraphN, i : Int, v : Double) -> MlfeaturepcaGraphN {
  let result = ml_feature_pca_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_graphn_sum(s : MlfeaturepcaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_graphn_mean(s : MlfeaturepcaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_graphn_scale(s : MlfeaturepcaGraphN, f : Double) -> MlfeaturepcaGraphN {
  let result = ml_feature_pca_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_graphn_add(a : MlfeaturepcaGraphN, b : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_graphn_copy(s : MlfeaturepcaGraphN) -> MlfeaturepcaGraphN {
  let result = ml_feature_pca_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_graphn_fill(s : MlfeaturepcaGraphN, v : Double) -> MlfeaturepcaGraphN {
  let result = ml_feature_pca_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_graphn_min(s : MlfeaturepcaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_graphn_max(s : MlfeaturepcaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_graphn_to_string(s : MlfeaturepcaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_node_make(size : Int) -> MlfeaturepcaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_node_len(s : MlfeaturepcaNode) -> Int { s.size }

pub fn ml_feature_pca_node_get(s : MlfeaturepcaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_node_set(s : MlfeaturepcaNode, i : Int, v : Double) -> MlfeaturepcaNode {
  let result = ml_feature_pca_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_node_sum(s : MlfeaturepcaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_node_mean(s : MlfeaturepcaNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_node_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_node_scale(s : MlfeaturepcaNode, f : Double) -> MlfeaturepcaNode {
  let result = ml_feature_pca_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_node_add(a : MlfeaturepcaNode, b : MlfeaturepcaNode) -> MlfeaturepcaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_node_copy(s : MlfeaturepcaNode) -> MlfeaturepcaNode {
  let result = ml_feature_pca_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_node_fill(s : MlfeaturepcaNode, v : Double) -> MlfeaturepcaNode {
  let result = ml_feature_pca_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_node_min(s : MlfeaturepcaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_node_max(s : MlfeaturepcaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_node_to_string(s : MlfeaturepcaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_edge_make(size : Int) -> MlfeaturepcaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_edge_len(s : MlfeaturepcaEdge) -> Int { s.size }

pub fn ml_feature_pca_edge_get(s : MlfeaturepcaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_edge_set(s : MlfeaturepcaEdge, i : Int, v : Double) -> MlfeaturepcaEdge {
  let result = ml_feature_pca_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_edge_sum(s : MlfeaturepcaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_edge_mean(s : MlfeaturepcaEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_edge_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_edge_scale(s : MlfeaturepcaEdge, f : Double) -> MlfeaturepcaEdge {
  let result = ml_feature_pca_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_edge_add(a : MlfeaturepcaEdge, b : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_edge_copy(s : MlfeaturepcaEdge) -> MlfeaturepcaEdge {
  let result = ml_feature_pca_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_edge_fill(s : MlfeaturepcaEdge, v : Double) -> MlfeaturepcaEdge {
  let result = ml_feature_pca_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_edge_min(s : MlfeaturepcaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_edge_max(s : MlfeaturepcaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_edge_to_string(s : MlfeaturepcaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_path_make(size : Int) -> MlfeaturepcaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_path_len(s : MlfeaturepcaPath) -> Int { s.size }

pub fn ml_feature_pca_path_get(s : MlfeaturepcaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_path_set(s : MlfeaturepcaPath, i : Int, v : Double) -> MlfeaturepcaPath {
  let result = ml_feature_pca_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_path_sum(s : MlfeaturepcaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_path_mean(s : MlfeaturepcaPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_path_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_path_scale(s : MlfeaturepcaPath, f : Double) -> MlfeaturepcaPath {
  let result = ml_feature_pca_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_path_add(a : MlfeaturepcaPath, b : MlfeaturepcaPath) -> MlfeaturepcaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_path_copy(s : MlfeaturepcaPath) -> MlfeaturepcaPath {
  let result = ml_feature_pca_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_path_fill(s : MlfeaturepcaPath, v : Double) -> MlfeaturepcaPath {
  let result = ml_feature_pca_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_path_min(s : MlfeaturepcaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_path_max(s : MlfeaturepcaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_path_to_string(s : MlfeaturepcaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cluster_make(size : Int) -> MlfeaturepcaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cluster_len(s : MlfeaturepcaCluster) -> Int { s.size }

pub fn ml_feature_pca_cluster_get(s : MlfeaturepcaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cluster_set(s : MlfeaturepcaCluster, i : Int, v : Double) -> MlfeaturepcaCluster {
  let result = ml_feature_pca_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_cluster_sum(s : MlfeaturepcaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_cluster_mean(s : MlfeaturepcaCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_cluster_scale(s : MlfeaturepcaCluster, f : Double) -> MlfeaturepcaCluster {
  let result = ml_feature_pca_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_cluster_add(a : MlfeaturepcaCluster, b : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_cluster_copy(s : MlfeaturepcaCluster) -> MlfeaturepcaCluster {
  let result = ml_feature_pca_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_cluster_fill(s : MlfeaturepcaCluster, v : Double) -> MlfeaturepcaCluster {
  let result = ml_feature_pca_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_cluster_min(s : MlfeaturepcaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_cluster_max(s : MlfeaturepcaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_cluster_to_string(s : MlfeaturepcaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_model_make(size : Int) -> MlfeaturepcaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_model_len(s : MlfeaturepcaModel) -> Int { s.size }

pub fn ml_feature_pca_model_get(s : MlfeaturepcaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_model_set(s : MlfeaturepcaModel, i : Int, v : Double) -> MlfeaturepcaModel {
  let result = ml_feature_pca_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_model_sum(s : MlfeaturepcaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_model_mean(s : MlfeaturepcaModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_model_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_model_scale(s : MlfeaturepcaModel, f : Double) -> MlfeaturepcaModel {
  let result = ml_feature_pca_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_model_add(a : MlfeaturepcaModel, b : MlfeaturepcaModel) -> MlfeaturepcaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_model_copy(s : MlfeaturepcaModel) -> MlfeaturepcaModel {
  let result = ml_feature_pca_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_model_fill(s : MlfeaturepcaModel, v : Double) -> MlfeaturepcaModel {
  let result = ml_feature_pca_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_model_min(s : MlfeaturepcaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_model_max(s : MlfeaturepcaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_model_to_string(s : MlfeaturepcaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_layer_make(size : Int) -> MlfeaturepcaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_layer_len(s : MlfeaturepcaLayer) -> Int { s.size }

pub fn ml_feature_pca_layer_get(s : MlfeaturepcaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_layer_set(s : MlfeaturepcaLayer, i : Int, v : Double) -> MlfeaturepcaLayer {
  let result = ml_feature_pca_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_layer_sum(s : MlfeaturepcaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_layer_mean(s : MlfeaturepcaLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_layer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_layer_scale(s : MlfeaturepcaLayer, f : Double) -> MlfeaturepcaLayer {
  let result = ml_feature_pca_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_layer_add(a : MlfeaturepcaLayer, b : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_layer_copy(s : MlfeaturepcaLayer) -> MlfeaturepcaLayer {
  let result = ml_feature_pca_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_layer_fill(s : MlfeaturepcaLayer, v : Double) -> MlfeaturepcaLayer {
  let result = ml_feature_pca_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_layer_min(s : MlfeaturepcaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_layer_max(s : MlfeaturepcaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_layer_to_string(s : MlfeaturepcaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_buffer_make(size : Int) -> MlfeaturepcaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_buffer_len(s : MlfeaturepcaBuffer) -> Int { s.size }

pub fn ml_feature_pca_buffer_get(s : MlfeaturepcaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_buffer_set(s : MlfeaturepcaBuffer, i : Int, v : Double) -> MlfeaturepcaBuffer {
  let result = ml_feature_pca_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_buffer_sum(s : MlfeaturepcaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_buffer_mean(s : MlfeaturepcaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_buffer_scale(s : MlfeaturepcaBuffer, f : Double) -> MlfeaturepcaBuffer {
  let result = ml_feature_pca_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_buffer_add(a : MlfeaturepcaBuffer, b : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_buffer_copy(s : MlfeaturepcaBuffer) -> MlfeaturepcaBuffer {
  let result = ml_feature_pca_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_buffer_fill(s : MlfeaturepcaBuffer, v : Double) -> MlfeaturepcaBuffer {
  let result = ml_feature_pca_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_buffer_min(s : MlfeaturepcaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_buffer_max(s : MlfeaturepcaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_buffer_to_string(s : MlfeaturepcaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_cursor_make(size : Int) -> MlfeaturepcaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_cursor_len(s : MlfeaturepcaCursor) -> Int { s.size }

pub fn ml_feature_pca_cursor_get(s : MlfeaturepcaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_cursor_set(s : MlfeaturepcaCursor, i : Int, v : Double) -> MlfeaturepcaCursor {
  let result = ml_feature_pca_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_cursor_sum(s : MlfeaturepcaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_cursor_mean(s : MlfeaturepcaCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_cursor_scale(s : MlfeaturepcaCursor, f : Double) -> MlfeaturepcaCursor {
  let result = ml_feature_pca_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_cursor_add(a : MlfeaturepcaCursor, b : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_cursor_copy(s : MlfeaturepcaCursor) -> MlfeaturepcaCursor {
  let result = ml_feature_pca_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_cursor_fill(s : MlfeaturepcaCursor, v : Double) -> MlfeaturepcaCursor {
  let result = ml_feature_pca_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_cursor_min(s : MlfeaturepcaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_cursor_max(s : MlfeaturepcaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_cursor_to_string(s : MlfeaturepcaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_view_make(size : Int) -> MlfeaturepcaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_view_len(s : MlfeaturepcaView) -> Int { s.size }

pub fn ml_feature_pca_view_get(s : MlfeaturepcaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_view_set(s : MlfeaturepcaView, i : Int, v : Double) -> MlfeaturepcaView {
  let result = ml_feature_pca_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_view_sum(s : MlfeaturepcaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_view_mean(s : MlfeaturepcaView) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_view_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_view_scale(s : MlfeaturepcaView, f : Double) -> MlfeaturepcaView {
  let result = ml_feature_pca_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_view_add(a : MlfeaturepcaView, b : MlfeaturepcaView) -> MlfeaturepcaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_view_copy(s : MlfeaturepcaView) -> MlfeaturepcaView {
  let result = ml_feature_pca_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_view_fill(s : MlfeaturepcaView, v : Double) -> MlfeaturepcaView {
  let result = ml_feature_pca_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_view_min(s : MlfeaturepcaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_view_max(s : MlfeaturepcaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_view_to_string(s : MlfeaturepcaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_range_make(size : Int) -> MlfeaturepcaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_range_len(s : MlfeaturepcaRange) -> Int { s.size }

pub fn ml_feature_pca_range_get(s : MlfeaturepcaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_range_set(s : MlfeaturepcaRange, i : Int, v : Double) -> MlfeaturepcaRange {
  let result = ml_feature_pca_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_range_sum(s : MlfeaturepcaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_range_mean(s : MlfeaturepcaRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_range_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_range_scale(s : MlfeaturepcaRange, f : Double) -> MlfeaturepcaRange {
  let result = ml_feature_pca_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_range_add(a : MlfeaturepcaRange, b : MlfeaturepcaRange) -> MlfeaturepcaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_range_copy(s : MlfeaturepcaRange) -> MlfeaturepcaRange {
  let result = ml_feature_pca_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_range_fill(s : MlfeaturepcaRange, v : Double) -> MlfeaturepcaRange {
  let result = ml_feature_pca_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_range_min(s : MlfeaturepcaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_range_max(s : MlfeaturepcaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_range_to_string(s : MlfeaturepcaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturepcaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_pca_slice_make(size : Int) -> MlfeaturepcaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_pca_slice_len(s : MlfeaturepcaSlice) -> Int { s.size }

pub fn ml_feature_pca_slice_get(s : MlfeaturepcaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_pca_slice_set(s : MlfeaturepcaSlice, i : Int, v : Double) -> MlfeaturepcaSlice {
  let result = ml_feature_pca_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_slice_sum(s : MlfeaturepcaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_feature_pca_slice_mean(s : MlfeaturepcaSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_feature_pca_slice_sum(s) / s.size.to_double() }
}

pub fn ml_feature_pca_slice_scale(s : MlfeaturepcaSlice, f : Double) -> MlfeaturepcaSlice {
  let result = ml_feature_pca_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_feature_pca_slice_add(a : MlfeaturepcaSlice, b : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_feature_pca_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_feature_pca_slice_copy(s : MlfeaturepcaSlice) -> MlfeaturepcaSlice {
  let result = ml_feature_pca_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_feature_pca_slice_fill(s : MlfeaturepcaSlice, v : Double) -> MlfeaturepcaSlice {
  let result = ml_feature_pca_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_feature_pca_slice_min(s : MlfeaturepcaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_slice_max(s : MlfeaturepcaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_feature_pca_slice_to_string(s : MlfeaturepcaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_feature_pca_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_feature_pca_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


///===
/// extcore/sort_exchange_cocktail

pub(all) struct SortexchangecocktailPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_cocktail_make_point(x : Double, y : Double) -> SortexchangecocktailPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_cocktail_make_point3(x : Double, y : Double, z : Double) -> SortexchangecocktailPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_cocktail_point_x(pt : SortexchangecocktailPoint) -> Double { pt.x }

pub fn sort_exchange_cocktail_point_y(pt : SortexchangecocktailPoint) -> Double { pt.y }

pub fn sort_exchange_cocktail_point_z(pt : SortexchangecocktailPoint) -> Double { pt.z }

pub fn sort_exchange_cocktail_point_label(pt : SortexchangecocktailPoint) -> Int { pt.label }

pub fn sort_exchange_cocktail_point_dist(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_cocktail_point_add(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_cocktail_point_sub(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_cocktail_point_scale(pt : SortexchangecocktailPoint, s : Double) -> SortexchangecocktailPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_cocktail_point_dot(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_cocktail_point_cross(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_cocktail_point_norm(pt : SortexchangecocktailPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_cocktail_point_normalize(pt : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  let n = sort_exchange_cocktail_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_cocktail_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_cocktail_point_negate(pt : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_cocktail_point_mid(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_cocktail_point_lerp(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint, t : Double) -> SortexchangecocktailPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_cocktail_point_to_string(pt : SortexchangecocktailPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangecocktailSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_cocktail_make_series(vals : Array[Double], name : String) -> SortexchangecocktailSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_cocktail_series_len(s : SortexchangecocktailSeries) -> Int { s.vals.length() }

pub fn sort_exchange_cocktail_series_sum(s : SortexchangecocktailSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_exchange_cocktail_series_mean(s : SortexchangecocktailSeries) -> Double {
  let n = sort_exchange_cocktail_series_len(s)
  if n == 0 { 0.0 } else { sort_exchange_cocktail_series_sum(s) / n.to_double() }
}

pub fn sort_exchange_cocktail_series_min(s : SortexchangecocktailSeries) -> Double {
  let n = sort_exchange_cocktail_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_series_max(s : SortexchangecocktailSeries) -> Double {
  let n = sort_exchange_cocktail_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_series_range(s : SortexchangecocktailSeries) -> Double {
  sort_exchange_cocktail_series_max(s) - sort_exchange_cocktail_series_min(s)
}

pub fn sort_exchange_cocktail_series_var(s : SortexchangecocktailSeries) -> Double {
  let n = sort_exchange_cocktail_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_exchange_cocktail_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_exchange_cocktail_series_std(s : SortexchangecocktailSeries) -> Double { @_common.sqrt(sort_exchange_cocktail_series_var(s)) }

pub fn sort_exchange_cocktail_series_median(s : SortexchangecocktailSeries) -> Double {
  let n = sort_exchange_cocktail_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_cocktail_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_cocktail_series_scale(s : SortexchangecocktailSeries, f : Double) -> SortexchangecocktailSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_exchange_cocktail_series_add(a : SortexchangecocktailSeries, b : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_cocktail_series_sub(a : SortexchangecocktailSeries, b : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_cocktail_series_normalize(s : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let mn = sort_exchange_cocktail_series_min(s)
  let mx = sort_exchange_cocktail_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_cocktail_series_cumsum(s : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_cocktail_series_to_string(s : SortexchangecocktailSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangecocktailMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_cocktail_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangecocktailMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_cocktail_matrix_identity(n : Int) -> SortexchangecocktailMatrix {
  let m = sort_exchange_cocktail_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_cocktail_matrix_get(m : SortexchangecocktailMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_cocktail_matrix_transpose(m : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_cocktail_matrix_add(a : SortexchangecocktailMatrix, b : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_cocktail_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_cocktail_matrix_scale(m : SortexchangecocktailMatrix, s : Double) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_cocktail_matrix_multiply(a : SortexchangecocktailMatrix, b : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if a.cols != b.rows { return sort_exchange_cocktail_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_cocktail_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_cocktail_matrix_trace(m : SortexchangecocktailMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_cocktail_matrix_det(m : SortexchangecocktailMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_cocktail_matrix_norm(m : SortexchangecocktailMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_cocktail_matrix_to_string(m : SortexchangecocktailMatrix) -> String {
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

pub(all) struct SortexchangecocktailVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_cocktail_make_vector(comps : Array[Double]) -> SortexchangecocktailVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_cocktail_vector_zero(dim : Int) -> SortexchangecocktailVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_cocktail_vector_add(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_cocktail_vector_sub(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_exchange_cocktail_vector_scale(v : SortexchangecocktailVector, s : Double) -> SortexchangecocktailVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_exchange_cocktail_vector_dot(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_cocktail_vector_norm(v : SortexchangecocktailVector) -> Double { @_common.sqrt(sort_exchange_cocktail_vector_dot(v, v)) }

pub fn sort_exchange_cocktail_vector_normalize(v : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = sort_exchange_cocktail_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_cocktail_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_cocktail_vector_dist(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> Double {
  sort_exchange_cocktail_vector_norm(sort_exchange_cocktail_vector_sub(a, b))
}

pub fn sort_exchange_cocktail_vector_to_string(v : SortexchangecocktailVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_cocktail_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_exchange_cocktail_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_exchange_cocktail_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_cocktail_std(data : Array[Double]) -> Double { @_common.sqrt(sort_exchange_cocktail_var(data)) }

pub fn sort_exchange_cocktail_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_exchange_cocktail_mean(a); let mb = sort_exchange_cocktail_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_cocktail_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_exchange_cocktail_std(a); let sb = sort_exchange_cocktail_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_exchange_cocktail_cov(a, b) / (sa * sb) }
}

pub fn sort_exchange_cocktail_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_exchange_cocktail_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_exchange_cocktail_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_exchange_cocktail_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_exchange_cocktail_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(sort_exchange_cocktail_mse(pred, labels))
}

pub fn sort_exchange_cocktail_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_exchange_cocktail_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_exchange_cocktail_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_exchange_cocktail_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_exchange_cocktail_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_exchange_cocktail_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_exchange_cocktail_precision(pred, labels, pos); let r = sort_exchange_cocktail_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_exchange_cocktail_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_exchange_cocktail_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_exchange_cocktail_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_exchange_cocktail_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_exchange_cocktail_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_exchange_cocktail_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_exchange_cocktail_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_exchange_cocktail_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_exchange_cocktail_fibonacci(n : Int) -> Int {
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

pub fn sort_exchange_cocktail_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_exchange_cocktail_min(data); let mx = sort_exchange_cocktail_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_exchange_cocktail_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_exchange_cocktail_mean(data); let sd = sort_exchange_cocktail_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_exchange_cocktail_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_exchange_cocktail_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_exchange_cocktail_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_exchange_cocktail_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct SortexchangecocktailFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_frame_make(size : Int) -> SortexchangecocktailFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_frame_len(s : SortexchangecocktailFrame) -> Int { s.size }

pub fn sort_exchange_cocktail_frame_get(s : SortexchangecocktailFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_frame_set(s : SortexchangecocktailFrame, i : Int, v : Double) -> SortexchangecocktailFrame {
  let result = sort_exchange_cocktail_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_frame_sum(s : SortexchangecocktailFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_frame_mean(s : SortexchangecocktailFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_frame_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_frame_scale(s : SortexchangecocktailFrame, f : Double) -> SortexchangecocktailFrame {
  let result = sort_exchange_cocktail_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_frame_add(a : SortexchangecocktailFrame, b : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_frame_copy(s : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  let result = sort_exchange_cocktail_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_frame_fill(s : SortexchangecocktailFrame, v : Double) -> SortexchangecocktailFrame {
  let result = sort_exchange_cocktail_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_frame_min(s : SortexchangecocktailFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_frame_max(s : SortexchangecocktailFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_frame_to_string(s : SortexchangecocktailFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_table_make(size : Int) -> SortexchangecocktailTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_table_len(s : SortexchangecocktailTable) -> Int { s.size }

pub fn sort_exchange_cocktail_table_get(s : SortexchangecocktailTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_table_set(s : SortexchangecocktailTable, i : Int, v : Double) -> SortexchangecocktailTable {
  let result = sort_exchange_cocktail_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_table_sum(s : SortexchangecocktailTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_table_mean(s : SortexchangecocktailTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_table_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_table_scale(s : SortexchangecocktailTable, f : Double) -> SortexchangecocktailTable {
  let result = sort_exchange_cocktail_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_table_add(a : SortexchangecocktailTable, b : SortexchangecocktailTable) -> SortexchangecocktailTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_table_copy(s : SortexchangecocktailTable) -> SortexchangecocktailTable {
  let result = sort_exchange_cocktail_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_table_fill(s : SortexchangecocktailTable, v : Double) -> SortexchangecocktailTable {
  let result = sort_exchange_cocktail_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_table_min(s : SortexchangecocktailTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_table_max(s : SortexchangecocktailTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_table_to_string(s : SortexchangecocktailTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_graphn_make(size : Int) -> SortexchangecocktailGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_graphn_len(s : SortexchangecocktailGraphN) -> Int { s.size }

pub fn sort_exchange_cocktail_graphn_get(s : SortexchangecocktailGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_graphn_set(s : SortexchangecocktailGraphN, i : Int, v : Double) -> SortexchangecocktailGraphN {
  let result = sort_exchange_cocktail_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_graphn_sum(s : SortexchangecocktailGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_graphn_mean(s : SortexchangecocktailGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_graphn_scale(s : SortexchangecocktailGraphN, f : Double) -> SortexchangecocktailGraphN {
  let result = sort_exchange_cocktail_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_graphn_add(a : SortexchangecocktailGraphN, b : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_graphn_copy(s : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  let result = sort_exchange_cocktail_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_graphn_fill(s : SortexchangecocktailGraphN, v : Double) -> SortexchangecocktailGraphN {
  let result = sort_exchange_cocktail_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_graphn_min(s : SortexchangecocktailGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_graphn_max(s : SortexchangecocktailGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_graphn_to_string(s : SortexchangecocktailGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_node_make(size : Int) -> SortexchangecocktailNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_node_len(s : SortexchangecocktailNode) -> Int { s.size }

pub fn sort_exchange_cocktail_node_get(s : SortexchangecocktailNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_node_set(s : SortexchangecocktailNode, i : Int, v : Double) -> SortexchangecocktailNode {
  let result = sort_exchange_cocktail_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_node_sum(s : SortexchangecocktailNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_node_mean(s : SortexchangecocktailNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_node_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_node_scale(s : SortexchangecocktailNode, f : Double) -> SortexchangecocktailNode {
  let result = sort_exchange_cocktail_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_node_add(a : SortexchangecocktailNode, b : SortexchangecocktailNode) -> SortexchangecocktailNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_node_copy(s : SortexchangecocktailNode) -> SortexchangecocktailNode {
  let result = sort_exchange_cocktail_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_node_fill(s : SortexchangecocktailNode, v : Double) -> SortexchangecocktailNode {
  let result = sort_exchange_cocktail_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_node_min(s : SortexchangecocktailNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_node_max(s : SortexchangecocktailNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_node_to_string(s : SortexchangecocktailNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_edge_make(size : Int) -> SortexchangecocktailEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_edge_len(s : SortexchangecocktailEdge) -> Int { s.size }

pub fn sort_exchange_cocktail_edge_get(s : SortexchangecocktailEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_edge_set(s : SortexchangecocktailEdge, i : Int, v : Double) -> SortexchangecocktailEdge {
  let result = sort_exchange_cocktail_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_edge_sum(s : SortexchangecocktailEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_edge_mean(s : SortexchangecocktailEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_edge_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_edge_scale(s : SortexchangecocktailEdge, f : Double) -> SortexchangecocktailEdge {
  let result = sort_exchange_cocktail_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_edge_add(a : SortexchangecocktailEdge, b : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_edge_copy(s : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  let result = sort_exchange_cocktail_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_edge_fill(s : SortexchangecocktailEdge, v : Double) -> SortexchangecocktailEdge {
  let result = sort_exchange_cocktail_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_edge_min(s : SortexchangecocktailEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_edge_max(s : SortexchangecocktailEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_edge_to_string(s : SortexchangecocktailEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_path_make(size : Int) -> SortexchangecocktailPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_path_len(s : SortexchangecocktailPath) -> Int { s.size }

pub fn sort_exchange_cocktail_path_get(s : SortexchangecocktailPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_path_set(s : SortexchangecocktailPath, i : Int, v : Double) -> SortexchangecocktailPath {
  let result = sort_exchange_cocktail_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_path_sum(s : SortexchangecocktailPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_path_mean(s : SortexchangecocktailPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_path_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_path_scale(s : SortexchangecocktailPath, f : Double) -> SortexchangecocktailPath {
  let result = sort_exchange_cocktail_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_path_add(a : SortexchangecocktailPath, b : SortexchangecocktailPath) -> SortexchangecocktailPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_path_copy(s : SortexchangecocktailPath) -> SortexchangecocktailPath {
  let result = sort_exchange_cocktail_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_path_fill(s : SortexchangecocktailPath, v : Double) -> SortexchangecocktailPath {
  let result = sort_exchange_cocktail_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_path_min(s : SortexchangecocktailPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_path_max(s : SortexchangecocktailPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_path_to_string(s : SortexchangecocktailPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cluster_make(size : Int) -> SortexchangecocktailCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cluster_len(s : SortexchangecocktailCluster) -> Int { s.size }

pub fn sort_exchange_cocktail_cluster_get(s : SortexchangecocktailCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cluster_set(s : SortexchangecocktailCluster, i : Int, v : Double) -> SortexchangecocktailCluster {
  let result = sort_exchange_cocktail_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_cluster_sum(s : SortexchangecocktailCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_cluster_mean(s : SortexchangecocktailCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_cluster_scale(s : SortexchangecocktailCluster, f : Double) -> SortexchangecocktailCluster {
  let result = sort_exchange_cocktail_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_cluster_add(a : SortexchangecocktailCluster, b : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_cluster_copy(s : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  let result = sort_exchange_cocktail_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_cluster_fill(s : SortexchangecocktailCluster, v : Double) -> SortexchangecocktailCluster {
  let result = sort_exchange_cocktail_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_cluster_min(s : SortexchangecocktailCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_cluster_max(s : SortexchangecocktailCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_cluster_to_string(s : SortexchangecocktailCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_model_make(size : Int) -> SortexchangecocktailModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_model_len(s : SortexchangecocktailModel) -> Int { s.size }

pub fn sort_exchange_cocktail_model_get(s : SortexchangecocktailModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_model_set(s : SortexchangecocktailModel, i : Int, v : Double) -> SortexchangecocktailModel {
  let result = sort_exchange_cocktail_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_model_sum(s : SortexchangecocktailModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_model_mean(s : SortexchangecocktailModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_model_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_model_scale(s : SortexchangecocktailModel, f : Double) -> SortexchangecocktailModel {
  let result = sort_exchange_cocktail_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_model_add(a : SortexchangecocktailModel, b : SortexchangecocktailModel) -> SortexchangecocktailModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_model_copy(s : SortexchangecocktailModel) -> SortexchangecocktailModel {
  let result = sort_exchange_cocktail_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_model_fill(s : SortexchangecocktailModel, v : Double) -> SortexchangecocktailModel {
  let result = sort_exchange_cocktail_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_model_min(s : SortexchangecocktailModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_model_max(s : SortexchangecocktailModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_model_to_string(s : SortexchangecocktailModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_layer_make(size : Int) -> SortexchangecocktailLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_layer_len(s : SortexchangecocktailLayer) -> Int { s.size }

pub fn sort_exchange_cocktail_layer_get(s : SortexchangecocktailLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_layer_set(s : SortexchangecocktailLayer, i : Int, v : Double) -> SortexchangecocktailLayer {
  let result = sort_exchange_cocktail_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_layer_sum(s : SortexchangecocktailLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_layer_mean(s : SortexchangecocktailLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_layer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_layer_scale(s : SortexchangecocktailLayer, f : Double) -> SortexchangecocktailLayer {
  let result = sort_exchange_cocktail_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_layer_add(a : SortexchangecocktailLayer, b : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_layer_copy(s : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  let result = sort_exchange_cocktail_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_layer_fill(s : SortexchangecocktailLayer, v : Double) -> SortexchangecocktailLayer {
  let result = sort_exchange_cocktail_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_layer_min(s : SortexchangecocktailLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_layer_max(s : SortexchangecocktailLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_layer_to_string(s : SortexchangecocktailLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_buffer_make(size : Int) -> SortexchangecocktailBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_buffer_len(s : SortexchangecocktailBuffer) -> Int { s.size }

pub fn sort_exchange_cocktail_buffer_get(s : SortexchangecocktailBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_buffer_set(s : SortexchangecocktailBuffer, i : Int, v : Double) -> SortexchangecocktailBuffer {
  let result = sort_exchange_cocktail_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_buffer_sum(s : SortexchangecocktailBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_buffer_mean(s : SortexchangecocktailBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_buffer_scale(s : SortexchangecocktailBuffer, f : Double) -> SortexchangecocktailBuffer {
  let result = sort_exchange_cocktail_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_buffer_add(a : SortexchangecocktailBuffer, b : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_buffer_copy(s : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  let result = sort_exchange_cocktail_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_buffer_fill(s : SortexchangecocktailBuffer, v : Double) -> SortexchangecocktailBuffer {
  let result = sort_exchange_cocktail_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_buffer_min(s : SortexchangecocktailBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_buffer_max(s : SortexchangecocktailBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_buffer_to_string(s : SortexchangecocktailBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cursor_make(size : Int) -> SortexchangecocktailCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cursor_len(s : SortexchangecocktailCursor) -> Int { s.size }

pub fn sort_exchange_cocktail_cursor_get(s : SortexchangecocktailCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cursor_set(s : SortexchangecocktailCursor, i : Int, v : Double) -> SortexchangecocktailCursor {
  let result = sort_exchange_cocktail_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_cursor_sum(s : SortexchangecocktailCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_cursor_mean(s : SortexchangecocktailCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_cursor_scale(s : SortexchangecocktailCursor, f : Double) -> SortexchangecocktailCursor {
  let result = sort_exchange_cocktail_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_cursor_add(a : SortexchangecocktailCursor, b : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_cursor_copy(s : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  let result = sort_exchange_cocktail_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_cursor_fill(s : SortexchangecocktailCursor, v : Double) -> SortexchangecocktailCursor {
  let result = sort_exchange_cocktail_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_cursor_min(s : SortexchangecocktailCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_cursor_max(s : SortexchangecocktailCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_cursor_to_string(s : SortexchangecocktailCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_view_make(size : Int) -> SortexchangecocktailView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_view_len(s : SortexchangecocktailView) -> Int { s.size }

pub fn sort_exchange_cocktail_view_get(s : SortexchangecocktailView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_view_set(s : SortexchangecocktailView, i : Int, v : Double) -> SortexchangecocktailView {
  let result = sort_exchange_cocktail_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_view_sum(s : SortexchangecocktailView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_view_mean(s : SortexchangecocktailView) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_view_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_view_scale(s : SortexchangecocktailView, f : Double) -> SortexchangecocktailView {
  let result = sort_exchange_cocktail_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_view_add(a : SortexchangecocktailView, b : SortexchangecocktailView) -> SortexchangecocktailView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_view_copy(s : SortexchangecocktailView) -> SortexchangecocktailView {
  let result = sort_exchange_cocktail_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_view_fill(s : SortexchangecocktailView, v : Double) -> SortexchangecocktailView {
  let result = sort_exchange_cocktail_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_view_min(s : SortexchangecocktailView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_view_max(s : SortexchangecocktailView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_view_to_string(s : SortexchangecocktailView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_range_make(size : Int) -> SortexchangecocktailRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_range_len(s : SortexchangecocktailRange) -> Int { s.size }

pub fn sort_exchange_cocktail_range_get(s : SortexchangecocktailRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_range_set(s : SortexchangecocktailRange, i : Int, v : Double) -> SortexchangecocktailRange {
  let result = sort_exchange_cocktail_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_range_sum(s : SortexchangecocktailRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_range_mean(s : SortexchangecocktailRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_range_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_range_scale(s : SortexchangecocktailRange, f : Double) -> SortexchangecocktailRange {
  let result = sort_exchange_cocktail_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_range_add(a : SortexchangecocktailRange, b : SortexchangecocktailRange) -> SortexchangecocktailRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_range_copy(s : SortexchangecocktailRange) -> SortexchangecocktailRange {
  let result = sort_exchange_cocktail_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_range_fill(s : SortexchangecocktailRange, v : Double) -> SortexchangecocktailRange {
  let result = sort_exchange_cocktail_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_range_min(s : SortexchangecocktailRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_range_max(s : SortexchangecocktailRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_range_to_string(s : SortexchangecocktailRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_slice_make(size : Int) -> SortexchangecocktailSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_slice_len(s : SortexchangecocktailSlice) -> Int { s.size }

pub fn sort_exchange_cocktail_slice_get(s : SortexchangecocktailSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_slice_set(s : SortexchangecocktailSlice, i : Int, v : Double) -> SortexchangecocktailSlice {
  let result = sort_exchange_cocktail_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_slice_sum(s : SortexchangecocktailSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_exchange_cocktail_slice_mean(s : SortexchangecocktailSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_exchange_cocktail_slice_sum(s) / s.size.to_double() }
}

pub fn sort_exchange_cocktail_slice_scale(s : SortexchangecocktailSlice, f : Double) -> SortexchangecocktailSlice {
  let result = sort_exchange_cocktail_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_exchange_cocktail_slice_add(a : SortexchangecocktailSlice, b : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_exchange_cocktail_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_exchange_cocktail_slice_copy(s : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  let result = sort_exchange_cocktail_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_exchange_cocktail_slice_fill(s : SortexchangecocktailSlice, v : Double) -> SortexchangecocktailSlice {
  let result = sort_exchange_cocktail_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_exchange_cocktail_slice_min(s : SortexchangecocktailSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_slice_max(s : SortexchangecocktailSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_exchange_cocktail_slice_to_string(s : SortexchangecocktailSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


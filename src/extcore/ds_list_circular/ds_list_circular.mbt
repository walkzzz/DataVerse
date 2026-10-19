///===
/// extcore/ds_list_circular

pub(all) struct DslistcircularPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_circular_make_point(x : Double, y : Double) -> DslistcircularPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_circular_make_point3(x : Double, y : Double, z : Double) -> DslistcircularPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_circular_point_x(pt : DslistcircularPoint) -> Double { pt.x }

pub fn ds_list_circular_point_y(pt : DslistcircularPoint) -> Double { pt.y }

pub fn ds_list_circular_point_z(pt : DslistcircularPoint) -> Double { pt.z }

pub fn ds_list_circular_point_label(pt : DslistcircularPoint) -> Int { pt.label }

pub fn ds_list_circular_point_dist(a : DslistcircularPoint, b : DslistcircularPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_circular_point_add(a : DslistcircularPoint, b : DslistcircularPoint) -> DslistcircularPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_circular_point_sub(a : DslistcircularPoint, b : DslistcircularPoint) -> DslistcircularPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_circular_point_scale(pt : DslistcircularPoint, s : Double) -> DslistcircularPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_circular_point_dot(a : DslistcircularPoint, b : DslistcircularPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_circular_point_cross(a : DslistcircularPoint, b : DslistcircularPoint) -> DslistcircularPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_circular_point_norm(pt : DslistcircularPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_circular_point_normalize(pt : DslistcircularPoint) -> DslistcircularPoint {
  let n = ds_list_circular_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_circular_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_circular_point_negate(pt : DslistcircularPoint) -> DslistcircularPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_circular_point_mid(a : DslistcircularPoint, b : DslistcircularPoint) -> DslistcircularPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_circular_point_lerp(a : DslistcircularPoint, b : DslistcircularPoint, t : Double) -> DslistcircularPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_circular_point_to_string(pt : DslistcircularPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistcircularSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_circular_make_series(vals : Array[Double], name : String) -> DslistcircularSeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_circular_series_len(s : DslistcircularSeries) -> Int { s.vals.length() }

pub fn ds_list_circular_series_sum(s : DslistcircularSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_circular_series_mean(s : DslistcircularSeries) -> Double {
  let n = ds_list_circular_series_len(s)
  if n == 0 { 0.0 } else { ds_list_circular_series_sum(s) / n.to_double() }
}

pub fn ds_list_circular_series_min(s : DslistcircularSeries) -> Double {
  let n = ds_list_circular_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_circular_series_max(s : DslistcircularSeries) -> Double {
  let n = ds_list_circular_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_circular_series_range(s : DslistcircularSeries) -> Double {
  ds_list_circular_series_max(s) - ds_list_circular_series_min(s)
}

pub fn ds_list_circular_series_var(s : DslistcircularSeries) -> Double {
  let n = ds_list_circular_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_circular_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_circular_series_std(s : DslistcircularSeries) -> Double { @_common.sqrt(ds_list_circular_series_var(s)) }

pub fn ds_list_circular_series_median(s : DslistcircularSeries) -> Double {
  let n = ds_list_circular_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_circular_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_circular_series_scale(s : DslistcircularSeries, f : Double) -> DslistcircularSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_circular_series_add(a : DslistcircularSeries, b : DslistcircularSeries) -> DslistcircularSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_circular_series_sub(a : DslistcircularSeries, b : DslistcircularSeries) -> DslistcircularSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_circular_series_normalize(s : DslistcircularSeries) -> DslistcircularSeries {
  let mn = ds_list_circular_series_min(s)
  let mx = ds_list_circular_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_circular_series_cumsum(s : DslistcircularSeries) -> DslistcircularSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_circular_series_to_string(s : DslistcircularSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistcircularMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_circular_make_matrix(rows : Int, cols : Int, val : Double) -> DslistcircularMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_circular_matrix_identity(n : Int) -> DslistcircularMatrix {
  let m = ds_list_circular_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_circular_matrix_get(m : DslistcircularMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_circular_matrix_transpose(m : DslistcircularMatrix) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_circular_matrix_add(a : DslistcircularMatrix, b : DslistcircularMatrix) -> DslistcircularMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_circular_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_circular_matrix_scale(m : DslistcircularMatrix, s : Double) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_circular_matrix_multiply(a : DslistcircularMatrix, b : DslistcircularMatrix) -> DslistcircularMatrix {
  if a.cols != b.rows { return ds_list_circular_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_circular_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_circular_matrix_trace(m : DslistcircularMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_circular_matrix_det(m : DslistcircularMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_circular_matrix_norm(m : DslistcircularMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_circular_matrix_to_string(m : DslistcircularMatrix) -> String {
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

pub(all) struct DslistcircularVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_circular_make_vector(comps : Array[Double]) -> DslistcircularVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_circular_vector_zero(dim : Int) -> DslistcircularVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_circular_vector_add(a : DslistcircularVector, b : DslistcircularVector) -> DslistcircularVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_circular_vector_sub(a : DslistcircularVector, b : DslistcircularVector) -> DslistcircularVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_circular_vector_scale(v : DslistcircularVector, s : Double) -> DslistcircularVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_circular_vector_dot(a : DslistcircularVector, b : DslistcircularVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_circular_vector_norm(v : DslistcircularVector) -> Double { @_common.sqrt(ds_list_circular_vector_dot(v, v)) }

pub fn ds_list_circular_vector_normalize(v : DslistcircularVector) -> DslistcircularVector {
  let n = ds_list_circular_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_circular_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_circular_vector_dist(a : DslistcircularVector, b : DslistcircularVector) -> Double {
  ds_list_circular_vector_norm(ds_list_circular_vector_sub(a, b))
}

pub fn ds_list_circular_vector_to_string(v : DslistcircularVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_circular_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_circular_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_circular_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_circular_std(data : Array[Double]) -> Double { @_common.sqrt(ds_list_circular_var(data)) }

pub fn ds_list_circular_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_circular_mean(a); let mb = ds_list_circular_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_circular_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_circular_std(a); let sb = ds_list_circular_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_circular_cov(a, b) / (sa * sb) }
}

pub fn ds_list_circular_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_circular_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_circular_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_circular_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_circular_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_list_circular_mse(pred, labels))
}

pub fn ds_list_circular_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_circular_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_circular_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_circular_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_circular_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_circular_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_circular_precision(pred, labels, pos); let r = ds_list_circular_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_circular_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_circular_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_circular_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_circular_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_circular_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_circular_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_circular_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_circular_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_circular_fibonacci(n : Int) -> Int {
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

pub fn ds_list_circular_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_circular_min(data); let mx = ds_list_circular_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_circular_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_circular_mean(data); let sd = ds_list_circular_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_circular_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_circular_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_circular_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_circular_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_circular_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_circular_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DslistcircularFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_frame_make(size : Int) -> DslistcircularFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_frame_len(s : DslistcircularFrame) -> Int { s.size }

pub fn ds_list_circular_frame_get(s : DslistcircularFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_frame_set(s : DslistcircularFrame, i : Int, v : Double) -> DslistcircularFrame {
  let result = ds_list_circular_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_frame_sum(s : DslistcircularFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_frame_mean(s : DslistcircularFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_frame_scale(s : DslistcircularFrame, f : Double) -> DslistcircularFrame {
  let result = ds_list_circular_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_frame_add(a : DslistcircularFrame, b : DslistcircularFrame) -> DslistcircularFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_frame_copy(s : DslistcircularFrame) -> DslistcircularFrame {
  let result = ds_list_circular_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_frame_fill(s : DslistcircularFrame, v : Double) -> DslistcircularFrame {
  let result = ds_list_circular_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_frame_min(s : DslistcircularFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_frame_max(s : DslistcircularFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_frame_to_string(s : DslistcircularFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_table_make(size : Int) -> DslistcircularTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_table_len(s : DslistcircularTable) -> Int { s.size }

pub fn ds_list_circular_table_get(s : DslistcircularTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_table_set(s : DslistcircularTable, i : Int, v : Double) -> DslistcircularTable {
  let result = ds_list_circular_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_table_sum(s : DslistcircularTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_table_mean(s : DslistcircularTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_table_scale(s : DslistcircularTable, f : Double) -> DslistcircularTable {
  let result = ds_list_circular_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_table_add(a : DslistcircularTable, b : DslistcircularTable) -> DslistcircularTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_table_copy(s : DslistcircularTable) -> DslistcircularTable {
  let result = ds_list_circular_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_table_fill(s : DslistcircularTable, v : Double) -> DslistcircularTable {
  let result = ds_list_circular_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_table_min(s : DslistcircularTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_table_max(s : DslistcircularTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_table_to_string(s : DslistcircularTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_graphn_make(size : Int) -> DslistcircularGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_graphn_len(s : DslistcircularGraphN) -> Int { s.size }

pub fn ds_list_circular_graphn_get(s : DslistcircularGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_graphn_set(s : DslistcircularGraphN, i : Int, v : Double) -> DslistcircularGraphN {
  let result = ds_list_circular_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_graphn_sum(s : DslistcircularGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_graphn_mean(s : DslistcircularGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_graphn_scale(s : DslistcircularGraphN, f : Double) -> DslistcircularGraphN {
  let result = ds_list_circular_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_graphn_add(a : DslistcircularGraphN, b : DslistcircularGraphN) -> DslistcircularGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_graphn_copy(s : DslistcircularGraphN) -> DslistcircularGraphN {
  let result = ds_list_circular_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_graphn_fill(s : DslistcircularGraphN, v : Double) -> DslistcircularGraphN {
  let result = ds_list_circular_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_graphn_min(s : DslistcircularGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_graphn_max(s : DslistcircularGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_graphn_to_string(s : DslistcircularGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_node_make(size : Int) -> DslistcircularNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_node_len(s : DslistcircularNode) -> Int { s.size }

pub fn ds_list_circular_node_get(s : DslistcircularNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_node_set(s : DslistcircularNode, i : Int, v : Double) -> DslistcircularNode {
  let result = ds_list_circular_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_node_sum(s : DslistcircularNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_node_mean(s : DslistcircularNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_node_scale(s : DslistcircularNode, f : Double) -> DslistcircularNode {
  let result = ds_list_circular_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_node_add(a : DslistcircularNode, b : DslistcircularNode) -> DslistcircularNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_node_copy(s : DslistcircularNode) -> DslistcircularNode {
  let result = ds_list_circular_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_node_fill(s : DslistcircularNode, v : Double) -> DslistcircularNode {
  let result = ds_list_circular_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_node_min(s : DslistcircularNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_node_max(s : DslistcircularNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_node_to_string(s : DslistcircularNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_edge_make(size : Int) -> DslistcircularEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_edge_len(s : DslistcircularEdge) -> Int { s.size }

pub fn ds_list_circular_edge_get(s : DslistcircularEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_edge_set(s : DslistcircularEdge, i : Int, v : Double) -> DslistcircularEdge {
  let result = ds_list_circular_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_edge_sum(s : DslistcircularEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_edge_mean(s : DslistcircularEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_edge_scale(s : DslistcircularEdge, f : Double) -> DslistcircularEdge {
  let result = ds_list_circular_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_edge_add(a : DslistcircularEdge, b : DslistcircularEdge) -> DslistcircularEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_edge_copy(s : DslistcircularEdge) -> DslistcircularEdge {
  let result = ds_list_circular_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_edge_fill(s : DslistcircularEdge, v : Double) -> DslistcircularEdge {
  let result = ds_list_circular_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_edge_min(s : DslistcircularEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_edge_max(s : DslistcircularEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_edge_to_string(s : DslistcircularEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_path_make(size : Int) -> DslistcircularPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_path_len(s : DslistcircularPath) -> Int { s.size }

pub fn ds_list_circular_path_get(s : DslistcircularPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_path_set(s : DslistcircularPath, i : Int, v : Double) -> DslistcircularPath {
  let result = ds_list_circular_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_path_sum(s : DslistcircularPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_path_mean(s : DslistcircularPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_path_scale(s : DslistcircularPath, f : Double) -> DslistcircularPath {
  let result = ds_list_circular_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_path_add(a : DslistcircularPath, b : DslistcircularPath) -> DslistcircularPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_path_copy(s : DslistcircularPath) -> DslistcircularPath {
  let result = ds_list_circular_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_path_fill(s : DslistcircularPath, v : Double) -> DslistcircularPath {
  let result = ds_list_circular_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_path_min(s : DslistcircularPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_path_max(s : DslistcircularPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_path_to_string(s : DslistcircularPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cluster_make(size : Int) -> DslistcircularCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_cluster_len(s : DslistcircularCluster) -> Int { s.size }

pub fn ds_list_circular_cluster_get(s : DslistcircularCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_cluster_set(s : DslistcircularCluster, i : Int, v : Double) -> DslistcircularCluster {
  let result = ds_list_circular_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_cluster_sum(s : DslistcircularCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_cluster_mean(s : DslistcircularCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_cluster_scale(s : DslistcircularCluster, f : Double) -> DslistcircularCluster {
  let result = ds_list_circular_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_cluster_add(a : DslistcircularCluster, b : DslistcircularCluster) -> DslistcircularCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_cluster_copy(s : DslistcircularCluster) -> DslistcircularCluster {
  let result = ds_list_circular_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_cluster_fill(s : DslistcircularCluster, v : Double) -> DslistcircularCluster {
  let result = ds_list_circular_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_cluster_min(s : DslistcircularCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_cluster_max(s : DslistcircularCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_cluster_to_string(s : DslistcircularCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_model_make(size : Int) -> DslistcircularModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_model_len(s : DslistcircularModel) -> Int { s.size }

pub fn ds_list_circular_model_get(s : DslistcircularModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_model_set(s : DslistcircularModel, i : Int, v : Double) -> DslistcircularModel {
  let result = ds_list_circular_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_model_sum(s : DslistcircularModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_model_mean(s : DslistcircularModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_model_scale(s : DslistcircularModel, f : Double) -> DslistcircularModel {
  let result = ds_list_circular_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_model_add(a : DslistcircularModel, b : DslistcircularModel) -> DslistcircularModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_model_copy(s : DslistcircularModel) -> DslistcircularModel {
  let result = ds_list_circular_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_model_fill(s : DslistcircularModel, v : Double) -> DslistcircularModel {
  let result = ds_list_circular_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_model_min(s : DslistcircularModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_model_max(s : DslistcircularModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_model_to_string(s : DslistcircularModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_layer_make(size : Int) -> DslistcircularLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_layer_len(s : DslistcircularLayer) -> Int { s.size }

pub fn ds_list_circular_layer_get(s : DslistcircularLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_layer_set(s : DslistcircularLayer, i : Int, v : Double) -> DslistcircularLayer {
  let result = ds_list_circular_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_layer_sum(s : DslistcircularLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_layer_mean(s : DslistcircularLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_layer_scale(s : DslistcircularLayer, f : Double) -> DslistcircularLayer {
  let result = ds_list_circular_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_layer_add(a : DslistcircularLayer, b : DslistcircularLayer) -> DslistcircularLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_layer_copy(s : DslistcircularLayer) -> DslistcircularLayer {
  let result = ds_list_circular_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_layer_fill(s : DslistcircularLayer, v : Double) -> DslistcircularLayer {
  let result = ds_list_circular_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_layer_min(s : DslistcircularLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_layer_max(s : DslistcircularLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_layer_to_string(s : DslistcircularLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_buffer_make(size : Int) -> DslistcircularBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_buffer_len(s : DslistcircularBuffer) -> Int { s.size }

pub fn ds_list_circular_buffer_get(s : DslistcircularBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_buffer_set(s : DslistcircularBuffer, i : Int, v : Double) -> DslistcircularBuffer {
  let result = ds_list_circular_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_buffer_sum(s : DslistcircularBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_buffer_mean(s : DslistcircularBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_buffer_scale(s : DslistcircularBuffer, f : Double) -> DslistcircularBuffer {
  let result = ds_list_circular_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_buffer_add(a : DslistcircularBuffer, b : DslistcircularBuffer) -> DslistcircularBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_buffer_copy(s : DslistcircularBuffer) -> DslistcircularBuffer {
  let result = ds_list_circular_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_buffer_fill(s : DslistcircularBuffer, v : Double) -> DslistcircularBuffer {
  let result = ds_list_circular_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_buffer_min(s : DslistcircularBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_buffer_max(s : DslistcircularBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_buffer_to_string(s : DslistcircularBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cursor_make(size : Int) -> DslistcircularCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_cursor_len(s : DslistcircularCursor) -> Int { s.size }

pub fn ds_list_circular_cursor_get(s : DslistcircularCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_cursor_set(s : DslistcircularCursor, i : Int, v : Double) -> DslistcircularCursor {
  let result = ds_list_circular_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_cursor_sum(s : DslistcircularCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_cursor_mean(s : DslistcircularCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_cursor_scale(s : DslistcircularCursor, f : Double) -> DslistcircularCursor {
  let result = ds_list_circular_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_cursor_add(a : DslistcircularCursor, b : DslistcircularCursor) -> DslistcircularCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_cursor_copy(s : DslistcircularCursor) -> DslistcircularCursor {
  let result = ds_list_circular_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_cursor_fill(s : DslistcircularCursor, v : Double) -> DslistcircularCursor {
  let result = ds_list_circular_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_cursor_min(s : DslistcircularCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_cursor_max(s : DslistcircularCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_cursor_to_string(s : DslistcircularCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_view_make(size : Int) -> DslistcircularView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_view_len(s : DslistcircularView) -> Int { s.size }

pub fn ds_list_circular_view_get(s : DslistcircularView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_view_set(s : DslistcircularView, i : Int, v : Double) -> DslistcircularView {
  let result = ds_list_circular_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_view_sum(s : DslistcircularView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_view_mean(s : DslistcircularView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_view_scale(s : DslistcircularView, f : Double) -> DslistcircularView {
  let result = ds_list_circular_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_view_add(a : DslistcircularView, b : DslistcircularView) -> DslistcircularView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_view_copy(s : DslistcircularView) -> DslistcircularView {
  let result = ds_list_circular_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_view_fill(s : DslistcircularView, v : Double) -> DslistcircularView {
  let result = ds_list_circular_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_view_min(s : DslistcircularView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_view_max(s : DslistcircularView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_view_to_string(s : DslistcircularView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_range_make(size : Int) -> DslistcircularRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_range_len(s : DslistcircularRange) -> Int { s.size }

pub fn ds_list_circular_range_get(s : DslistcircularRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_range_set(s : DslistcircularRange, i : Int, v : Double) -> DslistcircularRange {
  let result = ds_list_circular_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_range_sum(s : DslistcircularRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_range_mean(s : DslistcircularRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_range_scale(s : DslistcircularRange, f : Double) -> DslistcircularRange {
  let result = ds_list_circular_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_range_add(a : DslistcircularRange, b : DslistcircularRange) -> DslistcircularRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_range_copy(s : DslistcircularRange) -> DslistcircularRange {
  let result = ds_list_circular_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_range_fill(s : DslistcircularRange, v : Double) -> DslistcircularRange {
  let result = ds_list_circular_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_range_min(s : DslistcircularRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_range_max(s : DslistcircularRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_range_to_string(s : DslistcircularRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_slice_make(size : Int) -> DslistcircularSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_slice_len(s : DslistcircularSlice) -> Int { s.size }

pub fn ds_list_circular_slice_get(s : DslistcircularSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_slice_set(s : DslistcircularSlice, i : Int, v : Double) -> DslistcircularSlice {
  let result = ds_list_circular_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_slice_sum(s : DslistcircularSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_circular_slice_mean(s : DslistcircularSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_circular_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_circular_slice_scale(s : DslistcircularSlice, f : Double) -> DslistcircularSlice {
  let result = ds_list_circular_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_circular_slice_add(a : DslistcircularSlice, b : DslistcircularSlice) -> DslistcircularSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_circular_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_circular_slice_copy(s : DslistcircularSlice) -> DslistcircularSlice {
  let result = ds_list_circular_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_circular_slice_fill(s : DslistcircularSlice, v : Double) -> DslistcircularSlice {
  let result = ds_list_circular_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_circular_slice_min(s : DslistcircularSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_slice_max(s : DslistcircularSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_circular_slice_to_string(s : DslistcircularSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


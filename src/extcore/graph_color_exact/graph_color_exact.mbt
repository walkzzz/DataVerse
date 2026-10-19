///===
/// extcore/graph_color_exact

pub(all) struct GraphcolorexactPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_exact_make_point(x : Double, y : Double) -> GraphcolorexactPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_exact_make_point3(x : Double, y : Double, z : Double) -> GraphcolorexactPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_exact_point_x(pt : GraphcolorexactPoint) -> Double { pt.x }

pub fn graph_color_exact_point_y(pt : GraphcolorexactPoint) -> Double { pt.y }

pub fn graph_color_exact_point_z(pt : GraphcolorexactPoint) -> Double { pt.z }

pub fn graph_color_exact_point_label(pt : GraphcolorexactPoint) -> Int { pt.label }

pub fn graph_color_exact_point_dist(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_exact_point_add(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_exact_point_sub(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_exact_point_scale(pt : GraphcolorexactPoint, s : Double) -> GraphcolorexactPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_exact_point_dot(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_exact_point_cross(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_exact_point_norm(pt : GraphcolorexactPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_exact_point_normalize(pt : GraphcolorexactPoint) -> GraphcolorexactPoint {
  let n = graph_color_exact_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_exact_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_exact_point_negate(pt : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_exact_point_mid(a : GraphcolorexactPoint, b : GraphcolorexactPoint) -> GraphcolorexactPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_exact_point_lerp(a : GraphcolorexactPoint, b : GraphcolorexactPoint, t : Double) -> GraphcolorexactPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_exact_point_to_string(pt : GraphcolorexactPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorexactSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_exact_make_series(vals : Array[Double], name : String) -> GraphcolorexactSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_exact_series_len(s : GraphcolorexactSeries) -> Int { s.vals.length() }

pub fn graph_color_exact_series_sum(s : GraphcolorexactSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_exact_series_mean(s : GraphcolorexactSeries) -> Double {
  let n = graph_color_exact_series_len(s)
  if n == 0 { 0.0 } else { graph_color_exact_series_sum(s) / n.to_double() }
}

pub fn graph_color_exact_series_min(s : GraphcolorexactSeries) -> Double {
  let n = graph_color_exact_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_exact_series_max(s : GraphcolorexactSeries) -> Double {
  let n = graph_color_exact_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_exact_series_range(s : GraphcolorexactSeries) -> Double {
  graph_color_exact_series_max(s) - graph_color_exact_series_min(s)
}

pub fn graph_color_exact_series_var(s : GraphcolorexactSeries) -> Double {
  let n = graph_color_exact_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_color_exact_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_color_exact_series_std(s : GraphcolorexactSeries) -> Double { @_common.sqrt(graph_color_exact_series_var(s)) }

pub fn graph_color_exact_series_median(s : GraphcolorexactSeries) -> Double {
  let n = graph_color_exact_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_color_exact_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_exact_series_scale(s : GraphcolorexactSeries, f : Double) -> GraphcolorexactSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_exact_series_add(a : GraphcolorexactSeries, b : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_exact_series_sub(a : GraphcolorexactSeries, b : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_exact_series_normalize(s : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let mn = graph_color_exact_series_min(s)
  let mx = graph_color_exact_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_exact_series_cumsum(s : GraphcolorexactSeries) -> GraphcolorexactSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_exact_series_to_string(s : GraphcolorexactSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorexactMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_exact_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorexactMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_exact_matrix_identity(n : Int) -> GraphcolorexactMatrix {
  let m = graph_color_exact_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_exact_matrix_get(m : GraphcolorexactMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_exact_matrix_transpose(m : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_exact_matrix_add(a : GraphcolorexactMatrix, b : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_exact_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_exact_matrix_scale(m : GraphcolorexactMatrix, s : Double) -> GraphcolorexactMatrix {
  let result = graph_color_exact_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_exact_matrix_multiply(a : GraphcolorexactMatrix, b : GraphcolorexactMatrix) -> GraphcolorexactMatrix {
  if a.cols != b.rows { return graph_color_exact_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_exact_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_exact_matrix_trace(m : GraphcolorexactMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_exact_matrix_det(m : GraphcolorexactMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_exact_matrix_norm(m : GraphcolorexactMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_exact_matrix_to_string(m : GraphcolorexactMatrix) -> String {
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

pub(all) struct GraphcolorexactVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_exact_make_vector(comps : Array[Double]) -> GraphcolorexactVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_exact_vector_zero(dim : Int) -> GraphcolorexactVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_exact_vector_add(a : GraphcolorexactVector, b : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_exact_vector_sub(a : GraphcolorexactVector, b : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_exact_vector_scale(v : GraphcolorexactVector, s : Double) -> GraphcolorexactVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_exact_vector_dot(a : GraphcolorexactVector, b : GraphcolorexactVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_exact_vector_norm(v : GraphcolorexactVector) -> Double { @_common.sqrt(graph_color_exact_vector_dot(v, v)) }

pub fn graph_color_exact_vector_normalize(v : GraphcolorexactVector) -> GraphcolorexactVector {
  let n = graph_color_exact_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_exact_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_exact_vector_dist(a : GraphcolorexactVector, b : GraphcolorexactVector) -> Double {
  graph_color_exact_vector_norm(graph_color_exact_vector_sub(a, b))
}

pub fn graph_color_exact_vector_to_string(v : GraphcolorexactVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_exact_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_color_exact_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_color_exact_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_exact_std(data : Array[Double]) -> Double { @_common.sqrt(graph_color_exact_var(data)) }

pub fn graph_color_exact_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_color_exact_mean(a); let mb = graph_color_exact_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_color_exact_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_color_exact_std(a); let sb = graph_color_exact_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_color_exact_cov(a, b) / (sa * sb) }
}

pub fn graph_color_exact_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_color_exact_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_exact_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_color_exact_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_exact_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_color_exact_mse(pred, labels))
}

pub fn graph_color_exact_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_color_exact_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_color_exact_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_color_exact_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_color_exact_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_color_exact_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_color_exact_precision(pred, labels, pos); let r = graph_color_exact_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_color_exact_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_color_exact_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_color_exact_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_color_exact_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_color_exact_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_color_exact_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_color_exact_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_color_exact_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_color_exact_fibonacci(n : Int) -> Int {
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

pub fn graph_color_exact_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_color_exact_min(data); let mx = graph_color_exact_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_color_exact_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_color_exact_mean(data); let sd = graph_color_exact_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_color_exact_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_color_exact_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_color_exact_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_color_exact_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_color_exact_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_color_exact_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphcolorexactFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_frame_make(size : Int) -> GraphcolorexactFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_frame_len(s : GraphcolorexactFrame) -> Int { s.size }

pub fn graph_color_exact_frame_get(s : GraphcolorexactFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_frame_set(s : GraphcolorexactFrame, i : Int, v : Double) -> GraphcolorexactFrame {
  let result = graph_color_exact_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_frame_sum(s : GraphcolorexactFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_frame_mean(s : GraphcolorexactFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_frame_scale(s : GraphcolorexactFrame, f : Double) -> GraphcolorexactFrame {
  let result = graph_color_exact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_frame_add(a : GraphcolorexactFrame, b : GraphcolorexactFrame) -> GraphcolorexactFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_frame_copy(s : GraphcolorexactFrame) -> GraphcolorexactFrame {
  let result = graph_color_exact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_frame_fill(s : GraphcolorexactFrame, v : Double) -> GraphcolorexactFrame {
  let result = graph_color_exact_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_frame_min(s : GraphcolorexactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_frame_max(s : GraphcolorexactFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_frame_to_string(s : GraphcolorexactFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_table_make(size : Int) -> GraphcolorexactTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_table_len(s : GraphcolorexactTable) -> Int { s.size }

pub fn graph_color_exact_table_get(s : GraphcolorexactTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_table_set(s : GraphcolorexactTable, i : Int, v : Double) -> GraphcolorexactTable {
  let result = graph_color_exact_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_table_sum(s : GraphcolorexactTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_table_mean(s : GraphcolorexactTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_table_scale(s : GraphcolorexactTable, f : Double) -> GraphcolorexactTable {
  let result = graph_color_exact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_table_add(a : GraphcolorexactTable, b : GraphcolorexactTable) -> GraphcolorexactTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_table_copy(s : GraphcolorexactTable) -> GraphcolorexactTable {
  let result = graph_color_exact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_table_fill(s : GraphcolorexactTable, v : Double) -> GraphcolorexactTable {
  let result = graph_color_exact_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_table_min(s : GraphcolorexactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_table_max(s : GraphcolorexactTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_table_to_string(s : GraphcolorexactTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_graphn_make(size : Int) -> GraphcolorexactGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_graphn_len(s : GraphcolorexactGraphN) -> Int { s.size }

pub fn graph_color_exact_graphn_get(s : GraphcolorexactGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_graphn_set(s : GraphcolorexactGraphN, i : Int, v : Double) -> GraphcolorexactGraphN {
  let result = graph_color_exact_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_graphn_sum(s : GraphcolorexactGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_graphn_mean(s : GraphcolorexactGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_graphn_scale(s : GraphcolorexactGraphN, f : Double) -> GraphcolorexactGraphN {
  let result = graph_color_exact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_graphn_add(a : GraphcolorexactGraphN, b : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_graphn_copy(s : GraphcolorexactGraphN) -> GraphcolorexactGraphN {
  let result = graph_color_exact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_graphn_fill(s : GraphcolorexactGraphN, v : Double) -> GraphcolorexactGraphN {
  let result = graph_color_exact_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_graphn_min(s : GraphcolorexactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_graphn_max(s : GraphcolorexactGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_graphn_to_string(s : GraphcolorexactGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_node_make(size : Int) -> GraphcolorexactNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_node_len(s : GraphcolorexactNode) -> Int { s.size }

pub fn graph_color_exact_node_get(s : GraphcolorexactNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_node_set(s : GraphcolorexactNode, i : Int, v : Double) -> GraphcolorexactNode {
  let result = graph_color_exact_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_node_sum(s : GraphcolorexactNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_node_mean(s : GraphcolorexactNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_node_scale(s : GraphcolorexactNode, f : Double) -> GraphcolorexactNode {
  let result = graph_color_exact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_node_add(a : GraphcolorexactNode, b : GraphcolorexactNode) -> GraphcolorexactNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_node_copy(s : GraphcolorexactNode) -> GraphcolorexactNode {
  let result = graph_color_exact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_node_fill(s : GraphcolorexactNode, v : Double) -> GraphcolorexactNode {
  let result = graph_color_exact_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_node_min(s : GraphcolorexactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_node_max(s : GraphcolorexactNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_node_to_string(s : GraphcolorexactNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_edge_make(size : Int) -> GraphcolorexactEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_edge_len(s : GraphcolorexactEdge) -> Int { s.size }

pub fn graph_color_exact_edge_get(s : GraphcolorexactEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_edge_set(s : GraphcolorexactEdge, i : Int, v : Double) -> GraphcolorexactEdge {
  let result = graph_color_exact_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_edge_sum(s : GraphcolorexactEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_edge_mean(s : GraphcolorexactEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_edge_scale(s : GraphcolorexactEdge, f : Double) -> GraphcolorexactEdge {
  let result = graph_color_exact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_edge_add(a : GraphcolorexactEdge, b : GraphcolorexactEdge) -> GraphcolorexactEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_edge_copy(s : GraphcolorexactEdge) -> GraphcolorexactEdge {
  let result = graph_color_exact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_edge_fill(s : GraphcolorexactEdge, v : Double) -> GraphcolorexactEdge {
  let result = graph_color_exact_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_edge_min(s : GraphcolorexactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_edge_max(s : GraphcolorexactEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_edge_to_string(s : GraphcolorexactEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_path_make(size : Int) -> GraphcolorexactPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_path_len(s : GraphcolorexactPath) -> Int { s.size }

pub fn graph_color_exact_path_get(s : GraphcolorexactPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_path_set(s : GraphcolorexactPath, i : Int, v : Double) -> GraphcolorexactPath {
  let result = graph_color_exact_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_path_sum(s : GraphcolorexactPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_path_mean(s : GraphcolorexactPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_path_scale(s : GraphcolorexactPath, f : Double) -> GraphcolorexactPath {
  let result = graph_color_exact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_path_add(a : GraphcolorexactPath, b : GraphcolorexactPath) -> GraphcolorexactPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_path_copy(s : GraphcolorexactPath) -> GraphcolorexactPath {
  let result = graph_color_exact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_path_fill(s : GraphcolorexactPath, v : Double) -> GraphcolorexactPath {
  let result = graph_color_exact_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_path_min(s : GraphcolorexactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_path_max(s : GraphcolorexactPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_path_to_string(s : GraphcolorexactPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cluster_make(size : Int) -> GraphcolorexactCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_cluster_len(s : GraphcolorexactCluster) -> Int { s.size }

pub fn graph_color_exact_cluster_get(s : GraphcolorexactCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_cluster_set(s : GraphcolorexactCluster, i : Int, v : Double) -> GraphcolorexactCluster {
  let result = graph_color_exact_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_cluster_sum(s : GraphcolorexactCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_cluster_mean(s : GraphcolorexactCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_cluster_scale(s : GraphcolorexactCluster, f : Double) -> GraphcolorexactCluster {
  let result = graph_color_exact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_cluster_add(a : GraphcolorexactCluster, b : GraphcolorexactCluster) -> GraphcolorexactCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_cluster_copy(s : GraphcolorexactCluster) -> GraphcolorexactCluster {
  let result = graph_color_exact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_cluster_fill(s : GraphcolorexactCluster, v : Double) -> GraphcolorexactCluster {
  let result = graph_color_exact_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_cluster_min(s : GraphcolorexactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_cluster_max(s : GraphcolorexactCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_cluster_to_string(s : GraphcolorexactCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_model_make(size : Int) -> GraphcolorexactModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_model_len(s : GraphcolorexactModel) -> Int { s.size }

pub fn graph_color_exact_model_get(s : GraphcolorexactModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_model_set(s : GraphcolorexactModel, i : Int, v : Double) -> GraphcolorexactModel {
  let result = graph_color_exact_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_model_sum(s : GraphcolorexactModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_model_mean(s : GraphcolorexactModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_model_scale(s : GraphcolorexactModel, f : Double) -> GraphcolorexactModel {
  let result = graph_color_exact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_model_add(a : GraphcolorexactModel, b : GraphcolorexactModel) -> GraphcolorexactModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_model_copy(s : GraphcolorexactModel) -> GraphcolorexactModel {
  let result = graph_color_exact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_model_fill(s : GraphcolorexactModel, v : Double) -> GraphcolorexactModel {
  let result = graph_color_exact_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_model_min(s : GraphcolorexactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_model_max(s : GraphcolorexactModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_model_to_string(s : GraphcolorexactModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_layer_make(size : Int) -> GraphcolorexactLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_layer_len(s : GraphcolorexactLayer) -> Int { s.size }

pub fn graph_color_exact_layer_get(s : GraphcolorexactLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_layer_set(s : GraphcolorexactLayer, i : Int, v : Double) -> GraphcolorexactLayer {
  let result = graph_color_exact_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_layer_sum(s : GraphcolorexactLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_layer_mean(s : GraphcolorexactLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_layer_scale(s : GraphcolorexactLayer, f : Double) -> GraphcolorexactLayer {
  let result = graph_color_exact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_layer_add(a : GraphcolorexactLayer, b : GraphcolorexactLayer) -> GraphcolorexactLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_layer_copy(s : GraphcolorexactLayer) -> GraphcolorexactLayer {
  let result = graph_color_exact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_layer_fill(s : GraphcolorexactLayer, v : Double) -> GraphcolorexactLayer {
  let result = graph_color_exact_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_layer_min(s : GraphcolorexactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_layer_max(s : GraphcolorexactLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_layer_to_string(s : GraphcolorexactLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_buffer_make(size : Int) -> GraphcolorexactBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_buffer_len(s : GraphcolorexactBuffer) -> Int { s.size }

pub fn graph_color_exact_buffer_get(s : GraphcolorexactBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_buffer_set(s : GraphcolorexactBuffer, i : Int, v : Double) -> GraphcolorexactBuffer {
  let result = graph_color_exact_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_buffer_sum(s : GraphcolorexactBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_buffer_mean(s : GraphcolorexactBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_buffer_scale(s : GraphcolorexactBuffer, f : Double) -> GraphcolorexactBuffer {
  let result = graph_color_exact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_buffer_add(a : GraphcolorexactBuffer, b : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_buffer_copy(s : GraphcolorexactBuffer) -> GraphcolorexactBuffer {
  let result = graph_color_exact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_buffer_fill(s : GraphcolorexactBuffer, v : Double) -> GraphcolorexactBuffer {
  let result = graph_color_exact_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_buffer_min(s : GraphcolorexactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_buffer_max(s : GraphcolorexactBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_buffer_to_string(s : GraphcolorexactBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_cursor_make(size : Int) -> GraphcolorexactCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_cursor_len(s : GraphcolorexactCursor) -> Int { s.size }

pub fn graph_color_exact_cursor_get(s : GraphcolorexactCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_cursor_set(s : GraphcolorexactCursor, i : Int, v : Double) -> GraphcolorexactCursor {
  let result = graph_color_exact_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_cursor_sum(s : GraphcolorexactCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_cursor_mean(s : GraphcolorexactCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_cursor_scale(s : GraphcolorexactCursor, f : Double) -> GraphcolorexactCursor {
  let result = graph_color_exact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_cursor_add(a : GraphcolorexactCursor, b : GraphcolorexactCursor) -> GraphcolorexactCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_cursor_copy(s : GraphcolorexactCursor) -> GraphcolorexactCursor {
  let result = graph_color_exact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_cursor_fill(s : GraphcolorexactCursor, v : Double) -> GraphcolorexactCursor {
  let result = graph_color_exact_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_cursor_min(s : GraphcolorexactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_cursor_max(s : GraphcolorexactCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_cursor_to_string(s : GraphcolorexactCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_view_make(size : Int) -> GraphcolorexactView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_view_len(s : GraphcolorexactView) -> Int { s.size }

pub fn graph_color_exact_view_get(s : GraphcolorexactView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_view_set(s : GraphcolorexactView, i : Int, v : Double) -> GraphcolorexactView {
  let result = graph_color_exact_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_view_sum(s : GraphcolorexactView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_view_mean(s : GraphcolorexactView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_view_scale(s : GraphcolorexactView, f : Double) -> GraphcolorexactView {
  let result = graph_color_exact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_view_add(a : GraphcolorexactView, b : GraphcolorexactView) -> GraphcolorexactView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_view_copy(s : GraphcolorexactView) -> GraphcolorexactView {
  let result = graph_color_exact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_view_fill(s : GraphcolorexactView, v : Double) -> GraphcolorexactView {
  let result = graph_color_exact_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_view_min(s : GraphcolorexactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_view_max(s : GraphcolorexactView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_view_to_string(s : GraphcolorexactView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_range_make(size : Int) -> GraphcolorexactRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_range_len(s : GraphcolorexactRange) -> Int { s.size }

pub fn graph_color_exact_range_get(s : GraphcolorexactRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_range_set(s : GraphcolorexactRange, i : Int, v : Double) -> GraphcolorexactRange {
  let result = graph_color_exact_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_range_sum(s : GraphcolorexactRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_range_mean(s : GraphcolorexactRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_range_scale(s : GraphcolorexactRange, f : Double) -> GraphcolorexactRange {
  let result = graph_color_exact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_range_add(a : GraphcolorexactRange, b : GraphcolorexactRange) -> GraphcolorexactRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_range_copy(s : GraphcolorexactRange) -> GraphcolorexactRange {
  let result = graph_color_exact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_range_fill(s : GraphcolorexactRange, v : Double) -> GraphcolorexactRange {
  let result = graph_color_exact_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_range_min(s : GraphcolorexactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_range_max(s : GraphcolorexactRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_range_to_string(s : GraphcolorexactRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorexactSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_exact_slice_make(size : Int) -> GraphcolorexactSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_exact_slice_len(s : GraphcolorexactSlice) -> Int { s.size }

pub fn graph_color_exact_slice_get(s : GraphcolorexactSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_exact_slice_set(s : GraphcolorexactSlice, i : Int, v : Double) -> GraphcolorexactSlice {
  let result = graph_color_exact_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_slice_sum(s : GraphcolorexactSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_exact_slice_mean(s : GraphcolorexactSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_exact_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_exact_slice_scale(s : GraphcolorexactSlice, f : Double) -> GraphcolorexactSlice {
  let result = graph_color_exact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_exact_slice_add(a : GraphcolorexactSlice, b : GraphcolorexactSlice) -> GraphcolorexactSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_exact_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_exact_slice_copy(s : GraphcolorexactSlice) -> GraphcolorexactSlice {
  let result = graph_color_exact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_exact_slice_fill(s : GraphcolorexactSlice, v : Double) -> GraphcolorexactSlice {
  let result = graph_color_exact_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_exact_slice_min(s : GraphcolorexactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_slice_max(s : GraphcolorexactSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_exact_slice_to_string(s : GraphcolorexactSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


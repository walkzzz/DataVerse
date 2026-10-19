///===
/// extcore/graph_color_list

pub(all) struct GraphcolorlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_list_make_point(x : Double, y : Double) -> GraphcolorlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_list_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlistPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_list_point_x(pt : GraphcolorlistPoint) -> Double { pt.x }

pub fn graph_color_list_point_y(pt : GraphcolorlistPoint) -> Double { pt.y }

pub fn graph_color_list_point_z(pt : GraphcolorlistPoint) -> Double { pt.z }

pub fn graph_color_list_point_label(pt : GraphcolorlistPoint) -> Int { pt.label }

pub fn graph_color_list_point_dist(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_list_point_add(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_list_point_sub(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_list_point_scale(pt : GraphcolorlistPoint, s : Double) -> GraphcolorlistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_list_point_dot(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_list_point_cross(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_list_point_norm(pt : GraphcolorlistPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_list_point_normalize(pt : GraphcolorlistPoint) -> GraphcolorlistPoint {
  let n = graph_color_list_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_list_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_list_point_negate(pt : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_list_point_mid(a : GraphcolorlistPoint, b : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_list_point_lerp(a : GraphcolorlistPoint, b : GraphcolorlistPoint, t : Double) -> GraphcolorlistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_list_point_to_string(pt : GraphcolorlistPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_list_make_series(vals : Array[Double], name : String) -> GraphcolorlistSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_list_series_len(s : GraphcolorlistSeries) -> Int { s.vals.length() }

pub fn graph_color_list_series_sum(s : GraphcolorlistSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_list_series_mean(s : GraphcolorlistSeries) -> Double {
  let n = graph_color_list_series_len(s)
  if n == 0 { 0.0 } else { graph_color_list_series_sum(s) / n.to_double() }
}

pub fn graph_color_list_series_min(s : GraphcolorlistSeries) -> Double {
  let n = graph_color_list_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_list_series_max(s : GraphcolorlistSeries) -> Double {
  let n = graph_color_list_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_list_series_range(s : GraphcolorlistSeries) -> Double {
  graph_color_list_series_max(s) - graph_color_list_series_min(s)
}

pub fn graph_color_list_series_var(s : GraphcolorlistSeries) -> Double {
  let n = graph_color_list_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_color_list_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_color_list_series_std(s : GraphcolorlistSeries) -> Double { @_common.sqrt(graph_color_list_series_var(s)) }

pub fn graph_color_list_series_median(s : GraphcolorlistSeries) -> Double {
  let n = graph_color_list_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_color_list_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_list_series_scale(s : GraphcolorlistSeries, f : Double) -> GraphcolorlistSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_list_series_add(a : GraphcolorlistSeries, b : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_list_series_sub(a : GraphcolorlistSeries, b : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_list_series_normalize(s : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let mn = graph_color_list_series_min(s)
  let mx = graph_color_list_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_list_series_cumsum(s : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_list_series_to_string(s : GraphcolorlistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_list_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_list_matrix_identity(n : Int) -> GraphcolorlistMatrix {
  let m = graph_color_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_list_matrix_get(m : GraphcolorlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_list_matrix_transpose(m : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_list_matrix_add(a : GraphcolorlistMatrix, b : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_list_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_list_matrix_scale(m : GraphcolorlistMatrix, s : Double) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_list_matrix_multiply(a : GraphcolorlistMatrix, b : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if a.cols != b.rows { return graph_color_list_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_list_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_list_matrix_trace(m : GraphcolorlistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_list_matrix_det(m : GraphcolorlistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_list_matrix_norm(m : GraphcolorlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_color_list_matrix_to_string(m : GraphcolorlistMatrix) -> String {
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

pub(all) struct GraphcolorlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_list_make_vector(comps : Array[Double]) -> GraphcolorlistVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_list_vector_zero(dim : Int) -> GraphcolorlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_list_vector_add(a : GraphcolorlistVector, b : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_list_vector_sub(a : GraphcolorlistVector, b : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_list_vector_scale(v : GraphcolorlistVector, s : Double) -> GraphcolorlistVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_list_vector_dot(a : GraphcolorlistVector, b : GraphcolorlistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_list_vector_norm(v : GraphcolorlistVector) -> Double { @_common.sqrt(graph_color_list_vector_dot(v, v)) }

pub fn graph_color_list_vector_normalize(v : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = graph_color_list_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_list_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_list_vector_dist(a : GraphcolorlistVector, b : GraphcolorlistVector) -> Double {
  graph_color_list_vector_norm(graph_color_list_vector_sub(a, b))
}

pub fn graph_color_list_vector_to_string(v : GraphcolorlistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_list_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_color_list_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_color_list_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_list_std(data : Array[Double]) -> Double { @_common.sqrt(graph_color_list_var(data)) }

pub fn graph_color_list_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_color_list_mean(a); let mb = graph_color_list_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_color_list_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_color_list_std(a); let sb = graph_color_list_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_color_list_cov(a, b) / (sa * sb) }
}

pub fn graph_color_list_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_color_list_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_color_list_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_color_list_mse(pred, labels))
}

pub fn graph_color_list_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_color_list_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_color_list_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_color_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_color_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_color_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_color_list_precision(pred, labels, pos); let r = graph_color_list_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_color_list_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_color_list_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_color_list_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_color_list_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_color_list_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_color_list_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_color_list_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_color_list_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_color_list_fibonacci(n : Int) -> Int {
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

pub fn graph_color_list_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_color_list_min(data); let mx = graph_color_list_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_color_list_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_color_list_mean(data); let sd = graph_color_list_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_color_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_color_list_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_color_list_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_color_list_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_color_list_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_color_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphcolorlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_frame_make(size : Int) -> GraphcolorlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_frame_len(s : GraphcolorlistFrame) -> Int { s.size }

pub fn graph_color_list_frame_get(s : GraphcolorlistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_frame_set(s : GraphcolorlistFrame, i : Int, v : Double) -> GraphcolorlistFrame {
  let result = graph_color_list_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_frame_sum(s : GraphcolorlistFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_frame_mean(s : GraphcolorlistFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_frame_scale(s : GraphcolorlistFrame, f : Double) -> GraphcolorlistFrame {
  let result = graph_color_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_frame_add(a : GraphcolorlistFrame, b : GraphcolorlistFrame) -> GraphcolorlistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_frame_copy(s : GraphcolorlistFrame) -> GraphcolorlistFrame {
  let result = graph_color_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_frame_fill(s : GraphcolorlistFrame, v : Double) -> GraphcolorlistFrame {
  let result = graph_color_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_frame_min(s : GraphcolorlistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_frame_max(s : GraphcolorlistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_frame_to_string(s : GraphcolorlistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_table_make(size : Int) -> GraphcolorlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_table_len(s : GraphcolorlistTable) -> Int { s.size }

pub fn graph_color_list_table_get(s : GraphcolorlistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_table_set(s : GraphcolorlistTable, i : Int, v : Double) -> GraphcolorlistTable {
  let result = graph_color_list_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_table_sum(s : GraphcolorlistTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_table_mean(s : GraphcolorlistTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_table_scale(s : GraphcolorlistTable, f : Double) -> GraphcolorlistTable {
  let result = graph_color_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_table_add(a : GraphcolorlistTable, b : GraphcolorlistTable) -> GraphcolorlistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_table_copy(s : GraphcolorlistTable) -> GraphcolorlistTable {
  let result = graph_color_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_table_fill(s : GraphcolorlistTable, v : Double) -> GraphcolorlistTable {
  let result = graph_color_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_table_min(s : GraphcolorlistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_table_max(s : GraphcolorlistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_table_to_string(s : GraphcolorlistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_graphn_make(size : Int) -> GraphcolorlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_graphn_len(s : GraphcolorlistGraphN) -> Int { s.size }

pub fn graph_color_list_graphn_get(s : GraphcolorlistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_graphn_set(s : GraphcolorlistGraphN, i : Int, v : Double) -> GraphcolorlistGraphN {
  let result = graph_color_list_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_graphn_sum(s : GraphcolorlistGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_graphn_mean(s : GraphcolorlistGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_graphn_scale(s : GraphcolorlistGraphN, f : Double) -> GraphcolorlistGraphN {
  let result = graph_color_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_graphn_add(a : GraphcolorlistGraphN, b : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_graphn_copy(s : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  let result = graph_color_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_graphn_fill(s : GraphcolorlistGraphN, v : Double) -> GraphcolorlistGraphN {
  let result = graph_color_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_graphn_min(s : GraphcolorlistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_graphn_max(s : GraphcolorlistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_graphn_to_string(s : GraphcolorlistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_node_make(size : Int) -> GraphcolorlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_node_len(s : GraphcolorlistNode) -> Int { s.size }

pub fn graph_color_list_node_get(s : GraphcolorlistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_node_set(s : GraphcolorlistNode, i : Int, v : Double) -> GraphcolorlistNode {
  let result = graph_color_list_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_node_sum(s : GraphcolorlistNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_node_mean(s : GraphcolorlistNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_node_scale(s : GraphcolorlistNode, f : Double) -> GraphcolorlistNode {
  let result = graph_color_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_node_add(a : GraphcolorlistNode, b : GraphcolorlistNode) -> GraphcolorlistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_node_copy(s : GraphcolorlistNode) -> GraphcolorlistNode {
  let result = graph_color_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_node_fill(s : GraphcolorlistNode, v : Double) -> GraphcolorlistNode {
  let result = graph_color_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_node_min(s : GraphcolorlistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_node_max(s : GraphcolorlistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_node_to_string(s : GraphcolorlistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_edge_make(size : Int) -> GraphcolorlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_edge_len(s : GraphcolorlistEdge) -> Int { s.size }

pub fn graph_color_list_edge_get(s : GraphcolorlistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_edge_set(s : GraphcolorlistEdge, i : Int, v : Double) -> GraphcolorlistEdge {
  let result = graph_color_list_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_edge_sum(s : GraphcolorlistEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_edge_mean(s : GraphcolorlistEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_edge_scale(s : GraphcolorlistEdge, f : Double) -> GraphcolorlistEdge {
  let result = graph_color_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_edge_add(a : GraphcolorlistEdge, b : GraphcolorlistEdge) -> GraphcolorlistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_edge_copy(s : GraphcolorlistEdge) -> GraphcolorlistEdge {
  let result = graph_color_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_edge_fill(s : GraphcolorlistEdge, v : Double) -> GraphcolorlistEdge {
  let result = graph_color_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_edge_min(s : GraphcolorlistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_edge_max(s : GraphcolorlistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_edge_to_string(s : GraphcolorlistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_path_make(size : Int) -> GraphcolorlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_path_len(s : GraphcolorlistPath) -> Int { s.size }

pub fn graph_color_list_path_get(s : GraphcolorlistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_path_set(s : GraphcolorlistPath, i : Int, v : Double) -> GraphcolorlistPath {
  let result = graph_color_list_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_path_sum(s : GraphcolorlistPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_path_mean(s : GraphcolorlistPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_path_scale(s : GraphcolorlistPath, f : Double) -> GraphcolorlistPath {
  let result = graph_color_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_path_add(a : GraphcolorlistPath, b : GraphcolorlistPath) -> GraphcolorlistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_path_copy(s : GraphcolorlistPath) -> GraphcolorlistPath {
  let result = graph_color_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_path_fill(s : GraphcolorlistPath, v : Double) -> GraphcolorlistPath {
  let result = graph_color_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_path_min(s : GraphcolorlistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_path_max(s : GraphcolorlistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_path_to_string(s : GraphcolorlistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cluster_make(size : Int) -> GraphcolorlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cluster_len(s : GraphcolorlistCluster) -> Int { s.size }

pub fn graph_color_list_cluster_get(s : GraphcolorlistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cluster_set(s : GraphcolorlistCluster, i : Int, v : Double) -> GraphcolorlistCluster {
  let result = graph_color_list_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_cluster_sum(s : GraphcolorlistCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_cluster_mean(s : GraphcolorlistCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_cluster_scale(s : GraphcolorlistCluster, f : Double) -> GraphcolorlistCluster {
  let result = graph_color_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_cluster_add(a : GraphcolorlistCluster, b : GraphcolorlistCluster) -> GraphcolorlistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_cluster_copy(s : GraphcolorlistCluster) -> GraphcolorlistCluster {
  let result = graph_color_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_cluster_fill(s : GraphcolorlistCluster, v : Double) -> GraphcolorlistCluster {
  let result = graph_color_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_cluster_min(s : GraphcolorlistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_cluster_max(s : GraphcolorlistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_cluster_to_string(s : GraphcolorlistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_model_make(size : Int) -> GraphcolorlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_model_len(s : GraphcolorlistModel) -> Int { s.size }

pub fn graph_color_list_model_get(s : GraphcolorlistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_model_set(s : GraphcolorlistModel, i : Int, v : Double) -> GraphcolorlistModel {
  let result = graph_color_list_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_model_sum(s : GraphcolorlistModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_model_mean(s : GraphcolorlistModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_model_scale(s : GraphcolorlistModel, f : Double) -> GraphcolorlistModel {
  let result = graph_color_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_model_add(a : GraphcolorlistModel, b : GraphcolorlistModel) -> GraphcolorlistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_model_copy(s : GraphcolorlistModel) -> GraphcolorlistModel {
  let result = graph_color_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_model_fill(s : GraphcolorlistModel, v : Double) -> GraphcolorlistModel {
  let result = graph_color_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_model_min(s : GraphcolorlistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_model_max(s : GraphcolorlistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_model_to_string(s : GraphcolorlistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_layer_make(size : Int) -> GraphcolorlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_layer_len(s : GraphcolorlistLayer) -> Int { s.size }

pub fn graph_color_list_layer_get(s : GraphcolorlistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_layer_set(s : GraphcolorlistLayer, i : Int, v : Double) -> GraphcolorlistLayer {
  let result = graph_color_list_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_layer_sum(s : GraphcolorlistLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_layer_mean(s : GraphcolorlistLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_layer_scale(s : GraphcolorlistLayer, f : Double) -> GraphcolorlistLayer {
  let result = graph_color_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_layer_add(a : GraphcolorlistLayer, b : GraphcolorlistLayer) -> GraphcolorlistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_layer_copy(s : GraphcolorlistLayer) -> GraphcolorlistLayer {
  let result = graph_color_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_layer_fill(s : GraphcolorlistLayer, v : Double) -> GraphcolorlistLayer {
  let result = graph_color_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_layer_min(s : GraphcolorlistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_layer_max(s : GraphcolorlistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_layer_to_string(s : GraphcolorlistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_buffer_make(size : Int) -> GraphcolorlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_buffer_len(s : GraphcolorlistBuffer) -> Int { s.size }

pub fn graph_color_list_buffer_get(s : GraphcolorlistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_buffer_set(s : GraphcolorlistBuffer, i : Int, v : Double) -> GraphcolorlistBuffer {
  let result = graph_color_list_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_buffer_sum(s : GraphcolorlistBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_buffer_mean(s : GraphcolorlistBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_buffer_scale(s : GraphcolorlistBuffer, f : Double) -> GraphcolorlistBuffer {
  let result = graph_color_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_buffer_add(a : GraphcolorlistBuffer, b : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_buffer_copy(s : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  let result = graph_color_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_buffer_fill(s : GraphcolorlistBuffer, v : Double) -> GraphcolorlistBuffer {
  let result = graph_color_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_buffer_min(s : GraphcolorlistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_buffer_max(s : GraphcolorlistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_buffer_to_string(s : GraphcolorlistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cursor_make(size : Int) -> GraphcolorlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cursor_len(s : GraphcolorlistCursor) -> Int { s.size }

pub fn graph_color_list_cursor_get(s : GraphcolorlistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cursor_set(s : GraphcolorlistCursor, i : Int, v : Double) -> GraphcolorlistCursor {
  let result = graph_color_list_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_cursor_sum(s : GraphcolorlistCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_cursor_mean(s : GraphcolorlistCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_cursor_scale(s : GraphcolorlistCursor, f : Double) -> GraphcolorlistCursor {
  let result = graph_color_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_cursor_add(a : GraphcolorlistCursor, b : GraphcolorlistCursor) -> GraphcolorlistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_cursor_copy(s : GraphcolorlistCursor) -> GraphcolorlistCursor {
  let result = graph_color_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_cursor_fill(s : GraphcolorlistCursor, v : Double) -> GraphcolorlistCursor {
  let result = graph_color_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_cursor_min(s : GraphcolorlistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_cursor_max(s : GraphcolorlistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_cursor_to_string(s : GraphcolorlistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_view_make(size : Int) -> GraphcolorlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_view_len(s : GraphcolorlistView) -> Int { s.size }

pub fn graph_color_list_view_get(s : GraphcolorlistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_view_set(s : GraphcolorlistView, i : Int, v : Double) -> GraphcolorlistView {
  let result = graph_color_list_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_view_sum(s : GraphcolorlistView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_view_mean(s : GraphcolorlistView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_view_scale(s : GraphcolorlistView, f : Double) -> GraphcolorlistView {
  let result = graph_color_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_view_add(a : GraphcolorlistView, b : GraphcolorlistView) -> GraphcolorlistView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_view_copy(s : GraphcolorlistView) -> GraphcolorlistView {
  let result = graph_color_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_view_fill(s : GraphcolorlistView, v : Double) -> GraphcolorlistView {
  let result = graph_color_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_view_min(s : GraphcolorlistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_view_max(s : GraphcolorlistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_view_to_string(s : GraphcolorlistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_range_make(size : Int) -> GraphcolorlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_range_len(s : GraphcolorlistRange) -> Int { s.size }

pub fn graph_color_list_range_get(s : GraphcolorlistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_range_set(s : GraphcolorlistRange, i : Int, v : Double) -> GraphcolorlistRange {
  let result = graph_color_list_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_range_sum(s : GraphcolorlistRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_range_mean(s : GraphcolorlistRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_range_scale(s : GraphcolorlistRange, f : Double) -> GraphcolorlistRange {
  let result = graph_color_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_range_add(a : GraphcolorlistRange, b : GraphcolorlistRange) -> GraphcolorlistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_range_copy(s : GraphcolorlistRange) -> GraphcolorlistRange {
  let result = graph_color_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_range_fill(s : GraphcolorlistRange, v : Double) -> GraphcolorlistRange {
  let result = graph_color_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_range_min(s : GraphcolorlistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_range_max(s : GraphcolorlistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_range_to_string(s : GraphcolorlistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_slice_make(size : Int) -> GraphcolorlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_slice_len(s : GraphcolorlistSlice) -> Int { s.size }

pub fn graph_color_list_slice_get(s : GraphcolorlistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_slice_set(s : GraphcolorlistSlice, i : Int, v : Double) -> GraphcolorlistSlice {
  let result = graph_color_list_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_slice_sum(s : GraphcolorlistSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_list_slice_mean(s : GraphcolorlistSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_list_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_list_slice_scale(s : GraphcolorlistSlice, f : Double) -> GraphcolorlistSlice {
  let result = graph_color_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_list_slice_add(a : GraphcolorlistSlice, b : GraphcolorlistSlice) -> GraphcolorlistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_list_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_list_slice_copy(s : GraphcolorlistSlice) -> GraphcolorlistSlice {
  let result = graph_color_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_list_slice_fill(s : GraphcolorlistSlice, v : Double) -> GraphcolorlistSlice {
  let result = graph_color_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_list_slice_min(s : GraphcolorlistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_slice_max(s : GraphcolorlistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_list_slice_to_string(s : GraphcolorlistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


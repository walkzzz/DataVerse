///===
/// extcore/graph_tree_isomorphism

pub(all) struct GraphtreeisomorphismPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_isomorphism_make_point(x : Double, y : Double) -> GraphtreeisomorphismPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_isomorphism_make_point3(x : Double, y : Double, z : Double) -> GraphtreeisomorphismPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_isomorphism_point_x(pt : GraphtreeisomorphismPoint) -> Double { pt.x }

pub fn graph_tree_isomorphism_point_y(pt : GraphtreeisomorphismPoint) -> Double { pt.y }

pub fn graph_tree_isomorphism_point_z(pt : GraphtreeisomorphismPoint) -> Double { pt.z }

pub fn graph_tree_isomorphism_point_label(pt : GraphtreeisomorphismPoint) -> Int { pt.label }

pub fn graph_tree_isomorphism_point_dist(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_tree_isomorphism_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_isomorphism_point_add(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_isomorphism_point_sub(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_isomorphism_point_scale(pt : GraphtreeisomorphismPoint, s : Double) -> GraphtreeisomorphismPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_isomorphism_point_dot(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_isomorphism_point_cross(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_isomorphism_point_norm(pt : GraphtreeisomorphismPoint) -> Double {
  graph_tree_isomorphism_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_isomorphism_point_normalize(pt : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  let n = graph_tree_isomorphism_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_isomorphism_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_isomorphism_point_negate(pt : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_isomorphism_point_mid(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint) -> GraphtreeisomorphismPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_isomorphism_point_lerp(a : GraphtreeisomorphismPoint, b : GraphtreeisomorphismPoint, t : Double) -> GraphtreeisomorphismPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_isomorphism_point_to_string(pt : GraphtreeisomorphismPoint) -> String {
  "(" + graph_tree_isomorphism_dbl(pt.x) + ", " + graph_tree_isomorphism_dbl(pt.y) + ", " + graph_tree_isomorphism_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_isomorphism_make_series(vals : Array[Double], name : String) -> GraphtreeisomorphismSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_isomorphism_series_len(s : GraphtreeisomorphismSeries) -> Int { s.vals.length() }

pub fn graph_tree_isomorphism_series_sum(s : GraphtreeisomorphismSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_isomorphism_series_mean(s : GraphtreeisomorphismSeries) -> Double {
  let n = graph_tree_isomorphism_series_len(s)
  if n == 0 { 0.0 } else { graph_tree_isomorphism_series_sum(s) / n.to_double() }
}

pub fn graph_tree_isomorphism_series_min(s : GraphtreeisomorphismSeries) -> Double {
  let n = graph_tree_isomorphism_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_series_max(s : GraphtreeisomorphismSeries) -> Double {
  let n = graph_tree_isomorphism_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_series_range(s : GraphtreeisomorphismSeries) -> Double {
  graph_tree_isomorphism_series_max(s) - graph_tree_isomorphism_series_min(s)
}

pub fn graph_tree_isomorphism_series_var(s : GraphtreeisomorphismSeries) -> Double {
  let n = graph_tree_isomorphism_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_tree_isomorphism_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_tree_isomorphism_series_std(s : GraphtreeisomorphismSeries) -> Double { graph_tree_isomorphism_sqrt(graph_tree_isomorphism_series_var(s)) }

pub fn graph_tree_isomorphism_series_median(s : GraphtreeisomorphismSeries) -> Double {
  let n = graph_tree_isomorphism_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_isomorphism_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_isomorphism_series_scale(s : GraphtreeisomorphismSeries, f : Double) -> GraphtreeisomorphismSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_tree_isomorphism_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_isomorphism_series_add(a : GraphtreeisomorphismSeries, b : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_isomorphism_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_isomorphism_series_sub(a : GraphtreeisomorphismSeries, b : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_isomorphism_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_isomorphism_series_normalize(s : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  let mn = graph_tree_isomorphism_series_min(s)
  let mx = graph_tree_isomorphism_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_tree_isomorphism_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_isomorphism_series_cumsum(s : GraphtreeisomorphismSeries) -> GraphtreeisomorphismSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_tree_isomorphism_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_isomorphism_series_to_string(s : GraphtreeisomorphismSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_isomorphism_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeisomorphismMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_isomorphism_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreeisomorphismMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_isomorphism_matrix_identity(n : Int) -> GraphtreeisomorphismMatrix {
  let m = graph_tree_isomorphism_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_isomorphism_matrix_get(m : GraphtreeisomorphismMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_isomorphism_matrix_transpose(m : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_isomorphism_matrix_add(a : GraphtreeisomorphismMatrix, b : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_isomorphism_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_isomorphism_matrix_scale(m : GraphtreeisomorphismMatrix, s : Double) -> GraphtreeisomorphismMatrix {
  let result = graph_tree_isomorphism_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_isomorphism_matrix_multiply(a : GraphtreeisomorphismMatrix, b : GraphtreeisomorphismMatrix) -> GraphtreeisomorphismMatrix {
  if a.cols != b.rows { return graph_tree_isomorphism_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_isomorphism_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_isomorphism_matrix_trace(m : GraphtreeisomorphismMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_isomorphism_matrix_det(m : GraphtreeisomorphismMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_isomorphism_matrix_norm(m : GraphtreeisomorphismMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_tree_isomorphism_sqrt(sum)
}

pub fn graph_tree_isomorphism_matrix_to_string(m : GraphtreeisomorphismMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_tree_isomorphism_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphtreeisomorphismVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_isomorphism_make_vector(comps : Array[Double]) -> GraphtreeisomorphismVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_isomorphism_vector_zero(dim : Int) -> GraphtreeisomorphismVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_isomorphism_vector_add(a : GraphtreeisomorphismVector, b : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_isomorphism_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_isomorphism_vector_sub(a : GraphtreeisomorphismVector, b : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_isomorphism_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_isomorphism_vector_scale(v : GraphtreeisomorphismVector, s : Double) -> GraphtreeisomorphismVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_tree_isomorphism_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_isomorphism_vector_dot(a : GraphtreeisomorphismVector, b : GraphtreeisomorphismVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_isomorphism_vector_norm(v : GraphtreeisomorphismVector) -> Double { graph_tree_isomorphism_sqrt(graph_tree_isomorphism_vector_dot(v, v)) }

pub fn graph_tree_isomorphism_vector_normalize(v : GraphtreeisomorphismVector) -> GraphtreeisomorphismVector {
  let n = graph_tree_isomorphism_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_isomorphism_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_isomorphism_vector_dist(a : GraphtreeisomorphismVector, b : GraphtreeisomorphismVector) -> Double {
  graph_tree_isomorphism_vector_norm(graph_tree_isomorphism_vector_sub(a, b))
}

pub fn graph_tree_isomorphism_vector_to_string(v : GraphtreeisomorphismVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_isomorphism_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_isomorphism_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_tree_isomorphism_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_tree_isomorphism_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_isomorphism_std(data : Array[Double]) -> Double { graph_tree_isomorphism_sqrt(graph_tree_isomorphism_var(data)) }

pub fn graph_tree_isomorphism_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_tree_isomorphism_mean(a); let mb = graph_tree_isomorphism_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_tree_isomorphism_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_tree_isomorphism_std(a); let sb = graph_tree_isomorphism_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_tree_isomorphism_cov(a, b) / (sa * sb) }
}

pub fn graph_tree_isomorphism_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_isomorphism_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_isomorphism_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_tree_isomorphism_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_isomorphism_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_tree_isomorphism_sqrt(graph_tree_isomorphism_mse(pred, labels))
}

pub fn graph_tree_isomorphism_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_tree_isomorphism_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_tree_isomorphism_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_tree_isomorphism_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_tree_isomorphism_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_tree_isomorphism_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_tree_isomorphism_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_tree_isomorphism_precision(pred, labels, pos); let r = graph_tree_isomorphism_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_tree_isomorphism_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_tree_isomorphism_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_tree_isomorphism_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_tree_isomorphism_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_tree_isomorphism_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_tree_isomorphism_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_tree_isomorphism_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_tree_isomorphism_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_tree_isomorphism_fibonacci(n : Int) -> Int {
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

pub fn graph_tree_isomorphism_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_tree_isomorphism_min(data); let mx = graph_tree_isomorphism_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_tree_isomorphism_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_tree_isomorphism_mean(data); let sd = graph_tree_isomorphism_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_tree_isomorphism_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_tree_isomorphism_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_tree_isomorphism_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_tree_isomorphism_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_tree_isomorphism_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_tree_isomorphism_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_tree_isomorphism_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_tree_isomorphism_int(x) } else { -graph_tree_isomorphism_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_tree_isomorphism_int(f * 1000000.0) } else { graph_tree_isomorphism_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_tree_isomorphism_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_tree_isomorphism_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphtreeisomorphismFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_frame_make(size : Int) -> GraphtreeisomorphismFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_frame_len(s : GraphtreeisomorphismFrame) -> Int { s.size }

pub fn graph_tree_isomorphism_frame_get(s : GraphtreeisomorphismFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_frame_set(s : GraphtreeisomorphismFrame, i : Int, v : Double) -> GraphtreeisomorphismFrame {
  let result = graph_tree_isomorphism_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_frame_sum(s : GraphtreeisomorphismFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_frame_mean(s : GraphtreeisomorphismFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_frame_scale(s : GraphtreeisomorphismFrame, f : Double) -> GraphtreeisomorphismFrame {
  let result = graph_tree_isomorphism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_frame_add(a : GraphtreeisomorphismFrame, b : GraphtreeisomorphismFrame) -> GraphtreeisomorphismFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_frame_copy(s : GraphtreeisomorphismFrame) -> GraphtreeisomorphismFrame {
  let result = graph_tree_isomorphism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_frame_fill(s : GraphtreeisomorphismFrame, v : Double) -> GraphtreeisomorphismFrame {
  let result = graph_tree_isomorphism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_frame_min(s : GraphtreeisomorphismFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_frame_max(s : GraphtreeisomorphismFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_frame_to_string(s : GraphtreeisomorphismFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_table_make(size : Int) -> GraphtreeisomorphismTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_table_len(s : GraphtreeisomorphismTable) -> Int { s.size }

pub fn graph_tree_isomorphism_table_get(s : GraphtreeisomorphismTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_table_set(s : GraphtreeisomorphismTable, i : Int, v : Double) -> GraphtreeisomorphismTable {
  let result = graph_tree_isomorphism_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_table_sum(s : GraphtreeisomorphismTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_table_mean(s : GraphtreeisomorphismTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_table_scale(s : GraphtreeisomorphismTable, f : Double) -> GraphtreeisomorphismTable {
  let result = graph_tree_isomorphism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_table_add(a : GraphtreeisomorphismTable, b : GraphtreeisomorphismTable) -> GraphtreeisomorphismTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_table_copy(s : GraphtreeisomorphismTable) -> GraphtreeisomorphismTable {
  let result = graph_tree_isomorphism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_table_fill(s : GraphtreeisomorphismTable, v : Double) -> GraphtreeisomorphismTable {
  let result = graph_tree_isomorphism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_table_min(s : GraphtreeisomorphismTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_table_max(s : GraphtreeisomorphismTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_table_to_string(s : GraphtreeisomorphismTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_graphn_make(size : Int) -> GraphtreeisomorphismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_graphn_len(s : GraphtreeisomorphismGraphN) -> Int { s.size }

pub fn graph_tree_isomorphism_graphn_get(s : GraphtreeisomorphismGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_graphn_set(s : GraphtreeisomorphismGraphN, i : Int, v : Double) -> GraphtreeisomorphismGraphN {
  let result = graph_tree_isomorphism_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_graphn_sum(s : GraphtreeisomorphismGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_graphn_mean(s : GraphtreeisomorphismGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_graphn_scale(s : GraphtreeisomorphismGraphN, f : Double) -> GraphtreeisomorphismGraphN {
  let result = graph_tree_isomorphism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_graphn_add(a : GraphtreeisomorphismGraphN, b : GraphtreeisomorphismGraphN) -> GraphtreeisomorphismGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_graphn_copy(s : GraphtreeisomorphismGraphN) -> GraphtreeisomorphismGraphN {
  let result = graph_tree_isomorphism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_graphn_fill(s : GraphtreeisomorphismGraphN, v : Double) -> GraphtreeisomorphismGraphN {
  let result = graph_tree_isomorphism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_graphn_min(s : GraphtreeisomorphismGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_graphn_max(s : GraphtreeisomorphismGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_graphn_to_string(s : GraphtreeisomorphismGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_node_make(size : Int) -> GraphtreeisomorphismNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_node_len(s : GraphtreeisomorphismNode) -> Int { s.size }

pub fn graph_tree_isomorphism_node_get(s : GraphtreeisomorphismNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_node_set(s : GraphtreeisomorphismNode, i : Int, v : Double) -> GraphtreeisomorphismNode {
  let result = graph_tree_isomorphism_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_node_sum(s : GraphtreeisomorphismNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_node_mean(s : GraphtreeisomorphismNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_node_scale(s : GraphtreeisomorphismNode, f : Double) -> GraphtreeisomorphismNode {
  let result = graph_tree_isomorphism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_node_add(a : GraphtreeisomorphismNode, b : GraphtreeisomorphismNode) -> GraphtreeisomorphismNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_node_copy(s : GraphtreeisomorphismNode) -> GraphtreeisomorphismNode {
  let result = graph_tree_isomorphism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_node_fill(s : GraphtreeisomorphismNode, v : Double) -> GraphtreeisomorphismNode {
  let result = graph_tree_isomorphism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_node_min(s : GraphtreeisomorphismNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_node_max(s : GraphtreeisomorphismNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_node_to_string(s : GraphtreeisomorphismNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_edge_make(size : Int) -> GraphtreeisomorphismEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_edge_len(s : GraphtreeisomorphismEdge) -> Int { s.size }

pub fn graph_tree_isomorphism_edge_get(s : GraphtreeisomorphismEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_edge_set(s : GraphtreeisomorphismEdge, i : Int, v : Double) -> GraphtreeisomorphismEdge {
  let result = graph_tree_isomorphism_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_edge_sum(s : GraphtreeisomorphismEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_edge_mean(s : GraphtreeisomorphismEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_edge_scale(s : GraphtreeisomorphismEdge, f : Double) -> GraphtreeisomorphismEdge {
  let result = graph_tree_isomorphism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_edge_add(a : GraphtreeisomorphismEdge, b : GraphtreeisomorphismEdge) -> GraphtreeisomorphismEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_edge_copy(s : GraphtreeisomorphismEdge) -> GraphtreeisomorphismEdge {
  let result = graph_tree_isomorphism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_edge_fill(s : GraphtreeisomorphismEdge, v : Double) -> GraphtreeisomorphismEdge {
  let result = graph_tree_isomorphism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_edge_min(s : GraphtreeisomorphismEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_edge_max(s : GraphtreeisomorphismEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_edge_to_string(s : GraphtreeisomorphismEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_path_make(size : Int) -> GraphtreeisomorphismPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_path_len(s : GraphtreeisomorphismPath) -> Int { s.size }

pub fn graph_tree_isomorphism_path_get(s : GraphtreeisomorphismPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_path_set(s : GraphtreeisomorphismPath, i : Int, v : Double) -> GraphtreeisomorphismPath {
  let result = graph_tree_isomorphism_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_path_sum(s : GraphtreeisomorphismPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_path_mean(s : GraphtreeisomorphismPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_path_scale(s : GraphtreeisomorphismPath, f : Double) -> GraphtreeisomorphismPath {
  let result = graph_tree_isomorphism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_path_add(a : GraphtreeisomorphismPath, b : GraphtreeisomorphismPath) -> GraphtreeisomorphismPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_path_copy(s : GraphtreeisomorphismPath) -> GraphtreeisomorphismPath {
  let result = graph_tree_isomorphism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_path_fill(s : GraphtreeisomorphismPath, v : Double) -> GraphtreeisomorphismPath {
  let result = graph_tree_isomorphism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_path_min(s : GraphtreeisomorphismPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_path_max(s : GraphtreeisomorphismPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_path_to_string(s : GraphtreeisomorphismPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_cluster_make(size : Int) -> GraphtreeisomorphismCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_cluster_len(s : GraphtreeisomorphismCluster) -> Int { s.size }

pub fn graph_tree_isomorphism_cluster_get(s : GraphtreeisomorphismCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_cluster_set(s : GraphtreeisomorphismCluster, i : Int, v : Double) -> GraphtreeisomorphismCluster {
  let result = graph_tree_isomorphism_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_cluster_sum(s : GraphtreeisomorphismCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_cluster_mean(s : GraphtreeisomorphismCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_cluster_scale(s : GraphtreeisomorphismCluster, f : Double) -> GraphtreeisomorphismCluster {
  let result = graph_tree_isomorphism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_cluster_add(a : GraphtreeisomorphismCluster, b : GraphtreeisomorphismCluster) -> GraphtreeisomorphismCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_cluster_copy(s : GraphtreeisomorphismCluster) -> GraphtreeisomorphismCluster {
  let result = graph_tree_isomorphism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_cluster_fill(s : GraphtreeisomorphismCluster, v : Double) -> GraphtreeisomorphismCluster {
  let result = graph_tree_isomorphism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_cluster_min(s : GraphtreeisomorphismCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_cluster_max(s : GraphtreeisomorphismCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_cluster_to_string(s : GraphtreeisomorphismCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_model_make(size : Int) -> GraphtreeisomorphismModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_model_len(s : GraphtreeisomorphismModel) -> Int { s.size }

pub fn graph_tree_isomorphism_model_get(s : GraphtreeisomorphismModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_model_set(s : GraphtreeisomorphismModel, i : Int, v : Double) -> GraphtreeisomorphismModel {
  let result = graph_tree_isomorphism_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_model_sum(s : GraphtreeisomorphismModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_model_mean(s : GraphtreeisomorphismModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_model_scale(s : GraphtreeisomorphismModel, f : Double) -> GraphtreeisomorphismModel {
  let result = graph_tree_isomorphism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_model_add(a : GraphtreeisomorphismModel, b : GraphtreeisomorphismModel) -> GraphtreeisomorphismModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_model_copy(s : GraphtreeisomorphismModel) -> GraphtreeisomorphismModel {
  let result = graph_tree_isomorphism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_model_fill(s : GraphtreeisomorphismModel, v : Double) -> GraphtreeisomorphismModel {
  let result = graph_tree_isomorphism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_model_min(s : GraphtreeisomorphismModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_model_max(s : GraphtreeisomorphismModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_model_to_string(s : GraphtreeisomorphismModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_layer_make(size : Int) -> GraphtreeisomorphismLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_layer_len(s : GraphtreeisomorphismLayer) -> Int { s.size }

pub fn graph_tree_isomorphism_layer_get(s : GraphtreeisomorphismLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_layer_set(s : GraphtreeisomorphismLayer, i : Int, v : Double) -> GraphtreeisomorphismLayer {
  let result = graph_tree_isomorphism_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_layer_sum(s : GraphtreeisomorphismLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_layer_mean(s : GraphtreeisomorphismLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_layer_scale(s : GraphtreeisomorphismLayer, f : Double) -> GraphtreeisomorphismLayer {
  let result = graph_tree_isomorphism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_layer_add(a : GraphtreeisomorphismLayer, b : GraphtreeisomorphismLayer) -> GraphtreeisomorphismLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_layer_copy(s : GraphtreeisomorphismLayer) -> GraphtreeisomorphismLayer {
  let result = graph_tree_isomorphism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_layer_fill(s : GraphtreeisomorphismLayer, v : Double) -> GraphtreeisomorphismLayer {
  let result = graph_tree_isomorphism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_layer_min(s : GraphtreeisomorphismLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_layer_max(s : GraphtreeisomorphismLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_layer_to_string(s : GraphtreeisomorphismLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_buffer_make(size : Int) -> GraphtreeisomorphismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_buffer_len(s : GraphtreeisomorphismBuffer) -> Int { s.size }

pub fn graph_tree_isomorphism_buffer_get(s : GraphtreeisomorphismBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_buffer_set(s : GraphtreeisomorphismBuffer, i : Int, v : Double) -> GraphtreeisomorphismBuffer {
  let result = graph_tree_isomorphism_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_buffer_sum(s : GraphtreeisomorphismBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_buffer_mean(s : GraphtreeisomorphismBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_buffer_scale(s : GraphtreeisomorphismBuffer, f : Double) -> GraphtreeisomorphismBuffer {
  let result = graph_tree_isomorphism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_buffer_add(a : GraphtreeisomorphismBuffer, b : GraphtreeisomorphismBuffer) -> GraphtreeisomorphismBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_buffer_copy(s : GraphtreeisomorphismBuffer) -> GraphtreeisomorphismBuffer {
  let result = graph_tree_isomorphism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_buffer_fill(s : GraphtreeisomorphismBuffer, v : Double) -> GraphtreeisomorphismBuffer {
  let result = graph_tree_isomorphism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_buffer_min(s : GraphtreeisomorphismBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_buffer_max(s : GraphtreeisomorphismBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_buffer_to_string(s : GraphtreeisomorphismBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_cursor_make(size : Int) -> GraphtreeisomorphismCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_cursor_len(s : GraphtreeisomorphismCursor) -> Int { s.size }

pub fn graph_tree_isomorphism_cursor_get(s : GraphtreeisomorphismCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_cursor_set(s : GraphtreeisomorphismCursor, i : Int, v : Double) -> GraphtreeisomorphismCursor {
  let result = graph_tree_isomorphism_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_cursor_sum(s : GraphtreeisomorphismCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_cursor_mean(s : GraphtreeisomorphismCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_cursor_scale(s : GraphtreeisomorphismCursor, f : Double) -> GraphtreeisomorphismCursor {
  let result = graph_tree_isomorphism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_cursor_add(a : GraphtreeisomorphismCursor, b : GraphtreeisomorphismCursor) -> GraphtreeisomorphismCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_cursor_copy(s : GraphtreeisomorphismCursor) -> GraphtreeisomorphismCursor {
  let result = graph_tree_isomorphism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_cursor_fill(s : GraphtreeisomorphismCursor, v : Double) -> GraphtreeisomorphismCursor {
  let result = graph_tree_isomorphism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_cursor_min(s : GraphtreeisomorphismCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_cursor_max(s : GraphtreeisomorphismCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_cursor_to_string(s : GraphtreeisomorphismCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_view_make(size : Int) -> GraphtreeisomorphismView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_view_len(s : GraphtreeisomorphismView) -> Int { s.size }

pub fn graph_tree_isomorphism_view_get(s : GraphtreeisomorphismView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_view_set(s : GraphtreeisomorphismView, i : Int, v : Double) -> GraphtreeisomorphismView {
  let result = graph_tree_isomorphism_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_view_sum(s : GraphtreeisomorphismView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_view_mean(s : GraphtreeisomorphismView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_view_scale(s : GraphtreeisomorphismView, f : Double) -> GraphtreeisomorphismView {
  let result = graph_tree_isomorphism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_view_add(a : GraphtreeisomorphismView, b : GraphtreeisomorphismView) -> GraphtreeisomorphismView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_view_copy(s : GraphtreeisomorphismView) -> GraphtreeisomorphismView {
  let result = graph_tree_isomorphism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_view_fill(s : GraphtreeisomorphismView, v : Double) -> GraphtreeisomorphismView {
  let result = graph_tree_isomorphism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_view_min(s : GraphtreeisomorphismView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_view_max(s : GraphtreeisomorphismView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_view_to_string(s : GraphtreeisomorphismView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_range_make(size : Int) -> GraphtreeisomorphismRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_range_len(s : GraphtreeisomorphismRange) -> Int { s.size }

pub fn graph_tree_isomorphism_range_get(s : GraphtreeisomorphismRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_range_set(s : GraphtreeisomorphismRange, i : Int, v : Double) -> GraphtreeisomorphismRange {
  let result = graph_tree_isomorphism_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_range_sum(s : GraphtreeisomorphismRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_range_mean(s : GraphtreeisomorphismRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_range_scale(s : GraphtreeisomorphismRange, f : Double) -> GraphtreeisomorphismRange {
  let result = graph_tree_isomorphism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_range_add(a : GraphtreeisomorphismRange, b : GraphtreeisomorphismRange) -> GraphtreeisomorphismRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_range_copy(s : GraphtreeisomorphismRange) -> GraphtreeisomorphismRange {
  let result = graph_tree_isomorphism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_range_fill(s : GraphtreeisomorphismRange, v : Double) -> GraphtreeisomorphismRange {
  let result = graph_tree_isomorphism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_range_min(s : GraphtreeisomorphismRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_range_max(s : GraphtreeisomorphismRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_range_to_string(s : GraphtreeisomorphismRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeisomorphismSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_isomorphism_slice_make(size : Int) -> GraphtreeisomorphismSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_isomorphism_slice_len(s : GraphtreeisomorphismSlice) -> Int { s.size }

pub fn graph_tree_isomorphism_slice_get(s : GraphtreeisomorphismSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_isomorphism_slice_set(s : GraphtreeisomorphismSlice, i : Int, v : Double) -> GraphtreeisomorphismSlice {
  let result = graph_tree_isomorphism_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_slice_sum(s : GraphtreeisomorphismSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_isomorphism_slice_mean(s : GraphtreeisomorphismSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_isomorphism_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_isomorphism_slice_scale(s : GraphtreeisomorphismSlice, f : Double) -> GraphtreeisomorphismSlice {
  let result = graph_tree_isomorphism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_isomorphism_slice_add(a : GraphtreeisomorphismSlice, b : GraphtreeisomorphismSlice) -> GraphtreeisomorphismSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_isomorphism_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_isomorphism_slice_copy(s : GraphtreeisomorphismSlice) -> GraphtreeisomorphismSlice {
  let result = graph_tree_isomorphism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_isomorphism_slice_fill(s : GraphtreeisomorphismSlice, v : Double) -> GraphtreeisomorphismSlice {
  let result = graph_tree_isomorphism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_isomorphism_slice_min(s : GraphtreeisomorphismSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_slice_max(s : GraphtreeisomorphismSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_isomorphism_slice_to_string(s : GraphtreeisomorphismSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_tree_isomorphism_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_isomorphism_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


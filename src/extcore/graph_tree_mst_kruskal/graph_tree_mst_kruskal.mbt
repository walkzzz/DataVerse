///===
/// extcore/graph_tree_mst_kruskal

pub(all) struct GraphtreemstkruskalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_kruskal_make_point(x : Double, y : Double) -> GraphtreemstkruskalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_kruskal_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstkruskalPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_mst_kruskal_point_x(pt : GraphtreemstkruskalPoint) -> Double { pt.x }

pub fn graph_tree_mst_kruskal_point_y(pt : GraphtreemstkruskalPoint) -> Double { pt.y }

pub fn graph_tree_mst_kruskal_point_z(pt : GraphtreemstkruskalPoint) -> Double { pt.z }

pub fn graph_tree_mst_kruskal_point_label(pt : GraphtreemstkruskalPoint) -> Int { pt.label }

pub fn graph_tree_mst_kruskal_point_dist(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_tree_mst_kruskal_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_mst_kruskal_point_add(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_mst_kruskal_point_sub(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_mst_kruskal_point_scale(pt : GraphtreemstkruskalPoint, s : Double) -> GraphtreemstkruskalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_mst_kruskal_point_dot(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_mst_kruskal_point_cross(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_mst_kruskal_point_norm(pt : GraphtreemstkruskalPoint) -> Double {
  graph_tree_mst_kruskal_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_mst_kruskal_point_normalize(pt : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  let n = graph_tree_mst_kruskal_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_mst_kruskal_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_mst_kruskal_point_negate(pt : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_mst_kruskal_point_mid(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint) -> GraphtreemstkruskalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_mst_kruskal_point_lerp(a : GraphtreemstkruskalPoint, b : GraphtreemstkruskalPoint, t : Double) -> GraphtreemstkruskalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_mst_kruskal_point_to_string(pt : GraphtreemstkruskalPoint) -> String {
  "(" + graph_tree_mst_kruskal_dbl(pt.x) + ", " + graph_tree_mst_kruskal_dbl(pt.y) + ", " + graph_tree_mst_kruskal_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_kruskal_make_series(vals : Array[Double], name : String) -> GraphtreemstkruskalSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_mst_kruskal_series_len(s : GraphtreemstkruskalSeries) -> Int { s.vals.length() }

pub fn graph_tree_mst_kruskal_series_sum(s : GraphtreemstkruskalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_mst_kruskal_series_mean(s : GraphtreemstkruskalSeries) -> Double {
  let n = graph_tree_mst_kruskal_series_len(s)
  if n == 0 { 0.0 } else { graph_tree_mst_kruskal_series_sum(s) / n.to_double() }
}

pub fn graph_tree_mst_kruskal_series_min(s : GraphtreemstkruskalSeries) -> Double {
  let n = graph_tree_mst_kruskal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_series_max(s : GraphtreemstkruskalSeries) -> Double {
  let n = graph_tree_mst_kruskal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_series_range(s : GraphtreemstkruskalSeries) -> Double {
  graph_tree_mst_kruskal_series_max(s) - graph_tree_mst_kruskal_series_min(s)
}

pub fn graph_tree_mst_kruskal_series_var(s : GraphtreemstkruskalSeries) -> Double {
  let n = graph_tree_mst_kruskal_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_tree_mst_kruskal_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_series_std(s : GraphtreemstkruskalSeries) -> Double { graph_tree_mst_kruskal_sqrt(graph_tree_mst_kruskal_series_var(s)) }

pub fn graph_tree_mst_kruskal_series_median(s : GraphtreemstkruskalSeries) -> Double {
  let n = graph_tree_mst_kruskal_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_mst_kruskal_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_mst_kruskal_series_scale(s : GraphtreemstkruskalSeries, f : Double) -> GraphtreemstkruskalSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_tree_mst_kruskal_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_mst_kruskal_series_add(a : GraphtreemstkruskalSeries, b : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_mst_kruskal_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_kruskal_series_sub(a : GraphtreemstkruskalSeries, b : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_mst_kruskal_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_mst_kruskal_series_normalize(s : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  let mn = graph_tree_mst_kruskal_series_min(s)
  let mx = graph_tree_mst_kruskal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_tree_mst_kruskal_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_mst_kruskal_series_cumsum(s : GraphtreemstkruskalSeries) -> GraphtreemstkruskalSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_tree_mst_kruskal_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_mst_kruskal_series_to_string(s : GraphtreemstkruskalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_mst_kruskal_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstkruskalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_kruskal_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstkruskalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_kruskal_matrix_identity(n : Int) -> GraphtreemstkruskalMatrix {
  let m = graph_tree_mst_kruskal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_mst_kruskal_matrix_get(m : GraphtreemstkruskalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_mst_kruskal_matrix_transpose(m : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  let result = graph_tree_mst_kruskal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_mst_kruskal_matrix_add(a : GraphtreemstkruskalMatrix, b : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_mst_kruskal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_mst_kruskal_matrix_scale(m : GraphtreemstkruskalMatrix, s : Double) -> GraphtreemstkruskalMatrix {
  let result = graph_tree_mst_kruskal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_mst_kruskal_matrix_multiply(a : GraphtreemstkruskalMatrix, b : GraphtreemstkruskalMatrix) -> GraphtreemstkruskalMatrix {
  if a.cols != b.rows { return graph_tree_mst_kruskal_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_mst_kruskal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_mst_kruskal_matrix_trace(m : GraphtreemstkruskalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_mst_kruskal_matrix_det(m : GraphtreemstkruskalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_mst_kruskal_matrix_norm(m : GraphtreemstkruskalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_tree_mst_kruskal_sqrt(sum)
}

pub fn graph_tree_mst_kruskal_matrix_to_string(m : GraphtreemstkruskalMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_tree_mst_kruskal_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphtreemstkruskalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_kruskal_make_vector(comps : Array[Double]) -> GraphtreemstkruskalVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_kruskal_vector_zero(dim : Int) -> GraphtreemstkruskalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_mst_kruskal_vector_add(a : GraphtreemstkruskalVector, b : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_mst_kruskal_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_kruskal_vector_sub(a : GraphtreemstkruskalVector, b : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_mst_kruskal_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_mst_kruskal_vector_scale(v : GraphtreemstkruskalVector, s : Double) -> GraphtreemstkruskalVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_tree_mst_kruskal_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_mst_kruskal_vector_dot(a : GraphtreemstkruskalVector, b : GraphtreemstkruskalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_mst_kruskal_vector_norm(v : GraphtreemstkruskalVector) -> Double { graph_tree_mst_kruskal_sqrt(graph_tree_mst_kruskal_vector_dot(v, v)) }

pub fn graph_tree_mst_kruskal_vector_normalize(v : GraphtreemstkruskalVector) -> GraphtreemstkruskalVector {
  let n = graph_tree_mst_kruskal_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_mst_kruskal_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_mst_kruskal_vector_dist(a : GraphtreemstkruskalVector, b : GraphtreemstkruskalVector) -> Double {
  graph_tree_mst_kruskal_vector_norm(graph_tree_mst_kruskal_vector_sub(a, b))
}

pub fn graph_tree_mst_kruskal_vector_to_string(v : GraphtreemstkruskalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_mst_kruskal_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_kruskal_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_tree_mst_kruskal_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_std(data : Array[Double]) -> Double { graph_tree_mst_kruskal_sqrt(graph_tree_mst_kruskal_var(data)) }

pub fn graph_tree_mst_kruskal_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_tree_mst_kruskal_mean(a); let mb = graph_tree_mst_kruskal_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_tree_mst_kruskal_std(a); let sb = graph_tree_mst_kruskal_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_tree_mst_kruskal_cov(a, b) / (sa * sb) }
}

pub fn graph_tree_mst_kruskal_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_mst_kruskal_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_mst_kruskal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_tree_mst_kruskal_sqrt(graph_tree_mst_kruskal_mse(pred, labels))
}

pub fn graph_tree_mst_kruskal_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_tree_mst_kruskal_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_tree_mst_kruskal_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_tree_mst_kruskal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_tree_mst_kruskal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_tree_mst_kruskal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_tree_mst_kruskal_precision(pred, labels, pos); let r = graph_tree_mst_kruskal_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_tree_mst_kruskal_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_tree_mst_kruskal_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_tree_mst_kruskal_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_tree_mst_kruskal_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_tree_mst_kruskal_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_tree_mst_kruskal_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_tree_mst_kruskal_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_tree_mst_kruskal_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_tree_mst_kruskal_fibonacci(n : Int) -> Int {
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

pub fn graph_tree_mst_kruskal_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_tree_mst_kruskal_min(data); let mx = graph_tree_mst_kruskal_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_tree_mst_kruskal_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_tree_mst_kruskal_mean(data); let sd = graph_tree_mst_kruskal_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_tree_mst_kruskal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_tree_mst_kruskal_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_tree_mst_kruskal_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_tree_mst_kruskal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_tree_mst_kruskal_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_tree_mst_kruskal_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_tree_mst_kruskal_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_tree_mst_kruskal_int(x) } else { -graph_tree_mst_kruskal_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_tree_mst_kruskal_int(f * 1000000.0) } else { graph_tree_mst_kruskal_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_tree_mst_kruskal_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_tree_mst_kruskal_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphtreemstkruskalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_frame_make(size : Int) -> GraphtreemstkruskalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_frame_len(s : GraphtreemstkruskalFrame) -> Int { s.size }

pub fn graph_tree_mst_kruskal_frame_get(s : GraphtreemstkruskalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_frame_set(s : GraphtreemstkruskalFrame, i : Int, v : Double) -> GraphtreemstkruskalFrame {
  let result = graph_tree_mst_kruskal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_frame_sum(s : GraphtreemstkruskalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_frame_mean(s : GraphtreemstkruskalFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_frame_scale(s : GraphtreemstkruskalFrame, f : Double) -> GraphtreemstkruskalFrame {
  let result = graph_tree_mst_kruskal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_frame_add(a : GraphtreemstkruskalFrame, b : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_frame_copy(s : GraphtreemstkruskalFrame) -> GraphtreemstkruskalFrame {
  let result = graph_tree_mst_kruskal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_frame_fill(s : GraphtreemstkruskalFrame, v : Double) -> GraphtreemstkruskalFrame {
  let result = graph_tree_mst_kruskal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_frame_min(s : GraphtreemstkruskalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_frame_max(s : GraphtreemstkruskalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_frame_to_string(s : GraphtreemstkruskalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_table_make(size : Int) -> GraphtreemstkruskalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_table_len(s : GraphtreemstkruskalTable) -> Int { s.size }

pub fn graph_tree_mst_kruskal_table_get(s : GraphtreemstkruskalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_table_set(s : GraphtreemstkruskalTable, i : Int, v : Double) -> GraphtreemstkruskalTable {
  let result = graph_tree_mst_kruskal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_table_sum(s : GraphtreemstkruskalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_table_mean(s : GraphtreemstkruskalTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_table_scale(s : GraphtreemstkruskalTable, f : Double) -> GraphtreemstkruskalTable {
  let result = graph_tree_mst_kruskal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_table_add(a : GraphtreemstkruskalTable, b : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_table_copy(s : GraphtreemstkruskalTable) -> GraphtreemstkruskalTable {
  let result = graph_tree_mst_kruskal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_table_fill(s : GraphtreemstkruskalTable, v : Double) -> GraphtreemstkruskalTable {
  let result = graph_tree_mst_kruskal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_table_min(s : GraphtreemstkruskalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_table_max(s : GraphtreemstkruskalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_table_to_string(s : GraphtreemstkruskalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_graphn_make(size : Int) -> GraphtreemstkruskalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_graphn_len(s : GraphtreemstkruskalGraphN) -> Int { s.size }

pub fn graph_tree_mst_kruskal_graphn_get(s : GraphtreemstkruskalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_graphn_set(s : GraphtreemstkruskalGraphN, i : Int, v : Double) -> GraphtreemstkruskalGraphN {
  let result = graph_tree_mst_kruskal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_graphn_sum(s : GraphtreemstkruskalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_graphn_mean(s : GraphtreemstkruskalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_graphn_scale(s : GraphtreemstkruskalGraphN, f : Double) -> GraphtreemstkruskalGraphN {
  let result = graph_tree_mst_kruskal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_graphn_add(a : GraphtreemstkruskalGraphN, b : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_graphn_copy(s : GraphtreemstkruskalGraphN) -> GraphtreemstkruskalGraphN {
  let result = graph_tree_mst_kruskal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_graphn_fill(s : GraphtreemstkruskalGraphN, v : Double) -> GraphtreemstkruskalGraphN {
  let result = graph_tree_mst_kruskal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_graphn_min(s : GraphtreemstkruskalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_graphn_max(s : GraphtreemstkruskalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_graphn_to_string(s : GraphtreemstkruskalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_node_make(size : Int) -> GraphtreemstkruskalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_node_len(s : GraphtreemstkruskalNode) -> Int { s.size }

pub fn graph_tree_mst_kruskal_node_get(s : GraphtreemstkruskalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_node_set(s : GraphtreemstkruskalNode, i : Int, v : Double) -> GraphtreemstkruskalNode {
  let result = graph_tree_mst_kruskal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_node_sum(s : GraphtreemstkruskalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_node_mean(s : GraphtreemstkruskalNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_node_scale(s : GraphtreemstkruskalNode, f : Double) -> GraphtreemstkruskalNode {
  let result = graph_tree_mst_kruskal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_node_add(a : GraphtreemstkruskalNode, b : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_node_copy(s : GraphtreemstkruskalNode) -> GraphtreemstkruskalNode {
  let result = graph_tree_mst_kruskal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_node_fill(s : GraphtreemstkruskalNode, v : Double) -> GraphtreemstkruskalNode {
  let result = graph_tree_mst_kruskal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_node_min(s : GraphtreemstkruskalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_node_max(s : GraphtreemstkruskalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_node_to_string(s : GraphtreemstkruskalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_edge_make(size : Int) -> GraphtreemstkruskalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_edge_len(s : GraphtreemstkruskalEdge) -> Int { s.size }

pub fn graph_tree_mst_kruskal_edge_get(s : GraphtreemstkruskalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_edge_set(s : GraphtreemstkruskalEdge, i : Int, v : Double) -> GraphtreemstkruskalEdge {
  let result = graph_tree_mst_kruskal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_edge_sum(s : GraphtreemstkruskalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_edge_mean(s : GraphtreemstkruskalEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_edge_scale(s : GraphtreemstkruskalEdge, f : Double) -> GraphtreemstkruskalEdge {
  let result = graph_tree_mst_kruskal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_edge_add(a : GraphtreemstkruskalEdge, b : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_edge_copy(s : GraphtreemstkruskalEdge) -> GraphtreemstkruskalEdge {
  let result = graph_tree_mst_kruskal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_edge_fill(s : GraphtreemstkruskalEdge, v : Double) -> GraphtreemstkruskalEdge {
  let result = graph_tree_mst_kruskal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_edge_min(s : GraphtreemstkruskalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_edge_max(s : GraphtreemstkruskalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_edge_to_string(s : GraphtreemstkruskalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_path_make(size : Int) -> GraphtreemstkruskalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_path_len(s : GraphtreemstkruskalPath) -> Int { s.size }

pub fn graph_tree_mst_kruskal_path_get(s : GraphtreemstkruskalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_path_set(s : GraphtreemstkruskalPath, i : Int, v : Double) -> GraphtreemstkruskalPath {
  let result = graph_tree_mst_kruskal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_path_sum(s : GraphtreemstkruskalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_path_mean(s : GraphtreemstkruskalPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_path_scale(s : GraphtreemstkruskalPath, f : Double) -> GraphtreemstkruskalPath {
  let result = graph_tree_mst_kruskal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_path_add(a : GraphtreemstkruskalPath, b : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_path_copy(s : GraphtreemstkruskalPath) -> GraphtreemstkruskalPath {
  let result = graph_tree_mst_kruskal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_path_fill(s : GraphtreemstkruskalPath, v : Double) -> GraphtreemstkruskalPath {
  let result = graph_tree_mst_kruskal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_path_min(s : GraphtreemstkruskalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_path_max(s : GraphtreemstkruskalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_path_to_string(s : GraphtreemstkruskalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cluster_make(size : Int) -> GraphtreemstkruskalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_cluster_len(s : GraphtreemstkruskalCluster) -> Int { s.size }

pub fn graph_tree_mst_kruskal_cluster_get(s : GraphtreemstkruskalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_cluster_set(s : GraphtreemstkruskalCluster, i : Int, v : Double) -> GraphtreemstkruskalCluster {
  let result = graph_tree_mst_kruskal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_cluster_sum(s : GraphtreemstkruskalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_cluster_mean(s : GraphtreemstkruskalCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_cluster_scale(s : GraphtreemstkruskalCluster, f : Double) -> GraphtreemstkruskalCluster {
  let result = graph_tree_mst_kruskal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_cluster_add(a : GraphtreemstkruskalCluster, b : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_cluster_copy(s : GraphtreemstkruskalCluster) -> GraphtreemstkruskalCluster {
  let result = graph_tree_mst_kruskal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_cluster_fill(s : GraphtreemstkruskalCluster, v : Double) -> GraphtreemstkruskalCluster {
  let result = graph_tree_mst_kruskal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_cluster_min(s : GraphtreemstkruskalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_cluster_max(s : GraphtreemstkruskalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_cluster_to_string(s : GraphtreemstkruskalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_model_make(size : Int) -> GraphtreemstkruskalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_model_len(s : GraphtreemstkruskalModel) -> Int { s.size }

pub fn graph_tree_mst_kruskal_model_get(s : GraphtreemstkruskalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_model_set(s : GraphtreemstkruskalModel, i : Int, v : Double) -> GraphtreemstkruskalModel {
  let result = graph_tree_mst_kruskal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_model_sum(s : GraphtreemstkruskalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_model_mean(s : GraphtreemstkruskalModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_model_scale(s : GraphtreemstkruskalModel, f : Double) -> GraphtreemstkruskalModel {
  let result = graph_tree_mst_kruskal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_model_add(a : GraphtreemstkruskalModel, b : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_model_copy(s : GraphtreemstkruskalModel) -> GraphtreemstkruskalModel {
  let result = graph_tree_mst_kruskal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_model_fill(s : GraphtreemstkruskalModel, v : Double) -> GraphtreemstkruskalModel {
  let result = graph_tree_mst_kruskal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_model_min(s : GraphtreemstkruskalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_model_max(s : GraphtreemstkruskalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_model_to_string(s : GraphtreemstkruskalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_layer_make(size : Int) -> GraphtreemstkruskalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_layer_len(s : GraphtreemstkruskalLayer) -> Int { s.size }

pub fn graph_tree_mst_kruskal_layer_get(s : GraphtreemstkruskalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_layer_set(s : GraphtreemstkruskalLayer, i : Int, v : Double) -> GraphtreemstkruskalLayer {
  let result = graph_tree_mst_kruskal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_layer_sum(s : GraphtreemstkruskalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_layer_mean(s : GraphtreemstkruskalLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_layer_scale(s : GraphtreemstkruskalLayer, f : Double) -> GraphtreemstkruskalLayer {
  let result = graph_tree_mst_kruskal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_layer_add(a : GraphtreemstkruskalLayer, b : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_layer_copy(s : GraphtreemstkruskalLayer) -> GraphtreemstkruskalLayer {
  let result = graph_tree_mst_kruskal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_layer_fill(s : GraphtreemstkruskalLayer, v : Double) -> GraphtreemstkruskalLayer {
  let result = graph_tree_mst_kruskal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_layer_min(s : GraphtreemstkruskalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_layer_max(s : GraphtreemstkruskalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_layer_to_string(s : GraphtreemstkruskalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_buffer_make(size : Int) -> GraphtreemstkruskalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_buffer_len(s : GraphtreemstkruskalBuffer) -> Int { s.size }

pub fn graph_tree_mst_kruskal_buffer_get(s : GraphtreemstkruskalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_buffer_set(s : GraphtreemstkruskalBuffer, i : Int, v : Double) -> GraphtreemstkruskalBuffer {
  let result = graph_tree_mst_kruskal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_buffer_sum(s : GraphtreemstkruskalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_buffer_mean(s : GraphtreemstkruskalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_buffer_scale(s : GraphtreemstkruskalBuffer, f : Double) -> GraphtreemstkruskalBuffer {
  let result = graph_tree_mst_kruskal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_buffer_add(a : GraphtreemstkruskalBuffer, b : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_buffer_copy(s : GraphtreemstkruskalBuffer) -> GraphtreemstkruskalBuffer {
  let result = graph_tree_mst_kruskal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_buffer_fill(s : GraphtreemstkruskalBuffer, v : Double) -> GraphtreemstkruskalBuffer {
  let result = graph_tree_mst_kruskal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_buffer_min(s : GraphtreemstkruskalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_buffer_max(s : GraphtreemstkruskalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_buffer_to_string(s : GraphtreemstkruskalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_cursor_make(size : Int) -> GraphtreemstkruskalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_cursor_len(s : GraphtreemstkruskalCursor) -> Int { s.size }

pub fn graph_tree_mst_kruskal_cursor_get(s : GraphtreemstkruskalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_cursor_set(s : GraphtreemstkruskalCursor, i : Int, v : Double) -> GraphtreemstkruskalCursor {
  let result = graph_tree_mst_kruskal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_cursor_sum(s : GraphtreemstkruskalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_cursor_mean(s : GraphtreemstkruskalCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_cursor_scale(s : GraphtreemstkruskalCursor, f : Double) -> GraphtreemstkruskalCursor {
  let result = graph_tree_mst_kruskal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_cursor_add(a : GraphtreemstkruskalCursor, b : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_cursor_copy(s : GraphtreemstkruskalCursor) -> GraphtreemstkruskalCursor {
  let result = graph_tree_mst_kruskal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_cursor_fill(s : GraphtreemstkruskalCursor, v : Double) -> GraphtreemstkruskalCursor {
  let result = graph_tree_mst_kruskal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_cursor_min(s : GraphtreemstkruskalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_cursor_max(s : GraphtreemstkruskalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_cursor_to_string(s : GraphtreemstkruskalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_view_make(size : Int) -> GraphtreemstkruskalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_view_len(s : GraphtreemstkruskalView) -> Int { s.size }

pub fn graph_tree_mst_kruskal_view_get(s : GraphtreemstkruskalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_view_set(s : GraphtreemstkruskalView, i : Int, v : Double) -> GraphtreemstkruskalView {
  let result = graph_tree_mst_kruskal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_view_sum(s : GraphtreemstkruskalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_view_mean(s : GraphtreemstkruskalView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_view_scale(s : GraphtreemstkruskalView, f : Double) -> GraphtreemstkruskalView {
  let result = graph_tree_mst_kruskal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_view_add(a : GraphtreemstkruskalView, b : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_view_copy(s : GraphtreemstkruskalView) -> GraphtreemstkruskalView {
  let result = graph_tree_mst_kruskal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_view_fill(s : GraphtreemstkruskalView, v : Double) -> GraphtreemstkruskalView {
  let result = graph_tree_mst_kruskal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_view_min(s : GraphtreemstkruskalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_view_max(s : GraphtreemstkruskalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_view_to_string(s : GraphtreemstkruskalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_range_make(size : Int) -> GraphtreemstkruskalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_range_len(s : GraphtreemstkruskalRange) -> Int { s.size }

pub fn graph_tree_mst_kruskal_range_get(s : GraphtreemstkruskalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_range_set(s : GraphtreemstkruskalRange, i : Int, v : Double) -> GraphtreemstkruskalRange {
  let result = graph_tree_mst_kruskal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_range_sum(s : GraphtreemstkruskalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_range_mean(s : GraphtreemstkruskalRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_range_scale(s : GraphtreemstkruskalRange, f : Double) -> GraphtreemstkruskalRange {
  let result = graph_tree_mst_kruskal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_range_add(a : GraphtreemstkruskalRange, b : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_range_copy(s : GraphtreemstkruskalRange) -> GraphtreemstkruskalRange {
  let result = graph_tree_mst_kruskal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_range_fill(s : GraphtreemstkruskalRange, v : Double) -> GraphtreemstkruskalRange {
  let result = graph_tree_mst_kruskal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_range_min(s : GraphtreemstkruskalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_range_max(s : GraphtreemstkruskalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_range_to_string(s : GraphtreemstkruskalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstkruskalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_kruskal_slice_make(size : Int) -> GraphtreemstkruskalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_kruskal_slice_len(s : GraphtreemstkruskalSlice) -> Int { s.size }

pub fn graph_tree_mst_kruskal_slice_get(s : GraphtreemstkruskalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_kruskal_slice_set(s : GraphtreemstkruskalSlice, i : Int, v : Double) -> GraphtreemstkruskalSlice {
  let result = graph_tree_mst_kruskal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_slice_sum(s : GraphtreemstkruskalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_mst_kruskal_slice_mean(s : GraphtreemstkruskalSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_mst_kruskal_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_mst_kruskal_slice_scale(s : GraphtreemstkruskalSlice, f : Double) -> GraphtreemstkruskalSlice {
  let result = graph_tree_mst_kruskal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_mst_kruskal_slice_add(a : GraphtreemstkruskalSlice, b : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_mst_kruskal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_slice_copy(s : GraphtreemstkruskalSlice) -> GraphtreemstkruskalSlice {
  let result = graph_tree_mst_kruskal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_mst_kruskal_slice_fill(s : GraphtreemstkruskalSlice, v : Double) -> GraphtreemstkruskalSlice {
  let result = graph_tree_mst_kruskal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_mst_kruskal_slice_min(s : GraphtreemstkruskalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_slice_max(s : GraphtreemstkruskalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_mst_kruskal_slice_to_string(s : GraphtreemstkruskalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_tree_mst_kruskal_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_mst_kruskal_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


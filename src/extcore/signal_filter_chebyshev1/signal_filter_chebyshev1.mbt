///===
/// extcore/signal_filter_chebyshev1

pub(all) struct Signalfilterchebyshev1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_chebyshev1_make_point(x : Double, y : Double) -> Signalfilterchebyshev1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_chebyshev1_make_point3(x : Double, y : Double, z : Double) -> Signalfilterchebyshev1Point {
  { x, y, z, label: 0 }
}

pub fn signal_filter_chebyshev1_point_x(pt : Signalfilterchebyshev1Point) -> Double { pt.x }

pub fn signal_filter_chebyshev1_point_y(pt : Signalfilterchebyshev1Point) -> Double { pt.y }

pub fn signal_filter_chebyshev1_point_z(pt : Signalfilterchebyshev1Point) -> Double { pt.z }

pub fn signal_filter_chebyshev1_point_label(pt : Signalfilterchebyshev1Point) -> Int { pt.label }

pub fn signal_filter_chebyshev1_point_dist(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  signal_filter_chebyshev1_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn signal_filter_chebyshev1_point_add(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn signal_filter_chebyshev1_point_sub(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn signal_filter_chebyshev1_point_scale(pt : Signalfilterchebyshev1Point, s : Double) -> Signalfilterchebyshev1Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn signal_filter_chebyshev1_point_dot(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn signal_filter_chebyshev1_point_cross(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn signal_filter_chebyshev1_point_norm(pt : Signalfilterchebyshev1Point) -> Double {
  signal_filter_chebyshev1_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn signal_filter_chebyshev1_point_normalize(pt : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  let n = signal_filter_chebyshev1_point_norm(pt)
  if n < 0.0000001 { pt } else { signal_filter_chebyshev1_point_scale(pt, 1.0 / n) }
}

pub fn signal_filter_chebyshev1_point_negate(pt : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn signal_filter_chebyshev1_point_mid(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn signal_filter_chebyshev1_point_lerp(a : Signalfilterchebyshev1Point, b : Signalfilterchebyshev1Point, t : Double) -> Signalfilterchebyshev1Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn signal_filter_chebyshev1_point_to_string(pt : Signalfilterchebyshev1Point) -> String {
  "(" + signal_filter_chebyshev1_dbl(pt.x) + ", " + signal_filter_chebyshev1_dbl(pt.y) + ", " + signal_filter_chebyshev1_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_chebyshev1_make_series(vals : Array[Double], name : String) -> Signalfilterchebyshev1Series {
  { vals, name, meta: 0 }
}

pub fn signal_filter_chebyshev1_series_len(s : Signalfilterchebyshev1Series) -> Int { s.vals.length() }

pub fn signal_filter_chebyshev1_series_sum(s : Signalfilterchebyshev1Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn signal_filter_chebyshev1_series_mean(s : Signalfilterchebyshev1Series) -> Double {
  let n = signal_filter_chebyshev1_series_len(s)
  if n == 0 { 0.0 } else { signal_filter_chebyshev1_series_sum(s) / n.to_double() }
}

pub fn signal_filter_chebyshev1_series_min(s : Signalfilterchebyshev1Series) -> Double {
  let n = signal_filter_chebyshev1_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_series_max(s : Signalfilterchebyshev1Series) -> Double {
  let n = signal_filter_chebyshev1_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_series_range(s : Signalfilterchebyshev1Series) -> Double {
  signal_filter_chebyshev1_series_max(s) - signal_filter_chebyshev1_series_min(s)
}

pub fn signal_filter_chebyshev1_series_var(s : Signalfilterchebyshev1Series) -> Double {
  let n = signal_filter_chebyshev1_series_len(s)
  if n == 0 { 0.0 } else {
    let m = signal_filter_chebyshev1_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_series_std(s : Signalfilterchebyshev1Series) -> Double { signal_filter_chebyshev1_sqrt(signal_filter_chebyshev1_series_var(s)) }

pub fn signal_filter_chebyshev1_series_median(s : Signalfilterchebyshev1Series) -> Double {
  let n = signal_filter_chebyshev1_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_chebyshev1_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_chebyshev1_series_scale(s : Signalfilterchebyshev1Series, f : Double) -> Signalfilterchebyshev1Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = signal_filter_chebyshev1_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn signal_filter_chebyshev1_series_add(a : Signalfilterchebyshev1Series, b : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_filter_chebyshev1_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn signal_filter_chebyshev1_series_sub(a : Signalfilterchebyshev1Series, b : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = signal_filter_chebyshev1_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn signal_filter_chebyshev1_series_normalize(s : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let mn = signal_filter_chebyshev1_series_min(s)
  let mx = signal_filter_chebyshev1_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = signal_filter_chebyshev1_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn signal_filter_chebyshev1_series_cumsum(s : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = signal_filter_chebyshev1_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn signal_filter_chebyshev1_series_to_string(s : Signalfilterchebyshev1Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_filter_chebyshev1_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_chebyshev1_make_matrix(rows : Int, cols : Int, val : Double) -> Signalfilterchebyshev1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_chebyshev1_matrix_identity(n : Int) -> Signalfilterchebyshev1Matrix {
  let m = signal_filter_chebyshev1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn signal_filter_chebyshev1_matrix_get(m : Signalfilterchebyshev1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn signal_filter_chebyshev1_matrix_transpose(m : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn signal_filter_chebyshev1_matrix_add(a : Signalfilterchebyshev1Matrix, b : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = signal_filter_chebyshev1_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn signal_filter_chebyshev1_matrix_scale(m : Signalfilterchebyshev1Matrix, s : Double) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn signal_filter_chebyshev1_matrix_multiply(a : Signalfilterchebyshev1Matrix, b : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if a.cols != b.rows { return signal_filter_chebyshev1_make_matrix(a.rows, b.cols, 0.0) }
  let result = signal_filter_chebyshev1_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn signal_filter_chebyshev1_matrix_trace(m : Signalfilterchebyshev1Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn signal_filter_chebyshev1_matrix_det(m : Signalfilterchebyshev1Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn signal_filter_chebyshev1_matrix_norm(m : Signalfilterchebyshev1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  signal_filter_chebyshev1_sqrt(sum)
}

pub fn signal_filter_chebyshev1_matrix_to_string(m : Signalfilterchebyshev1Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + signal_filter_chebyshev1_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Signalfilterchebyshev1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_chebyshev1_make_vector(comps : Array[Double]) -> Signalfilterchebyshev1Vector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_chebyshev1_vector_zero(dim : Int) -> Signalfilterchebyshev1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn signal_filter_chebyshev1_vector_add(a : Signalfilterchebyshev1Vector, b : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_filter_chebyshev1_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_chebyshev1_vector_sub(a : Signalfilterchebyshev1Vector, b : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = signal_filter_chebyshev1_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn signal_filter_chebyshev1_vector_scale(v : Signalfilterchebyshev1Vector, s : Double) -> Signalfilterchebyshev1Vector {
  let mut result = []
  for i in 0..<v.dim { result = signal_filter_chebyshev1_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn signal_filter_chebyshev1_vector_dot(a : Signalfilterchebyshev1Vector, b : Signalfilterchebyshev1Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn signal_filter_chebyshev1_vector_norm(v : Signalfilterchebyshev1Vector) -> Double { signal_filter_chebyshev1_sqrt(signal_filter_chebyshev1_vector_dot(v, v)) }

pub fn signal_filter_chebyshev1_vector_normalize(v : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = signal_filter_chebyshev1_vector_norm(v)
  if n < 0.0000001 { v } else { signal_filter_chebyshev1_vector_scale(v, 1.0 / n) }
}

pub fn signal_filter_chebyshev1_vector_dist(a : Signalfilterchebyshev1Vector, b : Signalfilterchebyshev1Vector) -> Double {
  signal_filter_chebyshev1_vector_norm(signal_filter_chebyshev1_vector_sub(a, b))
}

pub fn signal_filter_chebyshev1_vector_to_string(v : Signalfilterchebyshev1Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + signal_filter_chebyshev1_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_chebyshev1_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = signal_filter_chebyshev1_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_std(data : Array[Double]) -> Double { signal_filter_chebyshev1_sqrt(signal_filter_chebyshev1_var(data)) }

pub fn signal_filter_chebyshev1_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = signal_filter_chebyshev1_mean(a); let mb = signal_filter_chebyshev1_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = signal_filter_chebyshev1_std(a); let sb = signal_filter_chebyshev1_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { signal_filter_chebyshev1_cov(a, b) / (sa * sb) }
}

pub fn signal_filter_chebyshev1_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = signal_filter_chebyshev1_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn signal_filter_chebyshev1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  signal_filter_chebyshev1_sqrt(signal_filter_chebyshev1_mse(pred, labels))
}

pub fn signal_filter_chebyshev1_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + signal_filter_chebyshev1_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = signal_filter_chebyshev1_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn signal_filter_chebyshev1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn signal_filter_chebyshev1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn signal_filter_chebyshev1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = signal_filter_chebyshev1_precision(pred, labels, pos); let r = signal_filter_chebyshev1_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn signal_filter_chebyshev1_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn signal_filter_chebyshev1_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = signal_filter_chebyshev1_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn signal_filter_chebyshev1_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn signal_filter_chebyshev1_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn signal_filter_chebyshev1_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = signal_filter_chebyshev1_gcd(a, b)
    (a / g) * b
  }
}

pub fn signal_filter_chebyshev1_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn signal_filter_chebyshev1_fibonacci(n : Int) -> Int {
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

pub fn signal_filter_chebyshev1_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = signal_filter_chebyshev1_min(data); let mx = signal_filter_chebyshev1_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn signal_filter_chebyshev1_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = signal_filter_chebyshev1_mean(data); let sd = signal_filter_chebyshev1_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn signal_filter_chebyshev1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn signal_filter_chebyshev1_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn signal_filter_chebyshev1_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn signal_filter_chebyshev1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn signal_filter_chebyshev1_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn signal_filter_chebyshev1_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn signal_filter_chebyshev1_dbl(x : Double) -> String {
  let i = if x >= 0.0 { signal_filter_chebyshev1_int(x) } else { -signal_filter_chebyshev1_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { signal_filter_chebyshev1_int(f * 1000000.0) } else { signal_filter_chebyshev1_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn signal_filter_chebyshev1_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn signal_filter_chebyshev1_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Signalfilterchebyshev1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_frame_make(size : Int) -> Signalfilterchebyshev1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_frame_len(s : Signalfilterchebyshev1Frame) -> Int { s.size }

pub fn signal_filter_chebyshev1_frame_get(s : Signalfilterchebyshev1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_frame_set(s : Signalfilterchebyshev1Frame, i : Int, v : Double) -> Signalfilterchebyshev1Frame {
  let result = signal_filter_chebyshev1_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_frame_sum(s : Signalfilterchebyshev1Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_frame_mean(s : Signalfilterchebyshev1Frame) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_frame_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_frame_scale(s : Signalfilterchebyshev1Frame, f : Double) -> Signalfilterchebyshev1Frame {
  let result = signal_filter_chebyshev1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_frame_add(a : Signalfilterchebyshev1Frame, b : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_frame_copy(s : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  let result = signal_filter_chebyshev1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_frame_fill(s : Signalfilterchebyshev1Frame, v : Double) -> Signalfilterchebyshev1Frame {
  let result = signal_filter_chebyshev1_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_frame_min(s : Signalfilterchebyshev1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_frame_max(s : Signalfilterchebyshev1Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_frame_to_string(s : Signalfilterchebyshev1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_table_make(size : Int) -> Signalfilterchebyshev1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_table_len(s : Signalfilterchebyshev1Table) -> Int { s.size }

pub fn signal_filter_chebyshev1_table_get(s : Signalfilterchebyshev1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_table_set(s : Signalfilterchebyshev1Table, i : Int, v : Double) -> Signalfilterchebyshev1Table {
  let result = signal_filter_chebyshev1_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_table_sum(s : Signalfilterchebyshev1Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_table_mean(s : Signalfilterchebyshev1Table) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_table_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_table_scale(s : Signalfilterchebyshev1Table, f : Double) -> Signalfilterchebyshev1Table {
  let result = signal_filter_chebyshev1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_table_add(a : Signalfilterchebyshev1Table, b : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_table_copy(s : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  let result = signal_filter_chebyshev1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_table_fill(s : Signalfilterchebyshev1Table, v : Double) -> Signalfilterchebyshev1Table {
  let result = signal_filter_chebyshev1_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_table_min(s : Signalfilterchebyshev1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_table_max(s : Signalfilterchebyshev1Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_table_to_string(s : Signalfilterchebyshev1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_graphn_make(size : Int) -> Signalfilterchebyshev1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_graphn_len(s : Signalfilterchebyshev1GraphN) -> Int { s.size }

pub fn signal_filter_chebyshev1_graphn_get(s : Signalfilterchebyshev1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_graphn_set(s : Signalfilterchebyshev1GraphN, i : Int, v : Double) -> Signalfilterchebyshev1GraphN {
  let result = signal_filter_chebyshev1_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_graphn_sum(s : Signalfilterchebyshev1GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_graphn_mean(s : Signalfilterchebyshev1GraphN) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_graphn_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_graphn_scale(s : Signalfilterchebyshev1GraphN, f : Double) -> Signalfilterchebyshev1GraphN {
  let result = signal_filter_chebyshev1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_graphn_add(a : Signalfilterchebyshev1GraphN, b : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_graphn_copy(s : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  let result = signal_filter_chebyshev1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_graphn_fill(s : Signalfilterchebyshev1GraphN, v : Double) -> Signalfilterchebyshev1GraphN {
  let result = signal_filter_chebyshev1_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_graphn_min(s : Signalfilterchebyshev1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_graphn_max(s : Signalfilterchebyshev1GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_graphn_to_string(s : Signalfilterchebyshev1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_node_make(size : Int) -> Signalfilterchebyshev1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_node_len(s : Signalfilterchebyshev1Node) -> Int { s.size }

pub fn signal_filter_chebyshev1_node_get(s : Signalfilterchebyshev1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_node_set(s : Signalfilterchebyshev1Node, i : Int, v : Double) -> Signalfilterchebyshev1Node {
  let result = signal_filter_chebyshev1_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_node_sum(s : Signalfilterchebyshev1Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_node_mean(s : Signalfilterchebyshev1Node) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_node_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_node_scale(s : Signalfilterchebyshev1Node, f : Double) -> Signalfilterchebyshev1Node {
  let result = signal_filter_chebyshev1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_node_add(a : Signalfilterchebyshev1Node, b : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_node_copy(s : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  let result = signal_filter_chebyshev1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_node_fill(s : Signalfilterchebyshev1Node, v : Double) -> Signalfilterchebyshev1Node {
  let result = signal_filter_chebyshev1_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_node_min(s : Signalfilterchebyshev1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_node_max(s : Signalfilterchebyshev1Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_node_to_string(s : Signalfilterchebyshev1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_edge_make(size : Int) -> Signalfilterchebyshev1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_edge_len(s : Signalfilterchebyshev1Edge) -> Int { s.size }

pub fn signal_filter_chebyshev1_edge_get(s : Signalfilterchebyshev1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_edge_set(s : Signalfilterchebyshev1Edge, i : Int, v : Double) -> Signalfilterchebyshev1Edge {
  let result = signal_filter_chebyshev1_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_edge_sum(s : Signalfilterchebyshev1Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_edge_mean(s : Signalfilterchebyshev1Edge) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_edge_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_edge_scale(s : Signalfilterchebyshev1Edge, f : Double) -> Signalfilterchebyshev1Edge {
  let result = signal_filter_chebyshev1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_edge_add(a : Signalfilterchebyshev1Edge, b : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_edge_copy(s : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  let result = signal_filter_chebyshev1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_edge_fill(s : Signalfilterchebyshev1Edge, v : Double) -> Signalfilterchebyshev1Edge {
  let result = signal_filter_chebyshev1_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_edge_min(s : Signalfilterchebyshev1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_edge_max(s : Signalfilterchebyshev1Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_edge_to_string(s : Signalfilterchebyshev1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_path_make(size : Int) -> Signalfilterchebyshev1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_path_len(s : Signalfilterchebyshev1Path) -> Int { s.size }

pub fn signal_filter_chebyshev1_path_get(s : Signalfilterchebyshev1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_path_set(s : Signalfilterchebyshev1Path, i : Int, v : Double) -> Signalfilterchebyshev1Path {
  let result = signal_filter_chebyshev1_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_path_sum(s : Signalfilterchebyshev1Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_path_mean(s : Signalfilterchebyshev1Path) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_path_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_path_scale(s : Signalfilterchebyshev1Path, f : Double) -> Signalfilterchebyshev1Path {
  let result = signal_filter_chebyshev1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_path_add(a : Signalfilterchebyshev1Path, b : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_path_copy(s : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  let result = signal_filter_chebyshev1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_path_fill(s : Signalfilterchebyshev1Path, v : Double) -> Signalfilterchebyshev1Path {
  let result = signal_filter_chebyshev1_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_path_min(s : Signalfilterchebyshev1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_path_max(s : Signalfilterchebyshev1Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_path_to_string(s : Signalfilterchebyshev1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cluster_make(size : Int) -> Signalfilterchebyshev1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_cluster_len(s : Signalfilterchebyshev1Cluster) -> Int { s.size }

pub fn signal_filter_chebyshev1_cluster_get(s : Signalfilterchebyshev1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_cluster_set(s : Signalfilterchebyshev1Cluster, i : Int, v : Double) -> Signalfilterchebyshev1Cluster {
  let result = signal_filter_chebyshev1_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_cluster_sum(s : Signalfilterchebyshev1Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_cluster_mean(s : Signalfilterchebyshev1Cluster) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_cluster_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_cluster_scale(s : Signalfilterchebyshev1Cluster, f : Double) -> Signalfilterchebyshev1Cluster {
  let result = signal_filter_chebyshev1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_cluster_add(a : Signalfilterchebyshev1Cluster, b : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_cluster_copy(s : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  let result = signal_filter_chebyshev1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_cluster_fill(s : Signalfilterchebyshev1Cluster, v : Double) -> Signalfilterchebyshev1Cluster {
  let result = signal_filter_chebyshev1_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_cluster_min(s : Signalfilterchebyshev1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_cluster_max(s : Signalfilterchebyshev1Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_cluster_to_string(s : Signalfilterchebyshev1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_model_make(size : Int) -> Signalfilterchebyshev1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_model_len(s : Signalfilterchebyshev1Model) -> Int { s.size }

pub fn signal_filter_chebyshev1_model_get(s : Signalfilterchebyshev1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_model_set(s : Signalfilterchebyshev1Model, i : Int, v : Double) -> Signalfilterchebyshev1Model {
  let result = signal_filter_chebyshev1_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_model_sum(s : Signalfilterchebyshev1Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_model_mean(s : Signalfilterchebyshev1Model) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_model_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_model_scale(s : Signalfilterchebyshev1Model, f : Double) -> Signalfilterchebyshev1Model {
  let result = signal_filter_chebyshev1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_model_add(a : Signalfilterchebyshev1Model, b : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_model_copy(s : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  let result = signal_filter_chebyshev1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_model_fill(s : Signalfilterchebyshev1Model, v : Double) -> Signalfilterchebyshev1Model {
  let result = signal_filter_chebyshev1_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_model_min(s : Signalfilterchebyshev1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_model_max(s : Signalfilterchebyshev1Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_model_to_string(s : Signalfilterchebyshev1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_layer_make(size : Int) -> Signalfilterchebyshev1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_layer_len(s : Signalfilterchebyshev1Layer) -> Int { s.size }

pub fn signal_filter_chebyshev1_layer_get(s : Signalfilterchebyshev1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_layer_set(s : Signalfilterchebyshev1Layer, i : Int, v : Double) -> Signalfilterchebyshev1Layer {
  let result = signal_filter_chebyshev1_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_layer_sum(s : Signalfilterchebyshev1Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_layer_mean(s : Signalfilterchebyshev1Layer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_layer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_layer_scale(s : Signalfilterchebyshev1Layer, f : Double) -> Signalfilterchebyshev1Layer {
  let result = signal_filter_chebyshev1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_layer_add(a : Signalfilterchebyshev1Layer, b : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_layer_copy(s : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  let result = signal_filter_chebyshev1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_layer_fill(s : Signalfilterchebyshev1Layer, v : Double) -> Signalfilterchebyshev1Layer {
  let result = signal_filter_chebyshev1_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_layer_min(s : Signalfilterchebyshev1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_layer_max(s : Signalfilterchebyshev1Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_layer_to_string(s : Signalfilterchebyshev1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_buffer_make(size : Int) -> Signalfilterchebyshev1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_buffer_len(s : Signalfilterchebyshev1Buffer) -> Int { s.size }

pub fn signal_filter_chebyshev1_buffer_get(s : Signalfilterchebyshev1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_buffer_set(s : Signalfilterchebyshev1Buffer, i : Int, v : Double) -> Signalfilterchebyshev1Buffer {
  let result = signal_filter_chebyshev1_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_buffer_sum(s : Signalfilterchebyshev1Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_buffer_mean(s : Signalfilterchebyshev1Buffer) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_buffer_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_buffer_scale(s : Signalfilterchebyshev1Buffer, f : Double) -> Signalfilterchebyshev1Buffer {
  let result = signal_filter_chebyshev1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_buffer_add(a : Signalfilterchebyshev1Buffer, b : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_buffer_copy(s : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  let result = signal_filter_chebyshev1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_buffer_fill(s : Signalfilterchebyshev1Buffer, v : Double) -> Signalfilterchebyshev1Buffer {
  let result = signal_filter_chebyshev1_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_buffer_min(s : Signalfilterchebyshev1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_buffer_max(s : Signalfilterchebyshev1Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_buffer_to_string(s : Signalfilterchebyshev1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cursor_make(size : Int) -> Signalfilterchebyshev1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_cursor_len(s : Signalfilterchebyshev1Cursor) -> Int { s.size }

pub fn signal_filter_chebyshev1_cursor_get(s : Signalfilterchebyshev1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_cursor_set(s : Signalfilterchebyshev1Cursor, i : Int, v : Double) -> Signalfilterchebyshev1Cursor {
  let result = signal_filter_chebyshev1_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_cursor_sum(s : Signalfilterchebyshev1Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_cursor_mean(s : Signalfilterchebyshev1Cursor) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_cursor_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_cursor_scale(s : Signalfilterchebyshev1Cursor, f : Double) -> Signalfilterchebyshev1Cursor {
  let result = signal_filter_chebyshev1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_cursor_add(a : Signalfilterchebyshev1Cursor, b : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_cursor_copy(s : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  let result = signal_filter_chebyshev1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_cursor_fill(s : Signalfilterchebyshev1Cursor, v : Double) -> Signalfilterchebyshev1Cursor {
  let result = signal_filter_chebyshev1_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_cursor_min(s : Signalfilterchebyshev1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_cursor_max(s : Signalfilterchebyshev1Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_cursor_to_string(s : Signalfilterchebyshev1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_view_make(size : Int) -> Signalfilterchebyshev1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_view_len(s : Signalfilterchebyshev1View) -> Int { s.size }

pub fn signal_filter_chebyshev1_view_get(s : Signalfilterchebyshev1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_view_set(s : Signalfilterchebyshev1View, i : Int, v : Double) -> Signalfilterchebyshev1View {
  let result = signal_filter_chebyshev1_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_view_sum(s : Signalfilterchebyshev1View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_view_mean(s : Signalfilterchebyshev1View) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_view_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_view_scale(s : Signalfilterchebyshev1View, f : Double) -> Signalfilterchebyshev1View {
  let result = signal_filter_chebyshev1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_view_add(a : Signalfilterchebyshev1View, b : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_view_copy(s : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  let result = signal_filter_chebyshev1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_view_fill(s : Signalfilterchebyshev1View, v : Double) -> Signalfilterchebyshev1View {
  let result = signal_filter_chebyshev1_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_view_min(s : Signalfilterchebyshev1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_view_max(s : Signalfilterchebyshev1View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_view_to_string(s : Signalfilterchebyshev1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_range_make(size : Int) -> Signalfilterchebyshev1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_range_len(s : Signalfilterchebyshev1Range) -> Int { s.size }

pub fn signal_filter_chebyshev1_range_get(s : Signalfilterchebyshev1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_range_set(s : Signalfilterchebyshev1Range, i : Int, v : Double) -> Signalfilterchebyshev1Range {
  let result = signal_filter_chebyshev1_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_range_sum(s : Signalfilterchebyshev1Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_range_mean(s : Signalfilterchebyshev1Range) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_range_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_range_scale(s : Signalfilterchebyshev1Range, f : Double) -> Signalfilterchebyshev1Range {
  let result = signal_filter_chebyshev1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_range_add(a : Signalfilterchebyshev1Range, b : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_range_copy(s : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  let result = signal_filter_chebyshev1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_range_fill(s : Signalfilterchebyshev1Range, v : Double) -> Signalfilterchebyshev1Range {
  let result = signal_filter_chebyshev1_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_range_min(s : Signalfilterchebyshev1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_range_max(s : Signalfilterchebyshev1Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_range_to_string(s : Signalfilterchebyshev1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_slice_make(size : Int) -> Signalfilterchebyshev1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_slice_len(s : Signalfilterchebyshev1Slice) -> Int { s.size }

pub fn signal_filter_chebyshev1_slice_get(s : Signalfilterchebyshev1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_slice_set(s : Signalfilterchebyshev1Slice, i : Int, v : Double) -> Signalfilterchebyshev1Slice {
  let result = signal_filter_chebyshev1_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_slice_sum(s : Signalfilterchebyshev1Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn signal_filter_chebyshev1_slice_mean(s : Signalfilterchebyshev1Slice) -> Double {
  if s.size == 0 { 0.0 } else { signal_filter_chebyshev1_slice_sum(s) / s.size.to_double() }
}

pub fn signal_filter_chebyshev1_slice_scale(s : Signalfilterchebyshev1Slice, f : Double) -> Signalfilterchebyshev1Slice {
  let result = signal_filter_chebyshev1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn signal_filter_chebyshev1_slice_add(a : Signalfilterchebyshev1Slice, b : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = signal_filter_chebyshev1_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn signal_filter_chebyshev1_slice_copy(s : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  let result = signal_filter_chebyshev1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn signal_filter_chebyshev1_slice_fill(s : Signalfilterchebyshev1Slice, v : Double) -> Signalfilterchebyshev1Slice {
  let result = signal_filter_chebyshev1_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn signal_filter_chebyshev1_slice_min(s : Signalfilterchebyshev1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_slice_max(s : Signalfilterchebyshev1Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn signal_filter_chebyshev1_slice_to_string(s : Signalfilterchebyshev1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn signal_filter_chebyshev1_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn signal_filter_chebyshev1_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


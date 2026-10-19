///===
/// extcore/timeseries_decomp_x11

pub(all) struct Timeseriesdecompx11Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_x11_make_point(x : Double, y : Double) -> Timeseriesdecompx11Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_x11_make_point3(x : Double, y : Double, z : Double) -> Timeseriesdecompx11Point {
  { x, y, z, label: 0 }
}

pub fn timeseries_decomp_x11_point_x(pt : Timeseriesdecompx11Point) -> Double { pt.x }

pub fn timeseries_decomp_x11_point_y(pt : Timeseriesdecompx11Point) -> Double { pt.y }

pub fn timeseries_decomp_x11_point_z(pt : Timeseriesdecompx11Point) -> Double { pt.z }

pub fn timeseries_decomp_x11_point_label(pt : Timeseriesdecompx11Point) -> Int { pt.label }

pub fn timeseries_decomp_x11_point_dist(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  timeseries_decomp_x11_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_decomp_x11_point_add(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_decomp_x11_point_sub(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_decomp_x11_point_scale(pt : Timeseriesdecompx11Point, s : Double) -> Timeseriesdecompx11Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_decomp_x11_point_dot(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_decomp_x11_point_cross(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_decomp_x11_point_norm(pt : Timeseriesdecompx11Point) -> Double {
  timeseries_decomp_x11_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_decomp_x11_point_normalize(pt : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  let n = timeseries_decomp_x11_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_decomp_x11_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_decomp_x11_point_negate(pt : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_decomp_x11_point_mid(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_decomp_x11_point_lerp(a : Timeseriesdecompx11Point, b : Timeseriesdecompx11Point, t : Double) -> Timeseriesdecompx11Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_decomp_x11_point_to_string(pt : Timeseriesdecompx11Point) -> String {
  "(" + timeseries_decomp_x11_dbl(pt.x) + ", " + timeseries_decomp_x11_dbl(pt.y) + ", " + timeseries_decomp_x11_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_x11_make_series(vals : Array[Double], name : String) -> Timeseriesdecompx11Series {
  { vals, name, meta: 0 }
}

pub fn timeseries_decomp_x11_series_len(s : Timeseriesdecompx11Series) -> Int { s.vals.length() }

pub fn timeseries_decomp_x11_series_sum(s : Timeseriesdecompx11Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_decomp_x11_series_mean(s : Timeseriesdecompx11Series) -> Double {
  let n = timeseries_decomp_x11_series_len(s)
  if n == 0 { 0.0 } else { timeseries_decomp_x11_series_sum(s) / n.to_double() }
}

pub fn timeseries_decomp_x11_series_min(s : Timeseriesdecompx11Series) -> Double {
  let n = timeseries_decomp_x11_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_series_max(s : Timeseriesdecompx11Series) -> Double {
  let n = timeseries_decomp_x11_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_series_range(s : Timeseriesdecompx11Series) -> Double {
  timeseries_decomp_x11_series_max(s) - timeseries_decomp_x11_series_min(s)
}

pub fn timeseries_decomp_x11_series_var(s : Timeseriesdecompx11Series) -> Double {
  let n = timeseries_decomp_x11_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_x11_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_decomp_x11_series_std(s : Timeseriesdecompx11Series) -> Double { timeseries_decomp_x11_sqrt(timeseries_decomp_x11_series_var(s)) }

pub fn timeseries_decomp_x11_series_median(s : Timeseriesdecompx11Series) -> Double {
  let n = timeseries_decomp_x11_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_x11_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_x11_series_scale(s : Timeseriesdecompx11Series, f : Double) -> Timeseriesdecompx11Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = timeseries_decomp_x11_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_decomp_x11_series_add(a : Timeseriesdecompx11Series, b : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_x11_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_x11_series_sub(a : Timeseriesdecompx11Series, b : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_x11_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_decomp_x11_series_normalize(s : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  let mn = timeseries_decomp_x11_series_min(s)
  let mx = timeseries_decomp_x11_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = timeseries_decomp_x11_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_decomp_x11_series_cumsum(s : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = timeseries_decomp_x11_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_decomp_x11_series_to_string(s : Timeseriesdecompx11Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_x11_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Timeseriesdecompx11Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_x11_make_matrix(rows : Int, cols : Int, val : Double) -> Timeseriesdecompx11Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_x11_matrix_identity(n : Int) -> Timeseriesdecompx11Matrix {
  let m = timeseries_decomp_x11_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_decomp_x11_matrix_get(m : Timeseriesdecompx11Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_decomp_x11_matrix_transpose(m : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  let result = timeseries_decomp_x11_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_decomp_x11_matrix_add(a : Timeseriesdecompx11Matrix, b : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_decomp_x11_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_decomp_x11_matrix_scale(m : Timeseriesdecompx11Matrix, s : Double) -> Timeseriesdecompx11Matrix {
  let result = timeseries_decomp_x11_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_decomp_x11_matrix_multiply(a : Timeseriesdecompx11Matrix, b : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  if a.cols != b.rows { return timeseries_decomp_x11_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_decomp_x11_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_decomp_x11_matrix_trace(m : Timeseriesdecompx11Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_decomp_x11_matrix_det(m : Timeseriesdecompx11Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_decomp_x11_matrix_norm(m : Timeseriesdecompx11Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  timeseries_decomp_x11_sqrt(sum)
}

pub fn timeseries_decomp_x11_matrix_to_string(m : Timeseriesdecompx11Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + timeseries_decomp_x11_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Timeseriesdecompx11Vector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_x11_make_vector(comps : Array[Double]) -> Timeseriesdecompx11Vector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_x11_vector_zero(dim : Int) -> Timeseriesdecompx11Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_decomp_x11_vector_add(a : Timeseriesdecompx11Vector, b : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_x11_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_x11_vector_sub(a : Timeseriesdecompx11Vector, b : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = timeseries_decomp_x11_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_decomp_x11_vector_scale(v : Timeseriesdecompx11Vector, s : Double) -> Timeseriesdecompx11Vector {
  let mut result = []
  for i in 0..<v.dim { result = timeseries_decomp_x11_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_decomp_x11_vector_dot(a : Timeseriesdecompx11Vector, b : Timeseriesdecompx11Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_decomp_x11_vector_norm(v : Timeseriesdecompx11Vector) -> Double { timeseries_decomp_x11_sqrt(timeseries_decomp_x11_vector_dot(v, v)) }

pub fn timeseries_decomp_x11_vector_normalize(v : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = timeseries_decomp_x11_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_decomp_x11_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_decomp_x11_vector_dist(a : Timeseriesdecompx11Vector, b : Timeseriesdecompx11Vector) -> Double {
  timeseries_decomp_x11_vector_norm(timeseries_decomp_x11_vector_sub(a, b))
}

pub fn timeseries_decomp_x11_vector_to_string(v : Timeseriesdecompx11Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + timeseries_decomp_x11_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_x11_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_x11_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_decomp_x11_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_x11_std(data : Array[Double]) -> Double { timeseries_decomp_x11_sqrt(timeseries_decomp_x11_var(data)) }

pub fn timeseries_decomp_x11_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_decomp_x11_mean(a); let mb = timeseries_decomp_x11_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_x11_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_decomp_x11_std(a); let sb = timeseries_decomp_x11_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_decomp_x11_cov(a, b) / (sa * sb) }
}

pub fn timeseries_decomp_x11_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_decomp_x11_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_decomp_x11_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_decomp_x11_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_x11_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  timeseries_decomp_x11_sqrt(timeseries_decomp_x11_mse(pred, labels))
}

pub fn timeseries_decomp_x11_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + timeseries_decomp_x11_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_decomp_x11_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_decomp_x11_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_decomp_x11_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_decomp_x11_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_decomp_x11_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_decomp_x11_precision(pred, labels, pos); let r = timeseries_decomp_x11_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_decomp_x11_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_decomp_x11_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_decomp_x11_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_decomp_x11_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_decomp_x11_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_decomp_x11_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_decomp_x11_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_decomp_x11_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_decomp_x11_fibonacci(n : Int) -> Int {
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

pub fn timeseries_decomp_x11_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_decomp_x11_min(data); let mx = timeseries_decomp_x11_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_decomp_x11_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_decomp_x11_mean(data); let sd = timeseries_decomp_x11_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_decomp_x11_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_decomp_x11_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_decomp_x11_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_decomp_x11_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn timeseries_decomp_x11_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn timeseries_decomp_x11_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn timeseries_decomp_x11_dbl(x : Double) -> String {
  let i = if x >= 0.0 { timeseries_decomp_x11_int(x) } else { -timeseries_decomp_x11_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { timeseries_decomp_x11_int(f * 1000000.0) } else { timeseries_decomp_x11_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn timeseries_decomp_x11_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn timeseries_decomp_x11_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Timeseriesdecompx11Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_frame_make(size : Int) -> Timeseriesdecompx11Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_frame_len(s : Timeseriesdecompx11Frame) -> Int { s.size }

pub fn timeseries_decomp_x11_frame_get(s : Timeseriesdecompx11Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_frame_set(s : Timeseriesdecompx11Frame, i : Int, v : Double) -> Timeseriesdecompx11Frame {
  let result = timeseries_decomp_x11_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_frame_sum(s : Timeseriesdecompx11Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_frame_mean(s : Timeseriesdecompx11Frame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_frame_scale(s : Timeseriesdecompx11Frame, f : Double) -> Timeseriesdecompx11Frame {
  let result = timeseries_decomp_x11_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_frame_add(a : Timeseriesdecompx11Frame, b : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_frame_copy(s : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  let result = timeseries_decomp_x11_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_frame_fill(s : Timeseriesdecompx11Frame, v : Double) -> Timeseriesdecompx11Frame {
  let result = timeseries_decomp_x11_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_frame_min(s : Timeseriesdecompx11Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_frame_max(s : Timeseriesdecompx11Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_frame_to_string(s : Timeseriesdecompx11Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_table_make(size : Int) -> Timeseriesdecompx11Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_table_len(s : Timeseriesdecompx11Table) -> Int { s.size }

pub fn timeseries_decomp_x11_table_get(s : Timeseriesdecompx11Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_table_set(s : Timeseriesdecompx11Table, i : Int, v : Double) -> Timeseriesdecompx11Table {
  let result = timeseries_decomp_x11_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_table_sum(s : Timeseriesdecompx11Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_table_mean(s : Timeseriesdecompx11Table) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_table_scale(s : Timeseriesdecompx11Table, f : Double) -> Timeseriesdecompx11Table {
  let result = timeseries_decomp_x11_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_table_add(a : Timeseriesdecompx11Table, b : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_table_copy(s : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  let result = timeseries_decomp_x11_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_table_fill(s : Timeseriesdecompx11Table, v : Double) -> Timeseriesdecompx11Table {
  let result = timeseries_decomp_x11_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_table_min(s : Timeseriesdecompx11Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_table_max(s : Timeseriesdecompx11Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_table_to_string(s : Timeseriesdecompx11Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_graphn_make(size : Int) -> Timeseriesdecompx11GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_graphn_len(s : Timeseriesdecompx11GraphN) -> Int { s.size }

pub fn timeseries_decomp_x11_graphn_get(s : Timeseriesdecompx11GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_graphn_set(s : Timeseriesdecompx11GraphN, i : Int, v : Double) -> Timeseriesdecompx11GraphN {
  let result = timeseries_decomp_x11_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_graphn_sum(s : Timeseriesdecompx11GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_graphn_mean(s : Timeseriesdecompx11GraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_graphn_scale(s : Timeseriesdecompx11GraphN, f : Double) -> Timeseriesdecompx11GraphN {
  let result = timeseries_decomp_x11_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_graphn_add(a : Timeseriesdecompx11GraphN, b : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_graphn_copy(s : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  let result = timeseries_decomp_x11_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_graphn_fill(s : Timeseriesdecompx11GraphN, v : Double) -> Timeseriesdecompx11GraphN {
  let result = timeseries_decomp_x11_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_graphn_min(s : Timeseriesdecompx11GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_graphn_max(s : Timeseriesdecompx11GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_graphn_to_string(s : Timeseriesdecompx11GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_node_make(size : Int) -> Timeseriesdecompx11Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_node_len(s : Timeseriesdecompx11Node) -> Int { s.size }

pub fn timeseries_decomp_x11_node_get(s : Timeseriesdecompx11Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_node_set(s : Timeseriesdecompx11Node, i : Int, v : Double) -> Timeseriesdecompx11Node {
  let result = timeseries_decomp_x11_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_node_sum(s : Timeseriesdecompx11Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_node_mean(s : Timeseriesdecompx11Node) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_node_scale(s : Timeseriesdecompx11Node, f : Double) -> Timeseriesdecompx11Node {
  let result = timeseries_decomp_x11_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_node_add(a : Timeseriesdecompx11Node, b : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_node_copy(s : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  let result = timeseries_decomp_x11_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_node_fill(s : Timeseriesdecompx11Node, v : Double) -> Timeseriesdecompx11Node {
  let result = timeseries_decomp_x11_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_node_min(s : Timeseriesdecompx11Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_node_max(s : Timeseriesdecompx11Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_node_to_string(s : Timeseriesdecompx11Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_edge_make(size : Int) -> Timeseriesdecompx11Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_edge_len(s : Timeseriesdecompx11Edge) -> Int { s.size }

pub fn timeseries_decomp_x11_edge_get(s : Timeseriesdecompx11Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_edge_set(s : Timeseriesdecompx11Edge, i : Int, v : Double) -> Timeseriesdecompx11Edge {
  let result = timeseries_decomp_x11_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_edge_sum(s : Timeseriesdecompx11Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_edge_mean(s : Timeseriesdecompx11Edge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_edge_scale(s : Timeseriesdecompx11Edge, f : Double) -> Timeseriesdecompx11Edge {
  let result = timeseries_decomp_x11_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_edge_add(a : Timeseriesdecompx11Edge, b : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_edge_copy(s : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  let result = timeseries_decomp_x11_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_edge_fill(s : Timeseriesdecompx11Edge, v : Double) -> Timeseriesdecompx11Edge {
  let result = timeseries_decomp_x11_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_edge_min(s : Timeseriesdecompx11Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_edge_max(s : Timeseriesdecompx11Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_edge_to_string(s : Timeseriesdecompx11Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_path_make(size : Int) -> Timeseriesdecompx11Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_path_len(s : Timeseriesdecompx11Path) -> Int { s.size }

pub fn timeseries_decomp_x11_path_get(s : Timeseriesdecompx11Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_path_set(s : Timeseriesdecompx11Path, i : Int, v : Double) -> Timeseriesdecompx11Path {
  let result = timeseries_decomp_x11_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_path_sum(s : Timeseriesdecompx11Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_path_mean(s : Timeseriesdecompx11Path) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_path_scale(s : Timeseriesdecompx11Path, f : Double) -> Timeseriesdecompx11Path {
  let result = timeseries_decomp_x11_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_path_add(a : Timeseriesdecompx11Path, b : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_path_copy(s : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  let result = timeseries_decomp_x11_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_path_fill(s : Timeseriesdecompx11Path, v : Double) -> Timeseriesdecompx11Path {
  let result = timeseries_decomp_x11_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_path_min(s : Timeseriesdecompx11Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_path_max(s : Timeseriesdecompx11Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_path_to_string(s : Timeseriesdecompx11Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cluster_make(size : Int) -> Timeseriesdecompx11Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_cluster_len(s : Timeseriesdecompx11Cluster) -> Int { s.size }

pub fn timeseries_decomp_x11_cluster_get(s : Timeseriesdecompx11Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_cluster_set(s : Timeseriesdecompx11Cluster, i : Int, v : Double) -> Timeseriesdecompx11Cluster {
  let result = timeseries_decomp_x11_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_cluster_sum(s : Timeseriesdecompx11Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_cluster_mean(s : Timeseriesdecompx11Cluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_cluster_scale(s : Timeseriesdecompx11Cluster, f : Double) -> Timeseriesdecompx11Cluster {
  let result = timeseries_decomp_x11_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_cluster_add(a : Timeseriesdecompx11Cluster, b : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_cluster_copy(s : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  let result = timeseries_decomp_x11_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_cluster_fill(s : Timeseriesdecompx11Cluster, v : Double) -> Timeseriesdecompx11Cluster {
  let result = timeseries_decomp_x11_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_cluster_min(s : Timeseriesdecompx11Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_cluster_max(s : Timeseriesdecompx11Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_cluster_to_string(s : Timeseriesdecompx11Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_model_make(size : Int) -> Timeseriesdecompx11Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_model_len(s : Timeseriesdecompx11Model) -> Int { s.size }

pub fn timeseries_decomp_x11_model_get(s : Timeseriesdecompx11Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_model_set(s : Timeseriesdecompx11Model, i : Int, v : Double) -> Timeseriesdecompx11Model {
  let result = timeseries_decomp_x11_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_model_sum(s : Timeseriesdecompx11Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_model_mean(s : Timeseriesdecompx11Model) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_model_scale(s : Timeseriesdecompx11Model, f : Double) -> Timeseriesdecompx11Model {
  let result = timeseries_decomp_x11_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_model_add(a : Timeseriesdecompx11Model, b : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_model_copy(s : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  let result = timeseries_decomp_x11_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_model_fill(s : Timeseriesdecompx11Model, v : Double) -> Timeseriesdecompx11Model {
  let result = timeseries_decomp_x11_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_model_min(s : Timeseriesdecompx11Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_model_max(s : Timeseriesdecompx11Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_model_to_string(s : Timeseriesdecompx11Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_layer_make(size : Int) -> Timeseriesdecompx11Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_layer_len(s : Timeseriesdecompx11Layer) -> Int { s.size }

pub fn timeseries_decomp_x11_layer_get(s : Timeseriesdecompx11Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_layer_set(s : Timeseriesdecompx11Layer, i : Int, v : Double) -> Timeseriesdecompx11Layer {
  let result = timeseries_decomp_x11_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_layer_sum(s : Timeseriesdecompx11Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_layer_mean(s : Timeseriesdecompx11Layer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_layer_scale(s : Timeseriesdecompx11Layer, f : Double) -> Timeseriesdecompx11Layer {
  let result = timeseries_decomp_x11_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_layer_add(a : Timeseriesdecompx11Layer, b : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_layer_copy(s : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  let result = timeseries_decomp_x11_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_layer_fill(s : Timeseriesdecompx11Layer, v : Double) -> Timeseriesdecompx11Layer {
  let result = timeseries_decomp_x11_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_layer_min(s : Timeseriesdecompx11Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_layer_max(s : Timeseriesdecompx11Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_layer_to_string(s : Timeseriesdecompx11Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_buffer_make(size : Int) -> Timeseriesdecompx11Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_buffer_len(s : Timeseriesdecompx11Buffer) -> Int { s.size }

pub fn timeseries_decomp_x11_buffer_get(s : Timeseriesdecompx11Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_buffer_set(s : Timeseriesdecompx11Buffer, i : Int, v : Double) -> Timeseriesdecompx11Buffer {
  let result = timeseries_decomp_x11_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_buffer_sum(s : Timeseriesdecompx11Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_buffer_mean(s : Timeseriesdecompx11Buffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_buffer_scale(s : Timeseriesdecompx11Buffer, f : Double) -> Timeseriesdecompx11Buffer {
  let result = timeseries_decomp_x11_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_buffer_add(a : Timeseriesdecompx11Buffer, b : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_buffer_copy(s : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  let result = timeseries_decomp_x11_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_buffer_fill(s : Timeseriesdecompx11Buffer, v : Double) -> Timeseriesdecompx11Buffer {
  let result = timeseries_decomp_x11_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_buffer_min(s : Timeseriesdecompx11Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_buffer_max(s : Timeseriesdecompx11Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_buffer_to_string(s : Timeseriesdecompx11Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cursor_make(size : Int) -> Timeseriesdecompx11Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_cursor_len(s : Timeseriesdecompx11Cursor) -> Int { s.size }

pub fn timeseries_decomp_x11_cursor_get(s : Timeseriesdecompx11Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_cursor_set(s : Timeseriesdecompx11Cursor, i : Int, v : Double) -> Timeseriesdecompx11Cursor {
  let result = timeseries_decomp_x11_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_cursor_sum(s : Timeseriesdecompx11Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_cursor_mean(s : Timeseriesdecompx11Cursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_cursor_scale(s : Timeseriesdecompx11Cursor, f : Double) -> Timeseriesdecompx11Cursor {
  let result = timeseries_decomp_x11_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_cursor_add(a : Timeseriesdecompx11Cursor, b : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_cursor_copy(s : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  let result = timeseries_decomp_x11_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_cursor_fill(s : Timeseriesdecompx11Cursor, v : Double) -> Timeseriesdecompx11Cursor {
  let result = timeseries_decomp_x11_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_cursor_min(s : Timeseriesdecompx11Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_cursor_max(s : Timeseriesdecompx11Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_cursor_to_string(s : Timeseriesdecompx11Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_view_make(size : Int) -> Timeseriesdecompx11View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_view_len(s : Timeseriesdecompx11View) -> Int { s.size }

pub fn timeseries_decomp_x11_view_get(s : Timeseriesdecompx11View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_view_set(s : Timeseriesdecompx11View, i : Int, v : Double) -> Timeseriesdecompx11View {
  let result = timeseries_decomp_x11_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_view_sum(s : Timeseriesdecompx11View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_view_mean(s : Timeseriesdecompx11View) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_view_scale(s : Timeseriesdecompx11View, f : Double) -> Timeseriesdecompx11View {
  let result = timeseries_decomp_x11_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_view_add(a : Timeseriesdecompx11View, b : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_view_copy(s : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  let result = timeseries_decomp_x11_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_view_fill(s : Timeseriesdecompx11View, v : Double) -> Timeseriesdecompx11View {
  let result = timeseries_decomp_x11_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_view_min(s : Timeseriesdecompx11View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_view_max(s : Timeseriesdecompx11View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_view_to_string(s : Timeseriesdecompx11View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_range_make(size : Int) -> Timeseriesdecompx11Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_range_len(s : Timeseriesdecompx11Range) -> Int { s.size }

pub fn timeseries_decomp_x11_range_get(s : Timeseriesdecompx11Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_range_set(s : Timeseriesdecompx11Range, i : Int, v : Double) -> Timeseriesdecompx11Range {
  let result = timeseries_decomp_x11_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_range_sum(s : Timeseriesdecompx11Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_range_mean(s : Timeseriesdecompx11Range) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_range_scale(s : Timeseriesdecompx11Range, f : Double) -> Timeseriesdecompx11Range {
  let result = timeseries_decomp_x11_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_range_add(a : Timeseriesdecompx11Range, b : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_range_copy(s : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  let result = timeseries_decomp_x11_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_range_fill(s : Timeseriesdecompx11Range, v : Double) -> Timeseriesdecompx11Range {
  let result = timeseries_decomp_x11_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_range_min(s : Timeseriesdecompx11Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_range_max(s : Timeseriesdecompx11Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_range_to_string(s : Timeseriesdecompx11Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_slice_make(size : Int) -> Timeseriesdecompx11Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_slice_len(s : Timeseriesdecompx11Slice) -> Int { s.size }

pub fn timeseries_decomp_x11_slice_get(s : Timeseriesdecompx11Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_slice_set(s : Timeseriesdecompx11Slice, i : Int, v : Double) -> Timeseriesdecompx11Slice {
  let result = timeseries_decomp_x11_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_slice_sum(s : Timeseriesdecompx11Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_decomp_x11_slice_mean(s : Timeseriesdecompx11Slice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_decomp_x11_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_decomp_x11_slice_scale(s : Timeseriesdecompx11Slice, f : Double) -> Timeseriesdecompx11Slice {
  let result = timeseries_decomp_x11_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_decomp_x11_slice_add(a : Timeseriesdecompx11Slice, b : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_decomp_x11_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_decomp_x11_slice_copy(s : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  let result = timeseries_decomp_x11_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_decomp_x11_slice_fill(s : Timeseriesdecompx11Slice, v : Double) -> Timeseriesdecompx11Slice {
  let result = timeseries_decomp_x11_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_decomp_x11_slice_min(s : Timeseriesdecompx11Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_slice_max(s : Timeseriesdecompx11Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_decomp_x11_slice_to_string(s : Timeseriesdecompx11Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn timeseries_decomp_x11_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn timeseries_decomp_x11_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}


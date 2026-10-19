///===
/// extcore/timeseries_winters

pub(all) struct TimeserieswintersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_winters_make_point(x : Double, y : Double) -> TimeserieswintersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_winters_make_point3(x : Double, y : Double, z : Double) -> TimeserieswintersPoint {
  { x, y, z, label: 0 }
}

pub fn timeseries_winters_point_x(pt : TimeserieswintersPoint) -> Double { pt.x }

pub fn timeseries_winters_point_y(pt : TimeserieswintersPoint) -> Double { pt.y }

pub fn timeseries_winters_point_z(pt : TimeserieswintersPoint) -> Double { pt.z }

pub fn timeseries_winters_point_label(pt : TimeserieswintersPoint) -> Int { pt.label }

pub fn timeseries_winters_point_dist(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn timeseries_winters_point_add(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn timeseries_winters_point_sub(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn timeseries_winters_point_scale(pt : TimeserieswintersPoint, s : Double) -> TimeserieswintersPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn timeseries_winters_point_dot(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn timeseries_winters_point_cross(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn timeseries_winters_point_norm(pt : TimeserieswintersPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn timeseries_winters_point_normalize(pt : TimeserieswintersPoint) -> TimeserieswintersPoint {
  let n = timeseries_winters_point_norm(pt)
  if n < 0.0000001 { pt } else { timeseries_winters_point_scale(pt, 1.0 / n) }
}

pub fn timeseries_winters_point_negate(pt : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn timeseries_winters_point_mid(a : TimeserieswintersPoint, b : TimeserieswintersPoint) -> TimeserieswintersPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn timeseries_winters_point_lerp(a : TimeserieswintersPoint, b : TimeserieswintersPoint, t : Double) -> TimeserieswintersPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn timeseries_winters_point_to_string(pt : TimeserieswintersPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct TimeserieswintersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_winters_make_series(vals : Array[Double], name : String) -> TimeserieswintersSeries {
  { vals, name, meta: 0 }
}

pub fn timeseries_winters_series_len(s : TimeserieswintersSeries) -> Int { s.vals.length() }

pub fn timeseries_winters_series_sum(s : TimeserieswintersSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn timeseries_winters_series_mean(s : TimeserieswintersSeries) -> Double {
  let n = timeseries_winters_series_len(s)
  if n == 0 { 0.0 } else { timeseries_winters_series_sum(s) / n.to_double() }
}

pub fn timeseries_winters_series_min(s : TimeserieswintersSeries) -> Double {
  let n = timeseries_winters_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_winters_series_max(s : TimeserieswintersSeries) -> Double {
  let n = timeseries_winters_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn timeseries_winters_series_range(s : TimeserieswintersSeries) -> Double {
  timeseries_winters_series_max(s) - timeseries_winters_series_min(s)
}

pub fn timeseries_winters_series_var(s : TimeserieswintersSeries) -> Double {
  let n = timeseries_winters_series_len(s)
  if n == 0 { 0.0 } else {
    let m = timeseries_winters_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn timeseries_winters_series_std(s : TimeserieswintersSeries) -> Double { @_common.sqrt(timeseries_winters_series_var(s)) }

pub fn timeseries_winters_series_median(s : TimeserieswintersSeries) -> Double {
  let n = timeseries_winters_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = timeseries_winters_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_winters_series_scale(s : TimeserieswintersSeries, f : Double) -> TimeserieswintersSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn timeseries_winters_series_add(a : TimeserieswintersSeries, b : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn timeseries_winters_series_sub(a : TimeserieswintersSeries, b : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn timeseries_winters_series_normalize(s : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let mn = timeseries_winters_series_min(s)
  let mx = timeseries_winters_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn timeseries_winters_series_cumsum(s : TimeserieswintersSeries) -> TimeserieswintersSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn timeseries_winters_series_to_string(s : TimeserieswintersSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeserieswintersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_winters_make_matrix(rows : Int, cols : Int, val : Double) -> TimeserieswintersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_winters_matrix_identity(n : Int) -> TimeserieswintersMatrix {
  let m = timeseries_winters_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn timeseries_winters_matrix_get(m : TimeserieswintersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn timeseries_winters_matrix_transpose(m : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn timeseries_winters_matrix_add(a : TimeserieswintersMatrix, b : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = timeseries_winters_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn timeseries_winters_matrix_scale(m : TimeserieswintersMatrix, s : Double) -> TimeserieswintersMatrix {
  let result = timeseries_winters_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn timeseries_winters_matrix_multiply(a : TimeserieswintersMatrix, b : TimeserieswintersMatrix) -> TimeserieswintersMatrix {
  if a.cols != b.rows { return timeseries_winters_make_matrix(a.rows, b.cols, 0.0) }
  let result = timeseries_winters_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn timeseries_winters_matrix_trace(m : TimeserieswintersMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn timeseries_winters_matrix_det(m : TimeserieswintersMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn timeseries_winters_matrix_norm(m : TimeserieswintersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn timeseries_winters_matrix_to_string(m : TimeserieswintersMatrix) -> String {
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

pub(all) struct TimeserieswintersVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_winters_make_vector(comps : Array[Double]) -> TimeserieswintersVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_winters_vector_zero(dim : Int) -> TimeserieswintersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn timeseries_winters_vector_add(a : TimeserieswintersVector, b : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_winters_vector_sub(a : TimeserieswintersVector, b : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn timeseries_winters_vector_scale(v : TimeserieswintersVector, s : Double) -> TimeserieswintersVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn timeseries_winters_vector_dot(a : TimeserieswintersVector, b : TimeserieswintersVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn timeseries_winters_vector_norm(v : TimeserieswintersVector) -> Double { @_common.sqrt(timeseries_winters_vector_dot(v, v)) }

pub fn timeseries_winters_vector_normalize(v : TimeserieswintersVector) -> TimeserieswintersVector {
  let n = timeseries_winters_vector_norm(v)
  if n < 0.0000001 { v } else { timeseries_winters_vector_scale(v, 1.0 / n) }
}

pub fn timeseries_winters_vector_dist(a : TimeserieswintersVector, b : TimeserieswintersVector) -> Double {
  timeseries_winters_vector_norm(timeseries_winters_vector_sub(a, b))
}

pub fn timeseries_winters_vector_to_string(v : TimeserieswintersVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_winters_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn timeseries_winters_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = timeseries_winters_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_winters_std(data : Array[Double]) -> Double { @_common.sqrt(timeseries_winters_var(data)) }

pub fn timeseries_winters_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = timeseries_winters_mean(a); let mb = timeseries_winters_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn timeseries_winters_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = timeseries_winters_std(a); let sb = timeseries_winters_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { timeseries_winters_cov(a, b) / (sa * sb) }
}

pub fn timeseries_winters_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = timeseries_winters_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn timeseries_winters_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn timeseries_winters_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn timeseries_winters_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(timeseries_winters_mse(pred, labels))
}

pub fn timeseries_winters_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn timeseries_winters_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = timeseries_winters_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn timeseries_winters_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn timeseries_winters_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn timeseries_winters_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = timeseries_winters_precision(pred, labels, pos); let r = timeseries_winters_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn timeseries_winters_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn timeseries_winters_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = timeseries_winters_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn timeseries_winters_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn timeseries_winters_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn timeseries_winters_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = timeseries_winters_gcd(a, b)
    (a / g) * b
  }
}

pub fn timeseries_winters_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn timeseries_winters_fibonacci(n : Int) -> Int {
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

pub fn timeseries_winters_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = timeseries_winters_min(data); let mx = timeseries_winters_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn timeseries_winters_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = timeseries_winters_mean(data); let sd = timeseries_winters_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn timeseries_winters_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn timeseries_winters_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn timeseries_winters_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn timeseries_winters_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn timeseries_winters_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn timeseries_winters_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct TimeserieswintersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_frame_make(size : Int) -> TimeserieswintersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_frame_len(s : TimeserieswintersFrame) -> Int { s.size }

pub fn timeseries_winters_frame_get(s : TimeserieswintersFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_frame_set(s : TimeserieswintersFrame, i : Int, v : Double) -> TimeserieswintersFrame {
  let result = timeseries_winters_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_frame_sum(s : TimeserieswintersFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_frame_mean(s : TimeserieswintersFrame) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_frame_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_frame_scale(s : TimeserieswintersFrame, f : Double) -> TimeserieswintersFrame {
  let result = timeseries_winters_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_frame_add(a : TimeserieswintersFrame, b : TimeserieswintersFrame) -> TimeserieswintersFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_frame_copy(s : TimeserieswintersFrame) -> TimeserieswintersFrame {
  let result = timeseries_winters_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_frame_fill(s : TimeserieswintersFrame, v : Double) -> TimeserieswintersFrame {
  let result = timeseries_winters_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_frame_min(s : TimeserieswintersFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_frame_max(s : TimeserieswintersFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_frame_to_string(s : TimeserieswintersFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_table_make(size : Int) -> TimeserieswintersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_table_len(s : TimeserieswintersTable) -> Int { s.size }

pub fn timeseries_winters_table_get(s : TimeserieswintersTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_table_set(s : TimeserieswintersTable, i : Int, v : Double) -> TimeserieswintersTable {
  let result = timeseries_winters_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_table_sum(s : TimeserieswintersTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_table_mean(s : TimeserieswintersTable) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_table_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_table_scale(s : TimeserieswintersTable, f : Double) -> TimeserieswintersTable {
  let result = timeseries_winters_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_table_add(a : TimeserieswintersTable, b : TimeserieswintersTable) -> TimeserieswintersTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_table_copy(s : TimeserieswintersTable) -> TimeserieswintersTable {
  let result = timeseries_winters_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_table_fill(s : TimeserieswintersTable, v : Double) -> TimeserieswintersTable {
  let result = timeseries_winters_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_table_min(s : TimeserieswintersTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_table_max(s : TimeserieswintersTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_table_to_string(s : TimeserieswintersTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_graphn_make(size : Int) -> TimeserieswintersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_graphn_len(s : TimeserieswintersGraphN) -> Int { s.size }

pub fn timeseries_winters_graphn_get(s : TimeserieswintersGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_graphn_set(s : TimeserieswintersGraphN, i : Int, v : Double) -> TimeserieswintersGraphN {
  let result = timeseries_winters_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_graphn_sum(s : TimeserieswintersGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_graphn_mean(s : TimeserieswintersGraphN) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_graphn_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_graphn_scale(s : TimeserieswintersGraphN, f : Double) -> TimeserieswintersGraphN {
  let result = timeseries_winters_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_graphn_add(a : TimeserieswintersGraphN, b : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_graphn_copy(s : TimeserieswintersGraphN) -> TimeserieswintersGraphN {
  let result = timeseries_winters_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_graphn_fill(s : TimeserieswintersGraphN, v : Double) -> TimeserieswintersGraphN {
  let result = timeseries_winters_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_graphn_min(s : TimeserieswintersGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_graphn_max(s : TimeserieswintersGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_graphn_to_string(s : TimeserieswintersGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_node_make(size : Int) -> TimeserieswintersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_node_len(s : TimeserieswintersNode) -> Int { s.size }

pub fn timeseries_winters_node_get(s : TimeserieswintersNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_node_set(s : TimeserieswintersNode, i : Int, v : Double) -> TimeserieswintersNode {
  let result = timeseries_winters_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_node_sum(s : TimeserieswintersNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_node_mean(s : TimeserieswintersNode) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_node_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_node_scale(s : TimeserieswintersNode, f : Double) -> TimeserieswintersNode {
  let result = timeseries_winters_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_node_add(a : TimeserieswintersNode, b : TimeserieswintersNode) -> TimeserieswintersNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_node_copy(s : TimeserieswintersNode) -> TimeserieswintersNode {
  let result = timeseries_winters_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_node_fill(s : TimeserieswintersNode, v : Double) -> TimeserieswintersNode {
  let result = timeseries_winters_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_node_min(s : TimeserieswintersNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_node_max(s : TimeserieswintersNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_node_to_string(s : TimeserieswintersNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_edge_make(size : Int) -> TimeserieswintersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_edge_len(s : TimeserieswintersEdge) -> Int { s.size }

pub fn timeseries_winters_edge_get(s : TimeserieswintersEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_edge_set(s : TimeserieswintersEdge, i : Int, v : Double) -> TimeserieswintersEdge {
  let result = timeseries_winters_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_edge_sum(s : TimeserieswintersEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_edge_mean(s : TimeserieswintersEdge) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_edge_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_edge_scale(s : TimeserieswintersEdge, f : Double) -> TimeserieswintersEdge {
  let result = timeseries_winters_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_edge_add(a : TimeserieswintersEdge, b : TimeserieswintersEdge) -> TimeserieswintersEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_edge_copy(s : TimeserieswintersEdge) -> TimeserieswintersEdge {
  let result = timeseries_winters_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_edge_fill(s : TimeserieswintersEdge, v : Double) -> TimeserieswintersEdge {
  let result = timeseries_winters_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_edge_min(s : TimeserieswintersEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_edge_max(s : TimeserieswintersEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_edge_to_string(s : TimeserieswintersEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_path_make(size : Int) -> TimeserieswintersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_path_len(s : TimeserieswintersPath) -> Int { s.size }

pub fn timeseries_winters_path_get(s : TimeserieswintersPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_path_set(s : TimeserieswintersPath, i : Int, v : Double) -> TimeserieswintersPath {
  let result = timeseries_winters_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_path_sum(s : TimeserieswintersPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_path_mean(s : TimeserieswintersPath) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_path_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_path_scale(s : TimeserieswintersPath, f : Double) -> TimeserieswintersPath {
  let result = timeseries_winters_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_path_add(a : TimeserieswintersPath, b : TimeserieswintersPath) -> TimeserieswintersPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_path_copy(s : TimeserieswintersPath) -> TimeserieswintersPath {
  let result = timeseries_winters_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_path_fill(s : TimeserieswintersPath, v : Double) -> TimeserieswintersPath {
  let result = timeseries_winters_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_path_min(s : TimeserieswintersPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_path_max(s : TimeserieswintersPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_path_to_string(s : TimeserieswintersPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cluster_make(size : Int) -> TimeserieswintersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_cluster_len(s : TimeserieswintersCluster) -> Int { s.size }

pub fn timeseries_winters_cluster_get(s : TimeserieswintersCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_cluster_set(s : TimeserieswintersCluster, i : Int, v : Double) -> TimeserieswintersCluster {
  let result = timeseries_winters_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_cluster_sum(s : TimeserieswintersCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_cluster_mean(s : TimeserieswintersCluster) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_cluster_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_cluster_scale(s : TimeserieswintersCluster, f : Double) -> TimeserieswintersCluster {
  let result = timeseries_winters_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_cluster_add(a : TimeserieswintersCluster, b : TimeserieswintersCluster) -> TimeserieswintersCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_cluster_copy(s : TimeserieswintersCluster) -> TimeserieswintersCluster {
  let result = timeseries_winters_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_cluster_fill(s : TimeserieswintersCluster, v : Double) -> TimeserieswintersCluster {
  let result = timeseries_winters_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_cluster_min(s : TimeserieswintersCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_cluster_max(s : TimeserieswintersCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_cluster_to_string(s : TimeserieswintersCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_model_make(size : Int) -> TimeserieswintersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_model_len(s : TimeserieswintersModel) -> Int { s.size }

pub fn timeseries_winters_model_get(s : TimeserieswintersModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_model_set(s : TimeserieswintersModel, i : Int, v : Double) -> TimeserieswintersModel {
  let result = timeseries_winters_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_model_sum(s : TimeserieswintersModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_model_mean(s : TimeserieswintersModel) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_model_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_model_scale(s : TimeserieswintersModel, f : Double) -> TimeserieswintersModel {
  let result = timeseries_winters_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_model_add(a : TimeserieswintersModel, b : TimeserieswintersModel) -> TimeserieswintersModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_model_copy(s : TimeserieswintersModel) -> TimeserieswintersModel {
  let result = timeseries_winters_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_model_fill(s : TimeserieswintersModel, v : Double) -> TimeserieswintersModel {
  let result = timeseries_winters_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_model_min(s : TimeserieswintersModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_model_max(s : TimeserieswintersModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_model_to_string(s : TimeserieswintersModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_layer_make(size : Int) -> TimeserieswintersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_layer_len(s : TimeserieswintersLayer) -> Int { s.size }

pub fn timeseries_winters_layer_get(s : TimeserieswintersLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_layer_set(s : TimeserieswintersLayer, i : Int, v : Double) -> TimeserieswintersLayer {
  let result = timeseries_winters_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_layer_sum(s : TimeserieswintersLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_layer_mean(s : TimeserieswintersLayer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_layer_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_layer_scale(s : TimeserieswintersLayer, f : Double) -> TimeserieswintersLayer {
  let result = timeseries_winters_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_layer_add(a : TimeserieswintersLayer, b : TimeserieswintersLayer) -> TimeserieswintersLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_layer_copy(s : TimeserieswintersLayer) -> TimeserieswintersLayer {
  let result = timeseries_winters_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_layer_fill(s : TimeserieswintersLayer, v : Double) -> TimeserieswintersLayer {
  let result = timeseries_winters_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_layer_min(s : TimeserieswintersLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_layer_max(s : TimeserieswintersLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_layer_to_string(s : TimeserieswintersLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_buffer_make(size : Int) -> TimeserieswintersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_buffer_len(s : TimeserieswintersBuffer) -> Int { s.size }

pub fn timeseries_winters_buffer_get(s : TimeserieswintersBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_buffer_set(s : TimeserieswintersBuffer, i : Int, v : Double) -> TimeserieswintersBuffer {
  let result = timeseries_winters_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_buffer_sum(s : TimeserieswintersBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_buffer_mean(s : TimeserieswintersBuffer) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_buffer_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_buffer_scale(s : TimeserieswintersBuffer, f : Double) -> TimeserieswintersBuffer {
  let result = timeseries_winters_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_buffer_add(a : TimeserieswintersBuffer, b : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_buffer_copy(s : TimeserieswintersBuffer) -> TimeserieswintersBuffer {
  let result = timeseries_winters_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_buffer_fill(s : TimeserieswintersBuffer, v : Double) -> TimeserieswintersBuffer {
  let result = timeseries_winters_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_buffer_min(s : TimeserieswintersBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_buffer_max(s : TimeserieswintersBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_buffer_to_string(s : TimeserieswintersBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_cursor_make(size : Int) -> TimeserieswintersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_cursor_len(s : TimeserieswintersCursor) -> Int { s.size }

pub fn timeseries_winters_cursor_get(s : TimeserieswintersCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_cursor_set(s : TimeserieswintersCursor, i : Int, v : Double) -> TimeserieswintersCursor {
  let result = timeseries_winters_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_cursor_sum(s : TimeserieswintersCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_cursor_mean(s : TimeserieswintersCursor) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_cursor_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_cursor_scale(s : TimeserieswintersCursor, f : Double) -> TimeserieswintersCursor {
  let result = timeseries_winters_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_cursor_add(a : TimeserieswintersCursor, b : TimeserieswintersCursor) -> TimeserieswintersCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_cursor_copy(s : TimeserieswintersCursor) -> TimeserieswintersCursor {
  let result = timeseries_winters_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_cursor_fill(s : TimeserieswintersCursor, v : Double) -> TimeserieswintersCursor {
  let result = timeseries_winters_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_cursor_min(s : TimeserieswintersCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_cursor_max(s : TimeserieswintersCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_cursor_to_string(s : TimeserieswintersCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_view_make(size : Int) -> TimeserieswintersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_view_len(s : TimeserieswintersView) -> Int { s.size }

pub fn timeseries_winters_view_get(s : TimeserieswintersView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_view_set(s : TimeserieswintersView, i : Int, v : Double) -> TimeserieswintersView {
  let result = timeseries_winters_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_view_sum(s : TimeserieswintersView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_view_mean(s : TimeserieswintersView) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_view_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_view_scale(s : TimeserieswintersView, f : Double) -> TimeserieswintersView {
  let result = timeseries_winters_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_view_add(a : TimeserieswintersView, b : TimeserieswintersView) -> TimeserieswintersView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_view_copy(s : TimeserieswintersView) -> TimeserieswintersView {
  let result = timeseries_winters_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_view_fill(s : TimeserieswintersView, v : Double) -> TimeserieswintersView {
  let result = timeseries_winters_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_view_min(s : TimeserieswintersView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_view_max(s : TimeserieswintersView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_view_to_string(s : TimeserieswintersView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_range_make(size : Int) -> TimeserieswintersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_range_len(s : TimeserieswintersRange) -> Int { s.size }

pub fn timeseries_winters_range_get(s : TimeserieswintersRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_range_set(s : TimeserieswintersRange, i : Int, v : Double) -> TimeserieswintersRange {
  let result = timeseries_winters_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_range_sum(s : TimeserieswintersRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_range_mean(s : TimeserieswintersRange) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_range_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_range_scale(s : TimeserieswintersRange, f : Double) -> TimeserieswintersRange {
  let result = timeseries_winters_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_range_add(a : TimeserieswintersRange, b : TimeserieswintersRange) -> TimeserieswintersRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_range_copy(s : TimeserieswintersRange) -> TimeserieswintersRange {
  let result = timeseries_winters_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_range_fill(s : TimeserieswintersRange, v : Double) -> TimeserieswintersRange {
  let result = timeseries_winters_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_range_min(s : TimeserieswintersRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_range_max(s : TimeserieswintersRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_range_to_string(s : TimeserieswintersRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeserieswintersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_winters_slice_make(size : Int) -> TimeserieswintersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_winters_slice_len(s : TimeserieswintersSlice) -> Int { s.size }

pub fn timeseries_winters_slice_get(s : TimeserieswintersSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_winters_slice_set(s : TimeserieswintersSlice, i : Int, v : Double) -> TimeserieswintersSlice {
  let result = timeseries_winters_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_slice_sum(s : TimeserieswintersSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn timeseries_winters_slice_mean(s : TimeserieswintersSlice) -> Double {
  if s.size == 0 { 0.0 } else { timeseries_winters_slice_sum(s) / s.size.to_double() }
}

pub fn timeseries_winters_slice_scale(s : TimeserieswintersSlice, f : Double) -> TimeserieswintersSlice {
  let result = timeseries_winters_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn timeseries_winters_slice_add(a : TimeserieswintersSlice, b : TimeserieswintersSlice) -> TimeserieswintersSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = timeseries_winters_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn timeseries_winters_slice_copy(s : TimeserieswintersSlice) -> TimeserieswintersSlice {
  let result = timeseries_winters_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn timeseries_winters_slice_fill(s : TimeserieswintersSlice, v : Double) -> TimeserieswintersSlice {
  let result = timeseries_winters_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn timeseries_winters_slice_min(s : TimeserieswintersSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_slice_max(s : TimeserieswintersSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn timeseries_winters_slice_to_string(s : TimeserieswintersSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


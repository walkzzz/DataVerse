///===
/// extcore/physics_heat_insulation

pub(all) struct PhysicsheatinsulationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_insulation_make_point(x : Double, y : Double) -> PhysicsheatinsulationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_insulation_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatinsulationPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_insulation_point_x(pt : PhysicsheatinsulationPoint) -> Double { pt.x }

pub fn physics_heat_insulation_point_y(pt : PhysicsheatinsulationPoint) -> Double { pt.y }

pub fn physics_heat_insulation_point_z(pt : PhysicsheatinsulationPoint) -> Double { pt.z }

pub fn physics_heat_insulation_point_label(pt : PhysicsheatinsulationPoint) -> Int { pt.label }

pub fn physics_heat_insulation_point_dist(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_insulation_point_add(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_insulation_point_sub(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_insulation_point_scale(pt : PhysicsheatinsulationPoint, s : Double) -> PhysicsheatinsulationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_insulation_point_dot(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_insulation_point_cross(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_insulation_point_norm(pt : PhysicsheatinsulationPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_insulation_point_normalize(pt : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  let n = physics_heat_insulation_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_insulation_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_insulation_point_negate(pt : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_insulation_point_mid(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint) -> PhysicsheatinsulationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_insulation_point_lerp(a : PhysicsheatinsulationPoint, b : PhysicsheatinsulationPoint, t : Double) -> PhysicsheatinsulationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_insulation_point_to_string(pt : PhysicsheatinsulationPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_insulation_make_series(vals : Array[Double], name : String) -> PhysicsheatinsulationSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_insulation_series_len(s : PhysicsheatinsulationSeries) -> Int { s.vals.length() }

pub fn physics_heat_insulation_series_sum(s : PhysicsheatinsulationSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_insulation_series_mean(s : PhysicsheatinsulationSeries) -> Double {
  let n = physics_heat_insulation_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_insulation_series_sum(s) / n.to_double() }
}

pub fn physics_heat_insulation_series_min(s : PhysicsheatinsulationSeries) -> Double {
  let n = physics_heat_insulation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_insulation_series_max(s : PhysicsheatinsulationSeries) -> Double {
  let n = physics_heat_insulation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_insulation_series_range(s : PhysicsheatinsulationSeries) -> Double {
  physics_heat_insulation_series_max(s) - physics_heat_insulation_series_min(s)
}

pub fn physics_heat_insulation_series_var(s : PhysicsheatinsulationSeries) -> Double {
  let n = physics_heat_insulation_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_insulation_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_insulation_series_std(s : PhysicsheatinsulationSeries) -> Double { @_common.sqrt(physics_heat_insulation_series_var(s)) }

pub fn physics_heat_insulation_series_median(s : PhysicsheatinsulationSeries) -> Double {
  let n = physics_heat_insulation_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_insulation_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_insulation_series_scale(s : PhysicsheatinsulationSeries, f : Double) -> PhysicsheatinsulationSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_insulation_series_add(a : PhysicsheatinsulationSeries, b : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_insulation_series_sub(a : PhysicsheatinsulationSeries, b : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_insulation_series_normalize(s : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  let mn = physics_heat_insulation_series_min(s)
  let mx = physics_heat_insulation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_insulation_series_cumsum(s : PhysicsheatinsulationSeries) -> PhysicsheatinsulationSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_insulation_series_to_string(s : PhysicsheatinsulationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatinsulationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_insulation_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatinsulationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_insulation_matrix_identity(n : Int) -> PhysicsheatinsulationMatrix {
  let m = physics_heat_insulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_insulation_matrix_get(m : PhysicsheatinsulationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_insulation_matrix_transpose(m : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  let result = physics_heat_insulation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_insulation_matrix_add(a : PhysicsheatinsulationMatrix, b : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_insulation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_insulation_matrix_scale(m : PhysicsheatinsulationMatrix, s : Double) -> PhysicsheatinsulationMatrix {
  let result = physics_heat_insulation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_insulation_matrix_multiply(a : PhysicsheatinsulationMatrix, b : PhysicsheatinsulationMatrix) -> PhysicsheatinsulationMatrix {
  if a.cols != b.rows { return physics_heat_insulation_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_insulation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_insulation_matrix_trace(m : PhysicsheatinsulationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_insulation_matrix_det(m : PhysicsheatinsulationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_insulation_matrix_norm(m : PhysicsheatinsulationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_insulation_matrix_to_string(m : PhysicsheatinsulationMatrix) -> String {
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

pub(all) struct PhysicsheatinsulationVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_insulation_make_vector(comps : Array[Double]) -> PhysicsheatinsulationVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_insulation_vector_zero(dim : Int) -> PhysicsheatinsulationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_insulation_vector_add(a : PhysicsheatinsulationVector, b : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_insulation_vector_sub(a : PhysicsheatinsulationVector, b : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_insulation_vector_scale(v : PhysicsheatinsulationVector, s : Double) -> PhysicsheatinsulationVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_insulation_vector_dot(a : PhysicsheatinsulationVector, b : PhysicsheatinsulationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_insulation_vector_norm(v : PhysicsheatinsulationVector) -> Double { @_common.sqrt(physics_heat_insulation_vector_dot(v, v)) }

pub fn physics_heat_insulation_vector_normalize(v : PhysicsheatinsulationVector) -> PhysicsheatinsulationVector {
  let n = physics_heat_insulation_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_insulation_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_insulation_vector_dist(a : PhysicsheatinsulationVector, b : PhysicsheatinsulationVector) -> Double {
  physics_heat_insulation_vector_norm(physics_heat_insulation_vector_sub(a, b))
}

pub fn physics_heat_insulation_vector_to_string(v : PhysicsheatinsulationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_insulation_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn physics_heat_insulation_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = physics_heat_insulation_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_insulation_std(data : Array[Double]) -> Double { @_common.sqrt(physics_heat_insulation_var(data)) }

pub fn physics_heat_insulation_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = physics_heat_insulation_mean(a); let mb = physics_heat_insulation_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn physics_heat_insulation_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = physics_heat_insulation_std(a); let sb = physics_heat_insulation_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { physics_heat_insulation_cov(a, b) / (sa * sb) }
}

pub fn physics_heat_insulation_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_insulation_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_insulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn physics_heat_insulation_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn physics_heat_insulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(physics_heat_insulation_mse(pred, labels))
}

pub fn physics_heat_insulation_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn physics_heat_insulation_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = physics_heat_insulation_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn physics_heat_insulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn physics_heat_insulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn physics_heat_insulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = physics_heat_insulation_precision(pred, labels, pos); let r = physics_heat_insulation_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn physics_heat_insulation_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn physics_heat_insulation_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = physics_heat_insulation_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn physics_heat_insulation_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn physics_heat_insulation_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn physics_heat_insulation_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = physics_heat_insulation_gcd(a, b)
    (a / g) * b
  }
}

pub fn physics_heat_insulation_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn physics_heat_insulation_fibonacci(n : Int) -> Int {
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

pub fn physics_heat_insulation_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = physics_heat_insulation_min(data); let mx = physics_heat_insulation_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn physics_heat_insulation_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = physics_heat_insulation_mean(data); let sd = physics_heat_insulation_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn physics_heat_insulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn physics_heat_insulation_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn physics_heat_insulation_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn physics_heat_insulation_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn physics_heat_insulation_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn physics_heat_insulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct PhysicsheatinsulationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_frame_make(size : Int) -> PhysicsheatinsulationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_frame_len(s : PhysicsheatinsulationFrame) -> Int { s.size }

pub fn physics_heat_insulation_frame_get(s : PhysicsheatinsulationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_frame_set(s : PhysicsheatinsulationFrame, i : Int, v : Double) -> PhysicsheatinsulationFrame {
  let result = physics_heat_insulation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_frame_sum(s : PhysicsheatinsulationFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_frame_mean(s : PhysicsheatinsulationFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_frame_scale(s : PhysicsheatinsulationFrame, f : Double) -> PhysicsheatinsulationFrame {
  let result = physics_heat_insulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_frame_add(a : PhysicsheatinsulationFrame, b : PhysicsheatinsulationFrame) -> PhysicsheatinsulationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_frame_copy(s : PhysicsheatinsulationFrame) -> PhysicsheatinsulationFrame {
  let result = physics_heat_insulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_frame_fill(s : PhysicsheatinsulationFrame, v : Double) -> PhysicsheatinsulationFrame {
  let result = physics_heat_insulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_frame_min(s : PhysicsheatinsulationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_frame_max(s : PhysicsheatinsulationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_frame_to_string(s : PhysicsheatinsulationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_table_make(size : Int) -> PhysicsheatinsulationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_table_len(s : PhysicsheatinsulationTable) -> Int { s.size }

pub fn physics_heat_insulation_table_get(s : PhysicsheatinsulationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_table_set(s : PhysicsheatinsulationTable, i : Int, v : Double) -> PhysicsheatinsulationTable {
  let result = physics_heat_insulation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_table_sum(s : PhysicsheatinsulationTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_table_mean(s : PhysicsheatinsulationTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_table_scale(s : PhysicsheatinsulationTable, f : Double) -> PhysicsheatinsulationTable {
  let result = physics_heat_insulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_table_add(a : PhysicsheatinsulationTable, b : PhysicsheatinsulationTable) -> PhysicsheatinsulationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_table_copy(s : PhysicsheatinsulationTable) -> PhysicsheatinsulationTable {
  let result = physics_heat_insulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_table_fill(s : PhysicsheatinsulationTable, v : Double) -> PhysicsheatinsulationTable {
  let result = physics_heat_insulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_table_min(s : PhysicsheatinsulationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_table_max(s : PhysicsheatinsulationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_table_to_string(s : PhysicsheatinsulationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_graphn_make(size : Int) -> PhysicsheatinsulationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_graphn_len(s : PhysicsheatinsulationGraphN) -> Int { s.size }

pub fn physics_heat_insulation_graphn_get(s : PhysicsheatinsulationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_graphn_set(s : PhysicsheatinsulationGraphN, i : Int, v : Double) -> PhysicsheatinsulationGraphN {
  let result = physics_heat_insulation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_graphn_sum(s : PhysicsheatinsulationGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_graphn_mean(s : PhysicsheatinsulationGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_graphn_scale(s : PhysicsheatinsulationGraphN, f : Double) -> PhysicsheatinsulationGraphN {
  let result = physics_heat_insulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_graphn_add(a : PhysicsheatinsulationGraphN, b : PhysicsheatinsulationGraphN) -> PhysicsheatinsulationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_graphn_copy(s : PhysicsheatinsulationGraphN) -> PhysicsheatinsulationGraphN {
  let result = physics_heat_insulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_graphn_fill(s : PhysicsheatinsulationGraphN, v : Double) -> PhysicsheatinsulationGraphN {
  let result = physics_heat_insulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_graphn_min(s : PhysicsheatinsulationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_graphn_max(s : PhysicsheatinsulationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_graphn_to_string(s : PhysicsheatinsulationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_node_make(size : Int) -> PhysicsheatinsulationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_node_len(s : PhysicsheatinsulationNode) -> Int { s.size }

pub fn physics_heat_insulation_node_get(s : PhysicsheatinsulationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_node_set(s : PhysicsheatinsulationNode, i : Int, v : Double) -> PhysicsheatinsulationNode {
  let result = physics_heat_insulation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_node_sum(s : PhysicsheatinsulationNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_node_mean(s : PhysicsheatinsulationNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_node_scale(s : PhysicsheatinsulationNode, f : Double) -> PhysicsheatinsulationNode {
  let result = physics_heat_insulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_node_add(a : PhysicsheatinsulationNode, b : PhysicsheatinsulationNode) -> PhysicsheatinsulationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_node_copy(s : PhysicsheatinsulationNode) -> PhysicsheatinsulationNode {
  let result = physics_heat_insulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_node_fill(s : PhysicsheatinsulationNode, v : Double) -> PhysicsheatinsulationNode {
  let result = physics_heat_insulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_node_min(s : PhysicsheatinsulationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_node_max(s : PhysicsheatinsulationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_node_to_string(s : PhysicsheatinsulationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_edge_make(size : Int) -> PhysicsheatinsulationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_edge_len(s : PhysicsheatinsulationEdge) -> Int { s.size }

pub fn physics_heat_insulation_edge_get(s : PhysicsheatinsulationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_edge_set(s : PhysicsheatinsulationEdge, i : Int, v : Double) -> PhysicsheatinsulationEdge {
  let result = physics_heat_insulation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_edge_sum(s : PhysicsheatinsulationEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_edge_mean(s : PhysicsheatinsulationEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_edge_scale(s : PhysicsheatinsulationEdge, f : Double) -> PhysicsheatinsulationEdge {
  let result = physics_heat_insulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_edge_add(a : PhysicsheatinsulationEdge, b : PhysicsheatinsulationEdge) -> PhysicsheatinsulationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_edge_copy(s : PhysicsheatinsulationEdge) -> PhysicsheatinsulationEdge {
  let result = physics_heat_insulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_edge_fill(s : PhysicsheatinsulationEdge, v : Double) -> PhysicsheatinsulationEdge {
  let result = physics_heat_insulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_edge_min(s : PhysicsheatinsulationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_edge_max(s : PhysicsheatinsulationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_edge_to_string(s : PhysicsheatinsulationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_path_make(size : Int) -> PhysicsheatinsulationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_path_len(s : PhysicsheatinsulationPath) -> Int { s.size }

pub fn physics_heat_insulation_path_get(s : PhysicsheatinsulationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_path_set(s : PhysicsheatinsulationPath, i : Int, v : Double) -> PhysicsheatinsulationPath {
  let result = physics_heat_insulation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_path_sum(s : PhysicsheatinsulationPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_path_mean(s : PhysicsheatinsulationPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_path_scale(s : PhysicsheatinsulationPath, f : Double) -> PhysicsheatinsulationPath {
  let result = physics_heat_insulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_path_add(a : PhysicsheatinsulationPath, b : PhysicsheatinsulationPath) -> PhysicsheatinsulationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_path_copy(s : PhysicsheatinsulationPath) -> PhysicsheatinsulationPath {
  let result = physics_heat_insulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_path_fill(s : PhysicsheatinsulationPath, v : Double) -> PhysicsheatinsulationPath {
  let result = physics_heat_insulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_path_min(s : PhysicsheatinsulationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_path_max(s : PhysicsheatinsulationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_path_to_string(s : PhysicsheatinsulationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_cluster_make(size : Int) -> PhysicsheatinsulationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_cluster_len(s : PhysicsheatinsulationCluster) -> Int { s.size }

pub fn physics_heat_insulation_cluster_get(s : PhysicsheatinsulationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_cluster_set(s : PhysicsheatinsulationCluster, i : Int, v : Double) -> PhysicsheatinsulationCluster {
  let result = physics_heat_insulation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_cluster_sum(s : PhysicsheatinsulationCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_cluster_mean(s : PhysicsheatinsulationCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_cluster_scale(s : PhysicsheatinsulationCluster, f : Double) -> PhysicsheatinsulationCluster {
  let result = physics_heat_insulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_cluster_add(a : PhysicsheatinsulationCluster, b : PhysicsheatinsulationCluster) -> PhysicsheatinsulationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_cluster_copy(s : PhysicsheatinsulationCluster) -> PhysicsheatinsulationCluster {
  let result = physics_heat_insulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_cluster_fill(s : PhysicsheatinsulationCluster, v : Double) -> PhysicsheatinsulationCluster {
  let result = physics_heat_insulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_cluster_min(s : PhysicsheatinsulationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_cluster_max(s : PhysicsheatinsulationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_cluster_to_string(s : PhysicsheatinsulationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_model_make(size : Int) -> PhysicsheatinsulationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_model_len(s : PhysicsheatinsulationModel) -> Int { s.size }

pub fn physics_heat_insulation_model_get(s : PhysicsheatinsulationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_model_set(s : PhysicsheatinsulationModel, i : Int, v : Double) -> PhysicsheatinsulationModel {
  let result = physics_heat_insulation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_model_sum(s : PhysicsheatinsulationModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_model_mean(s : PhysicsheatinsulationModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_model_scale(s : PhysicsheatinsulationModel, f : Double) -> PhysicsheatinsulationModel {
  let result = physics_heat_insulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_model_add(a : PhysicsheatinsulationModel, b : PhysicsheatinsulationModel) -> PhysicsheatinsulationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_model_copy(s : PhysicsheatinsulationModel) -> PhysicsheatinsulationModel {
  let result = physics_heat_insulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_model_fill(s : PhysicsheatinsulationModel, v : Double) -> PhysicsheatinsulationModel {
  let result = physics_heat_insulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_model_min(s : PhysicsheatinsulationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_model_max(s : PhysicsheatinsulationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_model_to_string(s : PhysicsheatinsulationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_layer_make(size : Int) -> PhysicsheatinsulationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_layer_len(s : PhysicsheatinsulationLayer) -> Int { s.size }

pub fn physics_heat_insulation_layer_get(s : PhysicsheatinsulationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_layer_set(s : PhysicsheatinsulationLayer, i : Int, v : Double) -> PhysicsheatinsulationLayer {
  let result = physics_heat_insulation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_layer_sum(s : PhysicsheatinsulationLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_layer_mean(s : PhysicsheatinsulationLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_layer_scale(s : PhysicsheatinsulationLayer, f : Double) -> PhysicsheatinsulationLayer {
  let result = physics_heat_insulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_layer_add(a : PhysicsheatinsulationLayer, b : PhysicsheatinsulationLayer) -> PhysicsheatinsulationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_layer_copy(s : PhysicsheatinsulationLayer) -> PhysicsheatinsulationLayer {
  let result = physics_heat_insulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_layer_fill(s : PhysicsheatinsulationLayer, v : Double) -> PhysicsheatinsulationLayer {
  let result = physics_heat_insulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_layer_min(s : PhysicsheatinsulationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_layer_max(s : PhysicsheatinsulationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_layer_to_string(s : PhysicsheatinsulationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_buffer_make(size : Int) -> PhysicsheatinsulationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_buffer_len(s : PhysicsheatinsulationBuffer) -> Int { s.size }

pub fn physics_heat_insulation_buffer_get(s : PhysicsheatinsulationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_buffer_set(s : PhysicsheatinsulationBuffer, i : Int, v : Double) -> PhysicsheatinsulationBuffer {
  let result = physics_heat_insulation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_buffer_sum(s : PhysicsheatinsulationBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_buffer_mean(s : PhysicsheatinsulationBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_buffer_scale(s : PhysicsheatinsulationBuffer, f : Double) -> PhysicsheatinsulationBuffer {
  let result = physics_heat_insulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_buffer_add(a : PhysicsheatinsulationBuffer, b : PhysicsheatinsulationBuffer) -> PhysicsheatinsulationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_buffer_copy(s : PhysicsheatinsulationBuffer) -> PhysicsheatinsulationBuffer {
  let result = physics_heat_insulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_buffer_fill(s : PhysicsheatinsulationBuffer, v : Double) -> PhysicsheatinsulationBuffer {
  let result = physics_heat_insulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_buffer_min(s : PhysicsheatinsulationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_buffer_max(s : PhysicsheatinsulationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_buffer_to_string(s : PhysicsheatinsulationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_cursor_make(size : Int) -> PhysicsheatinsulationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_cursor_len(s : PhysicsheatinsulationCursor) -> Int { s.size }

pub fn physics_heat_insulation_cursor_get(s : PhysicsheatinsulationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_cursor_set(s : PhysicsheatinsulationCursor, i : Int, v : Double) -> PhysicsheatinsulationCursor {
  let result = physics_heat_insulation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_cursor_sum(s : PhysicsheatinsulationCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_cursor_mean(s : PhysicsheatinsulationCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_cursor_scale(s : PhysicsheatinsulationCursor, f : Double) -> PhysicsheatinsulationCursor {
  let result = physics_heat_insulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_cursor_add(a : PhysicsheatinsulationCursor, b : PhysicsheatinsulationCursor) -> PhysicsheatinsulationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_cursor_copy(s : PhysicsheatinsulationCursor) -> PhysicsheatinsulationCursor {
  let result = physics_heat_insulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_cursor_fill(s : PhysicsheatinsulationCursor, v : Double) -> PhysicsheatinsulationCursor {
  let result = physics_heat_insulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_cursor_min(s : PhysicsheatinsulationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_cursor_max(s : PhysicsheatinsulationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_cursor_to_string(s : PhysicsheatinsulationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_view_make(size : Int) -> PhysicsheatinsulationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_view_len(s : PhysicsheatinsulationView) -> Int { s.size }

pub fn physics_heat_insulation_view_get(s : PhysicsheatinsulationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_view_set(s : PhysicsheatinsulationView, i : Int, v : Double) -> PhysicsheatinsulationView {
  let result = physics_heat_insulation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_view_sum(s : PhysicsheatinsulationView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_view_mean(s : PhysicsheatinsulationView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_view_scale(s : PhysicsheatinsulationView, f : Double) -> PhysicsheatinsulationView {
  let result = physics_heat_insulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_view_add(a : PhysicsheatinsulationView, b : PhysicsheatinsulationView) -> PhysicsheatinsulationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_view_copy(s : PhysicsheatinsulationView) -> PhysicsheatinsulationView {
  let result = physics_heat_insulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_view_fill(s : PhysicsheatinsulationView, v : Double) -> PhysicsheatinsulationView {
  let result = physics_heat_insulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_view_min(s : PhysicsheatinsulationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_view_max(s : PhysicsheatinsulationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_view_to_string(s : PhysicsheatinsulationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_range_make(size : Int) -> PhysicsheatinsulationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_range_len(s : PhysicsheatinsulationRange) -> Int { s.size }

pub fn physics_heat_insulation_range_get(s : PhysicsheatinsulationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_range_set(s : PhysicsheatinsulationRange, i : Int, v : Double) -> PhysicsheatinsulationRange {
  let result = physics_heat_insulation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_range_sum(s : PhysicsheatinsulationRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_range_mean(s : PhysicsheatinsulationRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_range_scale(s : PhysicsheatinsulationRange, f : Double) -> PhysicsheatinsulationRange {
  let result = physics_heat_insulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_range_add(a : PhysicsheatinsulationRange, b : PhysicsheatinsulationRange) -> PhysicsheatinsulationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_range_copy(s : PhysicsheatinsulationRange) -> PhysicsheatinsulationRange {
  let result = physics_heat_insulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_range_fill(s : PhysicsheatinsulationRange, v : Double) -> PhysicsheatinsulationRange {
  let result = physics_heat_insulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_range_min(s : PhysicsheatinsulationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_range_max(s : PhysicsheatinsulationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_range_to_string(s : PhysicsheatinsulationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatinsulationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_insulation_slice_make(size : Int) -> PhysicsheatinsulationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_insulation_slice_len(s : PhysicsheatinsulationSlice) -> Int { s.size }

pub fn physics_heat_insulation_slice_get(s : PhysicsheatinsulationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_insulation_slice_set(s : PhysicsheatinsulationSlice, i : Int, v : Double) -> PhysicsheatinsulationSlice {
  let result = physics_heat_insulation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_slice_sum(s : PhysicsheatinsulationSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_insulation_slice_mean(s : PhysicsheatinsulationSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_insulation_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_insulation_slice_scale(s : PhysicsheatinsulationSlice, f : Double) -> PhysicsheatinsulationSlice {
  let result = physics_heat_insulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_insulation_slice_add(a : PhysicsheatinsulationSlice, b : PhysicsheatinsulationSlice) -> PhysicsheatinsulationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_insulation_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_insulation_slice_copy(s : PhysicsheatinsulationSlice) -> PhysicsheatinsulationSlice {
  let result = physics_heat_insulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_insulation_slice_fill(s : PhysicsheatinsulationSlice, v : Double) -> PhysicsheatinsulationSlice {
  let result = physics_heat_insulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_insulation_slice_min(s : PhysicsheatinsulationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_slice_max(s : PhysicsheatinsulationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_insulation_slice_to_string(s : PhysicsheatinsulationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}


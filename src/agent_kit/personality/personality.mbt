///===
/// agent_kit/personality
/// S13.132 new

pub struct PersonalityPoint {
  x : Double
  y : Double
  label : Int
}

pub fn personality_make_point(x : Double, y : Double) -> PersonalityPoint {
  { x, y, label: 0 }
}

pub fn personality_make_labeled_point(x : Double, y : Double, label : Int) -> PersonalityPoint {
  { x, y, label }
}

pub fn personality_point_x(p : PersonalityPoint) -> Double { p.x }

pub fn personality_point_y(p : PersonalityPoint) -> Double { p.y }

pub fn personality_point_label(p : PersonalityPoint) -> Int { p.label }

pub fn personality_point_dist(a : PersonalityPoint, b : PersonalityPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn personality_point_add(a : PersonalityPoint, b : PersonalityPoint) -> PersonalityPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn personality_point_sub(a : PersonalityPoint, b : PersonalityPoint) -> PersonalityPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn personality_point_scale(pt : PersonalityPoint, s : Double) -> PersonalityPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn personality_point_dot(a : PersonalityPoint, b : PersonalityPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn personality_point_norm(pt : PersonalityPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn personality_point_to_string(pt : PersonalityPoint) -> String {
  "(" + personality_dbl(pt.x) + ", " + personality_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct PersonalitySeries {
  vals : Array[Double]
  name : String
}

pub fn personality_make_series(vals : Array[Double], name : String) -> PersonalitySeries {
  { vals, name }
}

pub fn personality_series_len(s : PersonalitySeries) -> Int { s.vals.length() }

pub fn personality_series_sum(s : PersonalitySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn personality_series_mean(s : PersonalitySeries) -> Double {
  let n = personality_series_len(s)
  if n == 0 { 0.0 } else { personality_series_sum(s) / n.to_double() }
}

pub fn personality_series_min(s : PersonalitySeries) -> Double {
  let n = personality_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn personality_series_max(s : PersonalitySeries) -> Double {
  let n = personality_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn personality_series_var(s : PersonalitySeries) -> Double {
  let n = personality_series_len(s)
  if n == 0 { 0.0 } else {
    let m = personality_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn personality_series_std(s : PersonalitySeries) -> Double { @_common.sqrt(personality_series_var(s)) }

pub fn personality_series_scale(s : PersonalitySeries, f : Double) -> PersonalitySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = personality_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn personality_series_add(a : PersonalitySeries, b : PersonalitySeries) -> PersonalitySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = personality_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn personality_series_to_string(s : PersonalitySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + personality_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct PersonalityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn personality_make_matrix(rows : Int, cols : Int, val : Double) -> PersonalityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn personality_matrix_identity(n : Int) -> PersonalityMatrix {
  let m = personality_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn personality_matrix_get(m : PersonalityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn personality_matrix_transpose(m : PersonalityMatrix) -> PersonalityMatrix {
  let result = personality_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn personality_matrix_add(a : PersonalityMatrix, b : PersonalityMatrix) -> PersonalityMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = personality_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn personality_matrix_scale(m : PersonalityMatrix, s : Double) -> PersonalityMatrix {
  let result = personality_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn personality_matrix_multiply(a : PersonalityMatrix, b : PersonalityMatrix) -> PersonalityMatrix {
  if a.cols != b.rows { return personality_make_matrix(a.rows, b.cols, 0.0) }
  let result = personality_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn personality_matrix_trace(m : PersonalityMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn personality_matrix_norm(m : PersonalityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn personality_matrix_to_string(m : PersonalityMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + personality_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct PersonalityVector {
  comps : Array[Double]
  dim : Int
}

pub fn personality_make_vector(comps : Array[Double]) -> PersonalityVector {
  { comps, dim: comps.length() }
}

pub fn personality_vector_zero(dim : Int) -> PersonalityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn personality_vector_add(a : PersonalityVector, b : PersonalityVector) -> PersonalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = personality_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn personality_vector_sub(a : PersonalityVector, b : PersonalityVector) -> PersonalityVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = personality_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn personality_vector_scale(v : PersonalityVector, s : Double) -> PersonalityVector {
  let mut result = []
  for i in 0..<v.dim { result = personality_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn personality_vector_dot(a : PersonalityVector, b : PersonalityVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn personality_vector_norm(v : PersonalityVector) -> Double { @_common.sqrt(personality_vector_dot(v, v)) }

pub fn personality_vector_normalize(v : PersonalityVector) -> PersonalityVector {
  let n = personality_vector_norm(v)
  if n < 0.0000001 { v } else { personality_vector_scale(v, 1.0 / n) }
}

pub fn personality_vector_dist(a : PersonalityVector, b : PersonalityVector) -> Double {
  personality_vector_norm(personality_vector_sub(a, b))
}

pub fn personality_vector_to_string(v : PersonalityVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + personality_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn personality_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn personality_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = personality_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn personality_std(data : Array[Double]) -> Double { @_common.sqrt(personality_var(data)) }

pub fn personality_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = personality_mean(a); let mb = personality_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn personality_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = personality_std(a); let sb = personality_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { personality_cov(a, b) / (sa * sb) }
}

pub fn personality_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn personality_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn personality_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn personality_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = personality_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn personality_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn personality_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn personality_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = personality_precision(pred, labels, pos); let r = personality_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn personality_dbl(x : Double) -> String {
  let i = if x >= 0.0 { personality_int(x) } else { -personality_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { personality_int(f * 1000000.0) } else { personality_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn personality_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn personality_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

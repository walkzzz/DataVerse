///===
/// opcore/game_theory
/// S13.22 new

pub struct Game_theoryPoint {
  x : Double
  y : Double
  label : Int
}

pub fn game_theory_make_point(x : Double, y : Double) -> Game_theoryPoint {
  { x, y, label: 0 }
}

pub fn game_theory_make_labeled_point(x : Double, y : Double, label : Int) -> Game_theoryPoint {
  { x, y, label }
}

pub fn game_theory_point_x(p : Game_theoryPoint) -> Double { p.x }

pub fn game_theory_point_y(p : Game_theoryPoint) -> Double { p.y }

pub fn game_theory_point_label(p : Game_theoryPoint) -> Int { p.label }

pub fn game_theory_point_dist(a : Game_theoryPoint, b : Game_theoryPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn game_theory_point_add(a : Game_theoryPoint, b : Game_theoryPoint) -> Game_theoryPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn game_theory_point_sub(a : Game_theoryPoint, b : Game_theoryPoint) -> Game_theoryPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn game_theory_point_scale(pt : Game_theoryPoint, s : Double) -> Game_theoryPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn game_theory_point_dot(a : Game_theoryPoint, b : Game_theoryPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn game_theory_point_norm(pt : Game_theoryPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn game_theory_point_to_string(pt : Game_theoryPoint) -> String {
  "(" + game_theory_dbl(pt.x) + ", " + game_theory_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Game_theorySeries {
  vals : Array[Double]
  name : String
}

pub fn game_theory_make_series(vals : Array[Double], name : String) -> Game_theorySeries {
  { vals, name }
}

pub fn game_theory_series_len(s : Game_theorySeries) -> Int { s.vals.length() }

pub fn game_theory_series_sum(s : Game_theorySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn game_theory_series_mean(s : Game_theorySeries) -> Double {
  let n = game_theory_series_len(s)
  if n == 0 { 0.0 } else { game_theory_series_sum(s) / n.to_double() }
}

pub fn game_theory_series_min(s : Game_theorySeries) -> Double {
  let n = game_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn game_theory_series_max(s : Game_theorySeries) -> Double {
  let n = game_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn game_theory_series_var(s : Game_theorySeries) -> Double {
  let n = game_theory_series_len(s)
  if n == 0 { 0.0 } else {
    let m = game_theory_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn game_theory_series_std(s : Game_theorySeries) -> Double { @_common.sqrt(game_theory_series_var(s)) }

pub fn game_theory_series_scale(s : Game_theorySeries, f : Double) -> Game_theorySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = game_theory_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn game_theory_series_add(a : Game_theorySeries, b : Game_theorySeries) -> Game_theorySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = game_theory_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn game_theory_series_to_string(s : Game_theorySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + game_theory_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Game_theoryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn game_theory_make_matrix(rows : Int, cols : Int, val : Double) -> Game_theoryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn game_theory_matrix_identity(n : Int) -> Game_theoryMatrix {
  let m = game_theory_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn game_theory_matrix_get(m : Game_theoryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn game_theory_matrix_transpose(m : Game_theoryMatrix) -> Game_theoryMatrix {
  let result = game_theory_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn game_theory_matrix_add(a : Game_theoryMatrix, b : Game_theoryMatrix) -> Game_theoryMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = game_theory_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn game_theory_matrix_scale(m : Game_theoryMatrix, s : Double) -> Game_theoryMatrix {
  let result = game_theory_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn game_theory_matrix_multiply(a : Game_theoryMatrix, b : Game_theoryMatrix) -> Game_theoryMatrix {
  if a.cols != b.rows { return game_theory_make_matrix(a.rows, b.cols, 0.0) }
  let result = game_theory_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn game_theory_matrix_trace(m : Game_theoryMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn game_theory_matrix_norm(m : Game_theoryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn game_theory_matrix_to_string(m : Game_theoryMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + game_theory_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Game_theoryVector {
  comps : Array[Double]
  dim : Int
}

pub fn game_theory_make_vector(comps : Array[Double]) -> Game_theoryVector {
  { comps, dim: comps.length() }
}

pub fn game_theory_vector_zero(dim : Int) -> Game_theoryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn game_theory_vector_add(a : Game_theoryVector, b : Game_theoryVector) -> Game_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = game_theory_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn game_theory_vector_sub(a : Game_theoryVector, b : Game_theoryVector) -> Game_theoryVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = game_theory_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn game_theory_vector_scale(v : Game_theoryVector, s : Double) -> Game_theoryVector {
  let mut result = []
  for i in 0..<v.dim { result = game_theory_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn game_theory_vector_dot(a : Game_theoryVector, b : Game_theoryVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn game_theory_vector_norm(v : Game_theoryVector) -> Double { @_common.sqrt(game_theory_vector_dot(v, v)) }

pub fn game_theory_vector_normalize(v : Game_theoryVector) -> Game_theoryVector {
  let n = game_theory_vector_norm(v)
  if n < 0.0000001 { v } else { game_theory_vector_scale(v, 1.0 / n) }
}

pub fn game_theory_vector_dist(a : Game_theoryVector, b : Game_theoryVector) -> Double {
  game_theory_vector_norm(game_theory_vector_sub(a, b))
}

pub fn game_theory_vector_to_string(v : Game_theoryVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + game_theory_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn game_theory_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn game_theory_std(data : Array[Double]) -> Double { @_common.sqrt(game_theory_var(data)) }

pub fn game_theory_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = @_common.mean(a); let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn game_theory_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = game_theory_std(a); let sb = game_theory_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { game_theory_cov(a, b) / (sa * sb) }
}

pub fn game_theory_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn game_theory_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn game_theory_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn game_theory_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn game_theory_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn game_theory_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn game_theory_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = game_theory_precision(pred, labels, pos); let r = game_theory_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn game_theory_dbl(x : Double) -> String {
  let i = if x >= 0.0 { game_theory_int(x) } else { -game_theory_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { game_theory_int(f * 1000000.0) } else { game_theory_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn game_theory_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn game_theory_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

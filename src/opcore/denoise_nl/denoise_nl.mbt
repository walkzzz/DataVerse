///===
/// opcore/denoise_nl
/// S13.59 new

pub struct Denoise_nlPoint {
  x : Double
  y : Double
  label : Int
}

pub fn denoise_nl_make_point(x : Double, y : Double) -> Denoise_nlPoint {
  { x, y, label: 0 }
}

pub fn denoise_nl_make_labeled_point(x : Double, y : Double, label : Int) -> Denoise_nlPoint {
  { x, y, label }
}

pub fn denoise_nl_point_x(p : Denoise_nlPoint) -> Double { p.x }

pub fn denoise_nl_point_y(p : Denoise_nlPoint) -> Double { p.y }

pub fn denoise_nl_point_label(p : Denoise_nlPoint) -> Int { p.label }

pub fn denoise_nl_point_dist(a : Denoise_nlPoint, b : Denoise_nlPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  denoise_nl_sqrt(dx * dx + dy * dy)
}

pub fn denoise_nl_point_add(a : Denoise_nlPoint, b : Denoise_nlPoint) -> Denoise_nlPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn denoise_nl_point_sub(a : Denoise_nlPoint, b : Denoise_nlPoint) -> Denoise_nlPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn denoise_nl_point_scale(pt : Denoise_nlPoint, s : Double) -> Denoise_nlPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn denoise_nl_point_dot(a : Denoise_nlPoint, b : Denoise_nlPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn denoise_nl_point_norm(pt : Denoise_nlPoint) -> Double {
  denoise_nl_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn denoise_nl_point_to_string(pt : Denoise_nlPoint) -> String {
  "(" + denoise_nl_dbl(pt.x) + ", " + denoise_nl_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Denoise_nlSeries {
  vals : Array[Double]
  name : String
}

pub fn denoise_nl_make_series(vals : Array[Double], name : String) -> Denoise_nlSeries {
  { vals, name }
}

pub fn denoise_nl_series_len(s : Denoise_nlSeries) -> Int { s.vals.length() }

pub fn denoise_nl_series_sum(s : Denoise_nlSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn denoise_nl_series_mean(s : Denoise_nlSeries) -> Double {
  let n = denoise_nl_series_len(s)
  if n == 0 { 0.0 } else { denoise_nl_series_sum(s) / n.to_double() }
}

pub fn denoise_nl_series_min(s : Denoise_nlSeries) -> Double {
  let n = denoise_nl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn denoise_nl_series_max(s : Denoise_nlSeries) -> Double {
  let n = denoise_nl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn denoise_nl_series_var(s : Denoise_nlSeries) -> Double {
  let n = denoise_nl_series_len(s)
  if n == 0 { 0.0 } else {
    let m = denoise_nl_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn denoise_nl_series_std(s : Denoise_nlSeries) -> Double { denoise_nl_sqrt(denoise_nl_series_var(s)) }

pub fn denoise_nl_series_scale(s : Denoise_nlSeries, f : Double) -> Denoise_nlSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = denoise_nl_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn denoise_nl_series_add(a : Denoise_nlSeries, b : Denoise_nlSeries) -> Denoise_nlSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = denoise_nl_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn denoise_nl_series_to_string(s : Denoise_nlSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + denoise_nl_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Denoise_nlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn denoise_nl_make_matrix(rows : Int, cols : Int, val : Double) -> Denoise_nlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn denoise_nl_matrix_identity(n : Int) -> Denoise_nlMatrix {
  let m = denoise_nl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn denoise_nl_matrix_get(m : Denoise_nlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn denoise_nl_matrix_transpose(m : Denoise_nlMatrix) -> Denoise_nlMatrix {
  let result = denoise_nl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn denoise_nl_matrix_add(a : Denoise_nlMatrix, b : Denoise_nlMatrix) -> Denoise_nlMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = denoise_nl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn denoise_nl_matrix_scale(m : Denoise_nlMatrix, s : Double) -> Denoise_nlMatrix {
  let result = denoise_nl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn denoise_nl_matrix_multiply(a : Denoise_nlMatrix, b : Denoise_nlMatrix) -> Denoise_nlMatrix {
  if a.cols != b.rows { return denoise_nl_make_matrix(a.rows, b.cols, 0.0) }
  let result = denoise_nl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn denoise_nl_matrix_trace(m : Denoise_nlMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn denoise_nl_matrix_norm(m : Denoise_nlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  denoise_nl_sqrt(sum)
}

pub fn denoise_nl_matrix_to_string(m : Denoise_nlMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + denoise_nl_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Denoise_nlVector {
  comps : Array[Double]
  dim : Int
}

pub fn denoise_nl_make_vector(comps : Array[Double]) -> Denoise_nlVector {
  { comps, dim: comps.length() }
}

pub fn denoise_nl_vector_zero(dim : Int) -> Denoise_nlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn denoise_nl_vector_add(a : Denoise_nlVector, b : Denoise_nlVector) -> Denoise_nlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = denoise_nl_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn denoise_nl_vector_sub(a : Denoise_nlVector, b : Denoise_nlVector) -> Denoise_nlVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = denoise_nl_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn denoise_nl_vector_scale(v : Denoise_nlVector, s : Double) -> Denoise_nlVector {
  let mut result = []
  for i in 0..<v.dim { result = denoise_nl_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn denoise_nl_vector_dot(a : Denoise_nlVector, b : Denoise_nlVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn denoise_nl_vector_norm(v : Denoise_nlVector) -> Double { denoise_nl_sqrt(denoise_nl_vector_dot(v, v)) }

pub fn denoise_nl_vector_normalize(v : Denoise_nlVector) -> Denoise_nlVector {
  let n = denoise_nl_vector_norm(v)
  if n < 0.0000001 { v } else { denoise_nl_vector_scale(v, 1.0 / n) }
}

pub fn denoise_nl_vector_dist(a : Denoise_nlVector, b : Denoise_nlVector) -> Double {
  denoise_nl_vector_norm(denoise_nl_vector_sub(a, b))
}

pub fn denoise_nl_vector_to_string(v : Denoise_nlVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + denoise_nl_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn denoise_nl_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn denoise_nl_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = denoise_nl_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn denoise_nl_std(data : Array[Double]) -> Double { denoise_nl_sqrt(denoise_nl_var(data)) }

pub fn denoise_nl_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = denoise_nl_mean(a); let mb = denoise_nl_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn denoise_nl_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = denoise_nl_std(a); let sb = denoise_nl_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { denoise_nl_cov(a, b) / (sa * sb) }
}

pub fn denoise_nl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn denoise_nl_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn denoise_nl_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + denoise_nl_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn denoise_nl_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = denoise_nl_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn denoise_nl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn denoise_nl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn denoise_nl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = denoise_nl_precision(pred, labels, pos); let r = denoise_nl_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn denoise_nl_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn denoise_nl_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn denoise_nl_dbl(x : Double) -> String {
  let i = if x >= 0.0 { denoise_nl_int(x) } else { -denoise_nl_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { denoise_nl_int(f * 1000000.0) } else { denoise_nl_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn denoise_nl_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn denoise_nl_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

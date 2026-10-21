///===
/// agent_kit/model_check
/// S13.159 new

pub struct Model_checkPoint {
  x : Double
  y : Double
  label : Int
}

pub fn model_check_make_point(x : Double, y : Double) -> Model_checkPoint {
  { x, y, label: 0 }
}

pub fn model_check_make_labeled_point(x : Double, y : Double, label : Int) -> Model_checkPoint {
  { x, y, label }
}

pub fn model_check_point_x(p : Model_checkPoint) -> Double { p.x }

pub fn model_check_point_y(p : Model_checkPoint) -> Double { p.y }

pub fn model_check_point_label(p : Model_checkPoint) -> Int { p.label }

pub fn model_check_point_dist(a : Model_checkPoint, b : Model_checkPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

pub fn model_check_point_add(a : Model_checkPoint, b : Model_checkPoint) -> Model_checkPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn model_check_point_sub(a : Model_checkPoint, b : Model_checkPoint) -> Model_checkPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn model_check_point_scale(pt : Model_checkPoint, s : Double) -> Model_checkPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn model_check_point_dot(a : Model_checkPoint, b : Model_checkPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn model_check_point_norm(pt : Model_checkPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn model_check_point_to_string(pt : Model_checkPoint) -> String {
  "(" + model_check_dbl(pt.x) + ", " + model_check_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Model_checkSeries {
  vals : Array[Double]
  name : String
}

pub fn model_check_make_series(vals : Array[Double], name : String) -> Model_checkSeries {
  { vals, name }
}

pub fn model_check_series_len(s : Model_checkSeries) -> Int { s.vals.length() }

pub fn model_check_series_sum(s : Model_checkSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn model_check_series_mean(s : Model_checkSeries) -> Double {
  let n = model_check_series_len(s)
  if n == 0 { 0.0 } else { model_check_series_sum(s) / n.to_double() }
}

pub fn model_check_series_min(s : Model_checkSeries) -> Double {
  let n = model_check_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn model_check_series_max(s : Model_checkSeries) -> Double {
  let n = model_check_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn model_check_series_var(s : Model_checkSeries) -> Double {
  let n = model_check_series_len(s)
  if n == 0 { 0.0 } else {
    let m = model_check_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn model_check_series_std(s : Model_checkSeries) -> Double { @_common.sqrt(model_check_series_var(s)) }

pub fn model_check_series_scale(s : Model_checkSeries, f : Double) -> Model_checkSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = model_check_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn model_check_series_add(a : Model_checkSeries, b : Model_checkSeries) -> Model_checkSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = model_check_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn model_check_series_to_string(s : Model_checkSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + model_check_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Model_checkMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn model_check_make_matrix(rows : Int, cols : Int, val : Double) -> Model_checkMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn model_check_matrix_identity(n : Int) -> Model_checkMatrix {
  let m = model_check_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn model_check_matrix_get(m : Model_checkMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn model_check_matrix_transpose(m : Model_checkMatrix) -> Model_checkMatrix {
  let result = model_check_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn model_check_matrix_add(a : Model_checkMatrix, b : Model_checkMatrix) -> Model_checkMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = model_check_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn model_check_matrix_scale(m : Model_checkMatrix, s : Double) -> Model_checkMatrix {
  let result = model_check_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn model_check_matrix_multiply(a : Model_checkMatrix, b : Model_checkMatrix) -> Model_checkMatrix {
  if a.cols != b.rows { return model_check_make_matrix(a.rows, b.cols, 0.0) }
  let result = model_check_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn model_check_matrix_trace(m : Model_checkMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn model_check_matrix_norm(m : Model_checkMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn model_check_matrix_to_string(m : Model_checkMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + model_check_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Model_checkVector {
  comps : Array[Double]
  dim : Int
}

pub fn model_check_make_vector(comps : Array[Double]) -> Model_checkVector {
  { comps, dim: comps.length() }
}

pub fn model_check_vector_zero(dim : Int) -> Model_checkVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn model_check_vector_add(a : Model_checkVector, b : Model_checkVector) -> Model_checkVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = model_check_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn model_check_vector_sub(a : Model_checkVector, b : Model_checkVector) -> Model_checkVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = model_check_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn model_check_vector_scale(v : Model_checkVector, s : Double) -> Model_checkVector {
  let mut result = []
  for i in 0..<v.dim { result = model_check_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn model_check_vector_dot(a : Model_checkVector, b : Model_checkVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn model_check_vector_norm(v : Model_checkVector) -> Double { @_common.sqrt(model_check_vector_dot(v, v)) }

pub fn model_check_vector_normalize(v : Model_checkVector) -> Model_checkVector {
  let n = model_check_vector_norm(v)
  if n < 0.0000001 { v } else { model_check_vector_scale(v, 1.0 / n) }
}

pub fn model_check_vector_dist(a : Model_checkVector, b : Model_checkVector) -> Double {
  model_check_vector_norm(model_check_vector_sub(a, b))
}

pub fn model_check_vector_to_string(v : Model_checkVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + model_check_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn model_check_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn model_check_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = model_check_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn model_check_std(data : Array[Double]) -> Double { @_common.sqrt(model_check_var(data)) }

pub fn model_check_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = model_check_mean(a); let mb = model_check_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn model_check_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = model_check_std(a); let sb = model_check_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { model_check_cov(a, b) / (sa * sb) }
}

pub fn model_check_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn model_check_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn model_check_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn model_check_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = model_check_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn model_check_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn model_check_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn model_check_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = model_check_precision(pred, labels, pos); let r = model_check_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn model_check_dbl(x : Double) -> String {
  let i = if x >= 0.0 { model_check_int(x) } else { -model_check_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { model_check_int(f * 1000000.0) } else { model_check_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn model_check_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn model_check_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

///===
/// dataobject/encode_protobuf
/// S13.196 new

pub struct Encode_protobufPoint {
  x : Double
  y : Double
  label : Int
}

pub fn encode_protobuf_make_point(x : Double, y : Double) -> Encode_protobufPoint {
  { x, y, label: 0 }
}

pub fn encode_protobuf_make_labeled_point(x : Double, y : Double, label : Int) -> Encode_protobufPoint {
  { x, y, label }
}

pub fn encode_protobuf_point_x(p : Encode_protobufPoint) -> Double { p.x }

pub fn encode_protobuf_point_y(p : Encode_protobufPoint) -> Double { p.y }

pub fn encode_protobuf_point_label(p : Encode_protobufPoint) -> Int { p.label }

pub fn encode_protobuf_point_dist(a : Encode_protobufPoint, b : Encode_protobufPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  encode_protobuf_sqrt(dx * dx + dy * dy)
}

pub fn encode_protobuf_point_add(a : Encode_protobufPoint, b : Encode_protobufPoint) -> Encode_protobufPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn encode_protobuf_point_sub(a : Encode_protobufPoint, b : Encode_protobufPoint) -> Encode_protobufPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn encode_protobuf_point_scale(pt : Encode_protobufPoint, s : Double) -> Encode_protobufPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn encode_protobuf_point_dot(a : Encode_protobufPoint, b : Encode_protobufPoint) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn encode_protobuf_point_norm(pt : Encode_protobufPoint) -> Double {
  encode_protobuf_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn encode_protobuf_point_to_string(pt : Encode_protobufPoint) -> String {
  "(" + encode_protobuf_dbl(pt.x) + ", " + encode_protobuf_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Encode_protobufSeries {
  vals : Array[Double]
  name : String
}

pub fn encode_protobuf_make_series(vals : Array[Double], name : String) -> Encode_protobufSeries {
  { vals, name }
}

pub fn encode_protobuf_series_len(s : Encode_protobufSeries) -> Int { s.vals.length() }

pub fn encode_protobuf_series_sum(s : Encode_protobufSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn encode_protobuf_series_mean(s : Encode_protobufSeries) -> Double {
  let n = encode_protobuf_series_len(s)
  if n == 0 { 0.0 } else { encode_protobuf_series_sum(s) / n.to_double() }
}

pub fn encode_protobuf_series_min(s : Encode_protobufSeries) -> Double {
  let n = encode_protobuf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn encode_protobuf_series_max(s : Encode_protobufSeries) -> Double {
  let n = encode_protobuf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn encode_protobuf_series_var(s : Encode_protobufSeries) -> Double {
  let n = encode_protobuf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = encode_protobuf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn encode_protobuf_series_std(s : Encode_protobufSeries) -> Double { encode_protobuf_sqrt(encode_protobuf_series_var(s)) }

pub fn encode_protobuf_series_scale(s : Encode_protobufSeries, f : Double) -> Encode_protobufSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = encode_protobuf_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn encode_protobuf_series_add(a : Encode_protobufSeries, b : Encode_protobufSeries) -> Encode_protobufSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = encode_protobuf_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn encode_protobuf_series_to_string(s : Encode_protobufSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + encode_protobuf_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Encode_protobufMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn encode_protobuf_make_matrix(rows : Int, cols : Int, val : Double) -> Encode_protobufMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn encode_protobuf_matrix_identity(n : Int) -> Encode_protobufMatrix {
  let m = encode_protobuf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn encode_protobuf_matrix_get(m : Encode_protobufMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn encode_protobuf_matrix_transpose(m : Encode_protobufMatrix) -> Encode_protobufMatrix {
  let result = encode_protobuf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn encode_protobuf_matrix_add(a : Encode_protobufMatrix, b : Encode_protobufMatrix) -> Encode_protobufMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = encode_protobuf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn encode_protobuf_matrix_scale(m : Encode_protobufMatrix, s : Double) -> Encode_protobufMatrix {
  let result = encode_protobuf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn encode_protobuf_matrix_multiply(a : Encode_protobufMatrix, b : Encode_protobufMatrix) -> Encode_protobufMatrix {
  if a.cols != b.rows { return encode_protobuf_make_matrix(a.rows, b.cols, 0.0) }
  let result = encode_protobuf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn encode_protobuf_matrix_trace(m : Encode_protobufMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn encode_protobuf_matrix_norm(m : Encode_protobufMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  encode_protobuf_sqrt(sum)
}

pub fn encode_protobuf_matrix_to_string(m : Encode_protobufMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + encode_protobuf_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Encode_protobufVector {
  comps : Array[Double]
  dim : Int
}

pub fn encode_protobuf_make_vector(comps : Array[Double]) -> Encode_protobufVector {
  { comps, dim: comps.length() }
}

pub fn encode_protobuf_vector_zero(dim : Int) -> Encode_protobufVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn encode_protobuf_vector_add(a : Encode_protobufVector, b : Encode_protobufVector) -> Encode_protobufVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = encode_protobuf_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn encode_protobuf_vector_sub(a : Encode_protobufVector, b : Encode_protobufVector) -> Encode_protobufVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = encode_protobuf_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn encode_protobuf_vector_scale(v : Encode_protobufVector, s : Double) -> Encode_protobufVector {
  let mut result = []
  for i in 0..<v.dim { result = encode_protobuf_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn encode_protobuf_vector_dot(a : Encode_protobufVector, b : Encode_protobufVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn encode_protobuf_vector_norm(v : Encode_protobufVector) -> Double { encode_protobuf_sqrt(encode_protobuf_vector_dot(v, v)) }

pub fn encode_protobuf_vector_normalize(v : Encode_protobufVector) -> Encode_protobufVector {
  let n = encode_protobuf_vector_norm(v)
  if n < 0.0000001 { v } else { encode_protobuf_vector_scale(v, 1.0 / n) }
}

pub fn encode_protobuf_vector_dist(a : Encode_protobufVector, b : Encode_protobufVector) -> Double {
  encode_protobuf_vector_norm(encode_protobuf_vector_sub(a, b))
}

pub fn encode_protobuf_vector_to_string(v : Encode_protobufVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + encode_protobuf_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn encode_protobuf_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn encode_protobuf_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = encode_protobuf_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn encode_protobuf_std(data : Array[Double]) -> Double { encode_protobuf_sqrt(encode_protobuf_var(data)) }

pub fn encode_protobuf_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = encode_protobuf_mean(a); let mb = encode_protobuf_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn encode_protobuf_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = encode_protobuf_std(a); let sb = encode_protobuf_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { encode_protobuf_cov(a, b) / (sa * sb) }
}

pub fn encode_protobuf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn encode_protobuf_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn encode_protobuf_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + encode_protobuf_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn encode_protobuf_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = encode_protobuf_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn encode_protobuf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn encode_protobuf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn encode_protobuf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = encode_protobuf_precision(pred, labels, pos); let r = encode_protobuf_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn encode_protobuf_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn encode_protobuf_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn encode_protobuf_dbl(x : Double) -> String {
  let i = if x >= 0.0 { encode_protobuf_int(x) } else { -encode_protobuf_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { encode_protobuf_int(f * 1000000.0) } else { encode_protobuf_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn encode_protobuf_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn encode_protobuf_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

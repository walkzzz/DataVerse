///===
/// dataobject/compress_lz4
/// S13.191 new

pub struct Compress_lz4Point {
  x : Double
  y : Double
  label : Int
}

pub fn compress_lz4_make_point(x : Double, y : Double) -> Compress_lz4Point {
  { x, y, label: 0 }
}

pub fn compress_lz4_make_labeled_point(x : Double, y : Double, label : Int) -> Compress_lz4Point {
  { x, y, label }
}

pub fn compress_lz4_point_x(p : Compress_lz4Point) -> Double { p.x }

pub fn compress_lz4_point_y(p : Compress_lz4Point) -> Double { p.y }

pub fn compress_lz4_point_label(p : Compress_lz4Point) -> Int { p.label }

pub fn compress_lz4_point_dist(a : Compress_lz4Point, b : Compress_lz4Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  compress_lz4_sqrt(dx * dx + dy * dy)
}

pub fn compress_lz4_point_add(a : Compress_lz4Point, b : Compress_lz4Point) -> Compress_lz4Point {
  { x: a.x + b.x, y: a.y + b.y, label: a.label }
}

pub fn compress_lz4_point_sub(a : Compress_lz4Point, b : Compress_lz4Point) -> Compress_lz4Point {
  { x: a.x - b.x, y: a.y - b.y, label: a.label }
}

pub fn compress_lz4_point_scale(pt : Compress_lz4Point, s : Double) -> Compress_lz4Point {
  { x: pt.x * s, y: pt.y * s, label: pt.label }
}

pub fn compress_lz4_point_dot(a : Compress_lz4Point, b : Compress_lz4Point) -> Double {
  a.x * b.x + a.y * b.y
}

pub fn compress_lz4_point_norm(pt : Compress_lz4Point) -> Double {
  compress_lz4_sqrt(pt.x * pt.x + pt.y * pt.y)
}

pub fn compress_lz4_point_to_string(pt : Compress_lz4Point) -> String {
  "(" + compress_lz4_dbl(pt.x) + ", " + compress_lz4_dbl(pt.y) + ")[" + pt.label.to_string() + "]"
}

pub struct Compress_lz4Series {
  vals : Array[Double]
  name : String
}

pub fn compress_lz4_make_series(vals : Array[Double], name : String) -> Compress_lz4Series {
  { vals, name }
}

pub fn compress_lz4_series_len(s : Compress_lz4Series) -> Int { s.vals.length() }

pub fn compress_lz4_series_sum(s : Compress_lz4Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn compress_lz4_series_mean(s : Compress_lz4Series) -> Double {
  let n = compress_lz4_series_len(s)
  if n == 0 { 0.0 } else { compress_lz4_series_sum(s) / n.to_double() }
}

pub fn compress_lz4_series_min(s : Compress_lz4Series) -> Double {
  let n = compress_lz4_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn compress_lz4_series_max(s : Compress_lz4Series) -> Double {
  let n = compress_lz4_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn compress_lz4_series_var(s : Compress_lz4Series) -> Double {
  let n = compress_lz4_series_len(s)
  if n == 0 { 0.0 } else {
    let m = compress_lz4_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn compress_lz4_series_std(s : Compress_lz4Series) -> Double { compress_lz4_sqrt(compress_lz4_series_var(s)) }

pub fn compress_lz4_series_scale(s : Compress_lz4Series, f : Double) -> Compress_lz4Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = compress_lz4_push(result, s.vals[i] * f) }
  { vals: result, name: s.name }
}

pub fn compress_lz4_series_add(a : Compress_lz4Series, b : Compress_lz4Series) -> Compress_lz4Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = compress_lz4_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name }
}

pub fn compress_lz4_series_to_string(s : Compress_lz4Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + compress_lz4_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub struct Compress_lz4Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn compress_lz4_make_matrix(rows : Int, cols : Int, val : Double) -> Compress_lz4Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn compress_lz4_matrix_identity(n : Int) -> Compress_lz4Matrix {
  let m = compress_lz4_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn compress_lz4_matrix_get(m : Compress_lz4Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn compress_lz4_matrix_transpose(m : Compress_lz4Matrix) -> Compress_lz4Matrix {
  let result = compress_lz4_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn compress_lz4_matrix_add(a : Compress_lz4Matrix, b : Compress_lz4Matrix) -> Compress_lz4Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = compress_lz4_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn compress_lz4_matrix_scale(m : Compress_lz4Matrix, s : Double) -> Compress_lz4Matrix {
  let result = compress_lz4_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn compress_lz4_matrix_multiply(a : Compress_lz4Matrix, b : Compress_lz4Matrix) -> Compress_lz4Matrix {
  if a.cols != b.rows { return compress_lz4_make_matrix(a.rows, b.cols, 0.0) }
  let result = compress_lz4_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn compress_lz4_matrix_trace(m : Compress_lz4Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn compress_lz4_matrix_norm(m : Compress_lz4Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  compress_lz4_sqrt(sum)
}

pub fn compress_lz4_matrix_to_string(m : Compress_lz4Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + compress_lz4_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub struct Compress_lz4Vector {
  comps : Array[Double]
  dim : Int
}

pub fn compress_lz4_make_vector(comps : Array[Double]) -> Compress_lz4Vector {
  { comps, dim: comps.length() }
}

pub fn compress_lz4_vector_zero(dim : Int) -> Compress_lz4Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn compress_lz4_vector_add(a : Compress_lz4Vector, b : Compress_lz4Vector) -> Compress_lz4Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = compress_lz4_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn compress_lz4_vector_sub(a : Compress_lz4Vector, b : Compress_lz4Vector) -> Compress_lz4Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = compress_lz4_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn compress_lz4_vector_scale(v : Compress_lz4Vector, s : Double) -> Compress_lz4Vector {
  let mut result = []
  for i in 0..<v.dim { result = compress_lz4_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn compress_lz4_vector_dot(a : Compress_lz4Vector, b : Compress_lz4Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn compress_lz4_vector_norm(v : Compress_lz4Vector) -> Double { compress_lz4_sqrt(compress_lz4_vector_dot(v, v)) }

pub fn compress_lz4_vector_normalize(v : Compress_lz4Vector) -> Compress_lz4Vector {
  let n = compress_lz4_vector_norm(v)
  if n < 0.0000001 { v } else { compress_lz4_vector_scale(v, 1.0 / n) }
}

pub fn compress_lz4_vector_dist(a : Compress_lz4Vector, b : Compress_lz4Vector) -> Double {
  compress_lz4_vector_norm(compress_lz4_vector_sub(a, b))
}

pub fn compress_lz4_vector_to_string(v : Compress_lz4Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + compress_lz4_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn compress_lz4_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn compress_lz4_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = compress_lz4_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn compress_lz4_std(data : Array[Double]) -> Double { compress_lz4_sqrt(compress_lz4_var(data)) }

pub fn compress_lz4_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = compress_lz4_mean(a); let mb = compress_lz4_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn compress_lz4_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = compress_lz4_std(a); let sb = compress_lz4_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { compress_lz4_cov(a, b) / (sa * sb) }
}

pub fn compress_lz4_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn compress_lz4_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn compress_lz4_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + compress_lz4_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn compress_lz4_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = compress_lz4_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn compress_lz4_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn compress_lz4_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn compress_lz4_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = compress_lz4_precision(pred, labels, pos); let r = compress_lz4_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

fn compress_lz4_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn compress_lz4_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn compress_lz4_dbl(x : Double) -> String {
  let i = if x >= 0.0 { compress_lz4_int(x) } else { -compress_lz4_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { compress_lz4_int(f * 1000000.0) } else { compress_lz4_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn compress_lz4_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn compress_lz4_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

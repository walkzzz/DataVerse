///|
///===
/// learncore/spea2
/// S13.85 new
pub struct Spea2Point {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn spea2_spea2_make_point(x : Double, y : Double) -> Spea2Point {
  { x, y, label: 0, }
}

///|
pub fn spea2_spea2_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Spea2Point {
  { x, y, label, }
}

///|
pub fn spea2_spea2_point_x(p : Spea2Point) -> Double {
  p.x
}

///|
pub fn spea2_spea2_point_y(p : Spea2Point) -> Double {
  p.y
}

///|
pub fn spea2_spea2_point_label(p : Spea2Point) -> Int32 {
  p.label
}

///|
pub fn spea2_spea2_point_dist(a : Spea2Point, b : Spea2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn spea2_spea2_point_add(a : Spea2Point, b : Spea2Point) -> Spea2Point {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn spea2_spea2_point_sub(a : Spea2Point, b : Spea2Point) -> Spea2Point {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn spea2_spea2_point_scale(pt : Spea2Point, s : Double) -> Spea2Point {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn spea2_spea2_point_dot(a : Spea2Point, b : Spea2Point) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn spea2_spea2_point_norm(pt : Spea2Point) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn spea2_spea2_point_to_string(pt : Spea2Point) -> String {
  "(" +
  spea2_spea2_dbl(pt.x) +
  ", " +
  spea2_spea2_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Spea2Series {
  vals : Array[Double]
  name : String
}

///|
pub fn spea2_spea2_make_series(vals : Array[Double], name : String) -> Spea2Series {
  { vals, name, }
}

///|
pub fn spea2_spea2_series_len(s : Spea2Series) -> Int32 {
  s.vals.length()
}

///|
pub fn spea2_spea2_series_sum(s : Spea2Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn spea2_spea2_series_mean(s : Spea2Series) -> Double {
  let n = spea2_spea2_series_len(s)
  if n == 0 {
    0.0
  } else {
    spea2_spea2_series_sum(s) / n.to_double()
  }
}

///|
pub fn spea2_spea2_series_min(s : Spea2Series) -> Double {
  let n = spea2_spea2_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] < m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn spea2_spea2_series_max(s : Spea2Series) -> Double {
  let n = spea2_spea2_series_len(s)
  if n == 0 {
    0.0
  } else {
    let mut m = s.vals[0]
    for i in 1..<n {
      if s.vals[i] > m {
        m = s.vals[i]
      }
    }
    m
  }
}

///|
pub fn spea2_spea2_series_var(s : Spea2Series) -> Double {
  let n = spea2_spea2_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = spea2_spea2_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn spea2_spea2_series_std(s : Spea2Series) -> Double {
  @_common.sqrt(spea2_spea2_series_var(s))
}

///|
pub fn spea2_spea2_series_scale(s : Spea2Series, f : Double) -> Spea2Series {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = spea2_spea2_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn spea2_spea2_series_add(a : Spea2Series, b : Spea2Series) -> Spea2Series {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = spea2_spea2_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn spea2_spea2_series_to_string(s : Spea2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + spea2_spea2_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Spea2Matrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn spea2_spea2_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Spea2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn spea2_spea2_matrix_identity(n : Int32) -> Spea2Matrix {
  let m = spea2_spea2_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn spea2_spea2_matrix_get(m : Spea2Matrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn spea2_spea2_matrix_transpose(m : Spea2Matrix) -> Spea2Matrix {
  let result = spea2_spea2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn spea2_spea2_matrix_add(a : Spea2Matrix, b : Spea2Matrix) -> Spea2Matrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = spea2_spea2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn spea2_spea2_matrix_scale(m : Spea2Matrix, s : Double) -> Spea2Matrix {
  let result = spea2_spea2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn spea2_spea2_matrix_multiply(a : Spea2Matrix, b : Spea2Matrix) -> Spea2Matrix {
  if a.cols != b.rows {
    return spea2_spea2_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = spea2_spea2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols {
        sum = sum + a.data[i][k] * b.data[k][j]
      }
      result.data[i][j] = sum
    }
  }
  result
}

///|
pub fn spea2_spea2_matrix_trace(m : Spea2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn spea2_spea2_matrix_norm(m : Spea2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn spea2_spea2_matrix_to_string(m : Spea2Matrix) -> String {
  let mut result = "Mat(" +
    m.rows.to_string() +
    "x" +
    m.cols.to_string() +
    ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + spea2_spea2_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Spea2Vector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn spea2_spea2_make_vector(comps : Array[Double]) -> Spea2Vector {
  { comps, dim: comps.length(), }
}

///|
pub fn spea2_spea2_vector_zero(dim : Int32) -> Spea2Vector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn spea2_spea2_vector_add(a : Spea2Vector, b : Spea2Vector) -> Spea2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = spea2_spea2_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn spea2_spea2_vector_sub(a : Spea2Vector, b : Spea2Vector) -> Spea2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = spea2_spea2_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn spea2_spea2_vector_scale(v : Spea2Vector, s : Double) -> Spea2Vector {
  let mut result = []
  for i in 0..<v.dim {
    result = spea2_spea2_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn spea2_spea2_vector_dot(a : Spea2Vector, b : Spea2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn spea2_spea2_vector_norm(v : Spea2Vector) -> Double {
  @_common.sqrt(spea2_spea2_vector_dot(v, v))
}

///|
pub fn spea2_spea2_vector_normalize(v : Spea2Vector) -> Spea2Vector {
  let n = spea2_spea2_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    spea2_spea2_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn spea2_spea2_vector_dist(a : Spea2Vector, b : Spea2Vector) -> Double {
  spea2_spea2_vector_norm(spea2_spea2_vector_sub(a, b))
}

///|
pub fn spea2_spea2_vector_to_string(v : Spea2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + spea2_spea2_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn spea2_spea2_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 {
    0.0
  } else {
    let m = @_common.mean(data)
    let mut sum = 0.0
    for i in 0..<n {
      let d = data[i] - m
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn spea2_spea2_std(data : Array[Double]) -> Double {
  @_common.sqrt(spea2_spea2_var(data))
}

///|
pub fn spea2_spea2_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 {
    0.0
  } else {
    let ma = @_common.mean(a)
    let mb = @_common.mean(b)
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + (a[i] - ma) * (b[i] - mb)
    }
    sum / n.to_double()
  }
}

///|
pub fn spea2_spea2_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = spea2_spea2_std(a)
  let sb = spea2_spea2_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    spea2_spea2_cov(a, b) / (sa * sb)
  }
}

///|
pub fn spea2_spea2_accuracy(pred : Array[Int32], labels : Array[Int32]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut correct = 0
    for i in 0..<n {
      if pred[i] == labels[i] {
        correct = correct + 1
      }
    }
    correct.to_double() / n.to_double()
  }
}

///|
pub fn spea2_spea2_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      let d = pred[i] - labels[i]
      sum = sum + d * d
    }
    sum / n.to_double()
  }
}

///|
pub fn spea2_spea2_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let mut sum = 0.0
    for i in 0..<n {
      sum = sum + @_common.abs(pred[i] - labels[i])
    }
    sum / n.to_double()
  }
}

///|
pub fn spea2_spea2_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  if n == 0 {
    0.0
  } else {
    let lm = @_common.mean(labels)
    let mut ss_res = 0.0
    let mut ss_tot = 0.0
    for i in 0..<n {
      let r = labels[i] - pred[i]
      ss_res = ss_res + r * r
      let t = labels[i] - lm
      ss_tot = ss_tot + t * t
    }
    if ss_tot < 0.0000001 {
      0.0
    } else {
      1.0 - ss_res / ss_tot
    }
  }
}

///|
pub fn spea2_spea2_precision(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if pred[i] == pos {
      if labels[i] == pos {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  if tp + fp == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fp).to_double()
  }
}

///|
pub fn spea2_spea2_recall(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if labels[i] == pos {
      if pred[i] == pos {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  if tp + fn_ == 0 {
    0.0
  } else {
    tp.to_double() / (tp + fn_).to_double()
  }
}

///|
pub fn spea2_spea2_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = spea2_spea2_precision(pred, labels, pos)
  let r = spea2_spea2_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn spea2_spea2_dbl(x : Double) -> String {
  let i = if x >= 0.0 { spea2_spea2_int(x) } else { -spea2_spea2_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    spea2_spea2_int(f * 1000000.0)
  } else {
    spea2_spea2_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn spea2_spea2_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn spea2_spea2_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}

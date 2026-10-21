///|
///===
/// dataobject/tensor_store
/// S13.173 new
pub struct Tensor_storePoint {
  x : Double
  y : Double
  label : Int32
}

///|
pub fn tensor_store_make_point(x : Double, y : Double) -> Tensor_storePoint {
  { x, y, label: 0, }
}

///|
pub fn tensor_store_make_labeled_point(
  x : Double,
  y : Double,
  label : Int32,
) -> Tensor_storePoint {
  { x, y, label, }
}

///|
pub fn tensor_store_point_x(p : Tensor_storePoint) -> Double {
  p.x
}

///|
pub fn tensor_store_point_y(p : Tensor_storePoint) -> Double {
  p.y
}

///|
pub fn tensor_store_point_label(p : Tensor_storePoint) -> Int32 {
  p.label
}

///|
pub fn tensor_store_point_dist(
  a : Tensor_storePoint,
  b : Tensor_storePoint,
) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
pub fn tensor_store_point_add(
  a : Tensor_storePoint,
  b : Tensor_storePoint,
) -> Tensor_storePoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
pub fn tensor_store_point_sub(
  a : Tensor_storePoint,
  b : Tensor_storePoint,
) -> Tensor_storePoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
pub fn tensor_store_point_scale(
  pt : Tensor_storePoint,
  s : Double,
) -> Tensor_storePoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
pub fn tensor_store_point_dot(
  a : Tensor_storePoint,
  b : Tensor_storePoint,
) -> Double {
  a.x * b.x + a.y * b.y
}

///|
pub fn tensor_store_point_norm(pt : Tensor_storePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
pub fn tensor_store_point_to_string(pt : Tensor_storePoint) -> String {
  "(" +
  tensor_store_dbl(pt.x) +
  ", " +
  tensor_store_dbl(pt.y) +
  ")[" +
  pt.label.to_string() +
  "]"
}

///|
pub struct Tensor_storeSeries {
  vals : Array[Double]
  name : String
}

///|
pub fn tensor_store_make_series(
  vals : Array[Double],
  name : String,
) -> Tensor_storeSeries {
  { vals, name, }
}

///|
pub fn tensor_store_series_len(s : Tensor_storeSeries) -> Int32 {
  s.vals.length()
}

///|
pub fn tensor_store_series_sum(s : Tensor_storeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
pub fn tensor_store_series_mean(s : Tensor_storeSeries) -> Double {
  let n = tensor_store_series_len(s)
  if n == 0 {
    0.0
  } else {
    tensor_store_series_sum(s) / n.to_double()
  }
}

///|
pub fn tensor_store_series_min(s : Tensor_storeSeries) -> Double {
  let n = tensor_store_series_len(s)
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
pub fn tensor_store_series_max(s : Tensor_storeSeries) -> Double {
  let n = tensor_store_series_len(s)
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
pub fn tensor_store_series_var(s : Tensor_storeSeries) -> Double {
  let n = tensor_store_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = tensor_store_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
pub fn tensor_store_series_std(s : Tensor_storeSeries) -> Double {
  @_common.sqrt(tensor_store_series_var(s))
}

///|
pub fn tensor_store_series_scale(
  s : Tensor_storeSeries,
  f : Double,
) -> Tensor_storeSeries {
  let mut result = []
  for i in 0..<s.vals.length() {
    result = tensor_store_push(result, s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
pub fn tensor_store_series_add(
  a : Tensor_storeSeries,
  b : Tensor_storeSeries,
) -> Tensor_storeSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let mut result = []
  for i in 0..<n {
    result = tensor_store_push(result, a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
pub fn tensor_store_series_to_string(s : Tensor_storeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + tensor_store_dbl(s.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub struct Tensor_storeMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn tensor_store_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> Tensor_storeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
pub fn tensor_store_matrix_identity(n : Int32) -> Tensor_storeMatrix {
  let m = tensor_store_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn tensor_store_matrix_get(
  m : Tensor_storeMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
pub fn tensor_store_matrix_transpose(
  m : Tensor_storeMatrix,
) -> Tensor_storeMatrix {
  let result = tensor_store_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
pub fn tensor_store_matrix_add(
  a : Tensor_storeMatrix,
  b : Tensor_storeMatrix,
) -> Tensor_storeMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = tensor_store_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
pub fn tensor_store_matrix_scale(
  m : Tensor_storeMatrix,
  s : Double,
) -> Tensor_storeMatrix {
  let result = tensor_store_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
pub fn tensor_store_matrix_multiply(
  a : Tensor_storeMatrix,
  b : Tensor_storeMatrix,
) -> Tensor_storeMatrix {
  if a.cols != b.rows {
    return tensor_store_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = tensor_store_make_matrix(a.rows, b.cols, 0.0)
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
pub fn tensor_store_matrix_trace(m : Tensor_storeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
pub fn tensor_store_matrix_norm(m : Tensor_storeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn tensor_store_matrix_to_string(m : Tensor_storeMatrix) -> String {
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
      result = result + tensor_store_dbl(m.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub struct Tensor_storeVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn tensor_store_make_vector(comps : Array[Double]) -> Tensor_storeVector {
  { comps, dim: comps.length(), }
}

///|
pub fn tensor_store_vector_zero(dim : Int32) -> Tensor_storeVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn tensor_store_vector_add(
  a : Tensor_storeVector,
  b : Tensor_storeVector,
) -> Tensor_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = tensor_store_push(result, a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn tensor_store_vector_sub(
  a : Tensor_storeVector,
  b : Tensor_storeVector,
) -> Tensor_storeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n {
    result = tensor_store_push(result, a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
pub fn tensor_store_vector_scale(
  v : Tensor_storeVector,
  s : Double,
) -> Tensor_storeVector {
  let mut result = []
  for i in 0..<v.dim {
    result = tensor_store_push(result, v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
pub fn tensor_store_vector_dot(
  a : Tensor_storeVector,
  b : Tensor_storeVector,
) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
pub fn tensor_store_vector_norm(v : Tensor_storeVector) -> Double {
  @_common.sqrt(tensor_store_vector_dot(v, v))
}

///|
pub fn tensor_store_vector_normalize(
  v : Tensor_storeVector,
) -> Tensor_storeVector {
  let n = tensor_store_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    tensor_store_vector_scale(v, 1.0 / n)
  }
}

///|
pub fn tensor_store_vector_dist(
  a : Tensor_storeVector,
  b : Tensor_storeVector,
) -> Double {
  tensor_store_vector_norm(tensor_store_vector_sub(a, b))
}

///|
pub fn tensor_store_vector_to_string(v : Tensor_storeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + tensor_store_dbl(v.comps[i])
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub fn tensor_store_var(data : Array[Double]) -> Double {
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
pub fn tensor_store_std(data : Array[Double]) -> Double {
  @_common.sqrt(tensor_store_var(data))
}

///|
pub fn tensor_store_cov(a : Array[Double], b : Array[Double]) -> Double {
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
pub fn tensor_store_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = tensor_store_std(a)
  let sb = tensor_store_std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    tensor_store_cov(a, b) / (sa * sb)
  }
}

///|
pub fn tensor_store_accuracy(
  pred : Array[Int32],
  labels : Array[Int32],
) -> Double {
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
pub fn tensor_store_mse(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn tensor_store_mae(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn tensor_store_r2(pred : Array[Double], labels : Array[Double]) -> Double {
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
pub fn tensor_store_precision(
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
pub fn tensor_store_recall(
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
pub fn tensor_store_f1(
  pred : Array[Int32],
  labels : Array[Int32],
  pos : Int32,
) -> Double {
  let p_ = tensor_store_precision(pred, labels, pos)
  let r = tensor_store_recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

///|
fn tensor_store_dbl(x : Double) -> String {
  let i = if x >= 0.0 { tensor_store_int(x) } else { -tensor_store_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 {
    tensor_store_int(f * 1000000.0)
  } else {
    tensor_store_int(-f * 1000000.0)
  }
  i.to_string() + "." + fi.to_string()
}

///|
fn tensor_store_int(x : Double) -> Int32 {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

///|
fn tensor_store_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n {
    result[i] = arr[i]
  }
  result[n] = v
  result
}

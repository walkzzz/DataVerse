///|
/// # extcore/types — 通用数据类型 / Common Data Types
///
/// 消除各包重复的 Point/Series/Matrix/Vector 定义。
/// 所有包应使用 `@types.DvPoint` 等通用类型，而非各自定义。

// ============================================================================
// DvPoint — 二维标注点 / 2D Labeled Point
// ============================================================================

///|
/// 二维标注点 / 2D labeled point.
pub struct DvPoint {
  x : Double
  y : Double
  label : Int32
}

///|
/// 创建点 / Create a point.
pub fn dv_make_point(x : Double, y : Double) -> DvPoint {
  { x, y, label: 0, }
}

///|
/// 创建标注点 / Create a labeled point.
pub fn dv_make_labeled_point(x : Double, y : Double, label : Int32) -> DvPoint {
  { x, y, label, }
}

///|
/// 点 x 坐标 / Get x coordinate.
pub fn dv_point_x(p : DvPoint) -> Double {
  p.x
}

///|
/// 点 y 坐标 / Get y coordinate.
pub fn dv_point_y(p : DvPoint) -> Double {
  p.y
}

///|
/// 点标签 / Get label.
pub fn dv_point_label(p : DvPoint) -> Int32 {
  p.label
}

///|
/// 点距离 / Distance between two points.
pub fn dv_point_dist(a : DvPoint, b : DvPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  @_common.sqrt(dx * dx + dy * dy)
}

///|
/// 点加法 / Add two points.
pub fn dv_point_add(a : DvPoint, b : DvPoint) -> DvPoint {
  { x: a.x + b.x, y: a.y + b.y, label: a.label, }
}

///|
/// 点减法 / Subtract two points.
pub fn dv_point_sub(a : DvPoint, b : DvPoint) -> DvPoint {
  { x: a.x - b.x, y: a.y - b.y, label: a.label, }
}

///|
/// 点缩放 / Scale a point.
pub fn dv_point_scale(pt : DvPoint, s : Double) -> DvPoint {
  { x: pt.x * s, y: pt.y * s, label: pt.label, }
}

///|
/// 点点积 / Dot product of two points.
pub fn dv_point_dot(a : DvPoint, b : DvPoint) -> Double {
  a.x * b.x + a.y * b.y
}

///|
/// 点范数 / Norm of a point.
pub fn dv_point_norm(pt : DvPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y)
}

///|
/// 点转字符串 / Convert point to string.
pub fn dv_point_to_string(pt : DvPoint) -> String {
  "(" + pt.x.to_string() + ", " + pt.y.to_string() + ")[" + pt.label.to_string() + "]"
}

// ============================================================================
// DvSeries — 命名数据序列 / Named Data Series
// ============================================================================

///|
/// 命名数据序列 / Named data series.
pub struct DvSeries {
  vals : Array[Double]
  name : String
}

///|
/// 创建序列 / Create a series.
pub fn dv_make_series(vals : Array[Double], name : String) -> DvSeries {
  { vals, name, }
}

///|
/// 序列长度 / Length of series.
pub fn dv_series_len(s : DvSeries) -> Int32 {
  s.vals.length()
}

///|
/// 序列求和 / Sum of series.
pub fn dv_series_sum(s : DvSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() {
    total = total + s.vals[i]
  }
  total
}

///|
/// 序列均值 / Mean of series.
pub fn dv_series_mean(s : DvSeries) -> Double {
  let n = dv_series_len(s)
  if n == 0 {
    0.0
  } else {
    dv_series_sum(s) / n.to_double()
  }
}

///|
/// 序列最小值 / Min of series.
pub fn dv_series_min(s : DvSeries) -> Double {
  let n = dv_series_len(s)
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
/// 序列最大值 / Max of series.
pub fn dv_series_max(s : DvSeries) -> Double {
  let n = dv_series_len(s)
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
/// 序列方差 / Variance of series.
pub fn dv_series_var(s : DvSeries) -> Double {
  let n = dv_series_len(s)
  if n == 0 {
    0.0
  } else {
    let m = dv_series_mean(s)
    let mut total = 0.0
    for i in 0..<n {
      let d = s.vals[i] - m
      total = total + d * d
    }
    total / n.to_double()
  }
}

///|
/// 序列标准差 / Standard deviation of series.
pub fn dv_series_std(s : DvSeries) -> Double {
  @_common.sqrt(dv_series_var(s))
}

///|
/// 序列缩放 / Scale a series.
pub fn dv_series_scale(s : DvSeries, f : Double) -> DvSeries {
  let result = []
  for i in 0..<s.vals.length() {
    result.push(s.vals[i] * f)
  }
  { vals: result, name: s.name, }
}

///|
/// 序列加法 / Add two series.
pub fn dv_series_add(a : DvSeries, b : DvSeries) -> DvSeries {
  let n = if a.vals.length() < b.vals.length() {
    a.vals.length()
  } else {
    b.vals.length()
  }
  let result = []
  for i in 0..<n {
    result.push(a.vals[i] + b.vals[i])
  }
  { vals: result, name: a.name + "+" + b.name, }
}

///|
/// 序列转字符串 / Convert series to string.
pub fn dv_series_to_string(s : DvSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + s.vals[i].to_string()
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

// ============================================================================
// DvMatrix — 二维矩阵 / 2D Matrix
// ============================================================================

///|
/// 二维矩阵 / 2D matrix.
pub struct DvMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
/// 创建矩阵 / Create a matrix.
pub fn dv_make_matrix(rows : Int32, cols : Int32, val : Double) -> DvMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows {
    data[i] = Array::make(cols, val)
  }
  { data, rows, cols, }
}

///|
/// 单位矩阵 / Identity matrix.
pub fn dv_matrix_identity(n : Int32) -> DvMatrix {
  let m = dv_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
/// 矩阵取值 / Get matrix element.
pub fn dv_matrix_get(m : DvMatrix, i : Int32, j : Int32) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols {
    0.0
  } else {
    m.data[i][j]
  }
}

///|
/// 矩阵转置 / Transpose matrix.
pub fn dv_matrix_transpose(m : DvMatrix) -> DvMatrix {
  let result = dv_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[j][i] = m.data[i][j]
    }
  }
  result
}

///|
/// 矩阵加法 / Add two matrices.
pub fn dv_matrix_add(a : DvMatrix, b : DvMatrix) -> DvMatrix {
  if a.rows != b.rows || a.cols != b.cols {
    return a
  }
  let result = dv_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<a.cols {
      result.data[i][j] = a.data[i][j] + b.data[i][j]
    }
  }
  result
}

///|
/// 矩阵缩放 / Scale a matrix.
pub fn dv_matrix_scale(m : DvMatrix, s : Double) -> DvMatrix {
  let result = dv_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      result.data[i][j] = m.data[i][j] * s
    }
  }
  result
}

///|
/// 矩阵乘法 / Multiply two matrices.
pub fn dv_matrix_multiply(a : DvMatrix, b : DvMatrix) -> DvMatrix {
  if a.cols != b.rows {
    return dv_make_matrix(a.rows, b.cols, 0.0)
  }
  let result = dv_make_matrix(a.rows, b.cols, 0.0)
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
/// 矩阵迹 / Trace of a matrix.
pub fn dv_matrix_trace(m : DvMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + m.data[i][i]
  }
  sum
}

///|
/// 矩阵范数 / Norm of a matrix.
pub fn dv_matrix_norm(m : DvMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows {
    for j in 0..<m.cols {
      sum = sum + m.data[i][j] * m.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
/// 矩阵转字符串 / Convert matrix to string.
pub fn dv_matrix_to_string(m : DvMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + m.data[i][j].to_string()
    }
    result = result + "]\n"
  }
  result
}

// ============================================================================
// DvVector — 向量 / Vector
// ============================================================================

///|
/// 向量 / Vector.
pub struct DvVector {
  comps : Array[Double]
  dim : Int32
}

///|
/// 创建向量 / Create a vector.
pub fn dv_make_vector(comps : Array[Double]) -> DvVector {
  { comps, dim: comps.length(), }
}

///|
/// 零向量 / Zero vector.
pub fn dv_vector_zero(dim : Int32) -> DvVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
/// 向量加法 / Add two vectors.
pub fn dv_vector_add(a : DvVector, b : DvVector) -> DvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n {
    result.push(a.comps[i] + b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
/// 向量减法 / Subtract two vectors.
pub fn dv_vector_sub(a : DvVector, b : DvVector) -> DvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n {
    result.push(a.comps[i] - b.comps[i])
  }
  { comps: result, dim: n, }
}

///|
/// 向量缩放 / Scale a vector.
pub fn dv_vector_scale(v : DvVector, s : Double) -> DvVector {
  let result = []
  for i in 0..<v.dim {
    result.push(v.comps[i] * s)
  }
  { comps: result, dim: v.dim, }
}

///|
/// 向量点积 / Dot product of two vectors.
pub fn dv_vector_dot(a : DvVector, b : DvVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + a.comps[i] * b.comps[i]
  }
  sum
}

///|
/// 向量范数 / Norm of a vector.
pub fn dv_vector_norm(v : DvVector) -> Double {
  @_common.sqrt(dv_vector_dot(v, v))
}

///|
/// 向量归一化 / Normalize a vector.
pub fn dv_vector_normalize(v : DvVector) -> DvVector {
  let n = dv_vector_norm(v)
  if n < 0.0000001 {
    v
  } else {
    dv_vector_scale(v, 1.0 / n)
  }
}

///|
/// 向量距离 / Distance between two vectors.
pub fn dv_vector_dist(a : DvVector, b : DvVector) -> Double {
  dv_vector_norm(dv_vector_sub(a, b))
}

///|
/// 向量转字符串 / Convert vector to string.
pub fn dv_vector_to_string(v : DvVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + v.comps[i].to_string()
  }
  if v.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}
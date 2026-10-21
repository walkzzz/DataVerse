///|
///===
/// extcore/geo_buffer_ellipse
pub(all) struct GeobufferellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn geo_buffer_ellipse_make_point(
  x : Double,
  y : Double,
) -> GeobufferellipsePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn geo_buffer_ellipse_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GeobufferellipsePoint {
  { x, y, z, label: 0, }
}

///|
pub fn GeobufferellipsePoint::x(self : GeobufferellipsePoint) -> Double {
  self.x
}

///|
pub fn GeobufferellipsePoint::y(self : GeobufferellipsePoint) -> Double {
  self.y
}

///|
pub fn GeobufferellipsePoint::z(self : GeobufferellipsePoint) -> Double {
  self.z
}

///|
pub fn GeobufferellipsePoint::label(self : GeobufferellipsePoint) -> Int32 {
  self.label
}

///|
pub fn GeobufferellipsePoint::dist(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GeobufferellipsePoint::add(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GeobufferellipsePoint::sub(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GeobufferellipsePoint::scale(
  self : GeobufferellipsePoint,
  s : Double,
) -> GeobufferellipsePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GeobufferellipsePoint::dot(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GeobufferellipsePoint::cross(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GeobufferellipsePoint::norm(self : GeobufferellipsePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GeobufferellipsePoint::normalize(
  self : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GeobufferellipsePoint::negate(
  self : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GeobufferellipsePoint::mid(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
) -> GeobufferellipsePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GeobufferellipsePoint::lerp(
  self : GeobufferellipsePoint,
  other : GeobufferellipsePoint,
  t : Double,
) -> GeobufferellipsePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GeobufferellipsePoint::to_string(self : GeobufferellipsePoint) -> String {
  "(" +
  @_common.dbl(self.x) +
  ", " +
  @_common.dbl(self.y) +
  ", " +
  @_common.dbl(self.z) +
  ")[" +
  self.label.to_string() +
  "]"
}

///|
pub(all) struct GeobufferellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn geo_buffer_ellipse_make_series(
  vals : Array[Double],
  name : String,
) -> GeobufferellipseSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GeobufferellipseSeries::len(self : GeobufferellipseSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GeobufferellipseSeries::sum(self : GeobufferellipseSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GeobufferellipseSeries::mean(self : GeobufferellipseSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GeobufferellipseSeries::min(self : GeobufferellipseSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GeobufferellipseSeries::max(self : GeobufferellipseSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GeobufferellipseSeries::range(self : GeobufferellipseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GeobufferellipseSeries::variance(
  self : GeobufferellipseSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GeobufferellipseSeries::std(self : GeobufferellipseSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GeobufferellipseSeries::median(self : GeobufferellipseSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GeobufferellipseSeries::scale(
  self : GeobufferellipseSeries,
  f : Double,
) -> GeobufferellipseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GeobufferellipseSeries::add(
  self : GeobufferellipseSeries,
  other : GeobufferellipseSeries,
) -> GeobufferellipseSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GeobufferellipseSeries::sub(
  self : GeobufferellipseSeries,
  other : GeobufferellipseSeries,
) -> GeobufferellipseSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GeobufferellipseSeries::normalize(
  self : GeobufferellipseSeries,
) -> GeobufferellipseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 {
    self
  } else {
    let result = []
    for i in 0..<self.vals.length() {
      result.push((self.vals[i] - mn) / r)
    }
    { vals: result, name: self.name, meta: self.meta, }
  }
}

///|
pub fn GeobufferellipseSeries::cumsum(
  self : GeobufferellipseSeries,
) -> GeobufferellipseSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GeobufferellipseSeries::to_string(
  self : GeobufferellipseSeries,
) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.vals[i])
  }
  if n > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct GeobufferellipseMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn geo_buffer_ellipse_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GeobufferellipseMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn geo_buffer_ellipse_matrix_identity(n : Int32) -> GeobufferellipseMatrix {
  let m = geo_buffer_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GeobufferellipseMatrix::get(
  self : GeobufferellipseMatrix,
  i : Int32,
  j : Int32,
) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols {
    0.0
  } else {
    self.data[i][j]
  }
}

///|
pub fn GeobufferellipseMatrix::transpose(
  self : GeobufferellipseMatrix,
) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GeobufferellipseMatrix::add(
  self : GeobufferellipseMatrix,
  other : GeobufferellipseMatrix,
) -> GeobufferellipseMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = geo_buffer_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GeobufferellipseMatrix::scale(
  self : GeobufferellipseMatrix,
  s : Double,
) -> GeobufferellipseMatrix {
  let result = geo_buffer_ellipse_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GeobufferellipseMatrix::multiply(
  self : GeobufferellipseMatrix,
  other : GeobufferellipseMatrix,
) -> GeobufferellipseMatrix {
  if self.cols != other.rows {
    return geo_buffer_ellipse_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = geo_buffer_ellipse_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for k in 0..<self.cols {
      let v = self.data[i][k]
      for j in 0..<other.cols {
        result.data[i][j] = result.data[i][j] + v * other.data[k][j]
      }
    }
  }
  result
}

///|
pub fn GeobufferellipseMatrix::trace(self : GeobufferellipseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GeobufferellipseMatrix::det(self : GeobufferellipseMatrix) -> Double {
  if self.rows != self.cols {
    0.0
  } else if self.rows == 1 {
    self.data[0][0]
  } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] *
      (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] *
      (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] *
      (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else {
    0.0
  }
}

///|
pub fn GeobufferellipseMatrix::norm(self : GeobufferellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GeobufferellipseMatrix::to_string(
  self : GeobufferellipseMatrix,
) -> String {
  let mut result = "Mat(" +
    self.rows.to_string() +
    "x" +
    self.cols.to_string() +
    ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl {
      if j > 0 {
        result = result + ", "
      }
      result = result + @_common.dbl(self.data[i][j])
    }
    result = result + "]\n"
  }
  result
}

///|
pub(all) struct GeobufferellipseVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn geo_buffer_ellipse_make_vector(
  comps : Array[Double],
) -> GeobufferellipseVector {
  { comps, dim: comps.length(), }
}

///|
pub fn geo_buffer_ellipse_vector_zero(dim : Int32) -> GeobufferellipseVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GeobufferellipseVector::add(
  self : GeobufferellipseVector,
  other : GeobufferellipseVector,
) -> GeobufferellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GeobufferellipseVector::sub(
  self : GeobufferellipseVector,
  other : GeobufferellipseVector,
) -> GeobufferellipseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GeobufferellipseVector::scale(
  self : GeobufferellipseVector,
  s : Double,
) -> GeobufferellipseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GeobufferellipseVector::dot(
  self : GeobufferellipseVector,
  other : GeobufferellipseVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GeobufferellipseVector::norm(self : GeobufferellipseVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GeobufferellipseVector::normalize(
  self : GeobufferellipseVector,
) -> GeobufferellipseVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GeobufferellipseVector::dist(
  self : GeobufferellipseVector,
  other : GeobufferellipseVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GeobufferellipseVector::to_string(
  self : GeobufferellipseVector,
) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim {
    if i > 0 {
      result = result + ", "
    }
    result = result + @_common.dbl(self.comps[i])
  }
  if self.dim > 10 {
    result + "...]"
  } else {
    result + "]"
  }
}

///|
pub(all) struct GeobufferellipseFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_frame_make(size : Int32) -> GeobufferellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseFrame::len(self : GeobufferellipseFrame) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseFrame::get(
  self : GeobufferellipseFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseFrame::set(
  self : GeobufferellipseFrame,
  i : Int32,
  v : Double,
) -> GeobufferellipseFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseFrame::sum(self : GeobufferellipseFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseFrame::mean(self : GeobufferellipseFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseFrame::scale(
  self : GeobufferellipseFrame,
  f : Double,
) -> GeobufferellipseFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseFrame::add(
  self : GeobufferellipseFrame,
  other : GeobufferellipseFrame,
) -> GeobufferellipseFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseFrame::copy(
  self : GeobufferellipseFrame,
) -> GeobufferellipseFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseFrame::fill(
  self : GeobufferellipseFrame,
  v : Double,
) -> GeobufferellipseFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseFrame::min(self : GeobufferellipseFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseFrame::max(self : GeobufferellipseFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseFrame::to_string(self : GeobufferellipseFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_table_make(size : Int32) -> GeobufferellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseTable::len(self : GeobufferellipseTable) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseTable::get(
  self : GeobufferellipseTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseTable::set(
  self : GeobufferellipseTable,
  i : Int32,
  v : Double,
) -> GeobufferellipseTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseTable::sum(self : GeobufferellipseTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseTable::mean(self : GeobufferellipseTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseTable::scale(
  self : GeobufferellipseTable,
  f : Double,
) -> GeobufferellipseTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseTable::add(
  self : GeobufferellipseTable,
  other : GeobufferellipseTable,
) -> GeobufferellipseTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseTable::copy(
  self : GeobufferellipseTable,
) -> GeobufferellipseTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseTable::fill(
  self : GeobufferellipseTable,
  v : Double,
) -> GeobufferellipseTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseTable::min(self : GeobufferellipseTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseTable::max(self : GeobufferellipseTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseTable::to_string(self : GeobufferellipseTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_graphn_make(size : Int32) -> GeobufferellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseGraphN::len(self : GeobufferellipseGraphN) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseGraphN::get(
  self : GeobufferellipseGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseGraphN::set(
  self : GeobufferellipseGraphN,
  i : Int32,
  v : Double,
) -> GeobufferellipseGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseGraphN::sum(self : GeobufferellipseGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseGraphN::mean(self : GeobufferellipseGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseGraphN::scale(
  self : GeobufferellipseGraphN,
  f : Double,
) -> GeobufferellipseGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseGraphN::add(
  self : GeobufferellipseGraphN,
  other : GeobufferellipseGraphN,
) -> GeobufferellipseGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseGraphN::copy(
  self : GeobufferellipseGraphN,
) -> GeobufferellipseGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseGraphN::fill(
  self : GeobufferellipseGraphN,
  v : Double,
) -> GeobufferellipseGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseGraphN::min(self : GeobufferellipseGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseGraphN::max(self : GeobufferellipseGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseGraphN::to_string(
  self : GeobufferellipseGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_node_make(size : Int32) -> GeobufferellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseNode::len(self : GeobufferellipseNode) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseNode::get(
  self : GeobufferellipseNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseNode::set(
  self : GeobufferellipseNode,
  i : Int32,
  v : Double,
) -> GeobufferellipseNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseNode::sum(self : GeobufferellipseNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseNode::mean(self : GeobufferellipseNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseNode::scale(
  self : GeobufferellipseNode,
  f : Double,
) -> GeobufferellipseNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseNode::add(
  self : GeobufferellipseNode,
  other : GeobufferellipseNode,
) -> GeobufferellipseNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseNode::copy(
  self : GeobufferellipseNode,
) -> GeobufferellipseNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseNode::fill(
  self : GeobufferellipseNode,
  v : Double,
) -> GeobufferellipseNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseNode::min(self : GeobufferellipseNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseNode::max(self : GeobufferellipseNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseNode::to_string(self : GeobufferellipseNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_edge_make(size : Int32) -> GeobufferellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseEdge::len(self : GeobufferellipseEdge) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseEdge::get(
  self : GeobufferellipseEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseEdge::set(
  self : GeobufferellipseEdge,
  i : Int32,
  v : Double,
) -> GeobufferellipseEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseEdge::sum(self : GeobufferellipseEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseEdge::mean(self : GeobufferellipseEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseEdge::scale(
  self : GeobufferellipseEdge,
  f : Double,
) -> GeobufferellipseEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseEdge::add(
  self : GeobufferellipseEdge,
  other : GeobufferellipseEdge,
) -> GeobufferellipseEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseEdge::copy(
  self : GeobufferellipseEdge,
) -> GeobufferellipseEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseEdge::fill(
  self : GeobufferellipseEdge,
  v : Double,
) -> GeobufferellipseEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseEdge::min(self : GeobufferellipseEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseEdge::max(self : GeobufferellipseEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseEdge::to_string(self : GeobufferellipseEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipsePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_path_make(size : Int32) -> GeobufferellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipsePath::len(self : GeobufferellipsePath) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipsePath::get(
  self : GeobufferellipsePath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipsePath::set(
  self : GeobufferellipsePath,
  i : Int32,
  v : Double,
) -> GeobufferellipsePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipsePath::sum(self : GeobufferellipsePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipsePath::mean(self : GeobufferellipsePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipsePath::scale(
  self : GeobufferellipsePath,
  f : Double,
) -> GeobufferellipsePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipsePath::add(
  self : GeobufferellipsePath,
  other : GeobufferellipsePath,
) -> GeobufferellipsePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipsePath::copy(
  self : GeobufferellipsePath,
) -> GeobufferellipsePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipsePath::fill(
  self : GeobufferellipsePath,
  v : Double,
) -> GeobufferellipsePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipsePath::min(self : GeobufferellipsePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipsePath::max(self : GeobufferellipsePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipsePath::to_string(self : GeobufferellipsePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_cluster_make(size : Int32) -> GeobufferellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseCluster::len(self : GeobufferellipseCluster) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseCluster::get(
  self : GeobufferellipseCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseCluster::set(
  self : GeobufferellipseCluster,
  i : Int32,
  v : Double,
) -> GeobufferellipseCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCluster::sum(self : GeobufferellipseCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseCluster::mean(self : GeobufferellipseCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseCluster::scale(
  self : GeobufferellipseCluster,
  f : Double,
) -> GeobufferellipseCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCluster::add(
  self : GeobufferellipseCluster,
  other : GeobufferellipseCluster,
) -> GeobufferellipseCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseCluster::copy(
  self : GeobufferellipseCluster,
) -> GeobufferellipseCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCluster::fill(
  self : GeobufferellipseCluster,
  v : Double,
) -> GeobufferellipseCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCluster::min(self : GeobufferellipseCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseCluster::max(self : GeobufferellipseCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseCluster::to_string(
  self : GeobufferellipseCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_model_make(size : Int32) -> GeobufferellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseModel::len(self : GeobufferellipseModel) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseModel::get(
  self : GeobufferellipseModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseModel::set(
  self : GeobufferellipseModel,
  i : Int32,
  v : Double,
) -> GeobufferellipseModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseModel::sum(self : GeobufferellipseModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseModel::mean(self : GeobufferellipseModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseModel::scale(
  self : GeobufferellipseModel,
  f : Double,
) -> GeobufferellipseModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseModel::add(
  self : GeobufferellipseModel,
  other : GeobufferellipseModel,
) -> GeobufferellipseModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseModel::copy(
  self : GeobufferellipseModel,
) -> GeobufferellipseModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseModel::fill(
  self : GeobufferellipseModel,
  v : Double,
) -> GeobufferellipseModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseModel::min(self : GeobufferellipseModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseModel::max(self : GeobufferellipseModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseModel::to_string(self : GeobufferellipseModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_layer_make(size : Int32) -> GeobufferellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseLayer::len(self : GeobufferellipseLayer) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseLayer::get(
  self : GeobufferellipseLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseLayer::set(
  self : GeobufferellipseLayer,
  i : Int32,
  v : Double,
) -> GeobufferellipseLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseLayer::sum(self : GeobufferellipseLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseLayer::mean(self : GeobufferellipseLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseLayer::scale(
  self : GeobufferellipseLayer,
  f : Double,
) -> GeobufferellipseLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseLayer::add(
  self : GeobufferellipseLayer,
  other : GeobufferellipseLayer,
) -> GeobufferellipseLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseLayer::copy(
  self : GeobufferellipseLayer,
) -> GeobufferellipseLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseLayer::fill(
  self : GeobufferellipseLayer,
  v : Double,
) -> GeobufferellipseLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseLayer::min(self : GeobufferellipseLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseLayer::max(self : GeobufferellipseLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseLayer::to_string(self : GeobufferellipseLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_buffer_make(size : Int32) -> GeobufferellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseBuffer::len(self : GeobufferellipseBuffer) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseBuffer::get(
  self : GeobufferellipseBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseBuffer::set(
  self : GeobufferellipseBuffer,
  i : Int32,
  v : Double,
) -> GeobufferellipseBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseBuffer::sum(self : GeobufferellipseBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseBuffer::mean(self : GeobufferellipseBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseBuffer::scale(
  self : GeobufferellipseBuffer,
  f : Double,
) -> GeobufferellipseBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseBuffer::add(
  self : GeobufferellipseBuffer,
  other : GeobufferellipseBuffer,
) -> GeobufferellipseBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseBuffer::copy(
  self : GeobufferellipseBuffer,
) -> GeobufferellipseBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseBuffer::fill(
  self : GeobufferellipseBuffer,
  v : Double,
) -> GeobufferellipseBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseBuffer::min(self : GeobufferellipseBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseBuffer::max(self : GeobufferellipseBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseBuffer::to_string(
  self : GeobufferellipseBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_cursor_make(size : Int32) -> GeobufferellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseCursor::len(self : GeobufferellipseCursor) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseCursor::get(
  self : GeobufferellipseCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseCursor::set(
  self : GeobufferellipseCursor,
  i : Int32,
  v : Double,
) -> GeobufferellipseCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCursor::sum(self : GeobufferellipseCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseCursor::mean(self : GeobufferellipseCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseCursor::scale(
  self : GeobufferellipseCursor,
  f : Double,
) -> GeobufferellipseCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCursor::add(
  self : GeobufferellipseCursor,
  other : GeobufferellipseCursor,
) -> GeobufferellipseCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseCursor::copy(
  self : GeobufferellipseCursor,
) -> GeobufferellipseCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCursor::fill(
  self : GeobufferellipseCursor,
  v : Double,
) -> GeobufferellipseCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseCursor::min(self : GeobufferellipseCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseCursor::max(self : GeobufferellipseCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseCursor::to_string(
  self : GeobufferellipseCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_view_make(size : Int32) -> GeobufferellipseView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseView::len(self : GeobufferellipseView) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseView::get(
  self : GeobufferellipseView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseView::set(
  self : GeobufferellipseView,
  i : Int32,
  v : Double,
) -> GeobufferellipseView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseView::sum(self : GeobufferellipseView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseView::mean(self : GeobufferellipseView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseView::scale(
  self : GeobufferellipseView,
  f : Double,
) -> GeobufferellipseView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseView::add(
  self : GeobufferellipseView,
  other : GeobufferellipseView,
) -> GeobufferellipseView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseView::copy(
  self : GeobufferellipseView,
) -> GeobufferellipseView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseView::fill(
  self : GeobufferellipseView,
  v : Double,
) -> GeobufferellipseView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseView::min(self : GeobufferellipseView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseView::max(self : GeobufferellipseView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseView::to_string(self : GeobufferellipseView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_range_make(size : Int32) -> GeobufferellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseRange::len(self : GeobufferellipseRange) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseRange::get(
  self : GeobufferellipseRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseRange::set(
  self : GeobufferellipseRange,
  i : Int32,
  v : Double,
) -> GeobufferellipseRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseRange::sum(self : GeobufferellipseRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseRange::mean(self : GeobufferellipseRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseRange::scale(
  self : GeobufferellipseRange,
  f : Double,
) -> GeobufferellipseRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseRange::add(
  self : GeobufferellipseRange,
  other : GeobufferellipseRange,
) -> GeobufferellipseRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseRange::copy(
  self : GeobufferellipseRange,
) -> GeobufferellipseRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseRange::fill(
  self : GeobufferellipseRange,
  v : Double,
) -> GeobufferellipseRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseRange::min(self : GeobufferellipseRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseRange::max(self : GeobufferellipseRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseRange::to_string(self : GeobufferellipseRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferellipseSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_ellipse_slice_make(size : Int32) -> GeobufferellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferellipseSlice::len(self : GeobufferellipseSlice) -> Int32 {
  self.size
}

///|
pub fn GeobufferellipseSlice::get(
  self : GeobufferellipseSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferellipseSlice::set(
  self : GeobufferellipseSlice,
  i : Int32,
  v : Double,
) -> GeobufferellipseSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseSlice::sum(self : GeobufferellipseSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferellipseSlice::mean(self : GeobufferellipseSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferellipseSlice::scale(
  self : GeobufferellipseSlice,
  f : Double,
) -> GeobufferellipseSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseSlice::add(
  self : GeobufferellipseSlice,
  other : GeobufferellipseSlice,
) -> GeobufferellipseSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferellipseSlice::copy(
  self : GeobufferellipseSlice,
) -> GeobufferellipseSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseSlice::fill(
  self : GeobufferellipseSlice,
  v : Double,
) -> GeobufferellipseSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferellipseSlice::min(self : GeobufferellipseSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferellipseSlice::max(self : GeobufferellipseSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferellipseSlice::to_string(self : GeobufferellipseSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

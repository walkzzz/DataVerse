///|
///===
/// extcore/crypto_sign_group
pub(all) struct CryptosigngroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sign_group_make_point(
  x : Double,
  y : Double,
) -> CryptosigngroupPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sign_group_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosigngroupPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosigngroupPoint::x(self : CryptosigngroupPoint) -> Double {
  self.x
}

///|
pub fn CryptosigngroupPoint::y(self : CryptosigngroupPoint) -> Double {
  self.y
}

///|
pub fn CryptosigngroupPoint::z(self : CryptosigngroupPoint) -> Double {
  self.z
}

///|
pub fn CryptosigngroupPoint::label(self : CryptosigngroupPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosigngroupPoint::dist(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosigngroupPoint::add(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosigngroupPoint::sub(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosigngroupPoint::scale(
  self : CryptosigngroupPoint,
  s : Double,
) -> CryptosigngroupPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosigngroupPoint::dot(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosigngroupPoint::cross(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosigngroupPoint::norm(self : CryptosigngroupPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosigngroupPoint::normalize(
  self : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosigngroupPoint::negate(
  self : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosigngroupPoint::mid(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
) -> CryptosigngroupPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosigngroupPoint::lerp(
  self : CryptosigngroupPoint,
  other : CryptosigngroupPoint,
  t : Double,
) -> CryptosigngroupPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosigngroupPoint::to_string(self : CryptosigngroupPoint) -> String {
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
pub(all) struct CryptosigngroupSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sign_group_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosigngroupSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosigngroupSeries::len(self : CryptosigngroupSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosigngroupSeries::sum(self : CryptosigngroupSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosigngroupSeries::mean(self : CryptosigngroupSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosigngroupSeries::min(self : CryptosigngroupSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosigngroupSeries::max(self : CryptosigngroupSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosigngroupSeries::range(self : CryptosigngroupSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosigngroupSeries::variance(self : CryptosigngroupSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosigngroupSeries::std(self : CryptosigngroupSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosigngroupSeries::median(self : CryptosigngroupSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosigngroupSeries::scale(
  self : CryptosigngroupSeries,
  f : Double,
) -> CryptosigngroupSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosigngroupSeries::add(
  self : CryptosigngroupSeries,
  other : CryptosigngroupSeries,
) -> CryptosigngroupSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosigngroupSeries::sub(
  self : CryptosigngroupSeries,
  other : CryptosigngroupSeries,
) -> CryptosigngroupSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosigngroupSeries::normalize(
  self : CryptosigngroupSeries,
) -> CryptosigngroupSeries {
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
pub fn CryptosigngroupSeries::cumsum(
  self : CryptosigngroupSeries,
) -> CryptosigngroupSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosigngroupSeries::to_string(self : CryptosigngroupSeries) -> String {
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
pub(all) struct CryptosigngroupMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sign_group_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosigngroupMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sign_group_matrix_identity(n : Int32) -> CryptosigngroupMatrix {
  let m = crypto_sign_group_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosigngroupMatrix::get(
  self : CryptosigngroupMatrix,
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
pub fn CryptosigngroupMatrix::transpose(
  self : CryptosigngroupMatrix,
) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosigngroupMatrix::add(
  self : CryptosigngroupMatrix,
  other : CryptosigngroupMatrix,
) -> CryptosigngroupMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sign_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosigngroupMatrix::scale(
  self : CryptosigngroupMatrix,
  s : Double,
) -> CryptosigngroupMatrix {
  let result = crypto_sign_group_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosigngroupMatrix::multiply(
  self : CryptosigngroupMatrix,
  other : CryptosigngroupMatrix,
) -> CryptosigngroupMatrix {
  if self.cols != other.rows {
    return crypto_sign_group_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sign_group_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosigngroupMatrix::trace(self : CryptosigngroupMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosigngroupMatrix::det(self : CryptosigngroupMatrix) -> Double {
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
pub fn CryptosigngroupMatrix::norm(self : CryptosigngroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosigngroupMatrix::to_string(self : CryptosigngroupMatrix) -> String {
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
pub(all) struct CryptosigngroupVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sign_group_make_vector(
  comps : Array[Double],
) -> CryptosigngroupVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sign_group_vector_zero(dim : Int32) -> CryptosigngroupVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosigngroupVector::add(
  self : CryptosigngroupVector,
  other : CryptosigngroupVector,
) -> CryptosigngroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosigngroupVector::sub(
  self : CryptosigngroupVector,
  other : CryptosigngroupVector,
) -> CryptosigngroupVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosigngroupVector::scale(
  self : CryptosigngroupVector,
  s : Double,
) -> CryptosigngroupVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosigngroupVector::dot(
  self : CryptosigngroupVector,
  other : CryptosigngroupVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosigngroupVector::norm(self : CryptosigngroupVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosigngroupVector::normalize(
  self : CryptosigngroupVector,
) -> CryptosigngroupVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosigngroupVector::dist(
  self : CryptosigngroupVector,
  other : CryptosigngroupVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosigngroupVector::to_string(self : CryptosigngroupVector) -> String {
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
pub(all) struct CryptosigngroupFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_frame_make(size : Int32) -> CryptosigngroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupFrame::len(self : CryptosigngroupFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupFrame::get(
  self : CryptosigngroupFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupFrame::set(
  self : CryptosigngroupFrame,
  i : Int32,
  v : Double,
) -> CryptosigngroupFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupFrame::sum(self : CryptosigngroupFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupFrame::mean(self : CryptosigngroupFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupFrame::scale(
  self : CryptosigngroupFrame,
  f : Double,
) -> CryptosigngroupFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupFrame::add(
  self : CryptosigngroupFrame,
  other : CryptosigngroupFrame,
) -> CryptosigngroupFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupFrame::copy(
  self : CryptosigngroupFrame,
) -> CryptosigngroupFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupFrame::fill(
  self : CryptosigngroupFrame,
  v : Double,
) -> CryptosigngroupFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupFrame::min(self : CryptosigngroupFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupFrame::max(self : CryptosigngroupFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupFrame::to_string(self : CryptosigngroupFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_table_make(size : Int32) -> CryptosigngroupTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupTable::len(self : CryptosigngroupTable) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupTable::get(
  self : CryptosigngroupTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupTable::set(
  self : CryptosigngroupTable,
  i : Int32,
  v : Double,
) -> CryptosigngroupTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupTable::sum(self : CryptosigngroupTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupTable::mean(self : CryptosigngroupTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupTable::scale(
  self : CryptosigngroupTable,
  f : Double,
) -> CryptosigngroupTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupTable::add(
  self : CryptosigngroupTable,
  other : CryptosigngroupTable,
) -> CryptosigngroupTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupTable::copy(
  self : CryptosigngroupTable,
) -> CryptosigngroupTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupTable::fill(
  self : CryptosigngroupTable,
  v : Double,
) -> CryptosigngroupTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupTable::min(self : CryptosigngroupTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupTable::max(self : CryptosigngroupTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupTable::to_string(self : CryptosigngroupTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_graphn_make(size : Int32) -> CryptosigngroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupGraphN::len(self : CryptosigngroupGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupGraphN::get(
  self : CryptosigngroupGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupGraphN::set(
  self : CryptosigngroupGraphN,
  i : Int32,
  v : Double,
) -> CryptosigngroupGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupGraphN::sum(self : CryptosigngroupGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupGraphN::mean(self : CryptosigngroupGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupGraphN::scale(
  self : CryptosigngroupGraphN,
  f : Double,
) -> CryptosigngroupGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupGraphN::add(
  self : CryptosigngroupGraphN,
  other : CryptosigngroupGraphN,
) -> CryptosigngroupGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupGraphN::copy(
  self : CryptosigngroupGraphN,
) -> CryptosigngroupGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupGraphN::fill(
  self : CryptosigngroupGraphN,
  v : Double,
) -> CryptosigngroupGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupGraphN::min(self : CryptosigngroupGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupGraphN::max(self : CryptosigngroupGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupGraphN::to_string(self : CryptosigngroupGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_node_make(size : Int32) -> CryptosigngroupNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupNode::len(self : CryptosigngroupNode) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupNode::get(
  self : CryptosigngroupNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupNode::set(
  self : CryptosigngroupNode,
  i : Int32,
  v : Double,
) -> CryptosigngroupNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupNode::sum(self : CryptosigngroupNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupNode::mean(self : CryptosigngroupNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupNode::scale(
  self : CryptosigngroupNode,
  f : Double,
) -> CryptosigngroupNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupNode::add(
  self : CryptosigngroupNode,
  other : CryptosigngroupNode,
) -> CryptosigngroupNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupNode::copy(
  self : CryptosigngroupNode,
) -> CryptosigngroupNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupNode::fill(
  self : CryptosigngroupNode,
  v : Double,
) -> CryptosigngroupNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupNode::min(self : CryptosigngroupNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupNode::max(self : CryptosigngroupNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupNode::to_string(self : CryptosigngroupNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_edge_make(size : Int32) -> CryptosigngroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupEdge::len(self : CryptosigngroupEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupEdge::get(
  self : CryptosigngroupEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupEdge::set(
  self : CryptosigngroupEdge,
  i : Int32,
  v : Double,
) -> CryptosigngroupEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupEdge::sum(self : CryptosigngroupEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupEdge::mean(self : CryptosigngroupEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupEdge::scale(
  self : CryptosigngroupEdge,
  f : Double,
) -> CryptosigngroupEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupEdge::add(
  self : CryptosigngroupEdge,
  other : CryptosigngroupEdge,
) -> CryptosigngroupEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupEdge::copy(
  self : CryptosigngroupEdge,
) -> CryptosigngroupEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupEdge::fill(
  self : CryptosigngroupEdge,
  v : Double,
) -> CryptosigngroupEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupEdge::min(self : CryptosigngroupEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupEdge::max(self : CryptosigngroupEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupEdge::to_string(self : CryptosigngroupEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_path_make(size : Int32) -> CryptosigngroupPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupPath::len(self : CryptosigngroupPath) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupPath::get(
  self : CryptosigngroupPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupPath::set(
  self : CryptosigngroupPath,
  i : Int32,
  v : Double,
) -> CryptosigngroupPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupPath::sum(self : CryptosigngroupPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupPath::mean(self : CryptosigngroupPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupPath::scale(
  self : CryptosigngroupPath,
  f : Double,
) -> CryptosigngroupPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupPath::add(
  self : CryptosigngroupPath,
  other : CryptosigngroupPath,
) -> CryptosigngroupPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupPath::copy(
  self : CryptosigngroupPath,
) -> CryptosigngroupPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupPath::fill(
  self : CryptosigngroupPath,
  v : Double,
) -> CryptosigngroupPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupPath::min(self : CryptosigngroupPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupPath::max(self : CryptosigngroupPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupPath::to_string(self : CryptosigngroupPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_cluster_make(size : Int32) -> CryptosigngroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupCluster::len(self : CryptosigngroupCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupCluster::get(
  self : CryptosigngroupCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupCluster::set(
  self : CryptosigngroupCluster,
  i : Int32,
  v : Double,
) -> CryptosigngroupCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCluster::sum(self : CryptosigngroupCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupCluster::mean(self : CryptosigngroupCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupCluster::scale(
  self : CryptosigngroupCluster,
  f : Double,
) -> CryptosigngroupCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCluster::add(
  self : CryptosigngroupCluster,
  other : CryptosigngroupCluster,
) -> CryptosigngroupCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupCluster::copy(
  self : CryptosigngroupCluster,
) -> CryptosigngroupCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCluster::fill(
  self : CryptosigngroupCluster,
  v : Double,
) -> CryptosigngroupCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCluster::min(self : CryptosigngroupCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupCluster::max(self : CryptosigngroupCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupCluster::to_string(
  self : CryptosigngroupCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_model_make(size : Int32) -> CryptosigngroupModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupModel::len(self : CryptosigngroupModel) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupModel::get(
  self : CryptosigngroupModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupModel::set(
  self : CryptosigngroupModel,
  i : Int32,
  v : Double,
) -> CryptosigngroupModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupModel::sum(self : CryptosigngroupModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupModel::mean(self : CryptosigngroupModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupModel::scale(
  self : CryptosigngroupModel,
  f : Double,
) -> CryptosigngroupModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupModel::add(
  self : CryptosigngroupModel,
  other : CryptosigngroupModel,
) -> CryptosigngroupModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupModel::copy(
  self : CryptosigngroupModel,
) -> CryptosigngroupModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupModel::fill(
  self : CryptosigngroupModel,
  v : Double,
) -> CryptosigngroupModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupModel::min(self : CryptosigngroupModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupModel::max(self : CryptosigngroupModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupModel::to_string(self : CryptosigngroupModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_layer_make(size : Int32) -> CryptosigngroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupLayer::len(self : CryptosigngroupLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupLayer::get(
  self : CryptosigngroupLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupLayer::set(
  self : CryptosigngroupLayer,
  i : Int32,
  v : Double,
) -> CryptosigngroupLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupLayer::sum(self : CryptosigngroupLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupLayer::mean(self : CryptosigngroupLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupLayer::scale(
  self : CryptosigngroupLayer,
  f : Double,
) -> CryptosigngroupLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupLayer::add(
  self : CryptosigngroupLayer,
  other : CryptosigngroupLayer,
) -> CryptosigngroupLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupLayer::copy(
  self : CryptosigngroupLayer,
) -> CryptosigngroupLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupLayer::fill(
  self : CryptosigngroupLayer,
  v : Double,
) -> CryptosigngroupLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupLayer::min(self : CryptosigngroupLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupLayer::max(self : CryptosigngroupLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupLayer::to_string(self : CryptosigngroupLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_buffer_make(size : Int32) -> CryptosigngroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupBuffer::len(self : CryptosigngroupBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupBuffer::get(
  self : CryptosigngroupBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupBuffer::set(
  self : CryptosigngroupBuffer,
  i : Int32,
  v : Double,
) -> CryptosigngroupBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupBuffer::sum(self : CryptosigngroupBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupBuffer::mean(self : CryptosigngroupBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupBuffer::scale(
  self : CryptosigngroupBuffer,
  f : Double,
) -> CryptosigngroupBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupBuffer::add(
  self : CryptosigngroupBuffer,
  other : CryptosigngroupBuffer,
) -> CryptosigngroupBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupBuffer::copy(
  self : CryptosigngroupBuffer,
) -> CryptosigngroupBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupBuffer::fill(
  self : CryptosigngroupBuffer,
  v : Double,
) -> CryptosigngroupBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupBuffer::min(self : CryptosigngroupBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupBuffer::max(self : CryptosigngroupBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupBuffer::to_string(self : CryptosigngroupBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_cursor_make(size : Int32) -> CryptosigngroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupCursor::len(self : CryptosigngroupCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupCursor::get(
  self : CryptosigngroupCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupCursor::set(
  self : CryptosigngroupCursor,
  i : Int32,
  v : Double,
) -> CryptosigngroupCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCursor::sum(self : CryptosigngroupCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupCursor::mean(self : CryptosigngroupCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupCursor::scale(
  self : CryptosigngroupCursor,
  f : Double,
) -> CryptosigngroupCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCursor::add(
  self : CryptosigngroupCursor,
  other : CryptosigngroupCursor,
) -> CryptosigngroupCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupCursor::copy(
  self : CryptosigngroupCursor,
) -> CryptosigngroupCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCursor::fill(
  self : CryptosigngroupCursor,
  v : Double,
) -> CryptosigngroupCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupCursor::min(self : CryptosigngroupCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupCursor::max(self : CryptosigngroupCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupCursor::to_string(self : CryptosigngroupCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_view_make(size : Int32) -> CryptosigngroupView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupView::len(self : CryptosigngroupView) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupView::get(
  self : CryptosigngroupView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupView::set(
  self : CryptosigngroupView,
  i : Int32,
  v : Double,
) -> CryptosigngroupView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupView::sum(self : CryptosigngroupView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupView::mean(self : CryptosigngroupView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupView::scale(
  self : CryptosigngroupView,
  f : Double,
) -> CryptosigngroupView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupView::add(
  self : CryptosigngroupView,
  other : CryptosigngroupView,
) -> CryptosigngroupView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupView::copy(
  self : CryptosigngroupView,
) -> CryptosigngroupView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupView::fill(
  self : CryptosigngroupView,
  v : Double,
) -> CryptosigngroupView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupView::min(self : CryptosigngroupView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupView::max(self : CryptosigngroupView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupView::to_string(self : CryptosigngroupView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_range_make(size : Int32) -> CryptosigngroupRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupRange::len(self : CryptosigngroupRange) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupRange::get(
  self : CryptosigngroupRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupRange::set(
  self : CryptosigngroupRange,
  i : Int32,
  v : Double,
) -> CryptosigngroupRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupRange::sum(self : CryptosigngroupRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupRange::mean(self : CryptosigngroupRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupRange::scale(
  self : CryptosigngroupRange,
  f : Double,
) -> CryptosigngroupRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupRange::add(
  self : CryptosigngroupRange,
  other : CryptosigngroupRange,
) -> CryptosigngroupRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupRange::copy(
  self : CryptosigngroupRange,
) -> CryptosigngroupRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupRange::fill(
  self : CryptosigngroupRange,
  v : Double,
) -> CryptosigngroupRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupRange::min(self : CryptosigngroupRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupRange::max(self : CryptosigngroupRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupRange::to_string(self : CryptosigngroupRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosigngroupSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_group_slice_make(size : Int32) -> CryptosigngroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosigngroupSlice::len(self : CryptosigngroupSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosigngroupSlice::get(
  self : CryptosigngroupSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosigngroupSlice::set(
  self : CryptosigngroupSlice,
  i : Int32,
  v : Double,
) -> CryptosigngroupSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupSlice::sum(self : CryptosigngroupSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosigngroupSlice::mean(self : CryptosigngroupSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosigngroupSlice::scale(
  self : CryptosigngroupSlice,
  f : Double,
) -> CryptosigngroupSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupSlice::add(
  self : CryptosigngroupSlice,
  other : CryptosigngroupSlice,
) -> CryptosigngroupSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosigngroupSlice::copy(
  self : CryptosigngroupSlice,
) -> CryptosigngroupSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupSlice::fill(
  self : CryptosigngroupSlice,
  v : Double,
) -> CryptosigngroupSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosigngroupSlice::min(self : CryptosigngroupSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosigngroupSlice::max(self : CryptosigngroupSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosigngroupSlice::to_string(self : CryptosigngroupSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

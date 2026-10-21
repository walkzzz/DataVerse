///|
///===
/// extcore/crypto_sym_idea
pub(all) struct CryptosymideaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sym_idea_make_point(x : Double, y : Double) -> CryptosymideaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sym_idea_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosymideaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosymideaPoint::x(self : CryptosymideaPoint) -> Double {
  self.x
}

///|
pub fn CryptosymideaPoint::y(self : CryptosymideaPoint) -> Double {
  self.y
}

///|
pub fn CryptosymideaPoint::z(self : CryptosymideaPoint) -> Double {
  self.z
}

///|
pub fn CryptosymideaPoint::label(self : CryptosymideaPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosymideaPoint::dist(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosymideaPoint::add(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> CryptosymideaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosymideaPoint::sub(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> CryptosymideaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosymideaPoint::scale(
  self : CryptosymideaPoint,
  s : Double,
) -> CryptosymideaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosymideaPoint::dot(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosymideaPoint::cross(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> CryptosymideaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosymideaPoint::norm(self : CryptosymideaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosymideaPoint::normalize(
  self : CryptosymideaPoint,
) -> CryptosymideaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosymideaPoint::negate(
  self : CryptosymideaPoint,
) -> CryptosymideaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosymideaPoint::mid(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
) -> CryptosymideaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosymideaPoint::lerp(
  self : CryptosymideaPoint,
  other : CryptosymideaPoint,
  t : Double,
) -> CryptosymideaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosymideaPoint::to_string(self : CryptosymideaPoint) -> String {
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
pub(all) struct CryptosymideaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sym_idea_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosymideaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosymideaSeries::len(self : CryptosymideaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosymideaSeries::sum(self : CryptosymideaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosymideaSeries::mean(self : CryptosymideaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosymideaSeries::min(self : CryptosymideaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosymideaSeries::max(self : CryptosymideaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosymideaSeries::range(self : CryptosymideaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosymideaSeries::variance(self : CryptosymideaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosymideaSeries::std(self : CryptosymideaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosymideaSeries::median(self : CryptosymideaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosymideaSeries::scale(
  self : CryptosymideaSeries,
  f : Double,
) -> CryptosymideaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosymideaSeries::add(
  self : CryptosymideaSeries,
  other : CryptosymideaSeries,
) -> CryptosymideaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosymideaSeries::sub(
  self : CryptosymideaSeries,
  other : CryptosymideaSeries,
) -> CryptosymideaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosymideaSeries::normalize(
  self : CryptosymideaSeries,
) -> CryptosymideaSeries {
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
pub fn CryptosymideaSeries::cumsum(
  self : CryptosymideaSeries,
) -> CryptosymideaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosymideaSeries::to_string(self : CryptosymideaSeries) -> String {
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
pub(all) struct CryptosymideaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sym_idea_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosymideaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sym_idea_matrix_identity(n : Int32) -> CryptosymideaMatrix {
  let m = crypto_sym_idea_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosymideaMatrix::get(
  self : CryptosymideaMatrix,
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
pub fn CryptosymideaMatrix::transpose(
  self : CryptosymideaMatrix,
) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosymideaMatrix::add(
  self : CryptosymideaMatrix,
  other : CryptosymideaMatrix,
) -> CryptosymideaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sym_idea_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosymideaMatrix::scale(
  self : CryptosymideaMatrix,
  s : Double,
) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosymideaMatrix::multiply(
  self : CryptosymideaMatrix,
  other : CryptosymideaMatrix,
) -> CryptosymideaMatrix {
  if self.cols != other.rows {
    return crypto_sym_idea_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sym_idea_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosymideaMatrix::trace(self : CryptosymideaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosymideaMatrix::det(self : CryptosymideaMatrix) -> Double {
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
pub fn CryptosymideaMatrix::norm(self : CryptosymideaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosymideaMatrix::to_string(self : CryptosymideaMatrix) -> String {
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
pub(all) struct CryptosymideaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sym_idea_make_vector(
  comps : Array[Double],
) -> CryptosymideaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sym_idea_vector_zero(dim : Int32) -> CryptosymideaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosymideaVector::add(
  self : CryptosymideaVector,
  other : CryptosymideaVector,
) -> CryptosymideaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosymideaVector::sub(
  self : CryptosymideaVector,
  other : CryptosymideaVector,
) -> CryptosymideaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosymideaVector::scale(
  self : CryptosymideaVector,
  s : Double,
) -> CryptosymideaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosymideaVector::dot(
  self : CryptosymideaVector,
  other : CryptosymideaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosymideaVector::norm(self : CryptosymideaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosymideaVector::normalize(
  self : CryptosymideaVector,
) -> CryptosymideaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosymideaVector::dist(
  self : CryptosymideaVector,
  other : CryptosymideaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosymideaVector::to_string(self : CryptosymideaVector) -> String {
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
pub(all) struct CryptosymideaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_frame_make(size : Int32) -> CryptosymideaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaFrame::len(self : CryptosymideaFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaFrame::get(self : CryptosymideaFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaFrame::set(
  self : CryptosymideaFrame,
  i : Int32,
  v : Double,
) -> CryptosymideaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaFrame::sum(self : CryptosymideaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaFrame::mean(self : CryptosymideaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaFrame::scale(
  self : CryptosymideaFrame,
  f : Double,
) -> CryptosymideaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaFrame::add(
  self : CryptosymideaFrame,
  other : CryptosymideaFrame,
) -> CryptosymideaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaFrame::copy(
  self : CryptosymideaFrame,
) -> CryptosymideaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaFrame::fill(
  self : CryptosymideaFrame,
  v : Double,
) -> CryptosymideaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaFrame::min(self : CryptosymideaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaFrame::max(self : CryptosymideaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaFrame::to_string(self : CryptosymideaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_table_make(size : Int32) -> CryptosymideaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaTable::len(self : CryptosymideaTable) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaTable::get(self : CryptosymideaTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaTable::set(
  self : CryptosymideaTable,
  i : Int32,
  v : Double,
) -> CryptosymideaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaTable::sum(self : CryptosymideaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaTable::mean(self : CryptosymideaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaTable::scale(
  self : CryptosymideaTable,
  f : Double,
) -> CryptosymideaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaTable::add(
  self : CryptosymideaTable,
  other : CryptosymideaTable,
) -> CryptosymideaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaTable::copy(
  self : CryptosymideaTable,
) -> CryptosymideaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaTable::fill(
  self : CryptosymideaTable,
  v : Double,
) -> CryptosymideaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaTable::min(self : CryptosymideaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaTable::max(self : CryptosymideaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaTable::to_string(self : CryptosymideaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_graphn_make(size : Int32) -> CryptosymideaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaGraphN::len(self : CryptosymideaGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaGraphN::get(
  self : CryptosymideaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaGraphN::set(
  self : CryptosymideaGraphN,
  i : Int32,
  v : Double,
) -> CryptosymideaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaGraphN::sum(self : CryptosymideaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaGraphN::mean(self : CryptosymideaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaGraphN::scale(
  self : CryptosymideaGraphN,
  f : Double,
) -> CryptosymideaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaGraphN::add(
  self : CryptosymideaGraphN,
  other : CryptosymideaGraphN,
) -> CryptosymideaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaGraphN::copy(
  self : CryptosymideaGraphN,
) -> CryptosymideaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaGraphN::fill(
  self : CryptosymideaGraphN,
  v : Double,
) -> CryptosymideaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaGraphN::min(self : CryptosymideaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaGraphN::max(self : CryptosymideaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaGraphN::to_string(self : CryptosymideaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_node_make(size : Int32) -> CryptosymideaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaNode::len(self : CryptosymideaNode) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaNode::get(self : CryptosymideaNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaNode::set(
  self : CryptosymideaNode,
  i : Int32,
  v : Double,
) -> CryptosymideaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaNode::sum(self : CryptosymideaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaNode::mean(self : CryptosymideaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaNode::scale(
  self : CryptosymideaNode,
  f : Double,
) -> CryptosymideaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaNode::add(
  self : CryptosymideaNode,
  other : CryptosymideaNode,
) -> CryptosymideaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaNode::copy(self : CryptosymideaNode) -> CryptosymideaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaNode::fill(
  self : CryptosymideaNode,
  v : Double,
) -> CryptosymideaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaNode::min(self : CryptosymideaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaNode::max(self : CryptosymideaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaNode::to_string(self : CryptosymideaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_edge_make(size : Int32) -> CryptosymideaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaEdge::len(self : CryptosymideaEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaEdge::get(self : CryptosymideaEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaEdge::set(
  self : CryptosymideaEdge,
  i : Int32,
  v : Double,
) -> CryptosymideaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaEdge::sum(self : CryptosymideaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaEdge::mean(self : CryptosymideaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaEdge::scale(
  self : CryptosymideaEdge,
  f : Double,
) -> CryptosymideaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaEdge::add(
  self : CryptosymideaEdge,
  other : CryptosymideaEdge,
) -> CryptosymideaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaEdge::copy(self : CryptosymideaEdge) -> CryptosymideaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaEdge::fill(
  self : CryptosymideaEdge,
  v : Double,
) -> CryptosymideaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaEdge::min(self : CryptosymideaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaEdge::max(self : CryptosymideaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaEdge::to_string(self : CryptosymideaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_path_make(size : Int32) -> CryptosymideaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaPath::len(self : CryptosymideaPath) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaPath::get(self : CryptosymideaPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaPath::set(
  self : CryptosymideaPath,
  i : Int32,
  v : Double,
) -> CryptosymideaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaPath::sum(self : CryptosymideaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaPath::mean(self : CryptosymideaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaPath::scale(
  self : CryptosymideaPath,
  f : Double,
) -> CryptosymideaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaPath::add(
  self : CryptosymideaPath,
  other : CryptosymideaPath,
) -> CryptosymideaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaPath::copy(self : CryptosymideaPath) -> CryptosymideaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaPath::fill(
  self : CryptosymideaPath,
  v : Double,
) -> CryptosymideaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaPath::min(self : CryptosymideaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaPath::max(self : CryptosymideaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaPath::to_string(self : CryptosymideaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_cluster_make(size : Int32) -> CryptosymideaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaCluster::len(self : CryptosymideaCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaCluster::get(
  self : CryptosymideaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaCluster::set(
  self : CryptosymideaCluster,
  i : Int32,
  v : Double,
) -> CryptosymideaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCluster::sum(self : CryptosymideaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaCluster::mean(self : CryptosymideaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaCluster::scale(
  self : CryptosymideaCluster,
  f : Double,
) -> CryptosymideaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCluster::add(
  self : CryptosymideaCluster,
  other : CryptosymideaCluster,
) -> CryptosymideaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaCluster::copy(
  self : CryptosymideaCluster,
) -> CryptosymideaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCluster::fill(
  self : CryptosymideaCluster,
  v : Double,
) -> CryptosymideaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCluster::min(self : CryptosymideaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaCluster::max(self : CryptosymideaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaCluster::to_string(self : CryptosymideaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_model_make(size : Int32) -> CryptosymideaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaModel::len(self : CryptosymideaModel) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaModel::get(self : CryptosymideaModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaModel::set(
  self : CryptosymideaModel,
  i : Int32,
  v : Double,
) -> CryptosymideaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaModel::sum(self : CryptosymideaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaModel::mean(self : CryptosymideaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaModel::scale(
  self : CryptosymideaModel,
  f : Double,
) -> CryptosymideaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaModel::add(
  self : CryptosymideaModel,
  other : CryptosymideaModel,
) -> CryptosymideaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaModel::copy(
  self : CryptosymideaModel,
) -> CryptosymideaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaModel::fill(
  self : CryptosymideaModel,
  v : Double,
) -> CryptosymideaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaModel::min(self : CryptosymideaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaModel::max(self : CryptosymideaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaModel::to_string(self : CryptosymideaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_layer_make(size : Int32) -> CryptosymideaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaLayer::len(self : CryptosymideaLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaLayer::get(self : CryptosymideaLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaLayer::set(
  self : CryptosymideaLayer,
  i : Int32,
  v : Double,
) -> CryptosymideaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaLayer::sum(self : CryptosymideaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaLayer::mean(self : CryptosymideaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaLayer::scale(
  self : CryptosymideaLayer,
  f : Double,
) -> CryptosymideaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaLayer::add(
  self : CryptosymideaLayer,
  other : CryptosymideaLayer,
) -> CryptosymideaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaLayer::copy(
  self : CryptosymideaLayer,
) -> CryptosymideaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaLayer::fill(
  self : CryptosymideaLayer,
  v : Double,
) -> CryptosymideaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaLayer::min(self : CryptosymideaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaLayer::max(self : CryptosymideaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaLayer::to_string(self : CryptosymideaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_buffer_make(size : Int32) -> CryptosymideaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaBuffer::len(self : CryptosymideaBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaBuffer::get(
  self : CryptosymideaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaBuffer::set(
  self : CryptosymideaBuffer,
  i : Int32,
  v : Double,
) -> CryptosymideaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaBuffer::sum(self : CryptosymideaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaBuffer::mean(self : CryptosymideaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaBuffer::scale(
  self : CryptosymideaBuffer,
  f : Double,
) -> CryptosymideaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaBuffer::add(
  self : CryptosymideaBuffer,
  other : CryptosymideaBuffer,
) -> CryptosymideaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaBuffer::copy(
  self : CryptosymideaBuffer,
) -> CryptosymideaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaBuffer::fill(
  self : CryptosymideaBuffer,
  v : Double,
) -> CryptosymideaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaBuffer::min(self : CryptosymideaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaBuffer::max(self : CryptosymideaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaBuffer::to_string(self : CryptosymideaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_cursor_make(size : Int32) -> CryptosymideaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaCursor::len(self : CryptosymideaCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaCursor::get(
  self : CryptosymideaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaCursor::set(
  self : CryptosymideaCursor,
  i : Int32,
  v : Double,
) -> CryptosymideaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCursor::sum(self : CryptosymideaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaCursor::mean(self : CryptosymideaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaCursor::scale(
  self : CryptosymideaCursor,
  f : Double,
) -> CryptosymideaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCursor::add(
  self : CryptosymideaCursor,
  other : CryptosymideaCursor,
) -> CryptosymideaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaCursor::copy(
  self : CryptosymideaCursor,
) -> CryptosymideaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCursor::fill(
  self : CryptosymideaCursor,
  v : Double,
) -> CryptosymideaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaCursor::min(self : CryptosymideaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaCursor::max(self : CryptosymideaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaCursor::to_string(self : CryptosymideaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_view_make(size : Int32) -> CryptosymideaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaView::len(self : CryptosymideaView) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaView::get(self : CryptosymideaView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaView::set(
  self : CryptosymideaView,
  i : Int32,
  v : Double,
) -> CryptosymideaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaView::sum(self : CryptosymideaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaView::mean(self : CryptosymideaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaView::scale(
  self : CryptosymideaView,
  f : Double,
) -> CryptosymideaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaView::add(
  self : CryptosymideaView,
  other : CryptosymideaView,
) -> CryptosymideaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaView::copy(self : CryptosymideaView) -> CryptosymideaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaView::fill(
  self : CryptosymideaView,
  v : Double,
) -> CryptosymideaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaView::min(self : CryptosymideaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaView::max(self : CryptosymideaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaView::to_string(self : CryptosymideaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_range_make(size : Int32) -> CryptosymideaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaRange::len(self : CryptosymideaRange) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaRange::get(self : CryptosymideaRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaRange::set(
  self : CryptosymideaRange,
  i : Int32,
  v : Double,
) -> CryptosymideaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaRange::sum(self : CryptosymideaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaRange::mean(self : CryptosymideaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaRange::scale(
  self : CryptosymideaRange,
  f : Double,
) -> CryptosymideaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaRange::add(
  self : CryptosymideaRange,
  other : CryptosymideaRange,
) -> CryptosymideaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaRange::copy(
  self : CryptosymideaRange,
) -> CryptosymideaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaRange::fill(
  self : CryptosymideaRange,
  v : Double,
) -> CryptosymideaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaRange::min(self : CryptosymideaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaRange::max(self : CryptosymideaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaRange::to_string(self : CryptosymideaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosymideaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sym_idea_slice_make(size : Int32) -> CryptosymideaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosymideaSlice::len(self : CryptosymideaSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosymideaSlice::get(self : CryptosymideaSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosymideaSlice::set(
  self : CryptosymideaSlice,
  i : Int32,
  v : Double,
) -> CryptosymideaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaSlice::sum(self : CryptosymideaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosymideaSlice::mean(self : CryptosymideaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosymideaSlice::scale(
  self : CryptosymideaSlice,
  f : Double,
) -> CryptosymideaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaSlice::add(
  self : CryptosymideaSlice,
  other : CryptosymideaSlice,
) -> CryptosymideaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosymideaSlice::copy(
  self : CryptosymideaSlice,
) -> CryptosymideaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaSlice::fill(
  self : CryptosymideaSlice,
  v : Double,
) -> CryptosymideaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosymideaSlice::min(self : CryptosymideaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosymideaSlice::max(self : CryptosymideaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosymideaSlice::to_string(self : CryptosymideaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

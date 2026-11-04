///|
///===
/// extcore/crypto_sign_ring
pub(all) struct CryptosignringPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn crypto_sign_ring_make_point(
  x : Double,
  y : Double,
) -> CryptosignringPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn crypto_sign_ring_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> CryptosignringPoint {
  { x, y, z, label: 0, }
}

///|
pub fn CryptosignringPoint::x(self : CryptosignringPoint) -> Double {
  self.x
}

///|
pub fn CryptosignringPoint::y(self : CryptosignringPoint) -> Double {
  self.y
}

///|
pub fn CryptosignringPoint::z(self : CryptosignringPoint) -> Double {
  self.z
}

///|
pub fn CryptosignringPoint::label(self : CryptosignringPoint) -> Int32 {
  self.label
}

///|
pub fn CryptosignringPoint::dist(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn CryptosignringPoint::add(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> CryptosignringPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignringPoint::sub(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> CryptosignringPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn CryptosignringPoint::scale(
  self : CryptosignringPoint,
  s : Double,
) -> CryptosignringPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn CryptosignringPoint::dot(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn CryptosignringPoint::cross(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> CryptosignringPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn CryptosignringPoint::norm(self : CryptosignringPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn CryptosignringPoint::normalize(
  self : CryptosignringPoint,
) -> CryptosignringPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignringPoint::negate(
  self : CryptosignringPoint,
) -> CryptosignringPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn CryptosignringPoint::mid(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
) -> CryptosignringPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn CryptosignringPoint::lerp(
  self : CryptosignringPoint,
  other : CryptosignringPoint,
  t : Double,
) -> CryptosignringPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn CryptosignringPoint::to_string(self : CryptosignringPoint) -> String {
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
pub(all) struct CryptosignringSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn crypto_sign_ring_make_series(
  vals : Array[Double],
  name : String,
) -> CryptosignringSeries {
  { vals, name, meta: 0, }
}

///|
pub fn CryptosignringSeries::len(self : CryptosignringSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn CryptosignringSeries::sum(self : CryptosignringSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn CryptosignringSeries::mean(self : CryptosignringSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn CryptosignringSeries::min(self : CryptosignringSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn CryptosignringSeries::max(self : CryptosignringSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn CryptosignringSeries::range(self : CryptosignringSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn CryptosignringSeries::variance(self : CryptosignringSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn CryptosignringSeries::std(self : CryptosignringSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn CryptosignringSeries::median(self : CryptosignringSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn CryptosignringSeries::scale(
  self : CryptosignringSeries,
  f : Double,
) -> CryptosignringSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn CryptosignringSeries::add(
  self : CryptosignringSeries,
  other : CryptosignringSeries,
) -> CryptosignringSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignringSeries::sub(
  self : CryptosignringSeries,
  other : CryptosignringSeries,
) -> CryptosignringSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn CryptosignringSeries::normalize(
  self : CryptosignringSeries,
) -> CryptosignringSeries {
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
pub fn CryptosignringSeries::cumsum(
  self : CryptosignringSeries,
) -> CryptosignringSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn CryptosignringSeries::to_string(self : CryptosignringSeries) -> String {
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
pub(all) struct CryptosignringMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn crypto_sign_ring_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> CryptosignringMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn crypto_sign_ring_matrix_identity(n : Int32) -> CryptosignringMatrix {
  let m = crypto_sign_ring_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn CryptosignringMatrix::get(
  self : CryptosignringMatrix,
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
pub fn CryptosignringMatrix::transpose(
  self : CryptosignringMatrix,
) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignringMatrix::add(
  self : CryptosignringMatrix,
  other : CryptosignringMatrix,
) -> CryptosignringMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = crypto_sign_ring_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn CryptosignringMatrix::scale(
  self : CryptosignringMatrix,
  s : Double,
) -> CryptosignringMatrix {
  let result = crypto_sign_ring_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn CryptosignringMatrix::multiply(
  self : CryptosignringMatrix,
  other : CryptosignringMatrix,
) -> CryptosignringMatrix {
  if self.cols != other.rows {
    return crypto_sign_ring_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = crypto_sign_ring_make_matrix(self.rows, other.cols, 0.0)
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
pub fn CryptosignringMatrix::trace(self : CryptosignringMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn CryptosignringMatrix::det(self : CryptosignringMatrix) -> Double {
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
pub fn CryptosignringMatrix::norm(self : CryptosignringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn CryptosignringMatrix::to_string(self : CryptosignringMatrix) -> String {
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
pub(all) struct CryptosignringVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn crypto_sign_ring_make_vector(
  comps : Array[Double],
) -> CryptosignringVector {
  { comps, dim: comps.length(), }
}

///|
pub fn crypto_sign_ring_vector_zero(dim : Int32) -> CryptosignringVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn CryptosignringVector::add(
  self : CryptosignringVector,
  other : CryptosignringVector,
) -> CryptosignringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignringVector::sub(
  self : CryptosignringVector,
  other : CryptosignringVector,
) -> CryptosignringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn CryptosignringVector::scale(
  self : CryptosignringVector,
  s : Double,
) -> CryptosignringVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn CryptosignringVector::dot(
  self : CryptosignringVector,
  other : CryptosignringVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn CryptosignringVector::norm(self : CryptosignringVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn CryptosignringVector::normalize(
  self : CryptosignringVector,
) -> CryptosignringVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn CryptosignringVector::dist(
  self : CryptosignringVector,
  other : CryptosignringVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn CryptosignringVector::to_string(self : CryptosignringVector) -> String {
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
pub(all) struct CryptosignringFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_frame_make(size : Int32) -> CryptosignringFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringFrame::len(self : CryptosignringFrame) -> Int32 {
  self.size
}

///|
pub fn CryptosignringFrame::get(
  self : CryptosignringFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringFrame::set(
  self : CryptosignringFrame,
  i : Int32,
  v : Double,
) -> CryptosignringFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringFrame::sum(self : CryptosignringFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringFrame::mean(self : CryptosignringFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringFrame::scale(
  self : CryptosignringFrame,
  f : Double,
) -> CryptosignringFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringFrame::add(
  self : CryptosignringFrame,
  other : CryptosignringFrame,
) -> CryptosignringFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringFrame::copy(
  self : CryptosignringFrame,
) -> CryptosignringFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringFrame::fill(
  self : CryptosignringFrame,
  v : Double,
) -> CryptosignringFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringFrame::min(self : CryptosignringFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringFrame::max(self : CryptosignringFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringFrame::to_string(self : CryptosignringFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_table_make(size : Int32) -> CryptosignringTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringTable::len(self : CryptosignringTable) -> Int32 {
  self.size
}

///|
pub fn CryptosignringTable::get(
  self : CryptosignringTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringTable::set(
  self : CryptosignringTable,
  i : Int32,
  v : Double,
) -> CryptosignringTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringTable::sum(self : CryptosignringTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringTable::mean(self : CryptosignringTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringTable::scale(
  self : CryptosignringTable,
  f : Double,
) -> CryptosignringTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringTable::add(
  self : CryptosignringTable,
  other : CryptosignringTable,
) -> CryptosignringTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringTable::copy(
  self : CryptosignringTable,
) -> CryptosignringTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringTable::fill(
  self : CryptosignringTable,
  v : Double,
) -> CryptosignringTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringTable::min(self : CryptosignringTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringTable::max(self : CryptosignringTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringTable::to_string(self : CryptosignringTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_graphn_make(size : Int32) -> CryptosignringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringGraphN::len(self : CryptosignringGraphN) -> Int32 {
  self.size
}

///|
pub fn CryptosignringGraphN::get(
  self : CryptosignringGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringGraphN::set(
  self : CryptosignringGraphN,
  i : Int32,
  v : Double,
) -> CryptosignringGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringGraphN::sum(self : CryptosignringGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringGraphN::mean(self : CryptosignringGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringGraphN::scale(
  self : CryptosignringGraphN,
  f : Double,
) -> CryptosignringGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringGraphN::add(
  self : CryptosignringGraphN,
  other : CryptosignringGraphN,
) -> CryptosignringGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringGraphN::copy(
  self : CryptosignringGraphN,
) -> CryptosignringGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringGraphN::fill(
  self : CryptosignringGraphN,
  v : Double,
) -> CryptosignringGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringGraphN::min(self : CryptosignringGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringGraphN::max(self : CryptosignringGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringGraphN::to_string(self : CryptosignringGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_node_make(size : Int32) -> CryptosignringNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringNode::len(self : CryptosignringNode) -> Int32 {
  self.size
}

///|
pub fn CryptosignringNode::get(self : CryptosignringNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringNode::set(
  self : CryptosignringNode,
  i : Int32,
  v : Double,
) -> CryptosignringNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringNode::sum(self : CryptosignringNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringNode::mean(self : CryptosignringNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringNode::scale(
  self : CryptosignringNode,
  f : Double,
) -> CryptosignringNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringNode::add(
  self : CryptosignringNode,
  other : CryptosignringNode,
) -> CryptosignringNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringNode::copy(
  self : CryptosignringNode,
) -> CryptosignringNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringNode::fill(
  self : CryptosignringNode,
  v : Double,
) -> CryptosignringNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringNode::min(self : CryptosignringNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringNode::max(self : CryptosignringNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringNode::to_string(self : CryptosignringNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_edge_make(size : Int32) -> CryptosignringEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringEdge::len(self : CryptosignringEdge) -> Int32 {
  self.size
}

///|
pub fn CryptosignringEdge::get(self : CryptosignringEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringEdge::set(
  self : CryptosignringEdge,
  i : Int32,
  v : Double,
) -> CryptosignringEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringEdge::sum(self : CryptosignringEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringEdge::mean(self : CryptosignringEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringEdge::scale(
  self : CryptosignringEdge,
  f : Double,
) -> CryptosignringEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringEdge::add(
  self : CryptosignringEdge,
  other : CryptosignringEdge,
) -> CryptosignringEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringEdge::copy(
  self : CryptosignringEdge,
) -> CryptosignringEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringEdge::fill(
  self : CryptosignringEdge,
  v : Double,
) -> CryptosignringEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringEdge::min(self : CryptosignringEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringEdge::max(self : CryptosignringEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringEdge::to_string(self : CryptosignringEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_path_make(size : Int32) -> CryptosignringPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringPath::len(self : CryptosignringPath) -> Int32 {
  self.size
}

///|
pub fn CryptosignringPath::get(self : CryptosignringPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringPath::set(
  self : CryptosignringPath,
  i : Int32,
  v : Double,
) -> CryptosignringPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringPath::sum(self : CryptosignringPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringPath::mean(self : CryptosignringPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringPath::scale(
  self : CryptosignringPath,
  f : Double,
) -> CryptosignringPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringPath::add(
  self : CryptosignringPath,
  other : CryptosignringPath,
) -> CryptosignringPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringPath::copy(
  self : CryptosignringPath,
) -> CryptosignringPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringPath::fill(
  self : CryptosignringPath,
  v : Double,
) -> CryptosignringPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringPath::min(self : CryptosignringPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringPath::max(self : CryptosignringPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringPath::to_string(self : CryptosignringPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_cluster_make(size : Int32) -> CryptosignringCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringCluster::len(self : CryptosignringCluster) -> Int32 {
  self.size
}

///|
pub fn CryptosignringCluster::get(
  self : CryptosignringCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringCluster::set(
  self : CryptosignringCluster,
  i : Int32,
  v : Double,
) -> CryptosignringCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCluster::sum(self : CryptosignringCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringCluster::mean(self : CryptosignringCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringCluster::scale(
  self : CryptosignringCluster,
  f : Double,
) -> CryptosignringCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCluster::add(
  self : CryptosignringCluster,
  other : CryptosignringCluster,
) -> CryptosignringCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringCluster::copy(
  self : CryptosignringCluster,
) -> CryptosignringCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCluster::fill(
  self : CryptosignringCluster,
  v : Double,
) -> CryptosignringCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCluster::min(self : CryptosignringCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringCluster::max(self : CryptosignringCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringCluster::to_string(self : CryptosignringCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_model_make(size : Int32) -> CryptosignringModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringModel::len(self : CryptosignringModel) -> Int32 {
  self.size
}

///|
pub fn CryptosignringModel::get(
  self : CryptosignringModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringModel::set(
  self : CryptosignringModel,
  i : Int32,
  v : Double,
) -> CryptosignringModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringModel::sum(self : CryptosignringModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringModel::mean(self : CryptosignringModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringModel::scale(
  self : CryptosignringModel,
  f : Double,
) -> CryptosignringModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringModel::add(
  self : CryptosignringModel,
  other : CryptosignringModel,
) -> CryptosignringModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringModel::copy(
  self : CryptosignringModel,
) -> CryptosignringModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringModel::fill(
  self : CryptosignringModel,
  v : Double,
) -> CryptosignringModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringModel::min(self : CryptosignringModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringModel::max(self : CryptosignringModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringModel::to_string(self : CryptosignringModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_layer_make(size : Int32) -> CryptosignringLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringLayer::len(self : CryptosignringLayer) -> Int32 {
  self.size
}

///|
pub fn CryptosignringLayer::get(
  self : CryptosignringLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringLayer::set(
  self : CryptosignringLayer,
  i : Int32,
  v : Double,
) -> CryptosignringLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringLayer::sum(self : CryptosignringLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringLayer::mean(self : CryptosignringLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringLayer::scale(
  self : CryptosignringLayer,
  f : Double,
) -> CryptosignringLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringLayer::add(
  self : CryptosignringLayer,
  other : CryptosignringLayer,
) -> CryptosignringLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringLayer::copy(
  self : CryptosignringLayer,
) -> CryptosignringLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringLayer::fill(
  self : CryptosignringLayer,
  v : Double,
) -> CryptosignringLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringLayer::min(self : CryptosignringLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringLayer::max(self : CryptosignringLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringLayer::to_string(self : CryptosignringLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_buffer_make(size : Int32) -> CryptosignringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringBuffer::len(self : CryptosignringBuffer) -> Int32 {
  self.size
}

///|
pub fn CryptosignringBuffer::get(
  self : CryptosignringBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringBuffer::set(
  self : CryptosignringBuffer,
  i : Int32,
  v : Double,
) -> CryptosignringBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringBuffer::sum(self : CryptosignringBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringBuffer::mean(self : CryptosignringBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringBuffer::scale(
  self : CryptosignringBuffer,
  f : Double,
) -> CryptosignringBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringBuffer::add(
  self : CryptosignringBuffer,
  other : CryptosignringBuffer,
) -> CryptosignringBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringBuffer::copy(
  self : CryptosignringBuffer,
) -> CryptosignringBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringBuffer::fill(
  self : CryptosignringBuffer,
  v : Double,
) -> CryptosignringBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringBuffer::min(self : CryptosignringBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringBuffer::max(self : CryptosignringBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringBuffer::to_string(self : CryptosignringBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_cursor_make(size : Int32) -> CryptosignringCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringCursor::len(self : CryptosignringCursor) -> Int32 {
  self.size
}

///|
pub fn CryptosignringCursor::get(
  self : CryptosignringCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringCursor::set(
  self : CryptosignringCursor,
  i : Int32,
  v : Double,
) -> CryptosignringCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCursor::sum(self : CryptosignringCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringCursor::mean(self : CryptosignringCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringCursor::scale(
  self : CryptosignringCursor,
  f : Double,
) -> CryptosignringCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCursor::add(
  self : CryptosignringCursor,
  other : CryptosignringCursor,
) -> CryptosignringCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringCursor::copy(
  self : CryptosignringCursor,
) -> CryptosignringCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCursor::fill(
  self : CryptosignringCursor,
  v : Double,
) -> CryptosignringCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringCursor::min(self : CryptosignringCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringCursor::max(self : CryptosignringCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringCursor::to_string(self : CryptosignringCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_view_make(size : Int32) -> CryptosignringView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringView::len(self : CryptosignringView) -> Int32 {
  self.size
}

///|
pub fn CryptosignringView::get(self : CryptosignringView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringView::set(
  self : CryptosignringView,
  i : Int32,
  v : Double,
) -> CryptosignringView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringView::sum(self : CryptosignringView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringView::mean(self : CryptosignringView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringView::scale(
  self : CryptosignringView,
  f : Double,
) -> CryptosignringView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringView::add(
  self : CryptosignringView,
  other : CryptosignringView,
) -> CryptosignringView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringView::copy(
  self : CryptosignringView,
) -> CryptosignringView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringView::fill(
  self : CryptosignringView,
  v : Double,
) -> CryptosignringView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringView::min(self : CryptosignringView) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringView::max(self : CryptosignringView) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringView::to_string(self : CryptosignringView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_range_make(size : Int32) -> CryptosignringRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringRange::len(self : CryptosignringRange) -> Int32 {
  self.size
}

///|
pub fn CryptosignringRange::get(
  self : CryptosignringRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringRange::set(
  self : CryptosignringRange,
  i : Int32,
  v : Double,
) -> CryptosignringRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringRange::sum(self : CryptosignringRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringRange::mean(self : CryptosignringRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringRange::scale(
  self : CryptosignringRange,
  f : Double,
) -> CryptosignringRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringRange::add(
  self : CryptosignringRange,
  other : CryptosignringRange,
) -> CryptosignringRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringRange::copy(
  self : CryptosignringRange,
) -> CryptosignringRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringRange::fill(
  self : CryptosignringRange,
  v : Double,
) -> CryptosignringRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringRange::min(self : CryptosignringRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringRange::max(self : CryptosignringRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringRange::to_string(self : CryptosignringRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct CryptosignringSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn crypto_sign_ring_slice_make(size : Int32) -> CryptosignringSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn CryptosignringSlice::len(self : CryptosignringSlice) -> Int32 {
  self.size
}

///|
pub fn CryptosignringSlice::get(
  self : CryptosignringSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn CryptosignringSlice::set(
  self : CryptosignringSlice,
  i : Int32,
  v : Double,
) -> CryptosignringSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringSlice::sum(self : CryptosignringSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn CryptosignringSlice::mean(self : CryptosignringSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn CryptosignringSlice::scale(
  self : CryptosignringSlice,
  f : Double,
) -> CryptosignringSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringSlice::add(
  self : CryptosignringSlice,
  other : CryptosignringSlice,
) -> CryptosignringSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn CryptosignringSlice::copy(
  self : CryptosignringSlice,
) -> CryptosignringSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringSlice::fill(
  self : CryptosignringSlice,
  v : Double,
) -> CryptosignringSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn CryptosignringSlice::min(self : CryptosignringSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn CryptosignringSlice::max(self : CryptosignringSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn CryptosignringSlice::to_string(self : CryptosignringSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

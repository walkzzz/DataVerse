///|
///===
/// extcore/math_special_zeta
pub(all) struct MathspecialzetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn math_special_zeta_make_point(
  x : Double,
  y : Double,
) -> MathspecialzetaPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn math_special_zeta_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> MathspecialzetaPoint {
  { x, y, z, label: 0, }
}

///|
pub fn MathspecialzetaPoint::x(self : MathspecialzetaPoint) -> Double {
  self.x
}

///|
pub fn MathspecialzetaPoint::y(self : MathspecialzetaPoint) -> Double {
  self.y
}

///|
pub fn MathspecialzetaPoint::z(self : MathspecialzetaPoint) -> Double {
  self.z
}

///|
pub fn MathspecialzetaPoint::label(self : MathspecialzetaPoint) -> Int32 {
  self.label
}

///|
pub fn MathspecialzetaPoint::dist(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn MathspecialzetaPoint::add(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialzetaPoint::sub(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn MathspecialzetaPoint::scale(
  self : MathspecialzetaPoint,
  s : Double,
) -> MathspecialzetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn MathspecialzetaPoint::dot(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn MathspecialzetaPoint::cross(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn MathspecialzetaPoint::norm(self : MathspecialzetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn MathspecialzetaPoint::normalize(
  self : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialzetaPoint::negate(
  self : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn MathspecialzetaPoint::mid(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
) -> MathspecialzetaPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn MathspecialzetaPoint::lerp(
  self : MathspecialzetaPoint,
  other : MathspecialzetaPoint,
  t : Double,
) -> MathspecialzetaPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn MathspecialzetaPoint::to_string(self : MathspecialzetaPoint) -> String {
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
pub(all) struct MathspecialzetaSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn math_special_zeta_make_series(
  vals : Array[Double],
  name : String,
) -> MathspecialzetaSeries {
  { vals, name, meta: 0, }
}

///|
pub fn MathspecialzetaSeries::len(self : MathspecialzetaSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn MathspecialzetaSeries::sum(self : MathspecialzetaSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn MathspecialzetaSeries::mean(self : MathspecialzetaSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn MathspecialzetaSeries::min(self : MathspecialzetaSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn MathspecialzetaSeries::max(self : MathspecialzetaSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn MathspecialzetaSeries::range(self : MathspecialzetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn MathspecialzetaSeries::variance(self : MathspecialzetaSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn MathspecialzetaSeries::std(self : MathspecialzetaSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn MathspecialzetaSeries::median(self : MathspecialzetaSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn MathspecialzetaSeries::scale(
  self : MathspecialzetaSeries,
  f : Double,
) -> MathspecialzetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn MathspecialzetaSeries::add(
  self : MathspecialzetaSeries,
  other : MathspecialzetaSeries,
) -> MathspecialzetaSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialzetaSeries::sub(
  self : MathspecialzetaSeries,
  other : MathspecialzetaSeries,
) -> MathspecialzetaSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn MathspecialzetaSeries::normalize(
  self : MathspecialzetaSeries,
) -> MathspecialzetaSeries {
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
pub fn MathspecialzetaSeries::cumsum(
  self : MathspecialzetaSeries,
) -> MathspecialzetaSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn MathspecialzetaSeries::to_string(self : MathspecialzetaSeries) -> String {
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
pub(all) struct MathspecialzetaMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn math_special_zeta_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> MathspecialzetaMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn math_special_zeta_matrix_identity(n : Int32) -> MathspecialzetaMatrix {
  let m = math_special_zeta_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn MathspecialzetaMatrix::get(
  self : MathspecialzetaMatrix,
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
pub fn MathspecialzetaMatrix::transpose(
  self : MathspecialzetaMatrix,
) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialzetaMatrix::add(
  self : MathspecialzetaMatrix,
  other : MathspecialzetaMatrix,
) -> MathspecialzetaMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = math_special_zeta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn MathspecialzetaMatrix::scale(
  self : MathspecialzetaMatrix,
  s : Double,
) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn MathspecialzetaMatrix::multiply(
  self : MathspecialzetaMatrix,
  other : MathspecialzetaMatrix,
) -> MathspecialzetaMatrix {
  if self.cols != other.rows {
    return math_special_zeta_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = math_special_zeta_make_matrix(self.rows, other.cols, 0.0)
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
pub fn MathspecialzetaMatrix::trace(self : MathspecialzetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn MathspecialzetaMatrix::det(self : MathspecialzetaMatrix) -> Double {
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
pub fn MathspecialzetaMatrix::norm(self : MathspecialzetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn MathspecialzetaMatrix::to_string(self : MathspecialzetaMatrix) -> String {
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
pub(all) struct MathspecialzetaVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn math_special_zeta_make_vector(
  comps : Array[Double],
) -> MathspecialzetaVector {
  { comps, dim: comps.length(), }
}

///|
pub fn math_special_zeta_vector_zero(dim : Int32) -> MathspecialzetaVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn MathspecialzetaVector::add(
  self : MathspecialzetaVector,
  other : MathspecialzetaVector,
) -> MathspecialzetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialzetaVector::sub(
  self : MathspecialzetaVector,
  other : MathspecialzetaVector,
) -> MathspecialzetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn MathspecialzetaVector::scale(
  self : MathspecialzetaVector,
  s : Double,
) -> MathspecialzetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn MathspecialzetaVector::dot(
  self : MathspecialzetaVector,
  other : MathspecialzetaVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn MathspecialzetaVector::norm(self : MathspecialzetaVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn MathspecialzetaVector::normalize(
  self : MathspecialzetaVector,
) -> MathspecialzetaVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn MathspecialzetaVector::dist(
  self : MathspecialzetaVector,
  other : MathspecialzetaVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn MathspecialzetaVector::to_string(self : MathspecialzetaVector) -> String {
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
pub(all) struct MathspecialzetaFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_frame_make(size : Int32) -> MathspecialzetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaFrame::len(self : MathspecialzetaFrame) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaFrame::get(
  self : MathspecialzetaFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaFrame::set(
  self : MathspecialzetaFrame,
  i : Int32,
  v : Double,
) -> MathspecialzetaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaFrame::sum(self : MathspecialzetaFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaFrame::mean(self : MathspecialzetaFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaFrame::scale(
  self : MathspecialzetaFrame,
  f : Double,
) -> MathspecialzetaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaFrame::add(
  self : MathspecialzetaFrame,
  other : MathspecialzetaFrame,
) -> MathspecialzetaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaFrame::copy(
  self : MathspecialzetaFrame,
) -> MathspecialzetaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaFrame::fill(
  self : MathspecialzetaFrame,
  v : Double,
) -> MathspecialzetaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaFrame::min(self : MathspecialzetaFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaFrame::max(self : MathspecialzetaFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaFrame::to_string(self : MathspecialzetaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_table_make(size : Int32) -> MathspecialzetaTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaTable::len(self : MathspecialzetaTable) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaTable::get(
  self : MathspecialzetaTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaTable::set(
  self : MathspecialzetaTable,
  i : Int32,
  v : Double,
) -> MathspecialzetaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaTable::sum(self : MathspecialzetaTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaTable::mean(self : MathspecialzetaTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaTable::scale(
  self : MathspecialzetaTable,
  f : Double,
) -> MathspecialzetaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaTable::add(
  self : MathspecialzetaTable,
  other : MathspecialzetaTable,
) -> MathspecialzetaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaTable::copy(
  self : MathspecialzetaTable,
) -> MathspecialzetaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaTable::fill(
  self : MathspecialzetaTable,
  v : Double,
) -> MathspecialzetaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaTable::min(self : MathspecialzetaTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaTable::max(self : MathspecialzetaTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaTable::to_string(self : MathspecialzetaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_graphn_make(size : Int32) -> MathspecialzetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaGraphN::len(self : MathspecialzetaGraphN) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaGraphN::get(
  self : MathspecialzetaGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaGraphN::set(
  self : MathspecialzetaGraphN,
  i : Int32,
  v : Double,
) -> MathspecialzetaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaGraphN::sum(self : MathspecialzetaGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaGraphN::mean(self : MathspecialzetaGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaGraphN::scale(
  self : MathspecialzetaGraphN,
  f : Double,
) -> MathspecialzetaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaGraphN::add(
  self : MathspecialzetaGraphN,
  other : MathspecialzetaGraphN,
) -> MathspecialzetaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaGraphN::copy(
  self : MathspecialzetaGraphN,
) -> MathspecialzetaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaGraphN::fill(
  self : MathspecialzetaGraphN,
  v : Double,
) -> MathspecialzetaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaGraphN::min(self : MathspecialzetaGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaGraphN::max(self : MathspecialzetaGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaGraphN::to_string(self : MathspecialzetaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_node_make(size : Int32) -> MathspecialzetaNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaNode::len(self : MathspecialzetaNode) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaNode::get(
  self : MathspecialzetaNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaNode::set(
  self : MathspecialzetaNode,
  i : Int32,
  v : Double,
) -> MathspecialzetaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaNode::sum(self : MathspecialzetaNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaNode::mean(self : MathspecialzetaNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaNode::scale(
  self : MathspecialzetaNode,
  f : Double,
) -> MathspecialzetaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaNode::add(
  self : MathspecialzetaNode,
  other : MathspecialzetaNode,
) -> MathspecialzetaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaNode::copy(
  self : MathspecialzetaNode,
) -> MathspecialzetaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaNode::fill(
  self : MathspecialzetaNode,
  v : Double,
) -> MathspecialzetaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaNode::min(self : MathspecialzetaNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaNode::max(self : MathspecialzetaNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaNode::to_string(self : MathspecialzetaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_edge_make(size : Int32) -> MathspecialzetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaEdge::len(self : MathspecialzetaEdge) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaEdge::get(
  self : MathspecialzetaEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaEdge::set(
  self : MathspecialzetaEdge,
  i : Int32,
  v : Double,
) -> MathspecialzetaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaEdge::sum(self : MathspecialzetaEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaEdge::mean(self : MathspecialzetaEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaEdge::scale(
  self : MathspecialzetaEdge,
  f : Double,
) -> MathspecialzetaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaEdge::add(
  self : MathspecialzetaEdge,
  other : MathspecialzetaEdge,
) -> MathspecialzetaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaEdge::copy(
  self : MathspecialzetaEdge,
) -> MathspecialzetaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaEdge::fill(
  self : MathspecialzetaEdge,
  v : Double,
) -> MathspecialzetaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaEdge::min(self : MathspecialzetaEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaEdge::max(self : MathspecialzetaEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaEdge::to_string(self : MathspecialzetaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_path_make(size : Int32) -> MathspecialzetaPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaPath::len(self : MathspecialzetaPath) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaPath::get(
  self : MathspecialzetaPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaPath::set(
  self : MathspecialzetaPath,
  i : Int32,
  v : Double,
) -> MathspecialzetaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaPath::sum(self : MathspecialzetaPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaPath::mean(self : MathspecialzetaPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaPath::scale(
  self : MathspecialzetaPath,
  f : Double,
) -> MathspecialzetaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaPath::add(
  self : MathspecialzetaPath,
  other : MathspecialzetaPath,
) -> MathspecialzetaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaPath::copy(
  self : MathspecialzetaPath,
) -> MathspecialzetaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaPath::fill(
  self : MathspecialzetaPath,
  v : Double,
) -> MathspecialzetaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaPath::min(self : MathspecialzetaPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaPath::max(self : MathspecialzetaPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaPath::to_string(self : MathspecialzetaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_cluster_make(size : Int32) -> MathspecialzetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaCluster::len(self : MathspecialzetaCluster) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaCluster::get(
  self : MathspecialzetaCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaCluster::set(
  self : MathspecialzetaCluster,
  i : Int32,
  v : Double,
) -> MathspecialzetaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCluster::sum(self : MathspecialzetaCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaCluster::mean(self : MathspecialzetaCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaCluster::scale(
  self : MathspecialzetaCluster,
  f : Double,
) -> MathspecialzetaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCluster::add(
  self : MathspecialzetaCluster,
  other : MathspecialzetaCluster,
) -> MathspecialzetaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaCluster::copy(
  self : MathspecialzetaCluster,
) -> MathspecialzetaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCluster::fill(
  self : MathspecialzetaCluster,
  v : Double,
) -> MathspecialzetaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCluster::min(self : MathspecialzetaCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaCluster::max(self : MathspecialzetaCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaCluster::to_string(
  self : MathspecialzetaCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_model_make(size : Int32) -> MathspecialzetaModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaModel::len(self : MathspecialzetaModel) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaModel::get(
  self : MathspecialzetaModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaModel::set(
  self : MathspecialzetaModel,
  i : Int32,
  v : Double,
) -> MathspecialzetaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaModel::sum(self : MathspecialzetaModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaModel::mean(self : MathspecialzetaModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaModel::scale(
  self : MathspecialzetaModel,
  f : Double,
) -> MathspecialzetaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaModel::add(
  self : MathspecialzetaModel,
  other : MathspecialzetaModel,
) -> MathspecialzetaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaModel::copy(
  self : MathspecialzetaModel,
) -> MathspecialzetaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaModel::fill(
  self : MathspecialzetaModel,
  v : Double,
) -> MathspecialzetaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaModel::min(self : MathspecialzetaModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaModel::max(self : MathspecialzetaModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaModel::to_string(self : MathspecialzetaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_layer_make(size : Int32) -> MathspecialzetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaLayer::len(self : MathspecialzetaLayer) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaLayer::get(
  self : MathspecialzetaLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaLayer::set(
  self : MathspecialzetaLayer,
  i : Int32,
  v : Double,
) -> MathspecialzetaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaLayer::sum(self : MathspecialzetaLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaLayer::mean(self : MathspecialzetaLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaLayer::scale(
  self : MathspecialzetaLayer,
  f : Double,
) -> MathspecialzetaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaLayer::add(
  self : MathspecialzetaLayer,
  other : MathspecialzetaLayer,
) -> MathspecialzetaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaLayer::copy(
  self : MathspecialzetaLayer,
) -> MathspecialzetaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaLayer::fill(
  self : MathspecialzetaLayer,
  v : Double,
) -> MathspecialzetaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaLayer::min(self : MathspecialzetaLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaLayer::max(self : MathspecialzetaLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaLayer::to_string(self : MathspecialzetaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_buffer_make(size : Int32) -> MathspecialzetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaBuffer::len(self : MathspecialzetaBuffer) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaBuffer::get(
  self : MathspecialzetaBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaBuffer::set(
  self : MathspecialzetaBuffer,
  i : Int32,
  v : Double,
) -> MathspecialzetaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaBuffer::sum(self : MathspecialzetaBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaBuffer::mean(self : MathspecialzetaBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaBuffer::scale(
  self : MathspecialzetaBuffer,
  f : Double,
) -> MathspecialzetaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaBuffer::add(
  self : MathspecialzetaBuffer,
  other : MathspecialzetaBuffer,
) -> MathspecialzetaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaBuffer::copy(
  self : MathspecialzetaBuffer,
) -> MathspecialzetaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaBuffer::fill(
  self : MathspecialzetaBuffer,
  v : Double,
) -> MathspecialzetaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaBuffer::min(self : MathspecialzetaBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaBuffer::max(self : MathspecialzetaBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaBuffer::to_string(self : MathspecialzetaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_cursor_make(size : Int32) -> MathspecialzetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaCursor::len(self : MathspecialzetaCursor) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaCursor::get(
  self : MathspecialzetaCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaCursor::set(
  self : MathspecialzetaCursor,
  i : Int32,
  v : Double,
) -> MathspecialzetaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCursor::sum(self : MathspecialzetaCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaCursor::mean(self : MathspecialzetaCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaCursor::scale(
  self : MathspecialzetaCursor,
  f : Double,
) -> MathspecialzetaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCursor::add(
  self : MathspecialzetaCursor,
  other : MathspecialzetaCursor,
) -> MathspecialzetaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaCursor::copy(
  self : MathspecialzetaCursor,
) -> MathspecialzetaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCursor::fill(
  self : MathspecialzetaCursor,
  v : Double,
) -> MathspecialzetaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaCursor::min(self : MathspecialzetaCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaCursor::max(self : MathspecialzetaCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaCursor::to_string(self : MathspecialzetaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_view_make(size : Int32) -> MathspecialzetaView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaView::len(self : MathspecialzetaView) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaView::get(
  self : MathspecialzetaView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaView::set(
  self : MathspecialzetaView,
  i : Int32,
  v : Double,
) -> MathspecialzetaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaView::sum(self : MathspecialzetaView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaView::mean(self : MathspecialzetaView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaView::scale(
  self : MathspecialzetaView,
  f : Double,
) -> MathspecialzetaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaView::add(
  self : MathspecialzetaView,
  other : MathspecialzetaView,
) -> MathspecialzetaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaView::copy(
  self : MathspecialzetaView,
) -> MathspecialzetaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaView::fill(
  self : MathspecialzetaView,
  v : Double,
) -> MathspecialzetaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaView::min(self : MathspecialzetaView) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaView::max(self : MathspecialzetaView) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaView::to_string(self : MathspecialzetaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_range_make(size : Int32) -> MathspecialzetaRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaRange::len(self : MathspecialzetaRange) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaRange::get(
  self : MathspecialzetaRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaRange::set(
  self : MathspecialzetaRange,
  i : Int32,
  v : Double,
) -> MathspecialzetaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaRange::sum(self : MathspecialzetaRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaRange::mean(self : MathspecialzetaRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaRange::scale(
  self : MathspecialzetaRange,
  f : Double,
) -> MathspecialzetaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaRange::add(
  self : MathspecialzetaRange,
  other : MathspecialzetaRange,
) -> MathspecialzetaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaRange::copy(
  self : MathspecialzetaRange,
) -> MathspecialzetaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaRange::fill(
  self : MathspecialzetaRange,
  v : Double,
) -> MathspecialzetaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaRange::min(self : MathspecialzetaRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaRange::max(self : MathspecialzetaRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaRange::to_string(self : MathspecialzetaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct MathspecialzetaSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn math_special_zeta_slice_make(size : Int32) -> MathspecialzetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn MathspecialzetaSlice::len(self : MathspecialzetaSlice) -> Int32 {
  self.size
}

///|
pub fn MathspecialzetaSlice::get(
  self : MathspecialzetaSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn MathspecialzetaSlice::set(
  self : MathspecialzetaSlice,
  i : Int32,
  v : Double,
) -> MathspecialzetaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaSlice::sum(self : MathspecialzetaSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn MathspecialzetaSlice::mean(self : MathspecialzetaSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn MathspecialzetaSlice::scale(
  self : MathspecialzetaSlice,
  f : Double,
) -> MathspecialzetaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaSlice::add(
  self : MathspecialzetaSlice,
  other : MathspecialzetaSlice,
) -> MathspecialzetaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn MathspecialzetaSlice::copy(
  self : MathspecialzetaSlice,
) -> MathspecialzetaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaSlice::fill(
  self : MathspecialzetaSlice,
  v : Double,
) -> MathspecialzetaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn MathspecialzetaSlice::min(self : MathspecialzetaSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn MathspecialzetaSlice::max(self : MathspecialzetaSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn MathspecialzetaSlice::to_string(self : MathspecialzetaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

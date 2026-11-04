///|
///===
/// extcore/physics_em_eddy
pub(all) struct PhysicsemeddyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn physics_em_eddy_make_point(x : Double, y : Double) -> PhysicsemeddyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn physics_em_eddy_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> PhysicsemeddyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn PhysicsemeddyPoint::x(self : PhysicsemeddyPoint) -> Double {
  self.x
}

///|
pub fn PhysicsemeddyPoint::y(self : PhysicsemeddyPoint) -> Double {
  self.y
}

///|
pub fn PhysicsemeddyPoint::z(self : PhysicsemeddyPoint) -> Double {
  self.z
}

///|
pub fn PhysicsemeddyPoint::label(self : PhysicsemeddyPoint) -> Int32 {
  self.label
}

///|
pub fn PhysicsemeddyPoint::dist(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn PhysicsemeddyPoint::add(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsemeddyPoint::sub(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn PhysicsemeddyPoint::scale(
  self : PhysicsemeddyPoint,
  s : Double,
) -> PhysicsemeddyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn PhysicsemeddyPoint::dot(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn PhysicsemeddyPoint::cross(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn PhysicsemeddyPoint::norm(self : PhysicsemeddyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn PhysicsemeddyPoint::normalize(
  self : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsemeddyPoint::negate(
  self : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn PhysicsemeddyPoint::mid(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
) -> PhysicsemeddyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn PhysicsemeddyPoint::lerp(
  self : PhysicsemeddyPoint,
  other : PhysicsemeddyPoint,
  t : Double,
) -> PhysicsemeddyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn PhysicsemeddyPoint::to_string(self : PhysicsemeddyPoint) -> String {
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
pub(all) struct PhysicsemeddySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn physics_em_eddy_make_series(
  vals : Array[Double],
  name : String,
) -> PhysicsemeddySeries {
  { vals, name, meta: 0, }
}

///|
pub fn PhysicsemeddySeries::len(self : PhysicsemeddySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn PhysicsemeddySeries::sum(self : PhysicsemeddySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn PhysicsemeddySeries::mean(self : PhysicsemeddySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn PhysicsemeddySeries::min(self : PhysicsemeddySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn PhysicsemeddySeries::max(self : PhysicsemeddySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn PhysicsemeddySeries::range(self : PhysicsemeddySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn PhysicsemeddySeries::variance(self : PhysicsemeddySeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn PhysicsemeddySeries::std(self : PhysicsemeddySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn PhysicsemeddySeries::median(self : PhysicsemeddySeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn PhysicsemeddySeries::scale(
  self : PhysicsemeddySeries,
  f : Double,
) -> PhysicsemeddySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn PhysicsemeddySeries::add(
  self : PhysicsemeddySeries,
  other : PhysicsemeddySeries,
) -> PhysicsemeddySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsemeddySeries::sub(
  self : PhysicsemeddySeries,
  other : PhysicsemeddySeries,
) -> PhysicsemeddySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn PhysicsemeddySeries::normalize(
  self : PhysicsemeddySeries,
) -> PhysicsemeddySeries {
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
pub fn PhysicsemeddySeries::cumsum(
  self : PhysicsemeddySeries,
) -> PhysicsemeddySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn PhysicsemeddySeries::to_string(self : PhysicsemeddySeries) -> String {
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
pub(all) struct PhysicsemeddyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn physics_em_eddy_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> PhysicsemeddyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn physics_em_eddy_matrix_identity(n : Int32) -> PhysicsemeddyMatrix {
  let m = physics_em_eddy_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn PhysicsemeddyMatrix::get(
  self : PhysicsemeddyMatrix,
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
pub fn PhysicsemeddyMatrix::transpose(
  self : PhysicsemeddyMatrix,
) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsemeddyMatrix::add(
  self : PhysicsemeddyMatrix,
  other : PhysicsemeddyMatrix,
) -> PhysicsemeddyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = physics_em_eddy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn PhysicsemeddyMatrix::scale(
  self : PhysicsemeddyMatrix,
  s : Double,
) -> PhysicsemeddyMatrix {
  let result = physics_em_eddy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn PhysicsemeddyMatrix::multiply(
  self : PhysicsemeddyMatrix,
  other : PhysicsemeddyMatrix,
) -> PhysicsemeddyMatrix {
  if self.cols != other.rows {
    return physics_em_eddy_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = physics_em_eddy_make_matrix(self.rows, other.cols, 0.0)
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
pub fn PhysicsemeddyMatrix::trace(self : PhysicsemeddyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn PhysicsemeddyMatrix::det(self : PhysicsemeddyMatrix) -> Double {
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
pub fn PhysicsemeddyMatrix::norm(self : PhysicsemeddyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn PhysicsemeddyMatrix::to_string(self : PhysicsemeddyMatrix) -> String {
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
pub(all) struct PhysicsemeddyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn physics_em_eddy_make_vector(
  comps : Array[Double],
) -> PhysicsemeddyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn physics_em_eddy_vector_zero(dim : Int32) -> PhysicsemeddyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn PhysicsemeddyVector::add(
  self : PhysicsemeddyVector,
  other : PhysicsemeddyVector,
) -> PhysicsemeddyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsemeddyVector::sub(
  self : PhysicsemeddyVector,
  other : PhysicsemeddyVector,
) -> PhysicsemeddyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn PhysicsemeddyVector::scale(
  self : PhysicsemeddyVector,
  s : Double,
) -> PhysicsemeddyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn PhysicsemeddyVector::dot(
  self : PhysicsemeddyVector,
  other : PhysicsemeddyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn PhysicsemeddyVector::norm(self : PhysicsemeddyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn PhysicsemeddyVector::normalize(
  self : PhysicsemeddyVector,
) -> PhysicsemeddyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn PhysicsemeddyVector::dist(
  self : PhysicsemeddyVector,
  other : PhysicsemeddyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn PhysicsemeddyVector::to_string(self : PhysicsemeddyVector) -> String {
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
pub(all) struct PhysicsemeddyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_frame_make(size : Int32) -> PhysicsemeddyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyFrame::len(self : PhysicsemeddyFrame) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyFrame::get(self : PhysicsemeddyFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyFrame::set(
  self : PhysicsemeddyFrame,
  i : Int32,
  v : Double,
) -> PhysicsemeddyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyFrame::sum(self : PhysicsemeddyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyFrame::mean(self : PhysicsemeddyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyFrame::scale(
  self : PhysicsemeddyFrame,
  f : Double,
) -> PhysicsemeddyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyFrame::add(
  self : PhysicsemeddyFrame,
  other : PhysicsemeddyFrame,
) -> PhysicsemeddyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyFrame::copy(
  self : PhysicsemeddyFrame,
) -> PhysicsemeddyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyFrame::fill(
  self : PhysicsemeddyFrame,
  v : Double,
) -> PhysicsemeddyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyFrame::min(self : PhysicsemeddyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyFrame::max(self : PhysicsemeddyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyFrame::to_string(self : PhysicsemeddyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_table_make(size : Int32) -> PhysicsemeddyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyTable::len(self : PhysicsemeddyTable) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyTable::get(self : PhysicsemeddyTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyTable::set(
  self : PhysicsemeddyTable,
  i : Int32,
  v : Double,
) -> PhysicsemeddyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyTable::sum(self : PhysicsemeddyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyTable::mean(self : PhysicsemeddyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyTable::scale(
  self : PhysicsemeddyTable,
  f : Double,
) -> PhysicsemeddyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyTable::add(
  self : PhysicsemeddyTable,
  other : PhysicsemeddyTable,
) -> PhysicsemeddyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyTable::copy(
  self : PhysicsemeddyTable,
) -> PhysicsemeddyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyTable::fill(
  self : PhysicsemeddyTable,
  v : Double,
) -> PhysicsemeddyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyTable::min(self : PhysicsemeddyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyTable::max(self : PhysicsemeddyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyTable::to_string(self : PhysicsemeddyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_graphn_make(size : Int32) -> PhysicsemeddyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyGraphN::len(self : PhysicsemeddyGraphN) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyGraphN::get(
  self : PhysicsemeddyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyGraphN::set(
  self : PhysicsemeddyGraphN,
  i : Int32,
  v : Double,
) -> PhysicsemeddyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyGraphN::sum(self : PhysicsemeddyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyGraphN::mean(self : PhysicsemeddyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyGraphN::scale(
  self : PhysicsemeddyGraphN,
  f : Double,
) -> PhysicsemeddyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyGraphN::add(
  self : PhysicsemeddyGraphN,
  other : PhysicsemeddyGraphN,
) -> PhysicsemeddyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyGraphN::copy(
  self : PhysicsemeddyGraphN,
) -> PhysicsemeddyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyGraphN::fill(
  self : PhysicsemeddyGraphN,
  v : Double,
) -> PhysicsemeddyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyGraphN::min(self : PhysicsemeddyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyGraphN::max(self : PhysicsemeddyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyGraphN::to_string(self : PhysicsemeddyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_node_make(size : Int32) -> PhysicsemeddyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyNode::len(self : PhysicsemeddyNode) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyNode::get(self : PhysicsemeddyNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyNode::set(
  self : PhysicsemeddyNode,
  i : Int32,
  v : Double,
) -> PhysicsemeddyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyNode::sum(self : PhysicsemeddyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyNode::mean(self : PhysicsemeddyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyNode::scale(
  self : PhysicsemeddyNode,
  f : Double,
) -> PhysicsemeddyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyNode::add(
  self : PhysicsemeddyNode,
  other : PhysicsemeddyNode,
) -> PhysicsemeddyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyNode::copy(self : PhysicsemeddyNode) -> PhysicsemeddyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyNode::fill(
  self : PhysicsemeddyNode,
  v : Double,
) -> PhysicsemeddyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyNode::min(self : PhysicsemeddyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyNode::max(self : PhysicsemeddyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyNode::to_string(self : PhysicsemeddyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_edge_make(size : Int32) -> PhysicsemeddyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyEdge::len(self : PhysicsemeddyEdge) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyEdge::get(self : PhysicsemeddyEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyEdge::set(
  self : PhysicsemeddyEdge,
  i : Int32,
  v : Double,
) -> PhysicsemeddyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyEdge::sum(self : PhysicsemeddyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyEdge::mean(self : PhysicsemeddyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyEdge::scale(
  self : PhysicsemeddyEdge,
  f : Double,
) -> PhysicsemeddyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyEdge::add(
  self : PhysicsemeddyEdge,
  other : PhysicsemeddyEdge,
) -> PhysicsemeddyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyEdge::copy(self : PhysicsemeddyEdge) -> PhysicsemeddyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyEdge::fill(
  self : PhysicsemeddyEdge,
  v : Double,
) -> PhysicsemeddyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyEdge::min(self : PhysicsemeddyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyEdge::max(self : PhysicsemeddyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyEdge::to_string(self : PhysicsemeddyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_path_make(size : Int32) -> PhysicsemeddyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyPath::len(self : PhysicsemeddyPath) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyPath::get(self : PhysicsemeddyPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyPath::set(
  self : PhysicsemeddyPath,
  i : Int32,
  v : Double,
) -> PhysicsemeddyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyPath::sum(self : PhysicsemeddyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyPath::mean(self : PhysicsemeddyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyPath::scale(
  self : PhysicsemeddyPath,
  f : Double,
) -> PhysicsemeddyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyPath::add(
  self : PhysicsemeddyPath,
  other : PhysicsemeddyPath,
) -> PhysicsemeddyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyPath::copy(self : PhysicsemeddyPath) -> PhysicsemeddyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyPath::fill(
  self : PhysicsemeddyPath,
  v : Double,
) -> PhysicsemeddyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyPath::min(self : PhysicsemeddyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyPath::max(self : PhysicsemeddyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyPath::to_string(self : PhysicsemeddyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_cluster_make(size : Int32) -> PhysicsemeddyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyCluster::len(self : PhysicsemeddyCluster) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyCluster::get(
  self : PhysicsemeddyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyCluster::set(
  self : PhysicsemeddyCluster,
  i : Int32,
  v : Double,
) -> PhysicsemeddyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCluster::sum(self : PhysicsemeddyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyCluster::mean(self : PhysicsemeddyCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyCluster::scale(
  self : PhysicsemeddyCluster,
  f : Double,
) -> PhysicsemeddyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCluster::add(
  self : PhysicsemeddyCluster,
  other : PhysicsemeddyCluster,
) -> PhysicsemeddyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCluster::copy(
  self : PhysicsemeddyCluster,
) -> PhysicsemeddyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCluster::fill(
  self : PhysicsemeddyCluster,
  v : Double,
) -> PhysicsemeddyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCluster::min(self : PhysicsemeddyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyCluster::max(self : PhysicsemeddyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyCluster::to_string(self : PhysicsemeddyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_model_make(size : Int32) -> PhysicsemeddyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyModel::len(self : PhysicsemeddyModel) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyModel::get(self : PhysicsemeddyModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyModel::set(
  self : PhysicsemeddyModel,
  i : Int32,
  v : Double,
) -> PhysicsemeddyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyModel::sum(self : PhysicsemeddyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyModel::mean(self : PhysicsemeddyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyModel::scale(
  self : PhysicsemeddyModel,
  f : Double,
) -> PhysicsemeddyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyModel::add(
  self : PhysicsemeddyModel,
  other : PhysicsemeddyModel,
) -> PhysicsemeddyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyModel::copy(
  self : PhysicsemeddyModel,
) -> PhysicsemeddyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyModel::fill(
  self : PhysicsemeddyModel,
  v : Double,
) -> PhysicsemeddyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyModel::min(self : PhysicsemeddyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyModel::max(self : PhysicsemeddyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyModel::to_string(self : PhysicsemeddyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_layer_make(size : Int32) -> PhysicsemeddyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyLayer::len(self : PhysicsemeddyLayer) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyLayer::get(self : PhysicsemeddyLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyLayer::set(
  self : PhysicsemeddyLayer,
  i : Int32,
  v : Double,
) -> PhysicsemeddyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyLayer::sum(self : PhysicsemeddyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyLayer::mean(self : PhysicsemeddyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyLayer::scale(
  self : PhysicsemeddyLayer,
  f : Double,
) -> PhysicsemeddyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyLayer::add(
  self : PhysicsemeddyLayer,
  other : PhysicsemeddyLayer,
) -> PhysicsemeddyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyLayer::copy(
  self : PhysicsemeddyLayer,
) -> PhysicsemeddyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyLayer::fill(
  self : PhysicsemeddyLayer,
  v : Double,
) -> PhysicsemeddyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyLayer::min(self : PhysicsemeddyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyLayer::max(self : PhysicsemeddyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyLayer::to_string(self : PhysicsemeddyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_buffer_make(size : Int32) -> PhysicsemeddyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyBuffer::len(self : PhysicsemeddyBuffer) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyBuffer::get(
  self : PhysicsemeddyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyBuffer::set(
  self : PhysicsemeddyBuffer,
  i : Int32,
  v : Double,
) -> PhysicsemeddyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyBuffer::sum(self : PhysicsemeddyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyBuffer::mean(self : PhysicsemeddyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyBuffer::scale(
  self : PhysicsemeddyBuffer,
  f : Double,
) -> PhysicsemeddyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyBuffer::add(
  self : PhysicsemeddyBuffer,
  other : PhysicsemeddyBuffer,
) -> PhysicsemeddyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyBuffer::copy(
  self : PhysicsemeddyBuffer,
) -> PhysicsemeddyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyBuffer::fill(
  self : PhysicsemeddyBuffer,
  v : Double,
) -> PhysicsemeddyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyBuffer::min(self : PhysicsemeddyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyBuffer::max(self : PhysicsemeddyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyBuffer::to_string(self : PhysicsemeddyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_cursor_make(size : Int32) -> PhysicsemeddyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyCursor::len(self : PhysicsemeddyCursor) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyCursor::get(
  self : PhysicsemeddyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyCursor::set(
  self : PhysicsemeddyCursor,
  i : Int32,
  v : Double,
) -> PhysicsemeddyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCursor::sum(self : PhysicsemeddyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyCursor::mean(self : PhysicsemeddyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyCursor::scale(
  self : PhysicsemeddyCursor,
  f : Double,
) -> PhysicsemeddyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCursor::add(
  self : PhysicsemeddyCursor,
  other : PhysicsemeddyCursor,
) -> PhysicsemeddyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCursor::copy(
  self : PhysicsemeddyCursor,
) -> PhysicsemeddyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCursor::fill(
  self : PhysicsemeddyCursor,
  v : Double,
) -> PhysicsemeddyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyCursor::min(self : PhysicsemeddyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyCursor::max(self : PhysicsemeddyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyCursor::to_string(self : PhysicsemeddyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_view_make(size : Int32) -> PhysicsemeddyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyView::len(self : PhysicsemeddyView) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyView::get(self : PhysicsemeddyView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyView::set(
  self : PhysicsemeddyView,
  i : Int32,
  v : Double,
) -> PhysicsemeddyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyView::sum(self : PhysicsemeddyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyView::mean(self : PhysicsemeddyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyView::scale(
  self : PhysicsemeddyView,
  f : Double,
) -> PhysicsemeddyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyView::add(
  self : PhysicsemeddyView,
  other : PhysicsemeddyView,
) -> PhysicsemeddyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyView::copy(self : PhysicsemeddyView) -> PhysicsemeddyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyView::fill(
  self : PhysicsemeddyView,
  v : Double,
) -> PhysicsemeddyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyView::min(self : PhysicsemeddyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyView::max(self : PhysicsemeddyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyView::to_string(self : PhysicsemeddyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_range_make(size : Int32) -> PhysicsemeddyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddyRange::len(self : PhysicsemeddyRange) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddyRange::get(self : PhysicsemeddyRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddyRange::set(
  self : PhysicsemeddyRange,
  i : Int32,
  v : Double,
) -> PhysicsemeddyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyRange::sum(self : PhysicsemeddyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddyRange::mean(self : PhysicsemeddyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddyRange::scale(
  self : PhysicsemeddyRange,
  f : Double,
) -> PhysicsemeddyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyRange::add(
  self : PhysicsemeddyRange,
  other : PhysicsemeddyRange,
) -> PhysicsemeddyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddyRange::copy(
  self : PhysicsemeddyRange,
) -> PhysicsemeddyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyRange::fill(
  self : PhysicsemeddyRange,
  v : Double,
) -> PhysicsemeddyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddyRange::min(self : PhysicsemeddyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddyRange::max(self : PhysicsemeddyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddyRange::to_string(self : PhysicsemeddyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct PhysicsemeddySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn physics_em_eddy_slice_make(size : Int32) -> PhysicsemeddySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn PhysicsemeddySlice::len(self : PhysicsemeddySlice) -> Int32 {
  self.size
}

///|
pub fn PhysicsemeddySlice::get(self : PhysicsemeddySlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn PhysicsemeddySlice::set(
  self : PhysicsemeddySlice,
  i : Int32,
  v : Double,
) -> PhysicsemeddySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddySlice::sum(self : PhysicsemeddySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn PhysicsemeddySlice::mean(self : PhysicsemeddySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn PhysicsemeddySlice::scale(
  self : PhysicsemeddySlice,
  f : Double,
) -> PhysicsemeddySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddySlice::add(
  self : PhysicsemeddySlice,
  other : PhysicsemeddySlice,
) -> PhysicsemeddySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn PhysicsemeddySlice::copy(
  self : PhysicsemeddySlice,
) -> PhysicsemeddySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddySlice::fill(
  self : PhysicsemeddySlice,
  v : Double,
) -> PhysicsemeddySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn PhysicsemeddySlice::min(self : PhysicsemeddySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn PhysicsemeddySlice::max(self : PhysicsemeddySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn PhysicsemeddySlice::to_string(self : PhysicsemeddySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

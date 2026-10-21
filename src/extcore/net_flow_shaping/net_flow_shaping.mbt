///|
///===
/// extcore/net_flow_shaping
pub(all) struct NetflowshapingPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_flow_shaping_make_point(
  x : Double,
  y : Double,
) -> NetflowshapingPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_flow_shaping_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetflowshapingPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetflowshapingPoint::x(self : NetflowshapingPoint) -> Double {
  self.x
}

///|
pub fn NetflowshapingPoint::y(self : NetflowshapingPoint) -> Double {
  self.y
}

///|
pub fn NetflowshapingPoint::z(self : NetflowshapingPoint) -> Double {
  self.z
}

///|
pub fn NetflowshapingPoint::label(self : NetflowshapingPoint) -> Int32 {
  self.label
}

///|
pub fn NetflowshapingPoint::dist(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetflowshapingPoint::add(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> NetflowshapingPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetflowshapingPoint::sub(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> NetflowshapingPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetflowshapingPoint::scale(
  self : NetflowshapingPoint,
  s : Double,
) -> NetflowshapingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetflowshapingPoint::dot(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetflowshapingPoint::cross(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> NetflowshapingPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetflowshapingPoint::norm(self : NetflowshapingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetflowshapingPoint::normalize(
  self : NetflowshapingPoint,
) -> NetflowshapingPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetflowshapingPoint::negate(
  self : NetflowshapingPoint,
) -> NetflowshapingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetflowshapingPoint::mid(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
) -> NetflowshapingPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetflowshapingPoint::lerp(
  self : NetflowshapingPoint,
  other : NetflowshapingPoint,
  t : Double,
) -> NetflowshapingPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetflowshapingPoint::to_string(self : NetflowshapingPoint) -> String {
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
pub(all) struct NetflowshapingSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_flow_shaping_make_series(
  vals : Array[Double],
  name : String,
) -> NetflowshapingSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetflowshapingSeries::len(self : NetflowshapingSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetflowshapingSeries::sum(self : NetflowshapingSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetflowshapingSeries::mean(self : NetflowshapingSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetflowshapingSeries::min(self : NetflowshapingSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetflowshapingSeries::max(self : NetflowshapingSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetflowshapingSeries::range(self : NetflowshapingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetflowshapingSeries::variance(self : NetflowshapingSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetflowshapingSeries::std(self : NetflowshapingSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetflowshapingSeries::median(self : NetflowshapingSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetflowshapingSeries::scale(
  self : NetflowshapingSeries,
  f : Double,
) -> NetflowshapingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetflowshapingSeries::add(
  self : NetflowshapingSeries,
  other : NetflowshapingSeries,
) -> NetflowshapingSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetflowshapingSeries::sub(
  self : NetflowshapingSeries,
  other : NetflowshapingSeries,
) -> NetflowshapingSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetflowshapingSeries::normalize(
  self : NetflowshapingSeries,
) -> NetflowshapingSeries {
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
pub fn NetflowshapingSeries::cumsum(
  self : NetflowshapingSeries,
) -> NetflowshapingSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetflowshapingSeries::to_string(self : NetflowshapingSeries) -> String {
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
pub(all) struct NetflowshapingMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_flow_shaping_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetflowshapingMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_flow_shaping_matrix_identity(n : Int32) -> NetflowshapingMatrix {
  let m = net_flow_shaping_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetflowshapingMatrix::get(
  self : NetflowshapingMatrix,
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
pub fn NetflowshapingMatrix::transpose(
  self : NetflowshapingMatrix,
) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetflowshapingMatrix::add(
  self : NetflowshapingMatrix,
  other : NetflowshapingMatrix,
) -> NetflowshapingMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_flow_shaping_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetflowshapingMatrix::scale(
  self : NetflowshapingMatrix,
  s : Double,
) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetflowshapingMatrix::multiply(
  self : NetflowshapingMatrix,
  other : NetflowshapingMatrix,
) -> NetflowshapingMatrix {
  if self.cols != other.rows {
    return net_flow_shaping_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_flow_shaping_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetflowshapingMatrix::trace(self : NetflowshapingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetflowshapingMatrix::det(self : NetflowshapingMatrix) -> Double {
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
pub fn NetflowshapingMatrix::norm(self : NetflowshapingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetflowshapingMatrix::to_string(self : NetflowshapingMatrix) -> String {
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
pub(all) struct NetflowshapingVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_flow_shaping_make_vector(
  comps : Array[Double],
) -> NetflowshapingVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_flow_shaping_vector_zero(dim : Int32) -> NetflowshapingVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetflowshapingVector::add(
  self : NetflowshapingVector,
  other : NetflowshapingVector,
) -> NetflowshapingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetflowshapingVector::sub(
  self : NetflowshapingVector,
  other : NetflowshapingVector,
) -> NetflowshapingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetflowshapingVector::scale(
  self : NetflowshapingVector,
  s : Double,
) -> NetflowshapingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetflowshapingVector::dot(
  self : NetflowshapingVector,
  other : NetflowshapingVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetflowshapingVector::norm(self : NetflowshapingVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetflowshapingVector::normalize(
  self : NetflowshapingVector,
) -> NetflowshapingVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetflowshapingVector::dist(
  self : NetflowshapingVector,
  other : NetflowshapingVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetflowshapingVector::to_string(self : NetflowshapingVector) -> String {
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
pub(all) struct NetflowshapingFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_frame_make(size : Int32) -> NetflowshapingFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingFrame::len(self : NetflowshapingFrame) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingFrame::get(
  self : NetflowshapingFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingFrame::set(
  self : NetflowshapingFrame,
  i : Int32,
  v : Double,
) -> NetflowshapingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingFrame::sum(self : NetflowshapingFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingFrame::mean(self : NetflowshapingFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingFrame::scale(
  self : NetflowshapingFrame,
  f : Double,
) -> NetflowshapingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingFrame::add(
  self : NetflowshapingFrame,
  other : NetflowshapingFrame,
) -> NetflowshapingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingFrame::copy(
  self : NetflowshapingFrame,
) -> NetflowshapingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingFrame::fill(
  self : NetflowshapingFrame,
  v : Double,
) -> NetflowshapingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingFrame::min(self : NetflowshapingFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingFrame::max(self : NetflowshapingFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingFrame::to_string(self : NetflowshapingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_table_make(size : Int32) -> NetflowshapingTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingTable::len(self : NetflowshapingTable) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingTable::get(
  self : NetflowshapingTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingTable::set(
  self : NetflowshapingTable,
  i : Int32,
  v : Double,
) -> NetflowshapingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingTable::sum(self : NetflowshapingTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingTable::mean(self : NetflowshapingTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingTable::scale(
  self : NetflowshapingTable,
  f : Double,
) -> NetflowshapingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingTable::add(
  self : NetflowshapingTable,
  other : NetflowshapingTable,
) -> NetflowshapingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingTable::copy(
  self : NetflowshapingTable,
) -> NetflowshapingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingTable::fill(
  self : NetflowshapingTable,
  v : Double,
) -> NetflowshapingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingTable::min(self : NetflowshapingTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingTable::max(self : NetflowshapingTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingTable::to_string(self : NetflowshapingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_graphn_make(size : Int32) -> NetflowshapingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingGraphN::len(self : NetflowshapingGraphN) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingGraphN::get(
  self : NetflowshapingGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingGraphN::set(
  self : NetflowshapingGraphN,
  i : Int32,
  v : Double,
) -> NetflowshapingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingGraphN::sum(self : NetflowshapingGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingGraphN::mean(self : NetflowshapingGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingGraphN::scale(
  self : NetflowshapingGraphN,
  f : Double,
) -> NetflowshapingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingGraphN::add(
  self : NetflowshapingGraphN,
  other : NetflowshapingGraphN,
) -> NetflowshapingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingGraphN::copy(
  self : NetflowshapingGraphN,
) -> NetflowshapingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingGraphN::fill(
  self : NetflowshapingGraphN,
  v : Double,
) -> NetflowshapingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingGraphN::min(self : NetflowshapingGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingGraphN::max(self : NetflowshapingGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingGraphN::to_string(self : NetflowshapingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_node_make(size : Int32) -> NetflowshapingNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingNode::len(self : NetflowshapingNode) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingNode::get(self : NetflowshapingNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingNode::set(
  self : NetflowshapingNode,
  i : Int32,
  v : Double,
) -> NetflowshapingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingNode::sum(self : NetflowshapingNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingNode::mean(self : NetflowshapingNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingNode::scale(
  self : NetflowshapingNode,
  f : Double,
) -> NetflowshapingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingNode::add(
  self : NetflowshapingNode,
  other : NetflowshapingNode,
) -> NetflowshapingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingNode::copy(
  self : NetflowshapingNode,
) -> NetflowshapingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingNode::fill(
  self : NetflowshapingNode,
  v : Double,
) -> NetflowshapingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingNode::min(self : NetflowshapingNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingNode::max(self : NetflowshapingNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingNode::to_string(self : NetflowshapingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_edge_make(size : Int32) -> NetflowshapingEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingEdge::len(self : NetflowshapingEdge) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingEdge::get(self : NetflowshapingEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingEdge::set(
  self : NetflowshapingEdge,
  i : Int32,
  v : Double,
) -> NetflowshapingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingEdge::sum(self : NetflowshapingEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingEdge::mean(self : NetflowshapingEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingEdge::scale(
  self : NetflowshapingEdge,
  f : Double,
) -> NetflowshapingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingEdge::add(
  self : NetflowshapingEdge,
  other : NetflowshapingEdge,
) -> NetflowshapingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingEdge::copy(
  self : NetflowshapingEdge,
) -> NetflowshapingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingEdge::fill(
  self : NetflowshapingEdge,
  v : Double,
) -> NetflowshapingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingEdge::min(self : NetflowshapingEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingEdge::max(self : NetflowshapingEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingEdge::to_string(self : NetflowshapingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_path_make(size : Int32) -> NetflowshapingPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingPath::len(self : NetflowshapingPath) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingPath::get(self : NetflowshapingPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingPath::set(
  self : NetflowshapingPath,
  i : Int32,
  v : Double,
) -> NetflowshapingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingPath::sum(self : NetflowshapingPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingPath::mean(self : NetflowshapingPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingPath::scale(
  self : NetflowshapingPath,
  f : Double,
) -> NetflowshapingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingPath::add(
  self : NetflowshapingPath,
  other : NetflowshapingPath,
) -> NetflowshapingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingPath::copy(
  self : NetflowshapingPath,
) -> NetflowshapingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingPath::fill(
  self : NetflowshapingPath,
  v : Double,
) -> NetflowshapingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingPath::min(self : NetflowshapingPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingPath::max(self : NetflowshapingPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingPath::to_string(self : NetflowshapingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_cluster_make(size : Int32) -> NetflowshapingCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingCluster::len(self : NetflowshapingCluster) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingCluster::get(
  self : NetflowshapingCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingCluster::set(
  self : NetflowshapingCluster,
  i : Int32,
  v : Double,
) -> NetflowshapingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCluster::sum(self : NetflowshapingCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingCluster::mean(self : NetflowshapingCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingCluster::scale(
  self : NetflowshapingCluster,
  f : Double,
) -> NetflowshapingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCluster::add(
  self : NetflowshapingCluster,
  other : NetflowshapingCluster,
) -> NetflowshapingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingCluster::copy(
  self : NetflowshapingCluster,
) -> NetflowshapingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCluster::fill(
  self : NetflowshapingCluster,
  v : Double,
) -> NetflowshapingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCluster::min(self : NetflowshapingCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingCluster::max(self : NetflowshapingCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingCluster::to_string(self : NetflowshapingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_model_make(size : Int32) -> NetflowshapingModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingModel::len(self : NetflowshapingModel) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingModel::get(
  self : NetflowshapingModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingModel::set(
  self : NetflowshapingModel,
  i : Int32,
  v : Double,
) -> NetflowshapingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingModel::sum(self : NetflowshapingModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingModel::mean(self : NetflowshapingModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingModel::scale(
  self : NetflowshapingModel,
  f : Double,
) -> NetflowshapingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingModel::add(
  self : NetflowshapingModel,
  other : NetflowshapingModel,
) -> NetflowshapingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingModel::copy(
  self : NetflowshapingModel,
) -> NetflowshapingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingModel::fill(
  self : NetflowshapingModel,
  v : Double,
) -> NetflowshapingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingModel::min(self : NetflowshapingModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingModel::max(self : NetflowshapingModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingModel::to_string(self : NetflowshapingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_layer_make(size : Int32) -> NetflowshapingLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingLayer::len(self : NetflowshapingLayer) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingLayer::get(
  self : NetflowshapingLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingLayer::set(
  self : NetflowshapingLayer,
  i : Int32,
  v : Double,
) -> NetflowshapingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingLayer::sum(self : NetflowshapingLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingLayer::mean(self : NetflowshapingLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingLayer::scale(
  self : NetflowshapingLayer,
  f : Double,
) -> NetflowshapingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingLayer::add(
  self : NetflowshapingLayer,
  other : NetflowshapingLayer,
) -> NetflowshapingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingLayer::copy(
  self : NetflowshapingLayer,
) -> NetflowshapingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingLayer::fill(
  self : NetflowshapingLayer,
  v : Double,
) -> NetflowshapingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingLayer::min(self : NetflowshapingLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingLayer::max(self : NetflowshapingLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingLayer::to_string(self : NetflowshapingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_buffer_make(size : Int32) -> NetflowshapingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingBuffer::len(self : NetflowshapingBuffer) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingBuffer::get(
  self : NetflowshapingBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingBuffer::set(
  self : NetflowshapingBuffer,
  i : Int32,
  v : Double,
) -> NetflowshapingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingBuffer::sum(self : NetflowshapingBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingBuffer::mean(self : NetflowshapingBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingBuffer::scale(
  self : NetflowshapingBuffer,
  f : Double,
) -> NetflowshapingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingBuffer::add(
  self : NetflowshapingBuffer,
  other : NetflowshapingBuffer,
) -> NetflowshapingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingBuffer::copy(
  self : NetflowshapingBuffer,
) -> NetflowshapingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingBuffer::fill(
  self : NetflowshapingBuffer,
  v : Double,
) -> NetflowshapingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingBuffer::min(self : NetflowshapingBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingBuffer::max(self : NetflowshapingBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingBuffer::to_string(self : NetflowshapingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_cursor_make(size : Int32) -> NetflowshapingCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingCursor::len(self : NetflowshapingCursor) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingCursor::get(
  self : NetflowshapingCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingCursor::set(
  self : NetflowshapingCursor,
  i : Int32,
  v : Double,
) -> NetflowshapingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCursor::sum(self : NetflowshapingCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingCursor::mean(self : NetflowshapingCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingCursor::scale(
  self : NetflowshapingCursor,
  f : Double,
) -> NetflowshapingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCursor::add(
  self : NetflowshapingCursor,
  other : NetflowshapingCursor,
) -> NetflowshapingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingCursor::copy(
  self : NetflowshapingCursor,
) -> NetflowshapingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCursor::fill(
  self : NetflowshapingCursor,
  v : Double,
) -> NetflowshapingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingCursor::min(self : NetflowshapingCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingCursor::max(self : NetflowshapingCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingCursor::to_string(self : NetflowshapingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_view_make(size : Int32) -> NetflowshapingView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingView::len(self : NetflowshapingView) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingView::get(self : NetflowshapingView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingView::set(
  self : NetflowshapingView,
  i : Int32,
  v : Double,
) -> NetflowshapingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingView::sum(self : NetflowshapingView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingView::mean(self : NetflowshapingView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingView::scale(
  self : NetflowshapingView,
  f : Double,
) -> NetflowshapingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingView::add(
  self : NetflowshapingView,
  other : NetflowshapingView,
) -> NetflowshapingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingView::copy(
  self : NetflowshapingView,
) -> NetflowshapingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingView::fill(
  self : NetflowshapingView,
  v : Double,
) -> NetflowshapingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingView::min(self : NetflowshapingView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingView::max(self : NetflowshapingView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingView::to_string(self : NetflowshapingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_range_make(size : Int32) -> NetflowshapingRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingRange::len(self : NetflowshapingRange) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingRange::get(
  self : NetflowshapingRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingRange::set(
  self : NetflowshapingRange,
  i : Int32,
  v : Double,
) -> NetflowshapingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingRange::sum(self : NetflowshapingRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingRange::mean(self : NetflowshapingRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingRange::scale(
  self : NetflowshapingRange,
  f : Double,
) -> NetflowshapingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingRange::add(
  self : NetflowshapingRange,
  other : NetflowshapingRange,
) -> NetflowshapingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingRange::copy(
  self : NetflowshapingRange,
) -> NetflowshapingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingRange::fill(
  self : NetflowshapingRange,
  v : Double,
) -> NetflowshapingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingRange::min(self : NetflowshapingRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingRange::max(self : NetflowshapingRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingRange::to_string(self : NetflowshapingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetflowshapingSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_flow_shaping_slice_make(size : Int32) -> NetflowshapingSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetflowshapingSlice::len(self : NetflowshapingSlice) -> Int32 {
  self.size
}

///|
pub fn NetflowshapingSlice::get(
  self : NetflowshapingSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetflowshapingSlice::set(
  self : NetflowshapingSlice,
  i : Int32,
  v : Double,
) -> NetflowshapingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingSlice::sum(self : NetflowshapingSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetflowshapingSlice::mean(self : NetflowshapingSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetflowshapingSlice::scale(
  self : NetflowshapingSlice,
  f : Double,
) -> NetflowshapingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingSlice::add(
  self : NetflowshapingSlice,
  other : NetflowshapingSlice,
) -> NetflowshapingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetflowshapingSlice::copy(
  self : NetflowshapingSlice,
) -> NetflowshapingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingSlice::fill(
  self : NetflowshapingSlice,
  v : Double,
) -> NetflowshapingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetflowshapingSlice::min(self : NetflowshapingSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetflowshapingSlice::max(self : NetflowshapingSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetflowshapingSlice::to_string(self : NetflowshapingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

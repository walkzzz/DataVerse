///|
///===
/// extcore/net_route_policy
pub(all) struct NetroutepolicyPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_route_policy_make_point(
  x : Double,
  y : Double,
) -> NetroutepolicyPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_route_policy_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetroutepolicyPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetroutepolicyPoint::x(self : NetroutepolicyPoint) -> Double {
  self.x
}

///|
pub fn NetroutepolicyPoint::y(self : NetroutepolicyPoint) -> Double {
  self.y
}

///|
pub fn NetroutepolicyPoint::z(self : NetroutepolicyPoint) -> Double {
  self.z
}

///|
pub fn NetroutepolicyPoint::label(self : NetroutepolicyPoint) -> Int32 {
  self.label
}

///|
pub fn NetroutepolicyPoint::dist(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetroutepolicyPoint::add(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetroutepolicyPoint::sub(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetroutepolicyPoint::scale(
  self : NetroutepolicyPoint,
  s : Double,
) -> NetroutepolicyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetroutepolicyPoint::dot(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetroutepolicyPoint::cross(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetroutepolicyPoint::norm(self : NetroutepolicyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetroutepolicyPoint::normalize(
  self : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetroutepolicyPoint::negate(
  self : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetroutepolicyPoint::mid(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
) -> NetroutepolicyPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetroutepolicyPoint::lerp(
  self : NetroutepolicyPoint,
  other : NetroutepolicyPoint,
  t : Double,
) -> NetroutepolicyPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetroutepolicyPoint::to_string(self : NetroutepolicyPoint) -> String {
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
pub(all) struct NetroutepolicySeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_route_policy_make_series(
  vals : Array[Double],
  name : String,
) -> NetroutepolicySeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetroutepolicySeries::len(self : NetroutepolicySeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetroutepolicySeries::sum(self : NetroutepolicySeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetroutepolicySeries::mean(self : NetroutepolicySeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetroutepolicySeries::min(self : NetroutepolicySeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetroutepolicySeries::max(self : NetroutepolicySeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetroutepolicySeries::range(self : NetroutepolicySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetroutepolicySeries::variance(self : NetroutepolicySeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetroutepolicySeries::std(self : NetroutepolicySeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetroutepolicySeries::median(self : NetroutepolicySeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetroutepolicySeries::scale(
  self : NetroutepolicySeries,
  f : Double,
) -> NetroutepolicySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetroutepolicySeries::add(
  self : NetroutepolicySeries,
  other : NetroutepolicySeries,
) -> NetroutepolicySeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetroutepolicySeries::sub(
  self : NetroutepolicySeries,
  other : NetroutepolicySeries,
) -> NetroutepolicySeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetroutepolicySeries::normalize(
  self : NetroutepolicySeries,
) -> NetroutepolicySeries {
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
pub fn NetroutepolicySeries::cumsum(
  self : NetroutepolicySeries,
) -> NetroutepolicySeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetroutepolicySeries::to_string(self : NetroutepolicySeries) -> String {
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
pub(all) struct NetroutepolicyMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_route_policy_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetroutepolicyMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_route_policy_matrix_identity(n : Int32) -> NetroutepolicyMatrix {
  let m = net_route_policy_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetroutepolicyMatrix::get(
  self : NetroutepolicyMatrix,
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
pub fn NetroutepolicyMatrix::transpose(
  self : NetroutepolicyMatrix,
) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetroutepolicyMatrix::add(
  self : NetroutepolicyMatrix,
  other : NetroutepolicyMatrix,
) -> NetroutepolicyMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_route_policy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetroutepolicyMatrix::scale(
  self : NetroutepolicyMatrix,
  s : Double,
) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetroutepolicyMatrix::multiply(
  self : NetroutepolicyMatrix,
  other : NetroutepolicyMatrix,
) -> NetroutepolicyMatrix {
  if self.cols != other.rows {
    return net_route_policy_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_route_policy_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetroutepolicyMatrix::trace(self : NetroutepolicyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetroutepolicyMatrix::det(self : NetroutepolicyMatrix) -> Double {
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
pub fn NetroutepolicyMatrix::norm(self : NetroutepolicyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetroutepolicyMatrix::to_string(self : NetroutepolicyMatrix) -> String {
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
pub(all) struct NetroutepolicyVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_route_policy_make_vector(
  comps : Array[Double],
) -> NetroutepolicyVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_route_policy_vector_zero(dim : Int32) -> NetroutepolicyVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetroutepolicyVector::add(
  self : NetroutepolicyVector,
  other : NetroutepolicyVector,
) -> NetroutepolicyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetroutepolicyVector::sub(
  self : NetroutepolicyVector,
  other : NetroutepolicyVector,
) -> NetroutepolicyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetroutepolicyVector::scale(
  self : NetroutepolicyVector,
  s : Double,
) -> NetroutepolicyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetroutepolicyVector::dot(
  self : NetroutepolicyVector,
  other : NetroutepolicyVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetroutepolicyVector::norm(self : NetroutepolicyVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetroutepolicyVector::normalize(
  self : NetroutepolicyVector,
) -> NetroutepolicyVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetroutepolicyVector::dist(
  self : NetroutepolicyVector,
  other : NetroutepolicyVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetroutepolicyVector::to_string(self : NetroutepolicyVector) -> String {
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
pub(all) struct NetroutepolicyFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_frame_make(size : Int32) -> NetroutepolicyFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyFrame::len(self : NetroutepolicyFrame) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyFrame::get(
  self : NetroutepolicyFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyFrame::set(
  self : NetroutepolicyFrame,
  i : Int32,
  v : Double,
) -> NetroutepolicyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyFrame::sum(self : NetroutepolicyFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyFrame::mean(self : NetroutepolicyFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyFrame::scale(
  self : NetroutepolicyFrame,
  f : Double,
) -> NetroutepolicyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyFrame::add(
  self : NetroutepolicyFrame,
  other : NetroutepolicyFrame,
) -> NetroutepolicyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyFrame::copy(
  self : NetroutepolicyFrame,
) -> NetroutepolicyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyFrame::fill(
  self : NetroutepolicyFrame,
  v : Double,
) -> NetroutepolicyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyFrame::min(self : NetroutepolicyFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyFrame::max(self : NetroutepolicyFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyFrame::to_string(self : NetroutepolicyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_table_make(size : Int32) -> NetroutepolicyTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyTable::len(self : NetroutepolicyTable) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyTable::get(
  self : NetroutepolicyTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyTable::set(
  self : NetroutepolicyTable,
  i : Int32,
  v : Double,
) -> NetroutepolicyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyTable::sum(self : NetroutepolicyTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyTable::mean(self : NetroutepolicyTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyTable::scale(
  self : NetroutepolicyTable,
  f : Double,
) -> NetroutepolicyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyTable::add(
  self : NetroutepolicyTable,
  other : NetroutepolicyTable,
) -> NetroutepolicyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyTable::copy(
  self : NetroutepolicyTable,
) -> NetroutepolicyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyTable::fill(
  self : NetroutepolicyTable,
  v : Double,
) -> NetroutepolicyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyTable::min(self : NetroutepolicyTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyTable::max(self : NetroutepolicyTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyTable::to_string(self : NetroutepolicyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_graphn_make(size : Int32) -> NetroutepolicyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyGraphN::len(self : NetroutepolicyGraphN) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyGraphN::get(
  self : NetroutepolicyGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyGraphN::set(
  self : NetroutepolicyGraphN,
  i : Int32,
  v : Double,
) -> NetroutepolicyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyGraphN::sum(self : NetroutepolicyGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyGraphN::mean(self : NetroutepolicyGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyGraphN::scale(
  self : NetroutepolicyGraphN,
  f : Double,
) -> NetroutepolicyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyGraphN::add(
  self : NetroutepolicyGraphN,
  other : NetroutepolicyGraphN,
) -> NetroutepolicyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyGraphN::copy(
  self : NetroutepolicyGraphN,
) -> NetroutepolicyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyGraphN::fill(
  self : NetroutepolicyGraphN,
  v : Double,
) -> NetroutepolicyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyGraphN::min(self : NetroutepolicyGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyGraphN::max(self : NetroutepolicyGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyGraphN::to_string(self : NetroutepolicyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_node_make(size : Int32) -> NetroutepolicyNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyNode::len(self : NetroutepolicyNode) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyNode::get(self : NetroutepolicyNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyNode::set(
  self : NetroutepolicyNode,
  i : Int32,
  v : Double,
) -> NetroutepolicyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyNode::sum(self : NetroutepolicyNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyNode::mean(self : NetroutepolicyNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyNode::scale(
  self : NetroutepolicyNode,
  f : Double,
) -> NetroutepolicyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyNode::add(
  self : NetroutepolicyNode,
  other : NetroutepolicyNode,
) -> NetroutepolicyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyNode::copy(
  self : NetroutepolicyNode,
) -> NetroutepolicyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyNode::fill(
  self : NetroutepolicyNode,
  v : Double,
) -> NetroutepolicyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyNode::min(self : NetroutepolicyNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyNode::max(self : NetroutepolicyNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyNode::to_string(self : NetroutepolicyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_edge_make(size : Int32) -> NetroutepolicyEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyEdge::len(self : NetroutepolicyEdge) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyEdge::get(self : NetroutepolicyEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyEdge::set(
  self : NetroutepolicyEdge,
  i : Int32,
  v : Double,
) -> NetroutepolicyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyEdge::sum(self : NetroutepolicyEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyEdge::mean(self : NetroutepolicyEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyEdge::scale(
  self : NetroutepolicyEdge,
  f : Double,
) -> NetroutepolicyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyEdge::add(
  self : NetroutepolicyEdge,
  other : NetroutepolicyEdge,
) -> NetroutepolicyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyEdge::copy(
  self : NetroutepolicyEdge,
) -> NetroutepolicyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyEdge::fill(
  self : NetroutepolicyEdge,
  v : Double,
) -> NetroutepolicyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyEdge::min(self : NetroutepolicyEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyEdge::max(self : NetroutepolicyEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyEdge::to_string(self : NetroutepolicyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_path_make(size : Int32) -> NetroutepolicyPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyPath::len(self : NetroutepolicyPath) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyPath::get(self : NetroutepolicyPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyPath::set(
  self : NetroutepolicyPath,
  i : Int32,
  v : Double,
) -> NetroutepolicyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyPath::sum(self : NetroutepolicyPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyPath::mean(self : NetroutepolicyPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyPath::scale(
  self : NetroutepolicyPath,
  f : Double,
) -> NetroutepolicyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyPath::add(
  self : NetroutepolicyPath,
  other : NetroutepolicyPath,
) -> NetroutepolicyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyPath::copy(
  self : NetroutepolicyPath,
) -> NetroutepolicyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyPath::fill(
  self : NetroutepolicyPath,
  v : Double,
) -> NetroutepolicyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyPath::min(self : NetroutepolicyPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyPath::max(self : NetroutepolicyPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyPath::to_string(self : NetroutepolicyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_cluster_make(size : Int32) -> NetroutepolicyCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyCluster::len(self : NetroutepolicyCluster) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyCluster::get(
  self : NetroutepolicyCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyCluster::set(
  self : NetroutepolicyCluster,
  i : Int32,
  v : Double,
) -> NetroutepolicyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCluster::sum(self : NetroutepolicyCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyCluster::mean(self : NetroutepolicyCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyCluster::scale(
  self : NetroutepolicyCluster,
  f : Double,
) -> NetroutepolicyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCluster::add(
  self : NetroutepolicyCluster,
  other : NetroutepolicyCluster,
) -> NetroutepolicyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyCluster::copy(
  self : NetroutepolicyCluster,
) -> NetroutepolicyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCluster::fill(
  self : NetroutepolicyCluster,
  v : Double,
) -> NetroutepolicyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCluster::min(self : NetroutepolicyCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyCluster::max(self : NetroutepolicyCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyCluster::to_string(self : NetroutepolicyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_model_make(size : Int32) -> NetroutepolicyModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyModel::len(self : NetroutepolicyModel) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyModel::get(
  self : NetroutepolicyModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyModel::set(
  self : NetroutepolicyModel,
  i : Int32,
  v : Double,
) -> NetroutepolicyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyModel::sum(self : NetroutepolicyModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyModel::mean(self : NetroutepolicyModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyModel::scale(
  self : NetroutepolicyModel,
  f : Double,
) -> NetroutepolicyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyModel::add(
  self : NetroutepolicyModel,
  other : NetroutepolicyModel,
) -> NetroutepolicyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyModel::copy(
  self : NetroutepolicyModel,
) -> NetroutepolicyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyModel::fill(
  self : NetroutepolicyModel,
  v : Double,
) -> NetroutepolicyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyModel::min(self : NetroutepolicyModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyModel::max(self : NetroutepolicyModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyModel::to_string(self : NetroutepolicyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_layer_make(size : Int32) -> NetroutepolicyLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyLayer::len(self : NetroutepolicyLayer) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyLayer::get(
  self : NetroutepolicyLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyLayer::set(
  self : NetroutepolicyLayer,
  i : Int32,
  v : Double,
) -> NetroutepolicyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyLayer::sum(self : NetroutepolicyLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyLayer::mean(self : NetroutepolicyLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyLayer::scale(
  self : NetroutepolicyLayer,
  f : Double,
) -> NetroutepolicyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyLayer::add(
  self : NetroutepolicyLayer,
  other : NetroutepolicyLayer,
) -> NetroutepolicyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyLayer::copy(
  self : NetroutepolicyLayer,
) -> NetroutepolicyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyLayer::fill(
  self : NetroutepolicyLayer,
  v : Double,
) -> NetroutepolicyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyLayer::min(self : NetroutepolicyLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyLayer::max(self : NetroutepolicyLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyLayer::to_string(self : NetroutepolicyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_buffer_make(size : Int32) -> NetroutepolicyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyBuffer::len(self : NetroutepolicyBuffer) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyBuffer::get(
  self : NetroutepolicyBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyBuffer::set(
  self : NetroutepolicyBuffer,
  i : Int32,
  v : Double,
) -> NetroutepolicyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyBuffer::sum(self : NetroutepolicyBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyBuffer::mean(self : NetroutepolicyBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyBuffer::scale(
  self : NetroutepolicyBuffer,
  f : Double,
) -> NetroutepolicyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyBuffer::add(
  self : NetroutepolicyBuffer,
  other : NetroutepolicyBuffer,
) -> NetroutepolicyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyBuffer::copy(
  self : NetroutepolicyBuffer,
) -> NetroutepolicyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyBuffer::fill(
  self : NetroutepolicyBuffer,
  v : Double,
) -> NetroutepolicyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyBuffer::min(self : NetroutepolicyBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyBuffer::max(self : NetroutepolicyBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyBuffer::to_string(self : NetroutepolicyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_cursor_make(size : Int32) -> NetroutepolicyCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyCursor::len(self : NetroutepolicyCursor) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyCursor::get(
  self : NetroutepolicyCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyCursor::set(
  self : NetroutepolicyCursor,
  i : Int32,
  v : Double,
) -> NetroutepolicyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCursor::sum(self : NetroutepolicyCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyCursor::mean(self : NetroutepolicyCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyCursor::scale(
  self : NetroutepolicyCursor,
  f : Double,
) -> NetroutepolicyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCursor::add(
  self : NetroutepolicyCursor,
  other : NetroutepolicyCursor,
) -> NetroutepolicyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyCursor::copy(
  self : NetroutepolicyCursor,
) -> NetroutepolicyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCursor::fill(
  self : NetroutepolicyCursor,
  v : Double,
) -> NetroutepolicyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyCursor::min(self : NetroutepolicyCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyCursor::max(self : NetroutepolicyCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyCursor::to_string(self : NetroutepolicyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_view_make(size : Int32) -> NetroutepolicyView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyView::len(self : NetroutepolicyView) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyView::get(self : NetroutepolicyView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyView::set(
  self : NetroutepolicyView,
  i : Int32,
  v : Double,
) -> NetroutepolicyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyView::sum(self : NetroutepolicyView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyView::mean(self : NetroutepolicyView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyView::scale(
  self : NetroutepolicyView,
  f : Double,
) -> NetroutepolicyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyView::add(
  self : NetroutepolicyView,
  other : NetroutepolicyView,
) -> NetroutepolicyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyView::copy(
  self : NetroutepolicyView,
) -> NetroutepolicyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyView::fill(
  self : NetroutepolicyView,
  v : Double,
) -> NetroutepolicyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyView::min(self : NetroutepolicyView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyView::max(self : NetroutepolicyView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyView::to_string(self : NetroutepolicyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicyRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_range_make(size : Int32) -> NetroutepolicyRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicyRange::len(self : NetroutepolicyRange) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicyRange::get(
  self : NetroutepolicyRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicyRange::set(
  self : NetroutepolicyRange,
  i : Int32,
  v : Double,
) -> NetroutepolicyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyRange::sum(self : NetroutepolicyRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicyRange::mean(self : NetroutepolicyRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicyRange::scale(
  self : NetroutepolicyRange,
  f : Double,
) -> NetroutepolicyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyRange::add(
  self : NetroutepolicyRange,
  other : NetroutepolicyRange,
) -> NetroutepolicyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicyRange::copy(
  self : NetroutepolicyRange,
) -> NetroutepolicyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyRange::fill(
  self : NetroutepolicyRange,
  v : Double,
) -> NetroutepolicyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicyRange::min(self : NetroutepolicyRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicyRange::max(self : NetroutepolicyRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicyRange::to_string(self : NetroutepolicyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetroutepolicySlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_route_policy_slice_make(size : Int32) -> NetroutepolicySlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetroutepolicySlice::len(self : NetroutepolicySlice) -> Int32 {
  self.size
}

///|
pub fn NetroutepolicySlice::get(
  self : NetroutepolicySlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetroutepolicySlice::set(
  self : NetroutepolicySlice,
  i : Int32,
  v : Double,
) -> NetroutepolicySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicySlice::sum(self : NetroutepolicySlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetroutepolicySlice::mean(self : NetroutepolicySlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetroutepolicySlice::scale(
  self : NetroutepolicySlice,
  f : Double,
) -> NetroutepolicySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicySlice::add(
  self : NetroutepolicySlice,
  other : NetroutepolicySlice,
) -> NetroutepolicySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetroutepolicySlice::copy(
  self : NetroutepolicySlice,
) -> NetroutepolicySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicySlice::fill(
  self : NetroutepolicySlice,
  v : Double,
) -> NetroutepolicySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetroutepolicySlice::min(self : NetroutepolicySlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetroutepolicySlice::max(self : NetroutepolicySlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetroutepolicySlice::to_string(self : NetroutepolicySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

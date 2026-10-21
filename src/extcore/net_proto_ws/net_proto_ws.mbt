///|
///===
/// extcore/net_proto_ws
pub(all) struct NetprotowsPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_proto_ws_make_point(x : Double, y : Double) -> NetprotowsPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_proto_ws_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetprotowsPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetprotowsPoint::x(self : NetprotowsPoint) -> Double {
  self.x
}

///|
pub fn NetprotowsPoint::y(self : NetprotowsPoint) -> Double {
  self.y
}

///|
pub fn NetprotowsPoint::z(self : NetprotowsPoint) -> Double {
  self.z
}

///|
pub fn NetprotowsPoint::label(self : NetprotowsPoint) -> Int32 {
  self.label
}

///|
pub fn NetprotowsPoint::dist(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetprotowsPoint::add(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> NetprotowsPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetprotowsPoint::sub(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> NetprotowsPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetprotowsPoint::scale(
  self : NetprotowsPoint,
  s : Double,
) -> NetprotowsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetprotowsPoint::dot(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetprotowsPoint::cross(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> NetprotowsPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetprotowsPoint::norm(self : NetprotowsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetprotowsPoint::normalize(self : NetprotowsPoint) -> NetprotowsPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotowsPoint::negate(self : NetprotowsPoint) -> NetprotowsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetprotowsPoint::mid(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
) -> NetprotowsPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetprotowsPoint::lerp(
  self : NetprotowsPoint,
  other : NetprotowsPoint,
  t : Double,
) -> NetprotowsPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetprotowsPoint::to_string(self : NetprotowsPoint) -> String {
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
pub(all) struct NetprotowsSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_proto_ws_make_series(
  vals : Array[Double],
  name : String,
) -> NetprotowsSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetprotowsSeries::len(self : NetprotowsSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetprotowsSeries::sum(self : NetprotowsSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetprotowsSeries::mean(self : NetprotowsSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetprotowsSeries::min(self : NetprotowsSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetprotowsSeries::max(self : NetprotowsSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetprotowsSeries::range(self : NetprotowsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetprotowsSeries::variance(self : NetprotowsSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetprotowsSeries::std(self : NetprotowsSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetprotowsSeries::median(self : NetprotowsSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetprotowsSeries::scale(
  self : NetprotowsSeries,
  f : Double,
) -> NetprotowsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetprotowsSeries::add(
  self : NetprotowsSeries,
  other : NetprotowsSeries,
) -> NetprotowsSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotowsSeries::sub(
  self : NetprotowsSeries,
  other : NetprotowsSeries,
) -> NetprotowsSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotowsSeries::normalize(self : NetprotowsSeries) -> NetprotowsSeries {
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
pub fn NetprotowsSeries::cumsum(self : NetprotowsSeries) -> NetprotowsSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetprotowsSeries::to_string(self : NetprotowsSeries) -> String {
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
pub(all) struct NetprotowsMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_proto_ws_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetprotowsMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_proto_ws_matrix_identity(n : Int32) -> NetprotowsMatrix {
  let m = net_proto_ws_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetprotowsMatrix::get(
  self : NetprotowsMatrix,
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
pub fn NetprotowsMatrix::transpose(self : NetprotowsMatrix) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotowsMatrix::add(
  self : NetprotowsMatrix,
  other : NetprotowsMatrix,
) -> NetprotowsMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_proto_ws_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotowsMatrix::scale(
  self : NetprotowsMatrix,
  s : Double,
) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetprotowsMatrix::multiply(
  self : NetprotowsMatrix,
  other : NetprotowsMatrix,
) -> NetprotowsMatrix {
  if self.cols != other.rows {
    return net_proto_ws_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_proto_ws_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetprotowsMatrix::trace(self : NetprotowsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetprotowsMatrix::det(self : NetprotowsMatrix) -> Double {
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
pub fn NetprotowsMatrix::norm(self : NetprotowsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetprotowsMatrix::to_string(self : NetprotowsMatrix) -> String {
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
pub(all) struct NetprotowsVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_proto_ws_make_vector(comps : Array[Double]) -> NetprotowsVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_proto_ws_vector_zero(dim : Int32) -> NetprotowsVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetprotowsVector::add(
  self : NetprotowsVector,
  other : NetprotowsVector,
) -> NetprotowsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotowsVector::sub(
  self : NetprotowsVector,
  other : NetprotowsVector,
) -> NetprotowsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotowsVector::scale(
  self : NetprotowsVector,
  s : Double,
) -> NetprotowsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetprotowsVector::dot(
  self : NetprotowsVector,
  other : NetprotowsVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetprotowsVector::norm(self : NetprotowsVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetprotowsVector::normalize(self : NetprotowsVector) -> NetprotowsVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotowsVector::dist(
  self : NetprotowsVector,
  other : NetprotowsVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetprotowsVector::to_string(self : NetprotowsVector) -> String {
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
pub(all) struct NetprotowsFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_frame_make(size : Int32) -> NetprotowsFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsFrame::len(self : NetprotowsFrame) -> Int32 {
  self.size
}

///|
pub fn NetprotowsFrame::get(self : NetprotowsFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsFrame::set(
  self : NetprotowsFrame,
  i : Int32,
  v : Double,
) -> NetprotowsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsFrame::sum(self : NetprotowsFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsFrame::mean(self : NetprotowsFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsFrame::scale(
  self : NetprotowsFrame,
  f : Double,
) -> NetprotowsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsFrame::add(
  self : NetprotowsFrame,
  other : NetprotowsFrame,
) -> NetprotowsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsFrame::copy(self : NetprotowsFrame) -> NetprotowsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsFrame::fill(
  self : NetprotowsFrame,
  v : Double,
) -> NetprotowsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsFrame::min(self : NetprotowsFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsFrame::max(self : NetprotowsFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsFrame::to_string(self : NetprotowsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_table_make(size : Int32) -> NetprotowsTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsTable::len(self : NetprotowsTable) -> Int32 {
  self.size
}

///|
pub fn NetprotowsTable::get(self : NetprotowsTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsTable::set(
  self : NetprotowsTable,
  i : Int32,
  v : Double,
) -> NetprotowsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsTable::sum(self : NetprotowsTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsTable::mean(self : NetprotowsTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsTable::scale(
  self : NetprotowsTable,
  f : Double,
) -> NetprotowsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsTable::add(
  self : NetprotowsTable,
  other : NetprotowsTable,
) -> NetprotowsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsTable::copy(self : NetprotowsTable) -> NetprotowsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsTable::fill(
  self : NetprotowsTable,
  v : Double,
) -> NetprotowsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsTable::min(self : NetprotowsTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsTable::max(self : NetprotowsTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsTable::to_string(self : NetprotowsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_graphn_make(size : Int32) -> NetprotowsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsGraphN::len(self : NetprotowsGraphN) -> Int32 {
  self.size
}

///|
pub fn NetprotowsGraphN::get(self : NetprotowsGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsGraphN::set(
  self : NetprotowsGraphN,
  i : Int32,
  v : Double,
) -> NetprotowsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsGraphN::sum(self : NetprotowsGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsGraphN::mean(self : NetprotowsGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsGraphN::scale(
  self : NetprotowsGraphN,
  f : Double,
) -> NetprotowsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsGraphN::add(
  self : NetprotowsGraphN,
  other : NetprotowsGraphN,
) -> NetprotowsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsGraphN::copy(self : NetprotowsGraphN) -> NetprotowsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsGraphN::fill(
  self : NetprotowsGraphN,
  v : Double,
) -> NetprotowsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsGraphN::min(self : NetprotowsGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsGraphN::max(self : NetprotowsGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsGraphN::to_string(self : NetprotowsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_node_make(size : Int32) -> NetprotowsNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsNode::len(self : NetprotowsNode) -> Int32 {
  self.size
}

///|
pub fn NetprotowsNode::get(self : NetprotowsNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsNode::set(
  self : NetprotowsNode,
  i : Int32,
  v : Double,
) -> NetprotowsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsNode::sum(self : NetprotowsNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsNode::mean(self : NetprotowsNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsNode::scale(
  self : NetprotowsNode,
  f : Double,
) -> NetprotowsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsNode::add(
  self : NetprotowsNode,
  other : NetprotowsNode,
) -> NetprotowsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsNode::copy(self : NetprotowsNode) -> NetprotowsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsNode::fill(
  self : NetprotowsNode,
  v : Double,
) -> NetprotowsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsNode::min(self : NetprotowsNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsNode::max(self : NetprotowsNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsNode::to_string(self : NetprotowsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_edge_make(size : Int32) -> NetprotowsEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsEdge::len(self : NetprotowsEdge) -> Int32 {
  self.size
}

///|
pub fn NetprotowsEdge::get(self : NetprotowsEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsEdge::set(
  self : NetprotowsEdge,
  i : Int32,
  v : Double,
) -> NetprotowsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsEdge::sum(self : NetprotowsEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsEdge::mean(self : NetprotowsEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsEdge::scale(
  self : NetprotowsEdge,
  f : Double,
) -> NetprotowsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsEdge::add(
  self : NetprotowsEdge,
  other : NetprotowsEdge,
) -> NetprotowsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsEdge::copy(self : NetprotowsEdge) -> NetprotowsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsEdge::fill(
  self : NetprotowsEdge,
  v : Double,
) -> NetprotowsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsEdge::min(self : NetprotowsEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsEdge::max(self : NetprotowsEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsEdge::to_string(self : NetprotowsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_path_make(size : Int32) -> NetprotowsPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsPath::len(self : NetprotowsPath) -> Int32 {
  self.size
}

///|
pub fn NetprotowsPath::get(self : NetprotowsPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsPath::set(
  self : NetprotowsPath,
  i : Int32,
  v : Double,
) -> NetprotowsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsPath::sum(self : NetprotowsPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsPath::mean(self : NetprotowsPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsPath::scale(
  self : NetprotowsPath,
  f : Double,
) -> NetprotowsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsPath::add(
  self : NetprotowsPath,
  other : NetprotowsPath,
) -> NetprotowsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsPath::copy(self : NetprotowsPath) -> NetprotowsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsPath::fill(
  self : NetprotowsPath,
  v : Double,
) -> NetprotowsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsPath::min(self : NetprotowsPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsPath::max(self : NetprotowsPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsPath::to_string(self : NetprotowsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_cluster_make(size : Int32) -> NetprotowsCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsCluster::len(self : NetprotowsCluster) -> Int32 {
  self.size
}

///|
pub fn NetprotowsCluster::get(self : NetprotowsCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsCluster::set(
  self : NetprotowsCluster,
  i : Int32,
  v : Double,
) -> NetprotowsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCluster::sum(self : NetprotowsCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsCluster::mean(self : NetprotowsCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsCluster::scale(
  self : NetprotowsCluster,
  f : Double,
) -> NetprotowsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCluster::add(
  self : NetprotowsCluster,
  other : NetprotowsCluster,
) -> NetprotowsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsCluster::copy(self : NetprotowsCluster) -> NetprotowsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCluster::fill(
  self : NetprotowsCluster,
  v : Double,
) -> NetprotowsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCluster::min(self : NetprotowsCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsCluster::max(self : NetprotowsCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsCluster::to_string(self : NetprotowsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_model_make(size : Int32) -> NetprotowsModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsModel::len(self : NetprotowsModel) -> Int32 {
  self.size
}

///|
pub fn NetprotowsModel::get(self : NetprotowsModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsModel::set(
  self : NetprotowsModel,
  i : Int32,
  v : Double,
) -> NetprotowsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsModel::sum(self : NetprotowsModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsModel::mean(self : NetprotowsModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsModel::scale(
  self : NetprotowsModel,
  f : Double,
) -> NetprotowsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsModel::add(
  self : NetprotowsModel,
  other : NetprotowsModel,
) -> NetprotowsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsModel::copy(self : NetprotowsModel) -> NetprotowsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsModel::fill(
  self : NetprotowsModel,
  v : Double,
) -> NetprotowsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsModel::min(self : NetprotowsModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsModel::max(self : NetprotowsModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsModel::to_string(self : NetprotowsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_layer_make(size : Int32) -> NetprotowsLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsLayer::len(self : NetprotowsLayer) -> Int32 {
  self.size
}

///|
pub fn NetprotowsLayer::get(self : NetprotowsLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsLayer::set(
  self : NetprotowsLayer,
  i : Int32,
  v : Double,
) -> NetprotowsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsLayer::sum(self : NetprotowsLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsLayer::mean(self : NetprotowsLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsLayer::scale(
  self : NetprotowsLayer,
  f : Double,
) -> NetprotowsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsLayer::add(
  self : NetprotowsLayer,
  other : NetprotowsLayer,
) -> NetprotowsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsLayer::copy(self : NetprotowsLayer) -> NetprotowsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsLayer::fill(
  self : NetprotowsLayer,
  v : Double,
) -> NetprotowsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsLayer::min(self : NetprotowsLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsLayer::max(self : NetprotowsLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsLayer::to_string(self : NetprotowsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_buffer_make(size : Int32) -> NetprotowsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsBuffer::len(self : NetprotowsBuffer) -> Int32 {
  self.size
}

///|
pub fn NetprotowsBuffer::get(self : NetprotowsBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsBuffer::set(
  self : NetprotowsBuffer,
  i : Int32,
  v : Double,
) -> NetprotowsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsBuffer::sum(self : NetprotowsBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsBuffer::mean(self : NetprotowsBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsBuffer::scale(
  self : NetprotowsBuffer,
  f : Double,
) -> NetprotowsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsBuffer::add(
  self : NetprotowsBuffer,
  other : NetprotowsBuffer,
) -> NetprotowsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsBuffer::copy(self : NetprotowsBuffer) -> NetprotowsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsBuffer::fill(
  self : NetprotowsBuffer,
  v : Double,
) -> NetprotowsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsBuffer::min(self : NetprotowsBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsBuffer::max(self : NetprotowsBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsBuffer::to_string(self : NetprotowsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_cursor_make(size : Int32) -> NetprotowsCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsCursor::len(self : NetprotowsCursor) -> Int32 {
  self.size
}

///|
pub fn NetprotowsCursor::get(self : NetprotowsCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsCursor::set(
  self : NetprotowsCursor,
  i : Int32,
  v : Double,
) -> NetprotowsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCursor::sum(self : NetprotowsCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsCursor::mean(self : NetprotowsCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsCursor::scale(
  self : NetprotowsCursor,
  f : Double,
) -> NetprotowsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCursor::add(
  self : NetprotowsCursor,
  other : NetprotowsCursor,
) -> NetprotowsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsCursor::copy(self : NetprotowsCursor) -> NetprotowsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCursor::fill(
  self : NetprotowsCursor,
  v : Double,
) -> NetprotowsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsCursor::min(self : NetprotowsCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsCursor::max(self : NetprotowsCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsCursor::to_string(self : NetprotowsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_view_make(size : Int32) -> NetprotowsView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsView::len(self : NetprotowsView) -> Int32 {
  self.size
}

///|
pub fn NetprotowsView::get(self : NetprotowsView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsView::set(
  self : NetprotowsView,
  i : Int32,
  v : Double,
) -> NetprotowsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsView::sum(self : NetprotowsView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsView::mean(self : NetprotowsView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsView::scale(
  self : NetprotowsView,
  f : Double,
) -> NetprotowsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsView::add(
  self : NetprotowsView,
  other : NetprotowsView,
) -> NetprotowsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsView::copy(self : NetprotowsView) -> NetprotowsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsView::fill(
  self : NetprotowsView,
  v : Double,
) -> NetprotowsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsView::min(self : NetprotowsView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsView::max(self : NetprotowsView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsView::to_string(self : NetprotowsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_range_make(size : Int32) -> NetprotowsRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsRange::len(self : NetprotowsRange) -> Int32 {
  self.size
}

///|
pub fn NetprotowsRange::get(self : NetprotowsRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsRange::set(
  self : NetprotowsRange,
  i : Int32,
  v : Double,
) -> NetprotowsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsRange::sum(self : NetprotowsRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsRange::mean(self : NetprotowsRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsRange::scale(
  self : NetprotowsRange,
  f : Double,
) -> NetprotowsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsRange::add(
  self : NetprotowsRange,
  other : NetprotowsRange,
) -> NetprotowsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsRange::copy(self : NetprotowsRange) -> NetprotowsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsRange::fill(
  self : NetprotowsRange,
  v : Double,
) -> NetprotowsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsRange::min(self : NetprotowsRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsRange::max(self : NetprotowsRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsRange::to_string(self : NetprotowsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotowsSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_ws_slice_make(size : Int32) -> NetprotowsSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotowsSlice::len(self : NetprotowsSlice) -> Int32 {
  self.size
}

///|
pub fn NetprotowsSlice::get(self : NetprotowsSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotowsSlice::set(
  self : NetprotowsSlice,
  i : Int32,
  v : Double,
) -> NetprotowsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsSlice::sum(self : NetprotowsSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotowsSlice::mean(self : NetprotowsSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotowsSlice::scale(
  self : NetprotowsSlice,
  f : Double,
) -> NetprotowsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsSlice::add(
  self : NetprotowsSlice,
  other : NetprotowsSlice,
) -> NetprotowsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotowsSlice::copy(self : NetprotowsSlice) -> NetprotowsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsSlice::fill(
  self : NetprotowsSlice,
  v : Double,
) -> NetprotowsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotowsSlice::min(self : NetprotowsSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotowsSlice::max(self : NetprotowsSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotowsSlice::to_string(self : NetprotowsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
///===
/// extcore/net_proto_grpc
pub(all) struct NetprotogrpcPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_proto_grpc_make_point(x : Double, y : Double) -> NetprotogrpcPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_proto_grpc_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetprotogrpcPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetprotogrpcPoint::x(self : NetprotogrpcPoint) -> Double {
  self.x
}

///|
pub fn NetprotogrpcPoint::y(self : NetprotogrpcPoint) -> Double {
  self.y
}

///|
pub fn NetprotogrpcPoint::z(self : NetprotogrpcPoint) -> Double {
  self.z
}

///|
pub fn NetprotogrpcPoint::label(self : NetprotogrpcPoint) -> Int32 {
  self.label
}

///|
pub fn NetprotogrpcPoint::dist(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetprotogrpcPoint::add(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> NetprotogrpcPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetprotogrpcPoint::sub(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> NetprotogrpcPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetprotogrpcPoint::scale(
  self : NetprotogrpcPoint,
  s : Double,
) -> NetprotogrpcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetprotogrpcPoint::dot(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetprotogrpcPoint::cross(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> NetprotogrpcPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetprotogrpcPoint::norm(self : NetprotogrpcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetprotogrpcPoint::normalize(
  self : NetprotogrpcPoint,
) -> NetprotogrpcPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotogrpcPoint::negate(self : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetprotogrpcPoint::mid(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
) -> NetprotogrpcPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetprotogrpcPoint::lerp(
  self : NetprotogrpcPoint,
  other : NetprotogrpcPoint,
  t : Double,
) -> NetprotogrpcPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetprotogrpcPoint::to_string(self : NetprotogrpcPoint) -> String {
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
pub(all) struct NetprotogrpcSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_proto_grpc_make_series(
  vals : Array[Double],
  name : String,
) -> NetprotogrpcSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetprotogrpcSeries::len(self : NetprotogrpcSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetprotogrpcSeries::sum(self : NetprotogrpcSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetprotogrpcSeries::mean(self : NetprotogrpcSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetprotogrpcSeries::min(self : NetprotogrpcSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetprotogrpcSeries::max(self : NetprotogrpcSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetprotogrpcSeries::range(self : NetprotogrpcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetprotogrpcSeries::variance(self : NetprotogrpcSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetprotogrpcSeries::std(self : NetprotogrpcSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetprotogrpcSeries::median(self : NetprotogrpcSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetprotogrpcSeries::scale(
  self : NetprotogrpcSeries,
  f : Double,
) -> NetprotogrpcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetprotogrpcSeries::add(
  self : NetprotogrpcSeries,
  other : NetprotogrpcSeries,
) -> NetprotogrpcSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotogrpcSeries::sub(
  self : NetprotogrpcSeries,
  other : NetprotogrpcSeries,
) -> NetprotogrpcSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotogrpcSeries::normalize(
  self : NetprotogrpcSeries,
) -> NetprotogrpcSeries {
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
pub fn NetprotogrpcSeries::cumsum(
  self : NetprotogrpcSeries,
) -> NetprotogrpcSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetprotogrpcSeries::to_string(self : NetprotogrpcSeries) -> String {
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
pub(all) struct NetprotogrpcMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_proto_grpc_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetprotogrpcMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_proto_grpc_matrix_identity(n : Int32) -> NetprotogrpcMatrix {
  let m = net_proto_grpc_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetprotogrpcMatrix::get(
  self : NetprotogrpcMatrix,
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
pub fn NetprotogrpcMatrix::transpose(
  self : NetprotogrpcMatrix,
) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotogrpcMatrix::add(
  self : NetprotogrpcMatrix,
  other : NetprotogrpcMatrix,
) -> NetprotogrpcMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_proto_grpc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotogrpcMatrix::scale(
  self : NetprotogrpcMatrix,
  s : Double,
) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetprotogrpcMatrix::multiply(
  self : NetprotogrpcMatrix,
  other : NetprotogrpcMatrix,
) -> NetprotogrpcMatrix {
  if self.cols != other.rows {
    return net_proto_grpc_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_proto_grpc_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetprotogrpcMatrix::trace(self : NetprotogrpcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetprotogrpcMatrix::det(self : NetprotogrpcMatrix) -> Double {
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
pub fn NetprotogrpcMatrix::norm(self : NetprotogrpcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetprotogrpcMatrix::to_string(self : NetprotogrpcMatrix) -> String {
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
pub(all) struct NetprotogrpcVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_proto_grpc_make_vector(comps : Array[Double]) -> NetprotogrpcVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_proto_grpc_vector_zero(dim : Int32) -> NetprotogrpcVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetprotogrpcVector::add(
  self : NetprotogrpcVector,
  other : NetprotogrpcVector,
) -> NetprotogrpcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotogrpcVector::sub(
  self : NetprotogrpcVector,
  other : NetprotogrpcVector,
) -> NetprotogrpcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotogrpcVector::scale(
  self : NetprotogrpcVector,
  s : Double,
) -> NetprotogrpcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetprotogrpcVector::dot(
  self : NetprotogrpcVector,
  other : NetprotogrpcVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetprotogrpcVector::norm(self : NetprotogrpcVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetprotogrpcVector::normalize(
  self : NetprotogrpcVector,
) -> NetprotogrpcVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotogrpcVector::dist(
  self : NetprotogrpcVector,
  other : NetprotogrpcVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetprotogrpcVector::to_string(self : NetprotogrpcVector) -> String {
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
pub(all) struct NetprotogrpcFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_frame_make(size : Int32) -> NetprotogrpcFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcFrame::len(self : NetprotogrpcFrame) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcFrame::get(self : NetprotogrpcFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcFrame::set(
  self : NetprotogrpcFrame,
  i : Int32,
  v : Double,
) -> NetprotogrpcFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcFrame::sum(self : NetprotogrpcFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcFrame::mean(self : NetprotogrpcFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcFrame::scale(
  self : NetprotogrpcFrame,
  f : Double,
) -> NetprotogrpcFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcFrame::add(
  self : NetprotogrpcFrame,
  other : NetprotogrpcFrame,
) -> NetprotogrpcFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcFrame::copy(self : NetprotogrpcFrame) -> NetprotogrpcFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcFrame::fill(
  self : NetprotogrpcFrame,
  v : Double,
) -> NetprotogrpcFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcFrame::min(self : NetprotogrpcFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcFrame::max(self : NetprotogrpcFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcFrame::to_string(self : NetprotogrpcFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_table_make(size : Int32) -> NetprotogrpcTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcTable::len(self : NetprotogrpcTable) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcTable::get(self : NetprotogrpcTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcTable::set(
  self : NetprotogrpcTable,
  i : Int32,
  v : Double,
) -> NetprotogrpcTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcTable::sum(self : NetprotogrpcTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcTable::mean(self : NetprotogrpcTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcTable::scale(
  self : NetprotogrpcTable,
  f : Double,
) -> NetprotogrpcTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcTable::add(
  self : NetprotogrpcTable,
  other : NetprotogrpcTable,
) -> NetprotogrpcTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcTable::copy(self : NetprotogrpcTable) -> NetprotogrpcTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcTable::fill(
  self : NetprotogrpcTable,
  v : Double,
) -> NetprotogrpcTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcTable::min(self : NetprotogrpcTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcTable::max(self : NetprotogrpcTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcTable::to_string(self : NetprotogrpcTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_graphn_make(size : Int32) -> NetprotogrpcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcGraphN::len(self : NetprotogrpcGraphN) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcGraphN::get(self : NetprotogrpcGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcGraphN::set(
  self : NetprotogrpcGraphN,
  i : Int32,
  v : Double,
) -> NetprotogrpcGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcGraphN::sum(self : NetprotogrpcGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcGraphN::mean(self : NetprotogrpcGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcGraphN::scale(
  self : NetprotogrpcGraphN,
  f : Double,
) -> NetprotogrpcGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcGraphN::add(
  self : NetprotogrpcGraphN,
  other : NetprotogrpcGraphN,
) -> NetprotogrpcGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcGraphN::copy(
  self : NetprotogrpcGraphN,
) -> NetprotogrpcGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcGraphN::fill(
  self : NetprotogrpcGraphN,
  v : Double,
) -> NetprotogrpcGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcGraphN::min(self : NetprotogrpcGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcGraphN::max(self : NetprotogrpcGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcGraphN::to_string(self : NetprotogrpcGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_node_make(size : Int32) -> NetprotogrpcNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcNode::len(self : NetprotogrpcNode) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcNode::get(self : NetprotogrpcNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcNode::set(
  self : NetprotogrpcNode,
  i : Int32,
  v : Double,
) -> NetprotogrpcNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcNode::sum(self : NetprotogrpcNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcNode::mean(self : NetprotogrpcNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcNode::scale(
  self : NetprotogrpcNode,
  f : Double,
) -> NetprotogrpcNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcNode::add(
  self : NetprotogrpcNode,
  other : NetprotogrpcNode,
) -> NetprotogrpcNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcNode::copy(self : NetprotogrpcNode) -> NetprotogrpcNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcNode::fill(
  self : NetprotogrpcNode,
  v : Double,
) -> NetprotogrpcNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcNode::min(self : NetprotogrpcNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcNode::max(self : NetprotogrpcNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcNode::to_string(self : NetprotogrpcNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_edge_make(size : Int32) -> NetprotogrpcEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcEdge::len(self : NetprotogrpcEdge) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcEdge::get(self : NetprotogrpcEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcEdge::set(
  self : NetprotogrpcEdge,
  i : Int32,
  v : Double,
) -> NetprotogrpcEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcEdge::sum(self : NetprotogrpcEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcEdge::mean(self : NetprotogrpcEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcEdge::scale(
  self : NetprotogrpcEdge,
  f : Double,
) -> NetprotogrpcEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcEdge::add(
  self : NetprotogrpcEdge,
  other : NetprotogrpcEdge,
) -> NetprotogrpcEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcEdge::copy(self : NetprotogrpcEdge) -> NetprotogrpcEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcEdge::fill(
  self : NetprotogrpcEdge,
  v : Double,
) -> NetprotogrpcEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcEdge::min(self : NetprotogrpcEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcEdge::max(self : NetprotogrpcEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcEdge::to_string(self : NetprotogrpcEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_path_make(size : Int32) -> NetprotogrpcPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcPath::len(self : NetprotogrpcPath) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcPath::get(self : NetprotogrpcPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcPath::set(
  self : NetprotogrpcPath,
  i : Int32,
  v : Double,
) -> NetprotogrpcPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcPath::sum(self : NetprotogrpcPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcPath::mean(self : NetprotogrpcPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcPath::scale(
  self : NetprotogrpcPath,
  f : Double,
) -> NetprotogrpcPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcPath::add(
  self : NetprotogrpcPath,
  other : NetprotogrpcPath,
) -> NetprotogrpcPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcPath::copy(self : NetprotogrpcPath) -> NetprotogrpcPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcPath::fill(
  self : NetprotogrpcPath,
  v : Double,
) -> NetprotogrpcPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcPath::min(self : NetprotogrpcPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcPath::max(self : NetprotogrpcPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcPath::to_string(self : NetprotogrpcPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_cluster_make(size : Int32) -> NetprotogrpcCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcCluster::len(self : NetprotogrpcCluster) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcCluster::get(
  self : NetprotogrpcCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcCluster::set(
  self : NetprotogrpcCluster,
  i : Int32,
  v : Double,
) -> NetprotogrpcCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCluster::sum(self : NetprotogrpcCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcCluster::mean(self : NetprotogrpcCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcCluster::scale(
  self : NetprotogrpcCluster,
  f : Double,
) -> NetprotogrpcCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCluster::add(
  self : NetprotogrpcCluster,
  other : NetprotogrpcCluster,
) -> NetprotogrpcCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcCluster::copy(
  self : NetprotogrpcCluster,
) -> NetprotogrpcCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCluster::fill(
  self : NetprotogrpcCluster,
  v : Double,
) -> NetprotogrpcCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCluster::min(self : NetprotogrpcCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcCluster::max(self : NetprotogrpcCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcCluster::to_string(self : NetprotogrpcCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_model_make(size : Int32) -> NetprotogrpcModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcModel::len(self : NetprotogrpcModel) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcModel::get(self : NetprotogrpcModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcModel::set(
  self : NetprotogrpcModel,
  i : Int32,
  v : Double,
) -> NetprotogrpcModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcModel::sum(self : NetprotogrpcModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcModel::mean(self : NetprotogrpcModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcModel::scale(
  self : NetprotogrpcModel,
  f : Double,
) -> NetprotogrpcModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcModel::add(
  self : NetprotogrpcModel,
  other : NetprotogrpcModel,
) -> NetprotogrpcModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcModel::copy(self : NetprotogrpcModel) -> NetprotogrpcModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcModel::fill(
  self : NetprotogrpcModel,
  v : Double,
) -> NetprotogrpcModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcModel::min(self : NetprotogrpcModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcModel::max(self : NetprotogrpcModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcModel::to_string(self : NetprotogrpcModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_layer_make(size : Int32) -> NetprotogrpcLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcLayer::len(self : NetprotogrpcLayer) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcLayer::get(self : NetprotogrpcLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcLayer::set(
  self : NetprotogrpcLayer,
  i : Int32,
  v : Double,
) -> NetprotogrpcLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcLayer::sum(self : NetprotogrpcLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcLayer::mean(self : NetprotogrpcLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcLayer::scale(
  self : NetprotogrpcLayer,
  f : Double,
) -> NetprotogrpcLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcLayer::add(
  self : NetprotogrpcLayer,
  other : NetprotogrpcLayer,
) -> NetprotogrpcLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcLayer::copy(self : NetprotogrpcLayer) -> NetprotogrpcLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcLayer::fill(
  self : NetprotogrpcLayer,
  v : Double,
) -> NetprotogrpcLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcLayer::min(self : NetprotogrpcLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcLayer::max(self : NetprotogrpcLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcLayer::to_string(self : NetprotogrpcLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_buffer_make(size : Int32) -> NetprotogrpcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcBuffer::len(self : NetprotogrpcBuffer) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcBuffer::get(self : NetprotogrpcBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcBuffer::set(
  self : NetprotogrpcBuffer,
  i : Int32,
  v : Double,
) -> NetprotogrpcBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcBuffer::sum(self : NetprotogrpcBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcBuffer::mean(self : NetprotogrpcBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcBuffer::scale(
  self : NetprotogrpcBuffer,
  f : Double,
) -> NetprotogrpcBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcBuffer::add(
  self : NetprotogrpcBuffer,
  other : NetprotogrpcBuffer,
) -> NetprotogrpcBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcBuffer::copy(
  self : NetprotogrpcBuffer,
) -> NetprotogrpcBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcBuffer::fill(
  self : NetprotogrpcBuffer,
  v : Double,
) -> NetprotogrpcBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcBuffer::min(self : NetprotogrpcBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcBuffer::max(self : NetprotogrpcBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcBuffer::to_string(self : NetprotogrpcBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_cursor_make(size : Int32) -> NetprotogrpcCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcCursor::len(self : NetprotogrpcCursor) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcCursor::get(self : NetprotogrpcCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcCursor::set(
  self : NetprotogrpcCursor,
  i : Int32,
  v : Double,
) -> NetprotogrpcCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCursor::sum(self : NetprotogrpcCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcCursor::mean(self : NetprotogrpcCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcCursor::scale(
  self : NetprotogrpcCursor,
  f : Double,
) -> NetprotogrpcCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCursor::add(
  self : NetprotogrpcCursor,
  other : NetprotogrpcCursor,
) -> NetprotogrpcCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcCursor::copy(
  self : NetprotogrpcCursor,
) -> NetprotogrpcCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCursor::fill(
  self : NetprotogrpcCursor,
  v : Double,
) -> NetprotogrpcCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcCursor::min(self : NetprotogrpcCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcCursor::max(self : NetprotogrpcCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcCursor::to_string(self : NetprotogrpcCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_view_make(size : Int32) -> NetprotogrpcView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcView::len(self : NetprotogrpcView) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcView::get(self : NetprotogrpcView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcView::set(
  self : NetprotogrpcView,
  i : Int32,
  v : Double,
) -> NetprotogrpcView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcView::sum(self : NetprotogrpcView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcView::mean(self : NetprotogrpcView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcView::scale(
  self : NetprotogrpcView,
  f : Double,
) -> NetprotogrpcView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcView::add(
  self : NetprotogrpcView,
  other : NetprotogrpcView,
) -> NetprotogrpcView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcView::copy(self : NetprotogrpcView) -> NetprotogrpcView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcView::fill(
  self : NetprotogrpcView,
  v : Double,
) -> NetprotogrpcView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcView::min(self : NetprotogrpcView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcView::max(self : NetprotogrpcView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcView::to_string(self : NetprotogrpcView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_range_make(size : Int32) -> NetprotogrpcRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcRange::len(self : NetprotogrpcRange) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcRange::get(self : NetprotogrpcRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcRange::set(
  self : NetprotogrpcRange,
  i : Int32,
  v : Double,
) -> NetprotogrpcRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcRange::sum(self : NetprotogrpcRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcRange::mean(self : NetprotogrpcRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcRange::scale(
  self : NetprotogrpcRange,
  f : Double,
) -> NetprotogrpcRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcRange::add(
  self : NetprotogrpcRange,
  other : NetprotogrpcRange,
) -> NetprotogrpcRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcRange::copy(self : NetprotogrpcRange) -> NetprotogrpcRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcRange::fill(
  self : NetprotogrpcRange,
  v : Double,
) -> NetprotogrpcRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcRange::min(self : NetprotogrpcRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcRange::max(self : NetprotogrpcRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcRange::to_string(self : NetprotogrpcRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotogrpcSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_grpc_slice_make(size : Int32) -> NetprotogrpcSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotogrpcSlice::len(self : NetprotogrpcSlice) -> Int32 {
  self.size
}

///|
pub fn NetprotogrpcSlice::get(self : NetprotogrpcSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotogrpcSlice::set(
  self : NetprotogrpcSlice,
  i : Int32,
  v : Double,
) -> NetprotogrpcSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcSlice::sum(self : NetprotogrpcSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotogrpcSlice::mean(self : NetprotogrpcSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotogrpcSlice::scale(
  self : NetprotogrpcSlice,
  f : Double,
) -> NetprotogrpcSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcSlice::add(
  self : NetprotogrpcSlice,
  other : NetprotogrpcSlice,
) -> NetprotogrpcSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotogrpcSlice::copy(self : NetprotogrpcSlice) -> NetprotogrpcSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcSlice::fill(
  self : NetprotogrpcSlice,
  v : Double,
) -> NetprotogrpcSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotogrpcSlice::min(self : NetprotogrpcSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotogrpcSlice::max(self : NetprotogrpcSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotogrpcSlice::to_string(self : NetprotogrpcSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

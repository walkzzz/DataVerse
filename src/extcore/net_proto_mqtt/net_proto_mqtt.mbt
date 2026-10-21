///|
///===
/// extcore/net_proto_mqtt
pub(all) struct NetprotomqttPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_proto_mqtt_make_point(x : Double, y : Double) -> NetprotomqttPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_proto_mqtt_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetprotomqttPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetprotomqttPoint::x(self : NetprotomqttPoint) -> Double {
  self.x
}

///|
pub fn NetprotomqttPoint::y(self : NetprotomqttPoint) -> Double {
  self.y
}

///|
pub fn NetprotomqttPoint::z(self : NetprotomqttPoint) -> Double {
  self.z
}

///|
pub fn NetprotomqttPoint::label(self : NetprotomqttPoint) -> Int32 {
  self.label
}

///|
pub fn NetprotomqttPoint::dist(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetprotomqttPoint::add(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> NetprotomqttPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetprotomqttPoint::sub(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> NetprotomqttPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetprotomqttPoint::scale(
  self : NetprotomqttPoint,
  s : Double,
) -> NetprotomqttPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetprotomqttPoint::dot(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetprotomqttPoint::cross(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> NetprotomqttPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetprotomqttPoint::norm(self : NetprotomqttPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetprotomqttPoint::normalize(
  self : NetprotomqttPoint,
) -> NetprotomqttPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotomqttPoint::negate(self : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetprotomqttPoint::mid(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
) -> NetprotomqttPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetprotomqttPoint::lerp(
  self : NetprotomqttPoint,
  other : NetprotomqttPoint,
  t : Double,
) -> NetprotomqttPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetprotomqttPoint::to_string(self : NetprotomqttPoint) -> String {
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
pub(all) struct NetprotomqttSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_proto_mqtt_make_series(
  vals : Array[Double],
  name : String,
) -> NetprotomqttSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetprotomqttSeries::len(self : NetprotomqttSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetprotomqttSeries::sum(self : NetprotomqttSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetprotomqttSeries::mean(self : NetprotomqttSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetprotomqttSeries::min(self : NetprotomqttSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetprotomqttSeries::max(self : NetprotomqttSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetprotomqttSeries::range(self : NetprotomqttSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetprotomqttSeries::variance(self : NetprotomqttSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetprotomqttSeries::std(self : NetprotomqttSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetprotomqttSeries::median(self : NetprotomqttSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetprotomqttSeries::scale(
  self : NetprotomqttSeries,
  f : Double,
) -> NetprotomqttSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetprotomqttSeries::add(
  self : NetprotomqttSeries,
  other : NetprotomqttSeries,
) -> NetprotomqttSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotomqttSeries::sub(
  self : NetprotomqttSeries,
  other : NetprotomqttSeries,
) -> NetprotomqttSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotomqttSeries::normalize(
  self : NetprotomqttSeries,
) -> NetprotomqttSeries {
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
pub fn NetprotomqttSeries::cumsum(
  self : NetprotomqttSeries,
) -> NetprotomqttSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetprotomqttSeries::to_string(self : NetprotomqttSeries) -> String {
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
pub(all) struct NetprotomqttMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_proto_mqtt_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetprotomqttMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_proto_mqtt_matrix_identity(n : Int32) -> NetprotomqttMatrix {
  let m = net_proto_mqtt_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetprotomqttMatrix::get(
  self : NetprotomqttMatrix,
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
pub fn NetprotomqttMatrix::transpose(
  self : NetprotomqttMatrix,
) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotomqttMatrix::add(
  self : NetprotomqttMatrix,
  other : NetprotomqttMatrix,
) -> NetprotomqttMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_proto_mqtt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotomqttMatrix::scale(
  self : NetprotomqttMatrix,
  s : Double,
) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetprotomqttMatrix::multiply(
  self : NetprotomqttMatrix,
  other : NetprotomqttMatrix,
) -> NetprotomqttMatrix {
  if self.cols != other.rows {
    return net_proto_mqtt_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_proto_mqtt_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetprotomqttMatrix::trace(self : NetprotomqttMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetprotomqttMatrix::det(self : NetprotomqttMatrix) -> Double {
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
pub fn NetprotomqttMatrix::norm(self : NetprotomqttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetprotomqttMatrix::to_string(self : NetprotomqttMatrix) -> String {
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
pub(all) struct NetprotomqttVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_proto_mqtt_make_vector(comps : Array[Double]) -> NetprotomqttVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_proto_mqtt_vector_zero(dim : Int32) -> NetprotomqttVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetprotomqttVector::add(
  self : NetprotomqttVector,
  other : NetprotomqttVector,
) -> NetprotomqttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotomqttVector::sub(
  self : NetprotomqttVector,
  other : NetprotomqttVector,
) -> NetprotomqttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotomqttVector::scale(
  self : NetprotomqttVector,
  s : Double,
) -> NetprotomqttVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetprotomqttVector::dot(
  self : NetprotomqttVector,
  other : NetprotomqttVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetprotomqttVector::norm(self : NetprotomqttVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetprotomqttVector::normalize(
  self : NetprotomqttVector,
) -> NetprotomqttVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotomqttVector::dist(
  self : NetprotomqttVector,
  other : NetprotomqttVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetprotomqttVector::to_string(self : NetprotomqttVector) -> String {
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
pub(all) struct NetprotomqttFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_frame_make(size : Int32) -> NetprotomqttFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttFrame::len(self : NetprotomqttFrame) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttFrame::get(self : NetprotomqttFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttFrame::set(
  self : NetprotomqttFrame,
  i : Int32,
  v : Double,
) -> NetprotomqttFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttFrame::sum(self : NetprotomqttFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttFrame::mean(self : NetprotomqttFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttFrame::scale(
  self : NetprotomqttFrame,
  f : Double,
) -> NetprotomqttFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttFrame::add(
  self : NetprotomqttFrame,
  other : NetprotomqttFrame,
) -> NetprotomqttFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttFrame::copy(self : NetprotomqttFrame) -> NetprotomqttFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttFrame::fill(
  self : NetprotomqttFrame,
  v : Double,
) -> NetprotomqttFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttFrame::min(self : NetprotomqttFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttFrame::max(self : NetprotomqttFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttFrame::to_string(self : NetprotomqttFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_table_make(size : Int32) -> NetprotomqttTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttTable::len(self : NetprotomqttTable) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttTable::get(self : NetprotomqttTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttTable::set(
  self : NetprotomqttTable,
  i : Int32,
  v : Double,
) -> NetprotomqttTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttTable::sum(self : NetprotomqttTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttTable::mean(self : NetprotomqttTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttTable::scale(
  self : NetprotomqttTable,
  f : Double,
) -> NetprotomqttTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttTable::add(
  self : NetprotomqttTable,
  other : NetprotomqttTable,
) -> NetprotomqttTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttTable::copy(self : NetprotomqttTable) -> NetprotomqttTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttTable::fill(
  self : NetprotomqttTable,
  v : Double,
) -> NetprotomqttTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttTable::min(self : NetprotomqttTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttTable::max(self : NetprotomqttTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttTable::to_string(self : NetprotomqttTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_graphn_make(size : Int32) -> NetprotomqttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttGraphN::len(self : NetprotomqttGraphN) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttGraphN::get(self : NetprotomqttGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttGraphN::set(
  self : NetprotomqttGraphN,
  i : Int32,
  v : Double,
) -> NetprotomqttGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttGraphN::sum(self : NetprotomqttGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttGraphN::mean(self : NetprotomqttGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttGraphN::scale(
  self : NetprotomqttGraphN,
  f : Double,
) -> NetprotomqttGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttGraphN::add(
  self : NetprotomqttGraphN,
  other : NetprotomqttGraphN,
) -> NetprotomqttGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttGraphN::copy(
  self : NetprotomqttGraphN,
) -> NetprotomqttGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttGraphN::fill(
  self : NetprotomqttGraphN,
  v : Double,
) -> NetprotomqttGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttGraphN::min(self : NetprotomqttGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttGraphN::max(self : NetprotomqttGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttGraphN::to_string(self : NetprotomqttGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_node_make(size : Int32) -> NetprotomqttNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttNode::len(self : NetprotomqttNode) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttNode::get(self : NetprotomqttNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttNode::set(
  self : NetprotomqttNode,
  i : Int32,
  v : Double,
) -> NetprotomqttNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttNode::sum(self : NetprotomqttNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttNode::mean(self : NetprotomqttNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttNode::scale(
  self : NetprotomqttNode,
  f : Double,
) -> NetprotomqttNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttNode::add(
  self : NetprotomqttNode,
  other : NetprotomqttNode,
) -> NetprotomqttNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttNode::copy(self : NetprotomqttNode) -> NetprotomqttNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttNode::fill(
  self : NetprotomqttNode,
  v : Double,
) -> NetprotomqttNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttNode::min(self : NetprotomqttNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttNode::max(self : NetprotomqttNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttNode::to_string(self : NetprotomqttNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_edge_make(size : Int32) -> NetprotomqttEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttEdge::len(self : NetprotomqttEdge) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttEdge::get(self : NetprotomqttEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttEdge::set(
  self : NetprotomqttEdge,
  i : Int32,
  v : Double,
) -> NetprotomqttEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttEdge::sum(self : NetprotomqttEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttEdge::mean(self : NetprotomqttEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttEdge::scale(
  self : NetprotomqttEdge,
  f : Double,
) -> NetprotomqttEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttEdge::add(
  self : NetprotomqttEdge,
  other : NetprotomqttEdge,
) -> NetprotomqttEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttEdge::copy(self : NetprotomqttEdge) -> NetprotomqttEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttEdge::fill(
  self : NetprotomqttEdge,
  v : Double,
) -> NetprotomqttEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttEdge::min(self : NetprotomqttEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttEdge::max(self : NetprotomqttEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttEdge::to_string(self : NetprotomqttEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_path_make(size : Int32) -> NetprotomqttPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttPath::len(self : NetprotomqttPath) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttPath::get(self : NetprotomqttPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttPath::set(
  self : NetprotomqttPath,
  i : Int32,
  v : Double,
) -> NetprotomqttPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttPath::sum(self : NetprotomqttPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttPath::mean(self : NetprotomqttPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttPath::scale(
  self : NetprotomqttPath,
  f : Double,
) -> NetprotomqttPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttPath::add(
  self : NetprotomqttPath,
  other : NetprotomqttPath,
) -> NetprotomqttPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttPath::copy(self : NetprotomqttPath) -> NetprotomqttPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttPath::fill(
  self : NetprotomqttPath,
  v : Double,
) -> NetprotomqttPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttPath::min(self : NetprotomqttPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttPath::max(self : NetprotomqttPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttPath::to_string(self : NetprotomqttPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_cluster_make(size : Int32) -> NetprotomqttCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttCluster::len(self : NetprotomqttCluster) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttCluster::get(
  self : NetprotomqttCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttCluster::set(
  self : NetprotomqttCluster,
  i : Int32,
  v : Double,
) -> NetprotomqttCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCluster::sum(self : NetprotomqttCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttCluster::mean(self : NetprotomqttCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttCluster::scale(
  self : NetprotomqttCluster,
  f : Double,
) -> NetprotomqttCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCluster::add(
  self : NetprotomqttCluster,
  other : NetprotomqttCluster,
) -> NetprotomqttCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttCluster::copy(
  self : NetprotomqttCluster,
) -> NetprotomqttCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCluster::fill(
  self : NetprotomqttCluster,
  v : Double,
) -> NetprotomqttCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCluster::min(self : NetprotomqttCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttCluster::max(self : NetprotomqttCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttCluster::to_string(self : NetprotomqttCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_model_make(size : Int32) -> NetprotomqttModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttModel::len(self : NetprotomqttModel) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttModel::get(self : NetprotomqttModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttModel::set(
  self : NetprotomqttModel,
  i : Int32,
  v : Double,
) -> NetprotomqttModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttModel::sum(self : NetprotomqttModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttModel::mean(self : NetprotomqttModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttModel::scale(
  self : NetprotomqttModel,
  f : Double,
) -> NetprotomqttModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttModel::add(
  self : NetprotomqttModel,
  other : NetprotomqttModel,
) -> NetprotomqttModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttModel::copy(self : NetprotomqttModel) -> NetprotomqttModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttModel::fill(
  self : NetprotomqttModel,
  v : Double,
) -> NetprotomqttModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttModel::min(self : NetprotomqttModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttModel::max(self : NetprotomqttModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttModel::to_string(self : NetprotomqttModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_layer_make(size : Int32) -> NetprotomqttLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttLayer::len(self : NetprotomqttLayer) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttLayer::get(self : NetprotomqttLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttLayer::set(
  self : NetprotomqttLayer,
  i : Int32,
  v : Double,
) -> NetprotomqttLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttLayer::sum(self : NetprotomqttLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttLayer::mean(self : NetprotomqttLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttLayer::scale(
  self : NetprotomqttLayer,
  f : Double,
) -> NetprotomqttLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttLayer::add(
  self : NetprotomqttLayer,
  other : NetprotomqttLayer,
) -> NetprotomqttLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttLayer::copy(self : NetprotomqttLayer) -> NetprotomqttLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttLayer::fill(
  self : NetprotomqttLayer,
  v : Double,
) -> NetprotomqttLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttLayer::min(self : NetprotomqttLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttLayer::max(self : NetprotomqttLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttLayer::to_string(self : NetprotomqttLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_buffer_make(size : Int32) -> NetprotomqttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttBuffer::len(self : NetprotomqttBuffer) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttBuffer::get(self : NetprotomqttBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttBuffer::set(
  self : NetprotomqttBuffer,
  i : Int32,
  v : Double,
) -> NetprotomqttBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttBuffer::sum(self : NetprotomqttBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttBuffer::mean(self : NetprotomqttBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttBuffer::scale(
  self : NetprotomqttBuffer,
  f : Double,
) -> NetprotomqttBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttBuffer::add(
  self : NetprotomqttBuffer,
  other : NetprotomqttBuffer,
) -> NetprotomqttBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttBuffer::copy(
  self : NetprotomqttBuffer,
) -> NetprotomqttBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttBuffer::fill(
  self : NetprotomqttBuffer,
  v : Double,
) -> NetprotomqttBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttBuffer::min(self : NetprotomqttBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttBuffer::max(self : NetprotomqttBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttBuffer::to_string(self : NetprotomqttBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_cursor_make(size : Int32) -> NetprotomqttCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttCursor::len(self : NetprotomqttCursor) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttCursor::get(self : NetprotomqttCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttCursor::set(
  self : NetprotomqttCursor,
  i : Int32,
  v : Double,
) -> NetprotomqttCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCursor::sum(self : NetprotomqttCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttCursor::mean(self : NetprotomqttCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttCursor::scale(
  self : NetprotomqttCursor,
  f : Double,
) -> NetprotomqttCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCursor::add(
  self : NetprotomqttCursor,
  other : NetprotomqttCursor,
) -> NetprotomqttCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttCursor::copy(
  self : NetprotomqttCursor,
) -> NetprotomqttCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCursor::fill(
  self : NetprotomqttCursor,
  v : Double,
) -> NetprotomqttCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttCursor::min(self : NetprotomqttCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttCursor::max(self : NetprotomqttCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttCursor::to_string(self : NetprotomqttCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_view_make(size : Int32) -> NetprotomqttView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttView::len(self : NetprotomqttView) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttView::get(self : NetprotomqttView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttView::set(
  self : NetprotomqttView,
  i : Int32,
  v : Double,
) -> NetprotomqttView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttView::sum(self : NetprotomqttView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttView::mean(self : NetprotomqttView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttView::scale(
  self : NetprotomqttView,
  f : Double,
) -> NetprotomqttView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttView::add(
  self : NetprotomqttView,
  other : NetprotomqttView,
) -> NetprotomqttView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttView::copy(self : NetprotomqttView) -> NetprotomqttView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttView::fill(
  self : NetprotomqttView,
  v : Double,
) -> NetprotomqttView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttView::min(self : NetprotomqttView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttView::max(self : NetprotomqttView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttView::to_string(self : NetprotomqttView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_range_make(size : Int32) -> NetprotomqttRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttRange::len(self : NetprotomqttRange) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttRange::get(self : NetprotomqttRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttRange::set(
  self : NetprotomqttRange,
  i : Int32,
  v : Double,
) -> NetprotomqttRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttRange::sum(self : NetprotomqttRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttRange::mean(self : NetprotomqttRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttRange::scale(
  self : NetprotomqttRange,
  f : Double,
) -> NetprotomqttRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttRange::add(
  self : NetprotomqttRange,
  other : NetprotomqttRange,
) -> NetprotomqttRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttRange::copy(self : NetprotomqttRange) -> NetprotomqttRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttRange::fill(
  self : NetprotomqttRange,
  v : Double,
) -> NetprotomqttRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttRange::min(self : NetprotomqttRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttRange::max(self : NetprotomqttRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttRange::to_string(self : NetprotomqttRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotomqttSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_mqtt_slice_make(size : Int32) -> NetprotomqttSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotomqttSlice::len(self : NetprotomqttSlice) -> Int32 {
  self.size
}

///|
pub fn NetprotomqttSlice::get(self : NetprotomqttSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotomqttSlice::set(
  self : NetprotomqttSlice,
  i : Int32,
  v : Double,
) -> NetprotomqttSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttSlice::sum(self : NetprotomqttSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotomqttSlice::mean(self : NetprotomqttSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotomqttSlice::scale(
  self : NetprotomqttSlice,
  f : Double,
) -> NetprotomqttSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttSlice::add(
  self : NetprotomqttSlice,
  other : NetprotomqttSlice,
) -> NetprotomqttSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotomqttSlice::copy(self : NetprotomqttSlice) -> NetprotomqttSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttSlice::fill(
  self : NetprotomqttSlice,
  v : Double,
) -> NetprotomqttSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotomqttSlice::min(self : NetprotomqttSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotomqttSlice::max(self : NetprotomqttSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotomqttSlice::to_string(self : NetprotomqttSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

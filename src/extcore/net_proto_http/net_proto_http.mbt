///|
///===
/// extcore/net_proto_http
pub(all) struct NetprotohttpPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_proto_http_make_point(x : Double, y : Double) -> NetprotohttpPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_proto_http_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetprotohttpPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetprotohttpPoint::x(self : NetprotohttpPoint) -> Double {
  self.x
}

///|
pub fn NetprotohttpPoint::y(self : NetprotohttpPoint) -> Double {
  self.y
}

///|
pub fn NetprotohttpPoint::z(self : NetprotohttpPoint) -> Double {
  self.z
}

///|
pub fn NetprotohttpPoint::label(self : NetprotohttpPoint) -> Int32 {
  self.label
}

///|
pub fn NetprotohttpPoint::dist(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetprotohttpPoint::add(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> NetprotohttpPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetprotohttpPoint::sub(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> NetprotohttpPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetprotohttpPoint::scale(
  self : NetprotohttpPoint,
  s : Double,
) -> NetprotohttpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetprotohttpPoint::dot(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetprotohttpPoint::cross(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> NetprotohttpPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetprotohttpPoint::norm(self : NetprotohttpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetprotohttpPoint::normalize(
  self : NetprotohttpPoint,
) -> NetprotohttpPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotohttpPoint::negate(self : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetprotohttpPoint::mid(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
) -> NetprotohttpPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetprotohttpPoint::lerp(
  self : NetprotohttpPoint,
  other : NetprotohttpPoint,
  t : Double,
) -> NetprotohttpPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetprotohttpPoint::to_string(self : NetprotohttpPoint) -> String {
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
pub(all) struct NetprotohttpSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_proto_http_make_series(
  vals : Array[Double],
  name : String,
) -> NetprotohttpSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetprotohttpSeries::len(self : NetprotohttpSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetprotohttpSeries::sum(self : NetprotohttpSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetprotohttpSeries::mean(self : NetprotohttpSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetprotohttpSeries::min(self : NetprotohttpSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetprotohttpSeries::max(self : NetprotohttpSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetprotohttpSeries::range(self : NetprotohttpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetprotohttpSeries::variance(self : NetprotohttpSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetprotohttpSeries::std(self : NetprotohttpSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetprotohttpSeries::median(self : NetprotohttpSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetprotohttpSeries::scale(
  self : NetprotohttpSeries,
  f : Double,
) -> NetprotohttpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetprotohttpSeries::add(
  self : NetprotohttpSeries,
  other : NetprotohttpSeries,
) -> NetprotohttpSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotohttpSeries::sub(
  self : NetprotohttpSeries,
  other : NetprotohttpSeries,
) -> NetprotohttpSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetprotohttpSeries::normalize(
  self : NetprotohttpSeries,
) -> NetprotohttpSeries {
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
pub fn NetprotohttpSeries::cumsum(
  self : NetprotohttpSeries,
) -> NetprotohttpSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetprotohttpSeries::to_string(self : NetprotohttpSeries) -> String {
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
pub(all) struct NetprotohttpMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_proto_http_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetprotohttpMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_proto_http_matrix_identity(n : Int32) -> NetprotohttpMatrix {
  let m = net_proto_http_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetprotohttpMatrix::get(
  self : NetprotohttpMatrix,
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
pub fn NetprotohttpMatrix::transpose(
  self : NetprotohttpMatrix,
) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotohttpMatrix::add(
  self : NetprotohttpMatrix,
  other : NetprotohttpMatrix,
) -> NetprotohttpMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_proto_http_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetprotohttpMatrix::scale(
  self : NetprotohttpMatrix,
  s : Double,
) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetprotohttpMatrix::multiply(
  self : NetprotohttpMatrix,
  other : NetprotohttpMatrix,
) -> NetprotohttpMatrix {
  if self.cols != other.rows {
    return net_proto_http_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_proto_http_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetprotohttpMatrix::trace(self : NetprotohttpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetprotohttpMatrix::det(self : NetprotohttpMatrix) -> Double {
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
pub fn NetprotohttpMatrix::norm(self : NetprotohttpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetprotohttpMatrix::to_string(self : NetprotohttpMatrix) -> String {
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
pub(all) struct NetprotohttpVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_proto_http_make_vector(comps : Array[Double]) -> NetprotohttpVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_proto_http_vector_zero(dim : Int32) -> NetprotohttpVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetprotohttpVector::add(
  self : NetprotohttpVector,
  other : NetprotohttpVector,
) -> NetprotohttpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotohttpVector::sub(
  self : NetprotohttpVector,
  other : NetprotohttpVector,
) -> NetprotohttpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetprotohttpVector::scale(
  self : NetprotohttpVector,
  s : Double,
) -> NetprotohttpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetprotohttpVector::dot(
  self : NetprotohttpVector,
  other : NetprotohttpVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetprotohttpVector::norm(self : NetprotohttpVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetprotohttpVector::normalize(
  self : NetprotohttpVector,
) -> NetprotohttpVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetprotohttpVector::dist(
  self : NetprotohttpVector,
  other : NetprotohttpVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetprotohttpVector::to_string(self : NetprotohttpVector) -> String {
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
pub(all) struct NetprotohttpFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_frame_make(size : Int32) -> NetprotohttpFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpFrame::len(self : NetprotohttpFrame) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpFrame::get(self : NetprotohttpFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpFrame::set(
  self : NetprotohttpFrame,
  i : Int32,
  v : Double,
) -> NetprotohttpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpFrame::sum(self : NetprotohttpFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpFrame::mean(self : NetprotohttpFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpFrame::scale(
  self : NetprotohttpFrame,
  f : Double,
) -> NetprotohttpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpFrame::add(
  self : NetprotohttpFrame,
  other : NetprotohttpFrame,
) -> NetprotohttpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpFrame::copy(self : NetprotohttpFrame) -> NetprotohttpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpFrame::fill(
  self : NetprotohttpFrame,
  v : Double,
) -> NetprotohttpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpFrame::min(self : NetprotohttpFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpFrame::max(self : NetprotohttpFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpFrame::to_string(self : NetprotohttpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_table_make(size : Int32) -> NetprotohttpTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpTable::len(self : NetprotohttpTable) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpTable::get(self : NetprotohttpTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpTable::set(
  self : NetprotohttpTable,
  i : Int32,
  v : Double,
) -> NetprotohttpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpTable::sum(self : NetprotohttpTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpTable::mean(self : NetprotohttpTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpTable::scale(
  self : NetprotohttpTable,
  f : Double,
) -> NetprotohttpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpTable::add(
  self : NetprotohttpTable,
  other : NetprotohttpTable,
) -> NetprotohttpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpTable::copy(self : NetprotohttpTable) -> NetprotohttpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpTable::fill(
  self : NetprotohttpTable,
  v : Double,
) -> NetprotohttpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpTable::min(self : NetprotohttpTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpTable::max(self : NetprotohttpTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpTable::to_string(self : NetprotohttpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_graphn_make(size : Int32) -> NetprotohttpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpGraphN::len(self : NetprotohttpGraphN) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpGraphN::get(self : NetprotohttpGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpGraphN::set(
  self : NetprotohttpGraphN,
  i : Int32,
  v : Double,
) -> NetprotohttpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpGraphN::sum(self : NetprotohttpGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpGraphN::mean(self : NetprotohttpGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpGraphN::scale(
  self : NetprotohttpGraphN,
  f : Double,
) -> NetprotohttpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpGraphN::add(
  self : NetprotohttpGraphN,
  other : NetprotohttpGraphN,
) -> NetprotohttpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpGraphN::copy(
  self : NetprotohttpGraphN,
) -> NetprotohttpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpGraphN::fill(
  self : NetprotohttpGraphN,
  v : Double,
) -> NetprotohttpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpGraphN::min(self : NetprotohttpGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpGraphN::max(self : NetprotohttpGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpGraphN::to_string(self : NetprotohttpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_node_make(size : Int32) -> NetprotohttpNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpNode::len(self : NetprotohttpNode) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpNode::get(self : NetprotohttpNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpNode::set(
  self : NetprotohttpNode,
  i : Int32,
  v : Double,
) -> NetprotohttpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpNode::sum(self : NetprotohttpNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpNode::mean(self : NetprotohttpNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpNode::scale(
  self : NetprotohttpNode,
  f : Double,
) -> NetprotohttpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpNode::add(
  self : NetprotohttpNode,
  other : NetprotohttpNode,
) -> NetprotohttpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpNode::copy(self : NetprotohttpNode) -> NetprotohttpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpNode::fill(
  self : NetprotohttpNode,
  v : Double,
) -> NetprotohttpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpNode::min(self : NetprotohttpNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpNode::max(self : NetprotohttpNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpNode::to_string(self : NetprotohttpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_edge_make(size : Int32) -> NetprotohttpEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpEdge::len(self : NetprotohttpEdge) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpEdge::get(self : NetprotohttpEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpEdge::set(
  self : NetprotohttpEdge,
  i : Int32,
  v : Double,
) -> NetprotohttpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpEdge::sum(self : NetprotohttpEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpEdge::mean(self : NetprotohttpEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpEdge::scale(
  self : NetprotohttpEdge,
  f : Double,
) -> NetprotohttpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpEdge::add(
  self : NetprotohttpEdge,
  other : NetprotohttpEdge,
) -> NetprotohttpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpEdge::copy(self : NetprotohttpEdge) -> NetprotohttpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpEdge::fill(
  self : NetprotohttpEdge,
  v : Double,
) -> NetprotohttpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpEdge::min(self : NetprotohttpEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpEdge::max(self : NetprotohttpEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpEdge::to_string(self : NetprotohttpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_path_make(size : Int32) -> NetprotohttpPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpPath::len(self : NetprotohttpPath) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpPath::get(self : NetprotohttpPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpPath::set(
  self : NetprotohttpPath,
  i : Int32,
  v : Double,
) -> NetprotohttpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpPath::sum(self : NetprotohttpPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpPath::mean(self : NetprotohttpPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpPath::scale(
  self : NetprotohttpPath,
  f : Double,
) -> NetprotohttpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpPath::add(
  self : NetprotohttpPath,
  other : NetprotohttpPath,
) -> NetprotohttpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpPath::copy(self : NetprotohttpPath) -> NetprotohttpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpPath::fill(
  self : NetprotohttpPath,
  v : Double,
) -> NetprotohttpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpPath::min(self : NetprotohttpPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpPath::max(self : NetprotohttpPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpPath::to_string(self : NetprotohttpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_cluster_make(size : Int32) -> NetprotohttpCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpCluster::len(self : NetprotohttpCluster) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpCluster::get(
  self : NetprotohttpCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpCluster::set(
  self : NetprotohttpCluster,
  i : Int32,
  v : Double,
) -> NetprotohttpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCluster::sum(self : NetprotohttpCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpCluster::mean(self : NetprotohttpCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpCluster::scale(
  self : NetprotohttpCluster,
  f : Double,
) -> NetprotohttpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCluster::add(
  self : NetprotohttpCluster,
  other : NetprotohttpCluster,
) -> NetprotohttpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpCluster::copy(
  self : NetprotohttpCluster,
) -> NetprotohttpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCluster::fill(
  self : NetprotohttpCluster,
  v : Double,
) -> NetprotohttpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCluster::min(self : NetprotohttpCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpCluster::max(self : NetprotohttpCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpCluster::to_string(self : NetprotohttpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_model_make(size : Int32) -> NetprotohttpModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpModel::len(self : NetprotohttpModel) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpModel::get(self : NetprotohttpModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpModel::set(
  self : NetprotohttpModel,
  i : Int32,
  v : Double,
) -> NetprotohttpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpModel::sum(self : NetprotohttpModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpModel::mean(self : NetprotohttpModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpModel::scale(
  self : NetprotohttpModel,
  f : Double,
) -> NetprotohttpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpModel::add(
  self : NetprotohttpModel,
  other : NetprotohttpModel,
) -> NetprotohttpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpModel::copy(self : NetprotohttpModel) -> NetprotohttpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpModel::fill(
  self : NetprotohttpModel,
  v : Double,
) -> NetprotohttpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpModel::min(self : NetprotohttpModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpModel::max(self : NetprotohttpModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpModel::to_string(self : NetprotohttpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_layer_make(size : Int32) -> NetprotohttpLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpLayer::len(self : NetprotohttpLayer) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpLayer::get(self : NetprotohttpLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpLayer::set(
  self : NetprotohttpLayer,
  i : Int32,
  v : Double,
) -> NetprotohttpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpLayer::sum(self : NetprotohttpLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpLayer::mean(self : NetprotohttpLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpLayer::scale(
  self : NetprotohttpLayer,
  f : Double,
) -> NetprotohttpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpLayer::add(
  self : NetprotohttpLayer,
  other : NetprotohttpLayer,
) -> NetprotohttpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpLayer::copy(self : NetprotohttpLayer) -> NetprotohttpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpLayer::fill(
  self : NetprotohttpLayer,
  v : Double,
) -> NetprotohttpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpLayer::min(self : NetprotohttpLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpLayer::max(self : NetprotohttpLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpLayer::to_string(self : NetprotohttpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_buffer_make(size : Int32) -> NetprotohttpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpBuffer::len(self : NetprotohttpBuffer) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpBuffer::get(self : NetprotohttpBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpBuffer::set(
  self : NetprotohttpBuffer,
  i : Int32,
  v : Double,
) -> NetprotohttpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpBuffer::sum(self : NetprotohttpBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpBuffer::mean(self : NetprotohttpBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpBuffer::scale(
  self : NetprotohttpBuffer,
  f : Double,
) -> NetprotohttpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpBuffer::add(
  self : NetprotohttpBuffer,
  other : NetprotohttpBuffer,
) -> NetprotohttpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpBuffer::copy(
  self : NetprotohttpBuffer,
) -> NetprotohttpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpBuffer::fill(
  self : NetprotohttpBuffer,
  v : Double,
) -> NetprotohttpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpBuffer::min(self : NetprotohttpBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpBuffer::max(self : NetprotohttpBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpBuffer::to_string(self : NetprotohttpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_cursor_make(size : Int32) -> NetprotohttpCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpCursor::len(self : NetprotohttpCursor) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpCursor::get(self : NetprotohttpCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpCursor::set(
  self : NetprotohttpCursor,
  i : Int32,
  v : Double,
) -> NetprotohttpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCursor::sum(self : NetprotohttpCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpCursor::mean(self : NetprotohttpCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpCursor::scale(
  self : NetprotohttpCursor,
  f : Double,
) -> NetprotohttpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCursor::add(
  self : NetprotohttpCursor,
  other : NetprotohttpCursor,
) -> NetprotohttpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpCursor::copy(
  self : NetprotohttpCursor,
) -> NetprotohttpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCursor::fill(
  self : NetprotohttpCursor,
  v : Double,
) -> NetprotohttpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpCursor::min(self : NetprotohttpCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpCursor::max(self : NetprotohttpCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpCursor::to_string(self : NetprotohttpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_view_make(size : Int32) -> NetprotohttpView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpView::len(self : NetprotohttpView) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpView::get(self : NetprotohttpView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpView::set(
  self : NetprotohttpView,
  i : Int32,
  v : Double,
) -> NetprotohttpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpView::sum(self : NetprotohttpView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpView::mean(self : NetprotohttpView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpView::scale(
  self : NetprotohttpView,
  f : Double,
) -> NetprotohttpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpView::add(
  self : NetprotohttpView,
  other : NetprotohttpView,
) -> NetprotohttpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpView::copy(self : NetprotohttpView) -> NetprotohttpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpView::fill(
  self : NetprotohttpView,
  v : Double,
) -> NetprotohttpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpView::min(self : NetprotohttpView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpView::max(self : NetprotohttpView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpView::to_string(self : NetprotohttpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_range_make(size : Int32) -> NetprotohttpRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpRange::len(self : NetprotohttpRange) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpRange::get(self : NetprotohttpRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpRange::set(
  self : NetprotohttpRange,
  i : Int32,
  v : Double,
) -> NetprotohttpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpRange::sum(self : NetprotohttpRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpRange::mean(self : NetprotohttpRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpRange::scale(
  self : NetprotohttpRange,
  f : Double,
) -> NetprotohttpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpRange::add(
  self : NetprotohttpRange,
  other : NetprotohttpRange,
) -> NetprotohttpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpRange::copy(self : NetprotohttpRange) -> NetprotohttpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpRange::fill(
  self : NetprotohttpRange,
  v : Double,
) -> NetprotohttpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpRange::min(self : NetprotohttpRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpRange::max(self : NetprotohttpRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpRange::to_string(self : NetprotohttpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetprotohttpSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_proto_http_slice_make(size : Int32) -> NetprotohttpSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetprotohttpSlice::len(self : NetprotohttpSlice) -> Int32 {
  self.size
}

///|
pub fn NetprotohttpSlice::get(self : NetprotohttpSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetprotohttpSlice::set(
  self : NetprotohttpSlice,
  i : Int32,
  v : Double,
) -> NetprotohttpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpSlice::sum(self : NetprotohttpSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetprotohttpSlice::mean(self : NetprotohttpSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetprotohttpSlice::scale(
  self : NetprotohttpSlice,
  f : Double,
) -> NetprotohttpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpSlice::add(
  self : NetprotohttpSlice,
  other : NetprotohttpSlice,
) -> NetprotohttpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetprotohttpSlice::copy(self : NetprotohttpSlice) -> NetprotohttpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpSlice::fill(
  self : NetprotohttpSlice,
  v : Double,
) -> NetprotohttpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetprotohttpSlice::min(self : NetprotohttpSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetprotohttpSlice::max(self : NetprotohttpSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetprotohttpSlice::to_string(self : NetprotohttpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

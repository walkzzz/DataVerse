///|
///===
/// extcore/net_sec_ipsec
pub(all) struct NetsecipsecPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_sec_ipsec_make_point(x : Double, y : Double) -> NetsecipsecPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_sec_ipsec_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetsecipsecPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetsecipsecPoint::x(self : NetsecipsecPoint) -> Double {
  self.x
}

///|
pub fn NetsecipsecPoint::y(self : NetsecipsecPoint) -> Double {
  self.y
}

///|
pub fn NetsecipsecPoint::z(self : NetsecipsecPoint) -> Double {
  self.z
}

///|
pub fn NetsecipsecPoint::label(self : NetsecipsecPoint) -> Int32 {
  self.label
}

///|
pub fn NetsecipsecPoint::dist(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetsecipsecPoint::add(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> NetsecipsecPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetsecipsecPoint::sub(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> NetsecipsecPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetsecipsecPoint::scale(
  self : NetsecipsecPoint,
  s : Double,
) -> NetsecipsecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetsecipsecPoint::dot(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetsecipsecPoint::cross(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> NetsecipsecPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetsecipsecPoint::norm(self : NetsecipsecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetsecipsecPoint::normalize(self : NetsecipsecPoint) -> NetsecipsecPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecipsecPoint::negate(self : NetsecipsecPoint) -> NetsecipsecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetsecipsecPoint::mid(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
) -> NetsecipsecPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetsecipsecPoint::lerp(
  self : NetsecipsecPoint,
  other : NetsecipsecPoint,
  t : Double,
) -> NetsecipsecPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetsecipsecPoint::to_string(self : NetsecipsecPoint) -> String {
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
pub(all) struct NetsecipsecSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_sec_ipsec_make_series(
  vals : Array[Double],
  name : String,
) -> NetsecipsecSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetsecipsecSeries::len(self : NetsecipsecSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetsecipsecSeries::sum(self : NetsecipsecSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetsecipsecSeries::mean(self : NetsecipsecSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetsecipsecSeries::min(self : NetsecipsecSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetsecipsecSeries::max(self : NetsecipsecSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetsecipsecSeries::range(self : NetsecipsecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetsecipsecSeries::variance(self : NetsecipsecSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetsecipsecSeries::std(self : NetsecipsecSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetsecipsecSeries::median(self : NetsecipsecSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetsecipsecSeries::scale(
  self : NetsecipsecSeries,
  f : Double,
) -> NetsecipsecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetsecipsecSeries::add(
  self : NetsecipsecSeries,
  other : NetsecipsecSeries,
) -> NetsecipsecSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecipsecSeries::sub(
  self : NetsecipsecSeries,
  other : NetsecipsecSeries,
) -> NetsecipsecSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecipsecSeries::normalize(
  self : NetsecipsecSeries,
) -> NetsecipsecSeries {
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
pub fn NetsecipsecSeries::cumsum(self : NetsecipsecSeries) -> NetsecipsecSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetsecipsecSeries::to_string(self : NetsecipsecSeries) -> String {
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
pub(all) struct NetsecipsecMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_sec_ipsec_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetsecipsecMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_sec_ipsec_matrix_identity(n : Int32) -> NetsecipsecMatrix {
  let m = net_sec_ipsec_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetsecipsecMatrix::get(
  self : NetsecipsecMatrix,
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
pub fn NetsecipsecMatrix::transpose(
  self : NetsecipsecMatrix,
) -> NetsecipsecMatrix {
  let result = net_sec_ipsec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecipsecMatrix::add(
  self : NetsecipsecMatrix,
  other : NetsecipsecMatrix,
) -> NetsecipsecMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_sec_ipsec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecipsecMatrix::scale(
  self : NetsecipsecMatrix,
  s : Double,
) -> NetsecipsecMatrix {
  let result = net_sec_ipsec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetsecipsecMatrix::multiply(
  self : NetsecipsecMatrix,
  other : NetsecipsecMatrix,
) -> NetsecipsecMatrix {
  if self.cols != other.rows {
    return net_sec_ipsec_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_sec_ipsec_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetsecipsecMatrix::trace(self : NetsecipsecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetsecipsecMatrix::det(self : NetsecipsecMatrix) -> Double {
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
pub fn NetsecipsecMatrix::norm(self : NetsecipsecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetsecipsecMatrix::to_string(self : NetsecipsecMatrix) -> String {
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
pub(all) struct NetsecipsecVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_sec_ipsec_make_vector(comps : Array[Double]) -> NetsecipsecVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_sec_ipsec_vector_zero(dim : Int32) -> NetsecipsecVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetsecipsecVector::add(
  self : NetsecipsecVector,
  other : NetsecipsecVector,
) -> NetsecipsecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecipsecVector::sub(
  self : NetsecipsecVector,
  other : NetsecipsecVector,
) -> NetsecipsecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecipsecVector::scale(
  self : NetsecipsecVector,
  s : Double,
) -> NetsecipsecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetsecipsecVector::dot(
  self : NetsecipsecVector,
  other : NetsecipsecVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetsecipsecVector::norm(self : NetsecipsecVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetsecipsecVector::normalize(
  self : NetsecipsecVector,
) -> NetsecipsecVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecipsecVector::dist(
  self : NetsecipsecVector,
  other : NetsecipsecVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetsecipsecVector::to_string(self : NetsecipsecVector) -> String {
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
pub(all) struct NetsecipsecFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_frame_make(size : Int32) -> NetsecipsecFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecFrame::len(self : NetsecipsecFrame) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecFrame::get(self : NetsecipsecFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecFrame::set(
  self : NetsecipsecFrame,
  i : Int32,
  v : Double,
) -> NetsecipsecFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecFrame::sum(self : NetsecipsecFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecFrame::mean(self : NetsecipsecFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecFrame::scale(
  self : NetsecipsecFrame,
  f : Double,
) -> NetsecipsecFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecFrame::add(
  self : NetsecipsecFrame,
  other : NetsecipsecFrame,
) -> NetsecipsecFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecFrame::copy(self : NetsecipsecFrame) -> NetsecipsecFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecFrame::fill(
  self : NetsecipsecFrame,
  v : Double,
) -> NetsecipsecFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecFrame::min(self : NetsecipsecFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecFrame::max(self : NetsecipsecFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecFrame::to_string(self : NetsecipsecFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_table_make(size : Int32) -> NetsecipsecTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecTable::len(self : NetsecipsecTable) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecTable::get(self : NetsecipsecTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecTable::set(
  self : NetsecipsecTable,
  i : Int32,
  v : Double,
) -> NetsecipsecTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecTable::sum(self : NetsecipsecTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecTable::mean(self : NetsecipsecTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecTable::scale(
  self : NetsecipsecTable,
  f : Double,
) -> NetsecipsecTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecTable::add(
  self : NetsecipsecTable,
  other : NetsecipsecTable,
) -> NetsecipsecTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecTable::copy(self : NetsecipsecTable) -> NetsecipsecTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecTable::fill(
  self : NetsecipsecTable,
  v : Double,
) -> NetsecipsecTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecTable::min(self : NetsecipsecTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecTable::max(self : NetsecipsecTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecTable::to_string(self : NetsecipsecTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_graphn_make(size : Int32) -> NetsecipsecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecGraphN::len(self : NetsecipsecGraphN) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecGraphN::get(self : NetsecipsecGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecGraphN::set(
  self : NetsecipsecGraphN,
  i : Int32,
  v : Double,
) -> NetsecipsecGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecGraphN::sum(self : NetsecipsecGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecGraphN::mean(self : NetsecipsecGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecGraphN::scale(
  self : NetsecipsecGraphN,
  f : Double,
) -> NetsecipsecGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecGraphN::add(
  self : NetsecipsecGraphN,
  other : NetsecipsecGraphN,
) -> NetsecipsecGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecGraphN::copy(self : NetsecipsecGraphN) -> NetsecipsecGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecGraphN::fill(
  self : NetsecipsecGraphN,
  v : Double,
) -> NetsecipsecGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecGraphN::min(self : NetsecipsecGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecGraphN::max(self : NetsecipsecGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecGraphN::to_string(self : NetsecipsecGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_node_make(size : Int32) -> NetsecipsecNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecNode::len(self : NetsecipsecNode) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecNode::get(self : NetsecipsecNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecNode::set(
  self : NetsecipsecNode,
  i : Int32,
  v : Double,
) -> NetsecipsecNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecNode::sum(self : NetsecipsecNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecNode::mean(self : NetsecipsecNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecNode::scale(
  self : NetsecipsecNode,
  f : Double,
) -> NetsecipsecNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecNode::add(
  self : NetsecipsecNode,
  other : NetsecipsecNode,
) -> NetsecipsecNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecNode::copy(self : NetsecipsecNode) -> NetsecipsecNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecNode::fill(
  self : NetsecipsecNode,
  v : Double,
) -> NetsecipsecNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecNode::min(self : NetsecipsecNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecNode::max(self : NetsecipsecNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecNode::to_string(self : NetsecipsecNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_edge_make(size : Int32) -> NetsecipsecEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecEdge::len(self : NetsecipsecEdge) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecEdge::get(self : NetsecipsecEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecEdge::set(
  self : NetsecipsecEdge,
  i : Int32,
  v : Double,
) -> NetsecipsecEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecEdge::sum(self : NetsecipsecEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecEdge::mean(self : NetsecipsecEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecEdge::scale(
  self : NetsecipsecEdge,
  f : Double,
) -> NetsecipsecEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecEdge::add(
  self : NetsecipsecEdge,
  other : NetsecipsecEdge,
) -> NetsecipsecEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecEdge::copy(self : NetsecipsecEdge) -> NetsecipsecEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecEdge::fill(
  self : NetsecipsecEdge,
  v : Double,
) -> NetsecipsecEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecEdge::min(self : NetsecipsecEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecEdge::max(self : NetsecipsecEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecEdge::to_string(self : NetsecipsecEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_path_make(size : Int32) -> NetsecipsecPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecPath::len(self : NetsecipsecPath) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecPath::get(self : NetsecipsecPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecPath::set(
  self : NetsecipsecPath,
  i : Int32,
  v : Double,
) -> NetsecipsecPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecPath::sum(self : NetsecipsecPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecPath::mean(self : NetsecipsecPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecPath::scale(
  self : NetsecipsecPath,
  f : Double,
) -> NetsecipsecPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecPath::add(
  self : NetsecipsecPath,
  other : NetsecipsecPath,
) -> NetsecipsecPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecPath::copy(self : NetsecipsecPath) -> NetsecipsecPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecPath::fill(
  self : NetsecipsecPath,
  v : Double,
) -> NetsecipsecPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecPath::min(self : NetsecipsecPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecPath::max(self : NetsecipsecPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecPath::to_string(self : NetsecipsecPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_cluster_make(size : Int32) -> NetsecipsecCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecCluster::len(self : NetsecipsecCluster) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecCluster::get(self : NetsecipsecCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecCluster::set(
  self : NetsecipsecCluster,
  i : Int32,
  v : Double,
) -> NetsecipsecCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCluster::sum(self : NetsecipsecCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecCluster::mean(self : NetsecipsecCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecCluster::scale(
  self : NetsecipsecCluster,
  f : Double,
) -> NetsecipsecCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCluster::add(
  self : NetsecipsecCluster,
  other : NetsecipsecCluster,
) -> NetsecipsecCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecCluster::copy(
  self : NetsecipsecCluster,
) -> NetsecipsecCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCluster::fill(
  self : NetsecipsecCluster,
  v : Double,
) -> NetsecipsecCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCluster::min(self : NetsecipsecCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecCluster::max(self : NetsecipsecCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecCluster::to_string(self : NetsecipsecCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_model_make(size : Int32) -> NetsecipsecModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecModel::len(self : NetsecipsecModel) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecModel::get(self : NetsecipsecModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecModel::set(
  self : NetsecipsecModel,
  i : Int32,
  v : Double,
) -> NetsecipsecModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecModel::sum(self : NetsecipsecModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecModel::mean(self : NetsecipsecModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecModel::scale(
  self : NetsecipsecModel,
  f : Double,
) -> NetsecipsecModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecModel::add(
  self : NetsecipsecModel,
  other : NetsecipsecModel,
) -> NetsecipsecModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecModel::copy(self : NetsecipsecModel) -> NetsecipsecModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecModel::fill(
  self : NetsecipsecModel,
  v : Double,
) -> NetsecipsecModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecModel::min(self : NetsecipsecModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecModel::max(self : NetsecipsecModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecModel::to_string(self : NetsecipsecModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_layer_make(size : Int32) -> NetsecipsecLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecLayer::len(self : NetsecipsecLayer) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecLayer::get(self : NetsecipsecLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecLayer::set(
  self : NetsecipsecLayer,
  i : Int32,
  v : Double,
) -> NetsecipsecLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecLayer::sum(self : NetsecipsecLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecLayer::mean(self : NetsecipsecLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecLayer::scale(
  self : NetsecipsecLayer,
  f : Double,
) -> NetsecipsecLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecLayer::add(
  self : NetsecipsecLayer,
  other : NetsecipsecLayer,
) -> NetsecipsecLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecLayer::copy(self : NetsecipsecLayer) -> NetsecipsecLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecLayer::fill(
  self : NetsecipsecLayer,
  v : Double,
) -> NetsecipsecLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecLayer::min(self : NetsecipsecLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecLayer::max(self : NetsecipsecLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecLayer::to_string(self : NetsecipsecLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_buffer_make(size : Int32) -> NetsecipsecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecBuffer::len(self : NetsecipsecBuffer) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecBuffer::get(self : NetsecipsecBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecBuffer::set(
  self : NetsecipsecBuffer,
  i : Int32,
  v : Double,
) -> NetsecipsecBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecBuffer::sum(self : NetsecipsecBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecBuffer::mean(self : NetsecipsecBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecBuffer::scale(
  self : NetsecipsecBuffer,
  f : Double,
) -> NetsecipsecBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecBuffer::add(
  self : NetsecipsecBuffer,
  other : NetsecipsecBuffer,
) -> NetsecipsecBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecBuffer::copy(self : NetsecipsecBuffer) -> NetsecipsecBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecBuffer::fill(
  self : NetsecipsecBuffer,
  v : Double,
) -> NetsecipsecBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecBuffer::min(self : NetsecipsecBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecBuffer::max(self : NetsecipsecBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecBuffer::to_string(self : NetsecipsecBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_cursor_make(size : Int32) -> NetsecipsecCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecCursor::len(self : NetsecipsecCursor) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecCursor::get(self : NetsecipsecCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecCursor::set(
  self : NetsecipsecCursor,
  i : Int32,
  v : Double,
) -> NetsecipsecCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCursor::sum(self : NetsecipsecCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecCursor::mean(self : NetsecipsecCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecCursor::scale(
  self : NetsecipsecCursor,
  f : Double,
) -> NetsecipsecCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCursor::add(
  self : NetsecipsecCursor,
  other : NetsecipsecCursor,
) -> NetsecipsecCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecCursor::copy(self : NetsecipsecCursor) -> NetsecipsecCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCursor::fill(
  self : NetsecipsecCursor,
  v : Double,
) -> NetsecipsecCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecCursor::min(self : NetsecipsecCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecCursor::max(self : NetsecipsecCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecCursor::to_string(self : NetsecipsecCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_view_make(size : Int32) -> NetsecipsecView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecView::len(self : NetsecipsecView) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecView::get(self : NetsecipsecView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecView::set(
  self : NetsecipsecView,
  i : Int32,
  v : Double,
) -> NetsecipsecView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecView::sum(self : NetsecipsecView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecView::mean(self : NetsecipsecView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecView::scale(
  self : NetsecipsecView,
  f : Double,
) -> NetsecipsecView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecView::add(
  self : NetsecipsecView,
  other : NetsecipsecView,
) -> NetsecipsecView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecView::copy(self : NetsecipsecView) -> NetsecipsecView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecView::fill(
  self : NetsecipsecView,
  v : Double,
) -> NetsecipsecView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecView::min(self : NetsecipsecView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecView::max(self : NetsecipsecView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecView::to_string(self : NetsecipsecView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_range_make(size : Int32) -> NetsecipsecRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecRange::len(self : NetsecipsecRange) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecRange::get(self : NetsecipsecRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecRange::set(
  self : NetsecipsecRange,
  i : Int32,
  v : Double,
) -> NetsecipsecRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecRange::sum(self : NetsecipsecRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecRange::mean(self : NetsecipsecRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecRange::scale(
  self : NetsecipsecRange,
  f : Double,
) -> NetsecipsecRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecRange::add(
  self : NetsecipsecRange,
  other : NetsecipsecRange,
) -> NetsecipsecRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecRange::copy(self : NetsecipsecRange) -> NetsecipsecRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecRange::fill(
  self : NetsecipsecRange,
  v : Double,
) -> NetsecipsecRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecRange::min(self : NetsecipsecRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecRange::max(self : NetsecipsecRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecRange::to_string(self : NetsecipsecRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecipsecSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_ipsec_slice_make(size : Int32) -> NetsecipsecSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecipsecSlice::len(self : NetsecipsecSlice) -> Int32 {
  self.size
}

///|
pub fn NetsecipsecSlice::get(self : NetsecipsecSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecipsecSlice::set(
  self : NetsecipsecSlice,
  i : Int32,
  v : Double,
) -> NetsecipsecSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecSlice::sum(self : NetsecipsecSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecipsecSlice::mean(self : NetsecipsecSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecipsecSlice::scale(
  self : NetsecipsecSlice,
  f : Double,
) -> NetsecipsecSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecSlice::add(
  self : NetsecipsecSlice,
  other : NetsecipsecSlice,
) -> NetsecipsecSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecipsecSlice::copy(self : NetsecipsecSlice) -> NetsecipsecSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecSlice::fill(
  self : NetsecipsecSlice,
  v : Double,
) -> NetsecipsecSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecipsecSlice::min(self : NetsecipsecSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecipsecSlice::max(self : NetsecipsecSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecipsecSlice::to_string(self : NetsecipsecSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
///===
/// extcore/net_sec_auth
pub(all) struct NetsecauthPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn net_sec_auth_make_point(x : Double, y : Double) -> NetsecauthPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn net_sec_auth_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> NetsecauthPoint {
  { x, y, z, label: 0, }
}

///|
pub fn NetsecauthPoint::x(self : NetsecauthPoint) -> Double {
  self.x
}

///|
pub fn NetsecauthPoint::y(self : NetsecauthPoint) -> Double {
  self.y
}

///|
pub fn NetsecauthPoint::z(self : NetsecauthPoint) -> Double {
  self.z
}

///|
pub fn NetsecauthPoint::label(self : NetsecauthPoint) -> Int32 {
  self.label
}

///|
pub fn NetsecauthPoint::dist(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn NetsecauthPoint::add(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> NetsecauthPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn NetsecauthPoint::sub(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> NetsecauthPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn NetsecauthPoint::scale(
  self : NetsecauthPoint,
  s : Double,
) -> NetsecauthPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn NetsecauthPoint::dot(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn NetsecauthPoint::cross(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> NetsecauthPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn NetsecauthPoint::norm(self : NetsecauthPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn NetsecauthPoint::normalize(self : NetsecauthPoint) -> NetsecauthPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecauthPoint::negate(self : NetsecauthPoint) -> NetsecauthPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn NetsecauthPoint::mid(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
) -> NetsecauthPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn NetsecauthPoint::lerp(
  self : NetsecauthPoint,
  other : NetsecauthPoint,
  t : Double,
) -> NetsecauthPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn NetsecauthPoint::to_string(self : NetsecauthPoint) -> String {
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
pub(all) struct NetsecauthSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn net_sec_auth_make_series(
  vals : Array[Double],
  name : String,
) -> NetsecauthSeries {
  { vals, name, meta: 0, }
}

///|
pub fn NetsecauthSeries::len(self : NetsecauthSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn NetsecauthSeries::sum(self : NetsecauthSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn NetsecauthSeries::mean(self : NetsecauthSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn NetsecauthSeries::min(self : NetsecauthSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn NetsecauthSeries::max(self : NetsecauthSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn NetsecauthSeries::range(self : NetsecauthSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn NetsecauthSeries::variance(self : NetsecauthSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn NetsecauthSeries::std(self : NetsecauthSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn NetsecauthSeries::median(self : NetsecauthSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn NetsecauthSeries::scale(
  self : NetsecauthSeries,
  f : Double,
) -> NetsecauthSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn NetsecauthSeries::add(
  self : NetsecauthSeries,
  other : NetsecauthSeries,
) -> NetsecauthSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecauthSeries::sub(
  self : NetsecauthSeries,
  other : NetsecauthSeries,
) -> NetsecauthSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn NetsecauthSeries::normalize(self : NetsecauthSeries) -> NetsecauthSeries {
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
pub fn NetsecauthSeries::cumsum(self : NetsecauthSeries) -> NetsecauthSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn NetsecauthSeries::to_string(self : NetsecauthSeries) -> String {
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
pub(all) struct NetsecauthMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn net_sec_auth_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> NetsecauthMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn net_sec_auth_matrix_identity(n : Int32) -> NetsecauthMatrix {
  let m = net_sec_auth_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn NetsecauthMatrix::get(
  self : NetsecauthMatrix,
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
pub fn NetsecauthMatrix::transpose(self : NetsecauthMatrix) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecauthMatrix::add(
  self : NetsecauthMatrix,
  other : NetsecauthMatrix,
) -> NetsecauthMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = net_sec_auth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn NetsecauthMatrix::scale(
  self : NetsecauthMatrix,
  s : Double,
) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn NetsecauthMatrix::multiply(
  self : NetsecauthMatrix,
  other : NetsecauthMatrix,
) -> NetsecauthMatrix {
  if self.cols != other.rows {
    return net_sec_auth_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = net_sec_auth_make_matrix(self.rows, other.cols, 0.0)
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
pub fn NetsecauthMatrix::trace(self : NetsecauthMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn NetsecauthMatrix::det(self : NetsecauthMatrix) -> Double {
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
pub fn NetsecauthMatrix::norm(self : NetsecauthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn NetsecauthMatrix::to_string(self : NetsecauthMatrix) -> String {
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
pub(all) struct NetsecauthVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn net_sec_auth_make_vector(comps : Array[Double]) -> NetsecauthVector {
  { comps, dim: comps.length(), }
}

///|
pub fn net_sec_auth_vector_zero(dim : Int32) -> NetsecauthVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn NetsecauthVector::add(
  self : NetsecauthVector,
  other : NetsecauthVector,
) -> NetsecauthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecauthVector::sub(
  self : NetsecauthVector,
  other : NetsecauthVector,
) -> NetsecauthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn NetsecauthVector::scale(
  self : NetsecauthVector,
  s : Double,
) -> NetsecauthVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn NetsecauthVector::dot(
  self : NetsecauthVector,
  other : NetsecauthVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn NetsecauthVector::norm(self : NetsecauthVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn NetsecauthVector::normalize(self : NetsecauthVector) -> NetsecauthVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn NetsecauthVector::dist(
  self : NetsecauthVector,
  other : NetsecauthVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn NetsecauthVector::to_string(self : NetsecauthVector) -> String {
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
pub(all) struct NetsecauthFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_frame_make(size : Int32) -> NetsecauthFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthFrame::len(self : NetsecauthFrame) -> Int32 {
  self.size
}

///|
pub fn NetsecauthFrame::get(self : NetsecauthFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthFrame::set(
  self : NetsecauthFrame,
  i : Int32,
  v : Double,
) -> NetsecauthFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthFrame::sum(self : NetsecauthFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthFrame::mean(self : NetsecauthFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthFrame::scale(
  self : NetsecauthFrame,
  f : Double,
) -> NetsecauthFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthFrame::add(
  self : NetsecauthFrame,
  other : NetsecauthFrame,
) -> NetsecauthFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthFrame::copy(self : NetsecauthFrame) -> NetsecauthFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthFrame::fill(
  self : NetsecauthFrame,
  v : Double,
) -> NetsecauthFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthFrame::min(self : NetsecauthFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthFrame::max(self : NetsecauthFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthFrame::to_string(self : NetsecauthFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_table_make(size : Int32) -> NetsecauthTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthTable::len(self : NetsecauthTable) -> Int32 {
  self.size
}

///|
pub fn NetsecauthTable::get(self : NetsecauthTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthTable::set(
  self : NetsecauthTable,
  i : Int32,
  v : Double,
) -> NetsecauthTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthTable::sum(self : NetsecauthTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthTable::mean(self : NetsecauthTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthTable::scale(
  self : NetsecauthTable,
  f : Double,
) -> NetsecauthTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthTable::add(
  self : NetsecauthTable,
  other : NetsecauthTable,
) -> NetsecauthTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthTable::copy(self : NetsecauthTable) -> NetsecauthTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthTable::fill(
  self : NetsecauthTable,
  v : Double,
) -> NetsecauthTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthTable::min(self : NetsecauthTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthTable::max(self : NetsecauthTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthTable::to_string(self : NetsecauthTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_graphn_make(size : Int32) -> NetsecauthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthGraphN::len(self : NetsecauthGraphN) -> Int32 {
  self.size
}

///|
pub fn NetsecauthGraphN::get(self : NetsecauthGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthGraphN::set(
  self : NetsecauthGraphN,
  i : Int32,
  v : Double,
) -> NetsecauthGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthGraphN::sum(self : NetsecauthGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthGraphN::mean(self : NetsecauthGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthGraphN::scale(
  self : NetsecauthGraphN,
  f : Double,
) -> NetsecauthGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthGraphN::add(
  self : NetsecauthGraphN,
  other : NetsecauthGraphN,
) -> NetsecauthGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthGraphN::copy(self : NetsecauthGraphN) -> NetsecauthGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthGraphN::fill(
  self : NetsecauthGraphN,
  v : Double,
) -> NetsecauthGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthGraphN::min(self : NetsecauthGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthGraphN::max(self : NetsecauthGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthGraphN::to_string(self : NetsecauthGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_node_make(size : Int32) -> NetsecauthNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthNode::len(self : NetsecauthNode) -> Int32 {
  self.size
}

///|
pub fn NetsecauthNode::get(self : NetsecauthNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthNode::set(
  self : NetsecauthNode,
  i : Int32,
  v : Double,
) -> NetsecauthNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthNode::sum(self : NetsecauthNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthNode::mean(self : NetsecauthNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthNode::scale(
  self : NetsecauthNode,
  f : Double,
) -> NetsecauthNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthNode::add(
  self : NetsecauthNode,
  other : NetsecauthNode,
) -> NetsecauthNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthNode::copy(self : NetsecauthNode) -> NetsecauthNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthNode::fill(
  self : NetsecauthNode,
  v : Double,
) -> NetsecauthNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthNode::min(self : NetsecauthNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthNode::max(self : NetsecauthNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthNode::to_string(self : NetsecauthNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_edge_make(size : Int32) -> NetsecauthEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthEdge::len(self : NetsecauthEdge) -> Int32 {
  self.size
}

///|
pub fn NetsecauthEdge::get(self : NetsecauthEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthEdge::set(
  self : NetsecauthEdge,
  i : Int32,
  v : Double,
) -> NetsecauthEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthEdge::sum(self : NetsecauthEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthEdge::mean(self : NetsecauthEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthEdge::scale(
  self : NetsecauthEdge,
  f : Double,
) -> NetsecauthEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthEdge::add(
  self : NetsecauthEdge,
  other : NetsecauthEdge,
) -> NetsecauthEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthEdge::copy(self : NetsecauthEdge) -> NetsecauthEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthEdge::fill(
  self : NetsecauthEdge,
  v : Double,
) -> NetsecauthEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthEdge::min(self : NetsecauthEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthEdge::max(self : NetsecauthEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthEdge::to_string(self : NetsecauthEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_path_make(size : Int32) -> NetsecauthPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthPath::len(self : NetsecauthPath) -> Int32 {
  self.size
}

///|
pub fn NetsecauthPath::get(self : NetsecauthPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthPath::set(
  self : NetsecauthPath,
  i : Int32,
  v : Double,
) -> NetsecauthPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthPath::sum(self : NetsecauthPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthPath::mean(self : NetsecauthPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthPath::scale(
  self : NetsecauthPath,
  f : Double,
) -> NetsecauthPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthPath::add(
  self : NetsecauthPath,
  other : NetsecauthPath,
) -> NetsecauthPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthPath::copy(self : NetsecauthPath) -> NetsecauthPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthPath::fill(
  self : NetsecauthPath,
  v : Double,
) -> NetsecauthPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthPath::min(self : NetsecauthPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthPath::max(self : NetsecauthPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthPath::to_string(self : NetsecauthPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_cluster_make(size : Int32) -> NetsecauthCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthCluster::len(self : NetsecauthCluster) -> Int32 {
  self.size
}

///|
pub fn NetsecauthCluster::get(self : NetsecauthCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthCluster::set(
  self : NetsecauthCluster,
  i : Int32,
  v : Double,
) -> NetsecauthCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCluster::sum(self : NetsecauthCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthCluster::mean(self : NetsecauthCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthCluster::scale(
  self : NetsecauthCluster,
  f : Double,
) -> NetsecauthCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCluster::add(
  self : NetsecauthCluster,
  other : NetsecauthCluster,
) -> NetsecauthCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthCluster::copy(self : NetsecauthCluster) -> NetsecauthCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCluster::fill(
  self : NetsecauthCluster,
  v : Double,
) -> NetsecauthCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCluster::min(self : NetsecauthCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthCluster::max(self : NetsecauthCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthCluster::to_string(self : NetsecauthCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_model_make(size : Int32) -> NetsecauthModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthModel::len(self : NetsecauthModel) -> Int32 {
  self.size
}

///|
pub fn NetsecauthModel::get(self : NetsecauthModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthModel::set(
  self : NetsecauthModel,
  i : Int32,
  v : Double,
) -> NetsecauthModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthModel::sum(self : NetsecauthModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthModel::mean(self : NetsecauthModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthModel::scale(
  self : NetsecauthModel,
  f : Double,
) -> NetsecauthModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthModel::add(
  self : NetsecauthModel,
  other : NetsecauthModel,
) -> NetsecauthModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthModel::copy(self : NetsecauthModel) -> NetsecauthModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthModel::fill(
  self : NetsecauthModel,
  v : Double,
) -> NetsecauthModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthModel::min(self : NetsecauthModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthModel::max(self : NetsecauthModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthModel::to_string(self : NetsecauthModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_layer_make(size : Int32) -> NetsecauthLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthLayer::len(self : NetsecauthLayer) -> Int32 {
  self.size
}

///|
pub fn NetsecauthLayer::get(self : NetsecauthLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthLayer::set(
  self : NetsecauthLayer,
  i : Int32,
  v : Double,
) -> NetsecauthLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthLayer::sum(self : NetsecauthLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthLayer::mean(self : NetsecauthLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthLayer::scale(
  self : NetsecauthLayer,
  f : Double,
) -> NetsecauthLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthLayer::add(
  self : NetsecauthLayer,
  other : NetsecauthLayer,
) -> NetsecauthLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthLayer::copy(self : NetsecauthLayer) -> NetsecauthLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthLayer::fill(
  self : NetsecauthLayer,
  v : Double,
) -> NetsecauthLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthLayer::min(self : NetsecauthLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthLayer::max(self : NetsecauthLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthLayer::to_string(self : NetsecauthLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_buffer_make(size : Int32) -> NetsecauthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthBuffer::len(self : NetsecauthBuffer) -> Int32 {
  self.size
}

///|
pub fn NetsecauthBuffer::get(self : NetsecauthBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthBuffer::set(
  self : NetsecauthBuffer,
  i : Int32,
  v : Double,
) -> NetsecauthBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthBuffer::sum(self : NetsecauthBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthBuffer::mean(self : NetsecauthBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthBuffer::scale(
  self : NetsecauthBuffer,
  f : Double,
) -> NetsecauthBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthBuffer::add(
  self : NetsecauthBuffer,
  other : NetsecauthBuffer,
) -> NetsecauthBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthBuffer::copy(self : NetsecauthBuffer) -> NetsecauthBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthBuffer::fill(
  self : NetsecauthBuffer,
  v : Double,
) -> NetsecauthBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthBuffer::min(self : NetsecauthBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthBuffer::max(self : NetsecauthBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthBuffer::to_string(self : NetsecauthBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_cursor_make(size : Int32) -> NetsecauthCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthCursor::len(self : NetsecauthCursor) -> Int32 {
  self.size
}

///|
pub fn NetsecauthCursor::get(self : NetsecauthCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthCursor::set(
  self : NetsecauthCursor,
  i : Int32,
  v : Double,
) -> NetsecauthCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCursor::sum(self : NetsecauthCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthCursor::mean(self : NetsecauthCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthCursor::scale(
  self : NetsecauthCursor,
  f : Double,
) -> NetsecauthCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCursor::add(
  self : NetsecauthCursor,
  other : NetsecauthCursor,
) -> NetsecauthCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthCursor::copy(self : NetsecauthCursor) -> NetsecauthCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCursor::fill(
  self : NetsecauthCursor,
  v : Double,
) -> NetsecauthCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthCursor::min(self : NetsecauthCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthCursor::max(self : NetsecauthCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthCursor::to_string(self : NetsecauthCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_view_make(size : Int32) -> NetsecauthView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthView::len(self : NetsecauthView) -> Int32 {
  self.size
}

///|
pub fn NetsecauthView::get(self : NetsecauthView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthView::set(
  self : NetsecauthView,
  i : Int32,
  v : Double,
) -> NetsecauthView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthView::sum(self : NetsecauthView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthView::mean(self : NetsecauthView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthView::scale(
  self : NetsecauthView,
  f : Double,
) -> NetsecauthView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthView::add(
  self : NetsecauthView,
  other : NetsecauthView,
) -> NetsecauthView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthView::copy(self : NetsecauthView) -> NetsecauthView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthView::fill(
  self : NetsecauthView,
  v : Double,
) -> NetsecauthView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthView::min(self : NetsecauthView) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthView::max(self : NetsecauthView) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthView::to_string(self : NetsecauthView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_range_make(size : Int32) -> NetsecauthRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthRange::len(self : NetsecauthRange) -> Int32 {
  self.size
}

///|
pub fn NetsecauthRange::get(self : NetsecauthRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthRange::set(
  self : NetsecauthRange,
  i : Int32,
  v : Double,
) -> NetsecauthRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthRange::sum(self : NetsecauthRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthRange::mean(self : NetsecauthRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthRange::scale(
  self : NetsecauthRange,
  f : Double,
) -> NetsecauthRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthRange::add(
  self : NetsecauthRange,
  other : NetsecauthRange,
) -> NetsecauthRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthRange::copy(self : NetsecauthRange) -> NetsecauthRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthRange::fill(
  self : NetsecauthRange,
  v : Double,
) -> NetsecauthRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthRange::min(self : NetsecauthRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthRange::max(self : NetsecauthRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthRange::to_string(self : NetsecauthRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct NetsecauthSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn net_sec_auth_slice_make(size : Int32) -> NetsecauthSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn NetsecauthSlice::len(self : NetsecauthSlice) -> Int32 {
  self.size
}

///|
pub fn NetsecauthSlice::get(self : NetsecauthSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn NetsecauthSlice::set(
  self : NetsecauthSlice,
  i : Int32,
  v : Double,
) -> NetsecauthSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthSlice::sum(self : NetsecauthSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn NetsecauthSlice::mean(self : NetsecauthSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn NetsecauthSlice::scale(
  self : NetsecauthSlice,
  f : Double,
) -> NetsecauthSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthSlice::add(
  self : NetsecauthSlice,
  other : NetsecauthSlice,
) -> NetsecauthSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn NetsecauthSlice::copy(self : NetsecauthSlice) -> NetsecauthSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthSlice::fill(
  self : NetsecauthSlice,
  v : Double,
) -> NetsecauthSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn NetsecauthSlice::min(self : NetsecauthSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn NetsecauthSlice::max(self : NetsecauthSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn NetsecauthSlice::to_string(self : NetsecauthSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

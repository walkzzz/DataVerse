///|
///===
/// extcore/geo_buffer_point
pub(all) struct GeobufferpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn geo_buffer_point_make_point(
  x : Double,
  y : Double,
) -> GeobufferpointPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn geo_buffer_point_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GeobufferpointPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GeobufferpointPoint::x(self : GeobufferpointPoint) -> Double {
  self.x
}

///|
pub fn GeobufferpointPoint::y(self : GeobufferpointPoint) -> Double {
  self.y
}

///|
pub fn GeobufferpointPoint::z(self : GeobufferpointPoint) -> Double {
  self.z
}

///|
pub fn GeobufferpointPoint::label(self : GeobufferpointPoint) -> Int32 {
  self.label
}

///|
pub fn GeobufferpointPoint::dist(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GeobufferpointPoint::add(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> GeobufferpointPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GeobufferpointPoint::sub(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> GeobufferpointPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GeobufferpointPoint::scale(
  self : GeobufferpointPoint,
  s : Double,
) -> GeobufferpointPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GeobufferpointPoint::dot(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GeobufferpointPoint::cross(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> GeobufferpointPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GeobufferpointPoint::norm(self : GeobufferpointPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GeobufferpointPoint::normalize(
  self : GeobufferpointPoint,
) -> GeobufferpointPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GeobufferpointPoint::negate(
  self : GeobufferpointPoint,
) -> GeobufferpointPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GeobufferpointPoint::mid(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
) -> GeobufferpointPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GeobufferpointPoint::lerp(
  self : GeobufferpointPoint,
  other : GeobufferpointPoint,
  t : Double,
) -> GeobufferpointPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GeobufferpointPoint::to_string(self : GeobufferpointPoint) -> String {
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
pub(all) struct GeobufferpointSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn geo_buffer_point_make_series(
  vals : Array[Double],
  name : String,
) -> GeobufferpointSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GeobufferpointSeries::len(self : GeobufferpointSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GeobufferpointSeries::sum(self : GeobufferpointSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GeobufferpointSeries::mean(self : GeobufferpointSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GeobufferpointSeries::min(self : GeobufferpointSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GeobufferpointSeries::max(self : GeobufferpointSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GeobufferpointSeries::range(self : GeobufferpointSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GeobufferpointSeries::variance(self : GeobufferpointSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GeobufferpointSeries::std(self : GeobufferpointSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GeobufferpointSeries::median(self : GeobufferpointSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GeobufferpointSeries::scale(
  self : GeobufferpointSeries,
  f : Double,
) -> GeobufferpointSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GeobufferpointSeries::add(
  self : GeobufferpointSeries,
  other : GeobufferpointSeries,
) -> GeobufferpointSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GeobufferpointSeries::sub(
  self : GeobufferpointSeries,
  other : GeobufferpointSeries,
) -> GeobufferpointSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GeobufferpointSeries::normalize(
  self : GeobufferpointSeries,
) -> GeobufferpointSeries {
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
pub fn GeobufferpointSeries::cumsum(
  self : GeobufferpointSeries,
) -> GeobufferpointSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GeobufferpointSeries::to_string(self : GeobufferpointSeries) -> String {
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
pub(all) struct GeobufferpointMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn geo_buffer_point_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GeobufferpointMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn geo_buffer_point_matrix_identity(n : Int32) -> GeobufferpointMatrix {
  let m = geo_buffer_point_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GeobufferpointMatrix::get(
  self : GeobufferpointMatrix,
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
pub fn GeobufferpointMatrix::transpose(
  self : GeobufferpointMatrix,
) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GeobufferpointMatrix::add(
  self : GeobufferpointMatrix,
  other : GeobufferpointMatrix,
) -> GeobufferpointMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = geo_buffer_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GeobufferpointMatrix::scale(
  self : GeobufferpointMatrix,
  s : Double,
) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GeobufferpointMatrix::multiply(
  self : GeobufferpointMatrix,
  other : GeobufferpointMatrix,
) -> GeobufferpointMatrix {
  if self.cols != other.rows {
    return geo_buffer_point_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = geo_buffer_point_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GeobufferpointMatrix::trace(self : GeobufferpointMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GeobufferpointMatrix::det(self : GeobufferpointMatrix) -> Double {
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
pub fn GeobufferpointMatrix::norm(self : GeobufferpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GeobufferpointMatrix::to_string(self : GeobufferpointMatrix) -> String {
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
pub(all) struct GeobufferpointVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn geo_buffer_point_make_vector(
  comps : Array[Double],
) -> GeobufferpointVector {
  { comps, dim: comps.length(), }
}

///|
pub fn geo_buffer_point_vector_zero(dim : Int32) -> GeobufferpointVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GeobufferpointVector::add(
  self : GeobufferpointVector,
  other : GeobufferpointVector,
) -> GeobufferpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GeobufferpointVector::sub(
  self : GeobufferpointVector,
  other : GeobufferpointVector,
) -> GeobufferpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GeobufferpointVector::scale(
  self : GeobufferpointVector,
  s : Double,
) -> GeobufferpointVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GeobufferpointVector::dot(
  self : GeobufferpointVector,
  other : GeobufferpointVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GeobufferpointVector::norm(self : GeobufferpointVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GeobufferpointVector::normalize(
  self : GeobufferpointVector,
) -> GeobufferpointVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GeobufferpointVector::dist(
  self : GeobufferpointVector,
  other : GeobufferpointVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GeobufferpointVector::to_string(self : GeobufferpointVector) -> String {
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
pub(all) struct GeobufferpointFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_frame_make(size : Int32) -> GeobufferpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointFrame::len(self : GeobufferpointFrame) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointFrame::get(
  self : GeobufferpointFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointFrame::set(
  self : GeobufferpointFrame,
  i : Int32,
  v : Double,
) -> GeobufferpointFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointFrame::sum(self : GeobufferpointFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointFrame::mean(self : GeobufferpointFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointFrame::scale(
  self : GeobufferpointFrame,
  f : Double,
) -> GeobufferpointFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointFrame::add(
  self : GeobufferpointFrame,
  other : GeobufferpointFrame,
) -> GeobufferpointFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointFrame::copy(
  self : GeobufferpointFrame,
) -> GeobufferpointFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointFrame::fill(
  self : GeobufferpointFrame,
  v : Double,
) -> GeobufferpointFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointFrame::min(self : GeobufferpointFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointFrame::max(self : GeobufferpointFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointFrame::to_string(self : GeobufferpointFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_table_make(size : Int32) -> GeobufferpointTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointTable::len(self : GeobufferpointTable) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointTable::get(
  self : GeobufferpointTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointTable::set(
  self : GeobufferpointTable,
  i : Int32,
  v : Double,
) -> GeobufferpointTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointTable::sum(self : GeobufferpointTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointTable::mean(self : GeobufferpointTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointTable::scale(
  self : GeobufferpointTable,
  f : Double,
) -> GeobufferpointTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointTable::add(
  self : GeobufferpointTable,
  other : GeobufferpointTable,
) -> GeobufferpointTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointTable::copy(
  self : GeobufferpointTable,
) -> GeobufferpointTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointTable::fill(
  self : GeobufferpointTable,
  v : Double,
) -> GeobufferpointTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointTable::min(self : GeobufferpointTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointTable::max(self : GeobufferpointTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointTable::to_string(self : GeobufferpointTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_graphn_make(size : Int32) -> GeobufferpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointGraphN::len(self : GeobufferpointGraphN) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointGraphN::get(
  self : GeobufferpointGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointGraphN::set(
  self : GeobufferpointGraphN,
  i : Int32,
  v : Double,
) -> GeobufferpointGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointGraphN::sum(self : GeobufferpointGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointGraphN::mean(self : GeobufferpointGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointGraphN::scale(
  self : GeobufferpointGraphN,
  f : Double,
) -> GeobufferpointGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointGraphN::add(
  self : GeobufferpointGraphN,
  other : GeobufferpointGraphN,
) -> GeobufferpointGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointGraphN::copy(
  self : GeobufferpointGraphN,
) -> GeobufferpointGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointGraphN::fill(
  self : GeobufferpointGraphN,
  v : Double,
) -> GeobufferpointGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointGraphN::min(self : GeobufferpointGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointGraphN::max(self : GeobufferpointGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointGraphN::to_string(self : GeobufferpointGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_node_make(size : Int32) -> GeobufferpointNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointNode::len(self : GeobufferpointNode) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointNode::get(self : GeobufferpointNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointNode::set(
  self : GeobufferpointNode,
  i : Int32,
  v : Double,
) -> GeobufferpointNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointNode::sum(self : GeobufferpointNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointNode::mean(self : GeobufferpointNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointNode::scale(
  self : GeobufferpointNode,
  f : Double,
) -> GeobufferpointNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointNode::add(
  self : GeobufferpointNode,
  other : GeobufferpointNode,
) -> GeobufferpointNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointNode::copy(
  self : GeobufferpointNode,
) -> GeobufferpointNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointNode::fill(
  self : GeobufferpointNode,
  v : Double,
) -> GeobufferpointNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointNode::min(self : GeobufferpointNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointNode::max(self : GeobufferpointNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointNode::to_string(self : GeobufferpointNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_edge_make(size : Int32) -> GeobufferpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointEdge::len(self : GeobufferpointEdge) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointEdge::get(self : GeobufferpointEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointEdge::set(
  self : GeobufferpointEdge,
  i : Int32,
  v : Double,
) -> GeobufferpointEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointEdge::sum(self : GeobufferpointEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointEdge::mean(self : GeobufferpointEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointEdge::scale(
  self : GeobufferpointEdge,
  f : Double,
) -> GeobufferpointEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointEdge::add(
  self : GeobufferpointEdge,
  other : GeobufferpointEdge,
) -> GeobufferpointEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointEdge::copy(
  self : GeobufferpointEdge,
) -> GeobufferpointEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointEdge::fill(
  self : GeobufferpointEdge,
  v : Double,
) -> GeobufferpointEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointEdge::min(self : GeobufferpointEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointEdge::max(self : GeobufferpointEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointEdge::to_string(self : GeobufferpointEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_path_make(size : Int32) -> GeobufferpointPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointPath::len(self : GeobufferpointPath) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointPath::get(self : GeobufferpointPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointPath::set(
  self : GeobufferpointPath,
  i : Int32,
  v : Double,
) -> GeobufferpointPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointPath::sum(self : GeobufferpointPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointPath::mean(self : GeobufferpointPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointPath::scale(
  self : GeobufferpointPath,
  f : Double,
) -> GeobufferpointPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointPath::add(
  self : GeobufferpointPath,
  other : GeobufferpointPath,
) -> GeobufferpointPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointPath::copy(
  self : GeobufferpointPath,
) -> GeobufferpointPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointPath::fill(
  self : GeobufferpointPath,
  v : Double,
) -> GeobufferpointPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointPath::min(self : GeobufferpointPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointPath::max(self : GeobufferpointPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointPath::to_string(self : GeobufferpointPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_cluster_make(size : Int32) -> GeobufferpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointCluster::len(self : GeobufferpointCluster) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointCluster::get(
  self : GeobufferpointCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointCluster::set(
  self : GeobufferpointCluster,
  i : Int32,
  v : Double,
) -> GeobufferpointCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCluster::sum(self : GeobufferpointCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointCluster::mean(self : GeobufferpointCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointCluster::scale(
  self : GeobufferpointCluster,
  f : Double,
) -> GeobufferpointCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCluster::add(
  self : GeobufferpointCluster,
  other : GeobufferpointCluster,
) -> GeobufferpointCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointCluster::copy(
  self : GeobufferpointCluster,
) -> GeobufferpointCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCluster::fill(
  self : GeobufferpointCluster,
  v : Double,
) -> GeobufferpointCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCluster::min(self : GeobufferpointCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointCluster::max(self : GeobufferpointCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointCluster::to_string(self : GeobufferpointCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_model_make(size : Int32) -> GeobufferpointModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointModel::len(self : GeobufferpointModel) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointModel::get(
  self : GeobufferpointModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointModel::set(
  self : GeobufferpointModel,
  i : Int32,
  v : Double,
) -> GeobufferpointModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointModel::sum(self : GeobufferpointModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointModel::mean(self : GeobufferpointModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointModel::scale(
  self : GeobufferpointModel,
  f : Double,
) -> GeobufferpointModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointModel::add(
  self : GeobufferpointModel,
  other : GeobufferpointModel,
) -> GeobufferpointModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointModel::copy(
  self : GeobufferpointModel,
) -> GeobufferpointModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointModel::fill(
  self : GeobufferpointModel,
  v : Double,
) -> GeobufferpointModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointModel::min(self : GeobufferpointModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointModel::max(self : GeobufferpointModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointModel::to_string(self : GeobufferpointModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_layer_make(size : Int32) -> GeobufferpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointLayer::len(self : GeobufferpointLayer) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointLayer::get(
  self : GeobufferpointLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointLayer::set(
  self : GeobufferpointLayer,
  i : Int32,
  v : Double,
) -> GeobufferpointLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointLayer::sum(self : GeobufferpointLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointLayer::mean(self : GeobufferpointLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointLayer::scale(
  self : GeobufferpointLayer,
  f : Double,
) -> GeobufferpointLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointLayer::add(
  self : GeobufferpointLayer,
  other : GeobufferpointLayer,
) -> GeobufferpointLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointLayer::copy(
  self : GeobufferpointLayer,
) -> GeobufferpointLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointLayer::fill(
  self : GeobufferpointLayer,
  v : Double,
) -> GeobufferpointLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointLayer::min(self : GeobufferpointLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointLayer::max(self : GeobufferpointLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointLayer::to_string(self : GeobufferpointLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_buffer_make(size : Int32) -> GeobufferpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointBuffer::len(self : GeobufferpointBuffer) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointBuffer::get(
  self : GeobufferpointBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointBuffer::set(
  self : GeobufferpointBuffer,
  i : Int32,
  v : Double,
) -> GeobufferpointBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointBuffer::sum(self : GeobufferpointBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointBuffer::mean(self : GeobufferpointBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointBuffer::scale(
  self : GeobufferpointBuffer,
  f : Double,
) -> GeobufferpointBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointBuffer::add(
  self : GeobufferpointBuffer,
  other : GeobufferpointBuffer,
) -> GeobufferpointBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointBuffer::copy(
  self : GeobufferpointBuffer,
) -> GeobufferpointBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointBuffer::fill(
  self : GeobufferpointBuffer,
  v : Double,
) -> GeobufferpointBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointBuffer::min(self : GeobufferpointBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointBuffer::max(self : GeobufferpointBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointBuffer::to_string(self : GeobufferpointBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_cursor_make(size : Int32) -> GeobufferpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointCursor::len(self : GeobufferpointCursor) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointCursor::get(
  self : GeobufferpointCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointCursor::set(
  self : GeobufferpointCursor,
  i : Int32,
  v : Double,
) -> GeobufferpointCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCursor::sum(self : GeobufferpointCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointCursor::mean(self : GeobufferpointCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointCursor::scale(
  self : GeobufferpointCursor,
  f : Double,
) -> GeobufferpointCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCursor::add(
  self : GeobufferpointCursor,
  other : GeobufferpointCursor,
) -> GeobufferpointCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointCursor::copy(
  self : GeobufferpointCursor,
) -> GeobufferpointCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCursor::fill(
  self : GeobufferpointCursor,
  v : Double,
) -> GeobufferpointCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointCursor::min(self : GeobufferpointCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointCursor::max(self : GeobufferpointCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointCursor::to_string(self : GeobufferpointCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_view_make(size : Int32) -> GeobufferpointView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointView::len(self : GeobufferpointView) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointView::get(self : GeobufferpointView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointView::set(
  self : GeobufferpointView,
  i : Int32,
  v : Double,
) -> GeobufferpointView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointView::sum(self : GeobufferpointView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointView::mean(self : GeobufferpointView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointView::scale(
  self : GeobufferpointView,
  f : Double,
) -> GeobufferpointView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointView::add(
  self : GeobufferpointView,
  other : GeobufferpointView,
) -> GeobufferpointView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointView::copy(
  self : GeobufferpointView,
) -> GeobufferpointView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointView::fill(
  self : GeobufferpointView,
  v : Double,
) -> GeobufferpointView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointView::min(self : GeobufferpointView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointView::max(self : GeobufferpointView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointView::to_string(self : GeobufferpointView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_range_make(size : Int32) -> GeobufferpointRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointRange::len(self : GeobufferpointRange) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointRange::get(
  self : GeobufferpointRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointRange::set(
  self : GeobufferpointRange,
  i : Int32,
  v : Double,
) -> GeobufferpointRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointRange::sum(self : GeobufferpointRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointRange::mean(self : GeobufferpointRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointRange::scale(
  self : GeobufferpointRange,
  f : Double,
) -> GeobufferpointRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointRange::add(
  self : GeobufferpointRange,
  other : GeobufferpointRange,
) -> GeobufferpointRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointRange::copy(
  self : GeobufferpointRange,
) -> GeobufferpointRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointRange::fill(
  self : GeobufferpointRange,
  v : Double,
) -> GeobufferpointRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointRange::min(self : GeobufferpointRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointRange::max(self : GeobufferpointRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointRange::to_string(self : GeobufferpointRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GeobufferpointSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn geo_buffer_point_slice_make(size : Int32) -> GeobufferpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GeobufferpointSlice::len(self : GeobufferpointSlice) -> Int32 {
  self.size
}

///|
pub fn GeobufferpointSlice::get(
  self : GeobufferpointSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GeobufferpointSlice::set(
  self : GeobufferpointSlice,
  i : Int32,
  v : Double,
) -> GeobufferpointSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointSlice::sum(self : GeobufferpointSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GeobufferpointSlice::mean(self : GeobufferpointSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GeobufferpointSlice::scale(
  self : GeobufferpointSlice,
  f : Double,
) -> GeobufferpointSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointSlice::add(
  self : GeobufferpointSlice,
  other : GeobufferpointSlice,
) -> GeobufferpointSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GeobufferpointSlice::copy(
  self : GeobufferpointSlice,
) -> GeobufferpointSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointSlice::fill(
  self : GeobufferpointSlice,
  v : Double,
) -> GeobufferpointSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GeobufferpointSlice::min(self : GeobufferpointSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GeobufferpointSlice::max(self : GeobufferpointSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GeobufferpointSlice::to_string(self : GeobufferpointSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
///===
/// extcore/bio_struct_angle
pub(all) struct BiostructanglePoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn bio_struct_angle_make_point(
  x : Double,
  y : Double,
) -> BiostructanglePoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn bio_struct_angle_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> BiostructanglePoint {
  { x, y, z, label: 0, }
}

///|
pub fn BiostructanglePoint::x(self : BiostructanglePoint) -> Double {
  self.x
}

///|
pub fn BiostructanglePoint::y(self : BiostructanglePoint) -> Double {
  self.y
}

///|
pub fn BiostructanglePoint::z(self : BiostructanglePoint) -> Double {
  self.z
}

///|
pub fn BiostructanglePoint::label(self : BiostructanglePoint) -> Int32 {
  self.label
}

///|
pub fn BiostructanglePoint::dist(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn BiostructanglePoint::add(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> BiostructanglePoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn BiostructanglePoint::sub(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> BiostructanglePoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn BiostructanglePoint::scale(
  self : BiostructanglePoint,
  s : Double,
) -> BiostructanglePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn BiostructanglePoint::dot(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn BiostructanglePoint::cross(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> BiostructanglePoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn BiostructanglePoint::norm(self : BiostructanglePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn BiostructanglePoint::normalize(
  self : BiostructanglePoint,
) -> BiostructanglePoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructanglePoint::negate(
  self : BiostructanglePoint,
) -> BiostructanglePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn BiostructanglePoint::mid(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
) -> BiostructanglePoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn BiostructanglePoint::lerp(
  self : BiostructanglePoint,
  other : BiostructanglePoint,
  t : Double,
) -> BiostructanglePoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn BiostructanglePoint::to_string(self : BiostructanglePoint) -> String {
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
pub(all) struct BiostructangleSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn bio_struct_angle_make_series(
  vals : Array[Double],
  name : String,
) -> BiostructangleSeries {
  { vals, name, meta: 0, }
}

///|
pub fn BiostructangleSeries::len(self : BiostructangleSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn BiostructangleSeries::sum(self : BiostructangleSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn BiostructangleSeries::mean(self : BiostructangleSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn BiostructangleSeries::min(self : BiostructangleSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn BiostructangleSeries::max(self : BiostructangleSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn BiostructangleSeries::range(self : BiostructangleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn BiostructangleSeries::variance(self : BiostructangleSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn BiostructangleSeries::std(self : BiostructangleSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn BiostructangleSeries::median(self : BiostructangleSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn BiostructangleSeries::scale(
  self : BiostructangleSeries,
  f : Double,
) -> BiostructangleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn BiostructangleSeries::add(
  self : BiostructangleSeries,
  other : BiostructangleSeries,
) -> BiostructangleSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructangleSeries::sub(
  self : BiostructangleSeries,
  other : BiostructangleSeries,
) -> BiostructangleSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn BiostructangleSeries::normalize(
  self : BiostructangleSeries,
) -> BiostructangleSeries {
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
pub fn BiostructangleSeries::cumsum(
  self : BiostructangleSeries,
) -> BiostructangleSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn BiostructangleSeries::to_string(self : BiostructangleSeries) -> String {
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
pub(all) struct BiostructangleMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn bio_struct_angle_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> BiostructangleMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn bio_struct_angle_matrix_identity(n : Int32) -> BiostructangleMatrix {
  let m = bio_struct_angle_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn BiostructangleMatrix::get(
  self : BiostructangleMatrix,
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
pub fn BiostructangleMatrix::transpose(
  self : BiostructangleMatrix,
) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructangleMatrix::add(
  self : BiostructangleMatrix,
  other : BiostructangleMatrix,
) -> BiostructangleMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = bio_struct_angle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn BiostructangleMatrix::scale(
  self : BiostructangleMatrix,
  s : Double,
) -> BiostructangleMatrix {
  let result = bio_struct_angle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn BiostructangleMatrix::multiply(
  self : BiostructangleMatrix,
  other : BiostructangleMatrix,
) -> BiostructangleMatrix {
  if self.cols != other.rows {
    return bio_struct_angle_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = bio_struct_angle_make_matrix(self.rows, other.cols, 0.0)
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
pub fn BiostructangleMatrix::trace(self : BiostructangleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn BiostructangleMatrix::det(self : BiostructangleMatrix) -> Double {
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
pub fn BiostructangleMatrix::norm(self : BiostructangleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn BiostructangleMatrix::to_string(self : BiostructangleMatrix) -> String {
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
pub(all) struct BiostructangleVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn bio_struct_angle_make_vector(
  comps : Array[Double],
) -> BiostructangleVector {
  { comps, dim: comps.length(), }
}

///|
pub fn bio_struct_angle_vector_zero(dim : Int32) -> BiostructangleVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn BiostructangleVector::add(
  self : BiostructangleVector,
  other : BiostructangleVector,
) -> BiostructangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructangleVector::sub(
  self : BiostructangleVector,
  other : BiostructangleVector,
) -> BiostructangleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn BiostructangleVector::scale(
  self : BiostructangleVector,
  s : Double,
) -> BiostructangleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn BiostructangleVector::dot(
  self : BiostructangleVector,
  other : BiostructangleVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn BiostructangleVector::norm(self : BiostructangleVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn BiostructangleVector::normalize(
  self : BiostructangleVector,
) -> BiostructangleVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn BiostructangleVector::dist(
  self : BiostructangleVector,
  other : BiostructangleVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn BiostructangleVector::to_string(self : BiostructangleVector) -> String {
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
pub(all) struct BiostructangleFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_frame_make(size : Int32) -> BiostructangleFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleFrame::len(self : BiostructangleFrame) -> Int32 {
  self.size
}

///|
pub fn BiostructangleFrame::get(
  self : BiostructangleFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleFrame::set(
  self : BiostructangleFrame,
  i : Int32,
  v : Double,
) -> BiostructangleFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleFrame::sum(self : BiostructangleFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleFrame::mean(self : BiostructangleFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleFrame::scale(
  self : BiostructangleFrame,
  f : Double,
) -> BiostructangleFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleFrame::add(
  self : BiostructangleFrame,
  other : BiostructangleFrame,
) -> BiostructangleFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleFrame::copy(
  self : BiostructangleFrame,
) -> BiostructangleFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleFrame::fill(
  self : BiostructangleFrame,
  v : Double,
) -> BiostructangleFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleFrame::min(self : BiostructangleFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleFrame::max(self : BiostructangleFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleFrame::to_string(self : BiostructangleFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_table_make(size : Int32) -> BiostructangleTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleTable::len(self : BiostructangleTable) -> Int32 {
  self.size
}

///|
pub fn BiostructangleTable::get(
  self : BiostructangleTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleTable::set(
  self : BiostructangleTable,
  i : Int32,
  v : Double,
) -> BiostructangleTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleTable::sum(self : BiostructangleTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleTable::mean(self : BiostructangleTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleTable::scale(
  self : BiostructangleTable,
  f : Double,
) -> BiostructangleTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleTable::add(
  self : BiostructangleTable,
  other : BiostructangleTable,
) -> BiostructangleTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleTable::copy(
  self : BiostructangleTable,
) -> BiostructangleTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleTable::fill(
  self : BiostructangleTable,
  v : Double,
) -> BiostructangleTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleTable::min(self : BiostructangleTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleTable::max(self : BiostructangleTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleTable::to_string(self : BiostructangleTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_graphn_make(size : Int32) -> BiostructangleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleGraphN::len(self : BiostructangleGraphN) -> Int32 {
  self.size
}

///|
pub fn BiostructangleGraphN::get(
  self : BiostructangleGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleGraphN::set(
  self : BiostructangleGraphN,
  i : Int32,
  v : Double,
) -> BiostructangleGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleGraphN::sum(self : BiostructangleGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleGraphN::mean(self : BiostructangleGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleGraphN::scale(
  self : BiostructangleGraphN,
  f : Double,
) -> BiostructangleGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleGraphN::add(
  self : BiostructangleGraphN,
  other : BiostructangleGraphN,
) -> BiostructangleGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleGraphN::copy(
  self : BiostructangleGraphN,
) -> BiostructangleGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleGraphN::fill(
  self : BiostructangleGraphN,
  v : Double,
) -> BiostructangleGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleGraphN::min(self : BiostructangleGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleGraphN::max(self : BiostructangleGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleGraphN::to_string(self : BiostructangleGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_node_make(size : Int32) -> BiostructangleNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleNode::len(self : BiostructangleNode) -> Int32 {
  self.size
}

///|
pub fn BiostructangleNode::get(self : BiostructangleNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleNode::set(
  self : BiostructangleNode,
  i : Int32,
  v : Double,
) -> BiostructangleNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleNode::sum(self : BiostructangleNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleNode::mean(self : BiostructangleNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleNode::scale(
  self : BiostructangleNode,
  f : Double,
) -> BiostructangleNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleNode::add(
  self : BiostructangleNode,
  other : BiostructangleNode,
) -> BiostructangleNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleNode::copy(
  self : BiostructangleNode,
) -> BiostructangleNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleNode::fill(
  self : BiostructangleNode,
  v : Double,
) -> BiostructangleNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleNode::min(self : BiostructangleNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleNode::max(self : BiostructangleNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleNode::to_string(self : BiostructangleNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_edge_make(size : Int32) -> BiostructangleEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleEdge::len(self : BiostructangleEdge) -> Int32 {
  self.size
}

///|
pub fn BiostructangleEdge::get(self : BiostructangleEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleEdge::set(
  self : BiostructangleEdge,
  i : Int32,
  v : Double,
) -> BiostructangleEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleEdge::sum(self : BiostructangleEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleEdge::mean(self : BiostructangleEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleEdge::scale(
  self : BiostructangleEdge,
  f : Double,
) -> BiostructangleEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleEdge::add(
  self : BiostructangleEdge,
  other : BiostructangleEdge,
) -> BiostructangleEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleEdge::copy(
  self : BiostructangleEdge,
) -> BiostructangleEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleEdge::fill(
  self : BiostructangleEdge,
  v : Double,
) -> BiostructangleEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleEdge::min(self : BiostructangleEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleEdge::max(self : BiostructangleEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleEdge::to_string(self : BiostructangleEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructanglePath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_path_make(size : Int32) -> BiostructanglePath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructanglePath::len(self : BiostructanglePath) -> Int32 {
  self.size
}

///|
pub fn BiostructanglePath::get(self : BiostructanglePath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructanglePath::set(
  self : BiostructanglePath,
  i : Int32,
  v : Double,
) -> BiostructanglePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructanglePath::sum(self : BiostructanglePath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructanglePath::mean(self : BiostructanglePath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructanglePath::scale(
  self : BiostructanglePath,
  f : Double,
) -> BiostructanglePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructanglePath::add(
  self : BiostructanglePath,
  other : BiostructanglePath,
) -> BiostructanglePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructanglePath::copy(
  self : BiostructanglePath,
) -> BiostructanglePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructanglePath::fill(
  self : BiostructanglePath,
  v : Double,
) -> BiostructanglePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructanglePath::min(self : BiostructanglePath) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructanglePath::max(self : BiostructanglePath) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructanglePath::to_string(self : BiostructanglePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_cluster_make(size : Int32) -> BiostructangleCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleCluster::len(self : BiostructangleCluster) -> Int32 {
  self.size
}

///|
pub fn BiostructangleCluster::get(
  self : BiostructangleCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleCluster::set(
  self : BiostructangleCluster,
  i : Int32,
  v : Double,
) -> BiostructangleCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCluster::sum(self : BiostructangleCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleCluster::mean(self : BiostructangleCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleCluster::scale(
  self : BiostructangleCluster,
  f : Double,
) -> BiostructangleCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCluster::add(
  self : BiostructangleCluster,
  other : BiostructangleCluster,
) -> BiostructangleCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleCluster::copy(
  self : BiostructangleCluster,
) -> BiostructangleCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCluster::fill(
  self : BiostructangleCluster,
  v : Double,
) -> BiostructangleCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCluster::min(self : BiostructangleCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleCluster::max(self : BiostructangleCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleCluster::to_string(self : BiostructangleCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_model_make(size : Int32) -> BiostructangleModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleModel::len(self : BiostructangleModel) -> Int32 {
  self.size
}

///|
pub fn BiostructangleModel::get(
  self : BiostructangleModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleModel::set(
  self : BiostructangleModel,
  i : Int32,
  v : Double,
) -> BiostructangleModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleModel::sum(self : BiostructangleModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleModel::mean(self : BiostructangleModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleModel::scale(
  self : BiostructangleModel,
  f : Double,
) -> BiostructangleModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleModel::add(
  self : BiostructangleModel,
  other : BiostructangleModel,
) -> BiostructangleModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleModel::copy(
  self : BiostructangleModel,
) -> BiostructangleModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleModel::fill(
  self : BiostructangleModel,
  v : Double,
) -> BiostructangleModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleModel::min(self : BiostructangleModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleModel::max(self : BiostructangleModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleModel::to_string(self : BiostructangleModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_layer_make(size : Int32) -> BiostructangleLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleLayer::len(self : BiostructangleLayer) -> Int32 {
  self.size
}

///|
pub fn BiostructangleLayer::get(
  self : BiostructangleLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleLayer::set(
  self : BiostructangleLayer,
  i : Int32,
  v : Double,
) -> BiostructangleLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleLayer::sum(self : BiostructangleLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleLayer::mean(self : BiostructangleLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleLayer::scale(
  self : BiostructangleLayer,
  f : Double,
) -> BiostructangleLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleLayer::add(
  self : BiostructangleLayer,
  other : BiostructangleLayer,
) -> BiostructangleLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleLayer::copy(
  self : BiostructangleLayer,
) -> BiostructangleLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleLayer::fill(
  self : BiostructangleLayer,
  v : Double,
) -> BiostructangleLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleLayer::min(self : BiostructangleLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleLayer::max(self : BiostructangleLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleLayer::to_string(self : BiostructangleLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_buffer_make(size : Int32) -> BiostructangleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleBuffer::len(self : BiostructangleBuffer) -> Int32 {
  self.size
}

///|
pub fn BiostructangleBuffer::get(
  self : BiostructangleBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleBuffer::set(
  self : BiostructangleBuffer,
  i : Int32,
  v : Double,
) -> BiostructangleBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleBuffer::sum(self : BiostructangleBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleBuffer::mean(self : BiostructangleBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleBuffer::scale(
  self : BiostructangleBuffer,
  f : Double,
) -> BiostructangleBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleBuffer::add(
  self : BiostructangleBuffer,
  other : BiostructangleBuffer,
) -> BiostructangleBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleBuffer::copy(
  self : BiostructangleBuffer,
) -> BiostructangleBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleBuffer::fill(
  self : BiostructangleBuffer,
  v : Double,
) -> BiostructangleBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleBuffer::min(self : BiostructangleBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleBuffer::max(self : BiostructangleBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleBuffer::to_string(self : BiostructangleBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_cursor_make(size : Int32) -> BiostructangleCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleCursor::len(self : BiostructangleCursor) -> Int32 {
  self.size
}

///|
pub fn BiostructangleCursor::get(
  self : BiostructangleCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleCursor::set(
  self : BiostructangleCursor,
  i : Int32,
  v : Double,
) -> BiostructangleCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCursor::sum(self : BiostructangleCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleCursor::mean(self : BiostructangleCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleCursor::scale(
  self : BiostructangleCursor,
  f : Double,
) -> BiostructangleCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCursor::add(
  self : BiostructangleCursor,
  other : BiostructangleCursor,
) -> BiostructangleCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleCursor::copy(
  self : BiostructangleCursor,
) -> BiostructangleCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCursor::fill(
  self : BiostructangleCursor,
  v : Double,
) -> BiostructangleCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleCursor::min(self : BiostructangleCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleCursor::max(self : BiostructangleCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleCursor::to_string(self : BiostructangleCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_view_make(size : Int32) -> BiostructangleView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleView::len(self : BiostructangleView) -> Int32 {
  self.size
}

///|
pub fn BiostructangleView::get(self : BiostructangleView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleView::set(
  self : BiostructangleView,
  i : Int32,
  v : Double,
) -> BiostructangleView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleView::sum(self : BiostructangleView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleView::mean(self : BiostructangleView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleView::scale(
  self : BiostructangleView,
  f : Double,
) -> BiostructangleView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleView::add(
  self : BiostructangleView,
  other : BiostructangleView,
) -> BiostructangleView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleView::copy(
  self : BiostructangleView,
) -> BiostructangleView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleView::fill(
  self : BiostructangleView,
  v : Double,
) -> BiostructangleView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleView::min(self : BiostructangleView) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleView::max(self : BiostructangleView) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleView::to_string(self : BiostructangleView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_range_make(size : Int32) -> BiostructangleRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleRange::len(self : BiostructangleRange) -> Int32 {
  self.size
}

///|
pub fn BiostructangleRange::get(
  self : BiostructangleRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleRange::set(
  self : BiostructangleRange,
  i : Int32,
  v : Double,
) -> BiostructangleRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleRange::sum(self : BiostructangleRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleRange::mean(self : BiostructangleRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleRange::scale(
  self : BiostructangleRange,
  f : Double,
) -> BiostructangleRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleRange::add(
  self : BiostructangleRange,
  other : BiostructangleRange,
) -> BiostructangleRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleRange::copy(
  self : BiostructangleRange,
) -> BiostructangleRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleRange::fill(
  self : BiostructangleRange,
  v : Double,
) -> BiostructangleRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleRange::min(self : BiostructangleRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleRange::max(self : BiostructangleRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleRange::to_string(self : BiostructangleRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct BiostructangleSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn bio_struct_angle_slice_make(size : Int32) -> BiostructangleSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn BiostructangleSlice::len(self : BiostructangleSlice) -> Int32 {
  self.size
}

///|
pub fn BiostructangleSlice::get(
  self : BiostructangleSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn BiostructangleSlice::set(
  self : BiostructangleSlice,
  i : Int32,
  v : Double,
) -> BiostructangleSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleSlice::sum(self : BiostructangleSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn BiostructangleSlice::mean(self : BiostructangleSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn BiostructangleSlice::scale(
  self : BiostructangleSlice,
  f : Double,
) -> BiostructangleSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleSlice::add(
  self : BiostructangleSlice,
  other : BiostructangleSlice,
) -> BiostructangleSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn BiostructangleSlice::copy(
  self : BiostructangleSlice,
) -> BiostructangleSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleSlice::fill(
  self : BiostructangleSlice,
  v : Double,
) -> BiostructangleSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn BiostructangleSlice::min(self : BiostructangleSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn BiostructangleSlice::max(self : BiostructangleSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn BiostructangleSlice::to_string(self : BiostructangleSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

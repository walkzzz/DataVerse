///|
///===
/// extcore/ds_hash_universal
pub(all) struct DshashuniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_hash_universal_make_point(
  x : Double,
  y : Double,
) -> DshashuniversalPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_hash_universal_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DshashuniversalPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DshashuniversalPoint::x(self : DshashuniversalPoint) -> Double {
  self.x
}

///|
pub fn DshashuniversalPoint::y(self : DshashuniversalPoint) -> Double {
  self.y
}

///|
pub fn DshashuniversalPoint::z(self : DshashuniversalPoint) -> Double {
  self.z
}

///|
pub fn DshashuniversalPoint::label(self : DshashuniversalPoint) -> Int32 {
  self.label
}

///|
pub fn DshashuniversalPoint::dist(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DshashuniversalPoint::add(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> DshashuniversalPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DshashuniversalPoint::sub(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> DshashuniversalPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DshashuniversalPoint::scale(
  self : DshashuniversalPoint,
  s : Double,
) -> DshashuniversalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DshashuniversalPoint::dot(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DshashuniversalPoint::cross(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> DshashuniversalPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DshashuniversalPoint::norm(self : DshashuniversalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DshashuniversalPoint::normalize(
  self : DshashuniversalPoint,
) -> DshashuniversalPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashuniversalPoint::negate(
  self : DshashuniversalPoint,
) -> DshashuniversalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DshashuniversalPoint::mid(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
) -> DshashuniversalPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DshashuniversalPoint::lerp(
  self : DshashuniversalPoint,
  other : DshashuniversalPoint,
  t : Double,
) -> DshashuniversalPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DshashuniversalPoint::to_string(self : DshashuniversalPoint) -> String {
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
pub(all) struct DshashuniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_hash_universal_make_series(
  vals : Array[Double],
  name : String,
) -> DshashuniversalSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DshashuniversalSeries::len(self : DshashuniversalSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DshashuniversalSeries::sum(self : DshashuniversalSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DshashuniversalSeries::mean(self : DshashuniversalSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DshashuniversalSeries::min(self : DshashuniversalSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DshashuniversalSeries::max(self : DshashuniversalSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DshashuniversalSeries::range(self : DshashuniversalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DshashuniversalSeries::variance(self : DshashuniversalSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DshashuniversalSeries::std(self : DshashuniversalSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DshashuniversalSeries::median(self : DshashuniversalSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DshashuniversalSeries::scale(
  self : DshashuniversalSeries,
  f : Double,
) -> DshashuniversalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DshashuniversalSeries::add(
  self : DshashuniversalSeries,
  other : DshashuniversalSeries,
) -> DshashuniversalSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashuniversalSeries::sub(
  self : DshashuniversalSeries,
  other : DshashuniversalSeries,
) -> DshashuniversalSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashuniversalSeries::normalize(
  self : DshashuniversalSeries,
) -> DshashuniversalSeries {
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
pub fn DshashuniversalSeries::cumsum(
  self : DshashuniversalSeries,
) -> DshashuniversalSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DshashuniversalSeries::to_string(self : DshashuniversalSeries) -> String {
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
pub(all) struct DshashuniversalMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_hash_universal_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DshashuniversalMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_hash_universal_matrix_identity(n : Int32) -> DshashuniversalMatrix {
  let m = ds_hash_universal_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DshashuniversalMatrix::get(
  self : DshashuniversalMatrix,
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
pub fn DshashuniversalMatrix::transpose(
  self : DshashuniversalMatrix,
) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DshashuniversalMatrix::add(
  self : DshashuniversalMatrix,
  other : DshashuniversalMatrix,
) -> DshashuniversalMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_hash_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DshashuniversalMatrix::scale(
  self : DshashuniversalMatrix,
  s : Double,
) -> DshashuniversalMatrix {
  let result = ds_hash_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DshashuniversalMatrix::multiply(
  self : DshashuniversalMatrix,
  other : DshashuniversalMatrix,
) -> DshashuniversalMatrix {
  if self.cols != other.rows {
    return ds_hash_universal_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_hash_universal_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DshashuniversalMatrix::trace(self : DshashuniversalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DshashuniversalMatrix::det(self : DshashuniversalMatrix) -> Double {
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
pub fn DshashuniversalMatrix::norm(self : DshashuniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DshashuniversalMatrix::to_string(self : DshashuniversalMatrix) -> String {
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
pub(all) struct DshashuniversalVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_hash_universal_make_vector(
  comps : Array[Double],
) -> DshashuniversalVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_hash_universal_vector_zero(dim : Int32) -> DshashuniversalVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DshashuniversalVector::add(
  self : DshashuniversalVector,
  other : DshashuniversalVector,
) -> DshashuniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashuniversalVector::sub(
  self : DshashuniversalVector,
  other : DshashuniversalVector,
) -> DshashuniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashuniversalVector::scale(
  self : DshashuniversalVector,
  s : Double,
) -> DshashuniversalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DshashuniversalVector::dot(
  self : DshashuniversalVector,
  other : DshashuniversalVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DshashuniversalVector::norm(self : DshashuniversalVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DshashuniversalVector::normalize(
  self : DshashuniversalVector,
) -> DshashuniversalVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashuniversalVector::dist(
  self : DshashuniversalVector,
  other : DshashuniversalVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DshashuniversalVector::to_string(self : DshashuniversalVector) -> String {
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
pub(all) struct DshashuniversalFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_frame_make(size : Int32) -> DshashuniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalFrame::len(self : DshashuniversalFrame) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalFrame::get(
  self : DshashuniversalFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalFrame::set(
  self : DshashuniversalFrame,
  i : Int32,
  v : Double,
) -> DshashuniversalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalFrame::sum(self : DshashuniversalFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalFrame::mean(self : DshashuniversalFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalFrame::scale(
  self : DshashuniversalFrame,
  f : Double,
) -> DshashuniversalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalFrame::add(
  self : DshashuniversalFrame,
  other : DshashuniversalFrame,
) -> DshashuniversalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalFrame::copy(
  self : DshashuniversalFrame,
) -> DshashuniversalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalFrame::fill(
  self : DshashuniversalFrame,
  v : Double,
) -> DshashuniversalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalFrame::min(self : DshashuniversalFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalFrame::max(self : DshashuniversalFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalFrame::to_string(self : DshashuniversalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_table_make(size : Int32) -> DshashuniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalTable::len(self : DshashuniversalTable) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalTable::get(
  self : DshashuniversalTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalTable::set(
  self : DshashuniversalTable,
  i : Int32,
  v : Double,
) -> DshashuniversalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalTable::sum(self : DshashuniversalTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalTable::mean(self : DshashuniversalTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalTable::scale(
  self : DshashuniversalTable,
  f : Double,
) -> DshashuniversalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalTable::add(
  self : DshashuniversalTable,
  other : DshashuniversalTable,
) -> DshashuniversalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalTable::copy(
  self : DshashuniversalTable,
) -> DshashuniversalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalTable::fill(
  self : DshashuniversalTable,
  v : Double,
) -> DshashuniversalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalTable::min(self : DshashuniversalTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalTable::max(self : DshashuniversalTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalTable::to_string(self : DshashuniversalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_graphn_make(size : Int32) -> DshashuniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalGraphN::len(self : DshashuniversalGraphN) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalGraphN::get(
  self : DshashuniversalGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalGraphN::set(
  self : DshashuniversalGraphN,
  i : Int32,
  v : Double,
) -> DshashuniversalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalGraphN::sum(self : DshashuniversalGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalGraphN::mean(self : DshashuniversalGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalGraphN::scale(
  self : DshashuniversalGraphN,
  f : Double,
) -> DshashuniversalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalGraphN::add(
  self : DshashuniversalGraphN,
  other : DshashuniversalGraphN,
) -> DshashuniversalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalGraphN::copy(
  self : DshashuniversalGraphN,
) -> DshashuniversalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalGraphN::fill(
  self : DshashuniversalGraphN,
  v : Double,
) -> DshashuniversalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalGraphN::min(self : DshashuniversalGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalGraphN::max(self : DshashuniversalGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalGraphN::to_string(self : DshashuniversalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_node_make(size : Int32) -> DshashuniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalNode::len(self : DshashuniversalNode) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalNode::get(
  self : DshashuniversalNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalNode::set(
  self : DshashuniversalNode,
  i : Int32,
  v : Double,
) -> DshashuniversalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalNode::sum(self : DshashuniversalNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalNode::mean(self : DshashuniversalNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalNode::scale(
  self : DshashuniversalNode,
  f : Double,
) -> DshashuniversalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalNode::add(
  self : DshashuniversalNode,
  other : DshashuniversalNode,
) -> DshashuniversalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalNode::copy(
  self : DshashuniversalNode,
) -> DshashuniversalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalNode::fill(
  self : DshashuniversalNode,
  v : Double,
) -> DshashuniversalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalNode::min(self : DshashuniversalNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalNode::max(self : DshashuniversalNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalNode::to_string(self : DshashuniversalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_edge_make(size : Int32) -> DshashuniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalEdge::len(self : DshashuniversalEdge) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalEdge::get(
  self : DshashuniversalEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalEdge::set(
  self : DshashuniversalEdge,
  i : Int32,
  v : Double,
) -> DshashuniversalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalEdge::sum(self : DshashuniversalEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalEdge::mean(self : DshashuniversalEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalEdge::scale(
  self : DshashuniversalEdge,
  f : Double,
) -> DshashuniversalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalEdge::add(
  self : DshashuniversalEdge,
  other : DshashuniversalEdge,
) -> DshashuniversalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalEdge::copy(
  self : DshashuniversalEdge,
) -> DshashuniversalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalEdge::fill(
  self : DshashuniversalEdge,
  v : Double,
) -> DshashuniversalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalEdge::min(self : DshashuniversalEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalEdge::max(self : DshashuniversalEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalEdge::to_string(self : DshashuniversalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_path_make(size : Int32) -> DshashuniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalPath::len(self : DshashuniversalPath) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalPath::get(
  self : DshashuniversalPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalPath::set(
  self : DshashuniversalPath,
  i : Int32,
  v : Double,
) -> DshashuniversalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalPath::sum(self : DshashuniversalPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalPath::mean(self : DshashuniversalPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalPath::scale(
  self : DshashuniversalPath,
  f : Double,
) -> DshashuniversalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalPath::add(
  self : DshashuniversalPath,
  other : DshashuniversalPath,
) -> DshashuniversalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalPath::copy(
  self : DshashuniversalPath,
) -> DshashuniversalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalPath::fill(
  self : DshashuniversalPath,
  v : Double,
) -> DshashuniversalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalPath::min(self : DshashuniversalPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalPath::max(self : DshashuniversalPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalPath::to_string(self : DshashuniversalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_cluster_make(size : Int32) -> DshashuniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalCluster::len(self : DshashuniversalCluster) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalCluster::get(
  self : DshashuniversalCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalCluster::set(
  self : DshashuniversalCluster,
  i : Int32,
  v : Double,
) -> DshashuniversalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCluster::sum(self : DshashuniversalCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalCluster::mean(self : DshashuniversalCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalCluster::scale(
  self : DshashuniversalCluster,
  f : Double,
) -> DshashuniversalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCluster::add(
  self : DshashuniversalCluster,
  other : DshashuniversalCluster,
) -> DshashuniversalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalCluster::copy(
  self : DshashuniversalCluster,
) -> DshashuniversalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCluster::fill(
  self : DshashuniversalCluster,
  v : Double,
) -> DshashuniversalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCluster::min(self : DshashuniversalCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalCluster::max(self : DshashuniversalCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalCluster::to_string(
  self : DshashuniversalCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_model_make(size : Int32) -> DshashuniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalModel::len(self : DshashuniversalModel) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalModel::get(
  self : DshashuniversalModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalModel::set(
  self : DshashuniversalModel,
  i : Int32,
  v : Double,
) -> DshashuniversalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalModel::sum(self : DshashuniversalModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalModel::mean(self : DshashuniversalModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalModel::scale(
  self : DshashuniversalModel,
  f : Double,
) -> DshashuniversalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalModel::add(
  self : DshashuniversalModel,
  other : DshashuniversalModel,
) -> DshashuniversalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalModel::copy(
  self : DshashuniversalModel,
) -> DshashuniversalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalModel::fill(
  self : DshashuniversalModel,
  v : Double,
) -> DshashuniversalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalModel::min(self : DshashuniversalModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalModel::max(self : DshashuniversalModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalModel::to_string(self : DshashuniversalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_layer_make(size : Int32) -> DshashuniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalLayer::len(self : DshashuniversalLayer) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalLayer::get(
  self : DshashuniversalLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalLayer::set(
  self : DshashuniversalLayer,
  i : Int32,
  v : Double,
) -> DshashuniversalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalLayer::sum(self : DshashuniversalLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalLayer::mean(self : DshashuniversalLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalLayer::scale(
  self : DshashuniversalLayer,
  f : Double,
) -> DshashuniversalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalLayer::add(
  self : DshashuniversalLayer,
  other : DshashuniversalLayer,
) -> DshashuniversalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalLayer::copy(
  self : DshashuniversalLayer,
) -> DshashuniversalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalLayer::fill(
  self : DshashuniversalLayer,
  v : Double,
) -> DshashuniversalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalLayer::min(self : DshashuniversalLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalLayer::max(self : DshashuniversalLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalLayer::to_string(self : DshashuniversalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_buffer_make(size : Int32) -> DshashuniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalBuffer::len(self : DshashuniversalBuffer) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalBuffer::get(
  self : DshashuniversalBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalBuffer::set(
  self : DshashuniversalBuffer,
  i : Int32,
  v : Double,
) -> DshashuniversalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalBuffer::sum(self : DshashuniversalBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalBuffer::mean(self : DshashuniversalBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalBuffer::scale(
  self : DshashuniversalBuffer,
  f : Double,
) -> DshashuniversalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalBuffer::add(
  self : DshashuniversalBuffer,
  other : DshashuniversalBuffer,
) -> DshashuniversalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalBuffer::copy(
  self : DshashuniversalBuffer,
) -> DshashuniversalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalBuffer::fill(
  self : DshashuniversalBuffer,
  v : Double,
) -> DshashuniversalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalBuffer::min(self : DshashuniversalBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalBuffer::max(self : DshashuniversalBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalBuffer::to_string(self : DshashuniversalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_cursor_make(size : Int32) -> DshashuniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalCursor::len(self : DshashuniversalCursor) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalCursor::get(
  self : DshashuniversalCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalCursor::set(
  self : DshashuniversalCursor,
  i : Int32,
  v : Double,
) -> DshashuniversalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCursor::sum(self : DshashuniversalCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalCursor::mean(self : DshashuniversalCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalCursor::scale(
  self : DshashuniversalCursor,
  f : Double,
) -> DshashuniversalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCursor::add(
  self : DshashuniversalCursor,
  other : DshashuniversalCursor,
) -> DshashuniversalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalCursor::copy(
  self : DshashuniversalCursor,
) -> DshashuniversalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCursor::fill(
  self : DshashuniversalCursor,
  v : Double,
) -> DshashuniversalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalCursor::min(self : DshashuniversalCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalCursor::max(self : DshashuniversalCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalCursor::to_string(self : DshashuniversalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_view_make(size : Int32) -> DshashuniversalView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalView::len(self : DshashuniversalView) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalView::get(
  self : DshashuniversalView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalView::set(
  self : DshashuniversalView,
  i : Int32,
  v : Double,
) -> DshashuniversalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalView::sum(self : DshashuniversalView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalView::mean(self : DshashuniversalView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalView::scale(
  self : DshashuniversalView,
  f : Double,
) -> DshashuniversalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalView::add(
  self : DshashuniversalView,
  other : DshashuniversalView,
) -> DshashuniversalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalView::copy(
  self : DshashuniversalView,
) -> DshashuniversalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalView::fill(
  self : DshashuniversalView,
  v : Double,
) -> DshashuniversalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalView::min(self : DshashuniversalView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalView::max(self : DshashuniversalView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalView::to_string(self : DshashuniversalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_range_make(size : Int32) -> DshashuniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalRange::len(self : DshashuniversalRange) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalRange::get(
  self : DshashuniversalRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalRange::set(
  self : DshashuniversalRange,
  i : Int32,
  v : Double,
) -> DshashuniversalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalRange::sum(self : DshashuniversalRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalRange::mean(self : DshashuniversalRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalRange::scale(
  self : DshashuniversalRange,
  f : Double,
) -> DshashuniversalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalRange::add(
  self : DshashuniversalRange,
  other : DshashuniversalRange,
) -> DshashuniversalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalRange::copy(
  self : DshashuniversalRange,
) -> DshashuniversalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalRange::fill(
  self : DshashuniversalRange,
  v : Double,
) -> DshashuniversalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalRange::min(self : DshashuniversalRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalRange::max(self : DshashuniversalRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalRange::to_string(self : DshashuniversalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashuniversalSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_universal_slice_make(size : Int32) -> DshashuniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashuniversalSlice::len(self : DshashuniversalSlice) -> Int32 {
  self.size
}

///|
pub fn DshashuniversalSlice::get(
  self : DshashuniversalSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashuniversalSlice::set(
  self : DshashuniversalSlice,
  i : Int32,
  v : Double,
) -> DshashuniversalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalSlice::sum(self : DshashuniversalSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashuniversalSlice::mean(self : DshashuniversalSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashuniversalSlice::scale(
  self : DshashuniversalSlice,
  f : Double,
) -> DshashuniversalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalSlice::add(
  self : DshashuniversalSlice,
  other : DshashuniversalSlice,
) -> DshashuniversalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashuniversalSlice::copy(
  self : DshashuniversalSlice,
) -> DshashuniversalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalSlice::fill(
  self : DshashuniversalSlice,
  v : Double,
) -> DshashuniversalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashuniversalSlice::min(self : DshashuniversalSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashuniversalSlice::max(self : DshashuniversalSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashuniversalSlice::to_string(self : DshashuniversalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

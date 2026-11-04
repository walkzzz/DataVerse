///|
///===
/// extcore/ds_hash_closed
pub(all) struct DshashclosedPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_hash_closed_make_point(x : Double, y : Double) -> DshashclosedPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_hash_closed_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DshashclosedPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DshashclosedPoint::x(self : DshashclosedPoint) -> Double {
  self.x
}

///|
pub fn DshashclosedPoint::y(self : DshashclosedPoint) -> Double {
  self.y
}

///|
pub fn DshashclosedPoint::z(self : DshashclosedPoint) -> Double {
  self.z
}

///|
pub fn DshashclosedPoint::label(self : DshashclosedPoint) -> Int32 {
  self.label
}

///|
pub fn DshashclosedPoint::dist(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DshashclosedPoint::add(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> DshashclosedPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DshashclosedPoint::sub(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> DshashclosedPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DshashclosedPoint::scale(
  self : DshashclosedPoint,
  s : Double,
) -> DshashclosedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DshashclosedPoint::dot(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DshashclosedPoint::cross(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> DshashclosedPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DshashclosedPoint::norm(self : DshashclosedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DshashclosedPoint::normalize(
  self : DshashclosedPoint,
) -> DshashclosedPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashclosedPoint::negate(self : DshashclosedPoint) -> DshashclosedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DshashclosedPoint::mid(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
) -> DshashclosedPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DshashclosedPoint::lerp(
  self : DshashclosedPoint,
  other : DshashclosedPoint,
  t : Double,
) -> DshashclosedPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DshashclosedPoint::to_string(self : DshashclosedPoint) -> String {
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
pub(all) struct DshashclosedSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_hash_closed_make_series(
  vals : Array[Double],
  name : String,
) -> DshashclosedSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DshashclosedSeries::len(self : DshashclosedSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DshashclosedSeries::sum(self : DshashclosedSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DshashclosedSeries::mean(self : DshashclosedSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DshashclosedSeries::min(self : DshashclosedSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DshashclosedSeries::max(self : DshashclosedSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DshashclosedSeries::range(self : DshashclosedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DshashclosedSeries::variance(self : DshashclosedSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DshashclosedSeries::std(self : DshashclosedSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DshashclosedSeries::median(self : DshashclosedSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DshashclosedSeries::scale(
  self : DshashclosedSeries,
  f : Double,
) -> DshashclosedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DshashclosedSeries::add(
  self : DshashclosedSeries,
  other : DshashclosedSeries,
) -> DshashclosedSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashclosedSeries::sub(
  self : DshashclosedSeries,
  other : DshashclosedSeries,
) -> DshashclosedSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DshashclosedSeries::normalize(
  self : DshashclosedSeries,
) -> DshashclosedSeries {
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
pub fn DshashclosedSeries::cumsum(
  self : DshashclosedSeries,
) -> DshashclosedSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DshashclosedSeries::to_string(self : DshashclosedSeries) -> String {
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
pub(all) struct DshashclosedMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_hash_closed_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DshashclosedMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_hash_closed_matrix_identity(n : Int32) -> DshashclosedMatrix {
  let m = ds_hash_closed_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DshashclosedMatrix::get(
  self : DshashclosedMatrix,
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
pub fn DshashclosedMatrix::transpose(
  self : DshashclosedMatrix,
) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DshashclosedMatrix::add(
  self : DshashclosedMatrix,
  other : DshashclosedMatrix,
) -> DshashclosedMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_hash_closed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DshashclosedMatrix::scale(
  self : DshashclosedMatrix,
  s : Double,
) -> DshashclosedMatrix {
  let result = ds_hash_closed_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DshashclosedMatrix::multiply(
  self : DshashclosedMatrix,
  other : DshashclosedMatrix,
) -> DshashclosedMatrix {
  if self.cols != other.rows {
    return ds_hash_closed_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_hash_closed_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DshashclosedMatrix::trace(self : DshashclosedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DshashclosedMatrix::det(self : DshashclosedMatrix) -> Double {
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
pub fn DshashclosedMatrix::norm(self : DshashclosedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DshashclosedMatrix::to_string(self : DshashclosedMatrix) -> String {
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
pub(all) struct DshashclosedVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_hash_closed_make_vector(comps : Array[Double]) -> DshashclosedVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_hash_closed_vector_zero(dim : Int32) -> DshashclosedVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DshashclosedVector::add(
  self : DshashclosedVector,
  other : DshashclosedVector,
) -> DshashclosedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashclosedVector::sub(
  self : DshashclosedVector,
  other : DshashclosedVector,
) -> DshashclosedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DshashclosedVector::scale(
  self : DshashclosedVector,
  s : Double,
) -> DshashclosedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DshashclosedVector::dot(
  self : DshashclosedVector,
  other : DshashclosedVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DshashclosedVector::norm(self : DshashclosedVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DshashclosedVector::normalize(
  self : DshashclosedVector,
) -> DshashclosedVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DshashclosedVector::dist(
  self : DshashclosedVector,
  other : DshashclosedVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DshashclosedVector::to_string(self : DshashclosedVector) -> String {
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
pub(all) struct DshashclosedFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_frame_make(size : Int32) -> DshashclosedFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedFrame::len(self : DshashclosedFrame) -> Int32 {
  self.size
}

///|
pub fn DshashclosedFrame::get(self : DshashclosedFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedFrame::set(
  self : DshashclosedFrame,
  i : Int32,
  v : Double,
) -> DshashclosedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedFrame::sum(self : DshashclosedFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedFrame::mean(self : DshashclosedFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedFrame::scale(
  self : DshashclosedFrame,
  f : Double,
) -> DshashclosedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedFrame::add(
  self : DshashclosedFrame,
  other : DshashclosedFrame,
) -> DshashclosedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedFrame::copy(self : DshashclosedFrame) -> DshashclosedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedFrame::fill(
  self : DshashclosedFrame,
  v : Double,
) -> DshashclosedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedFrame::min(self : DshashclosedFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedFrame::max(self : DshashclosedFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedFrame::to_string(self : DshashclosedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_table_make(size : Int32) -> DshashclosedTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedTable::len(self : DshashclosedTable) -> Int32 {
  self.size
}

///|
pub fn DshashclosedTable::get(self : DshashclosedTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedTable::set(
  self : DshashclosedTable,
  i : Int32,
  v : Double,
) -> DshashclosedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedTable::sum(self : DshashclosedTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedTable::mean(self : DshashclosedTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedTable::scale(
  self : DshashclosedTable,
  f : Double,
) -> DshashclosedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedTable::add(
  self : DshashclosedTable,
  other : DshashclosedTable,
) -> DshashclosedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedTable::copy(self : DshashclosedTable) -> DshashclosedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedTable::fill(
  self : DshashclosedTable,
  v : Double,
) -> DshashclosedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedTable::min(self : DshashclosedTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedTable::max(self : DshashclosedTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedTable::to_string(self : DshashclosedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_graphn_make(size : Int32) -> DshashclosedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedGraphN::len(self : DshashclosedGraphN) -> Int32 {
  self.size
}

///|
pub fn DshashclosedGraphN::get(self : DshashclosedGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedGraphN::set(
  self : DshashclosedGraphN,
  i : Int32,
  v : Double,
) -> DshashclosedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedGraphN::sum(self : DshashclosedGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedGraphN::mean(self : DshashclosedGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedGraphN::scale(
  self : DshashclosedGraphN,
  f : Double,
) -> DshashclosedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedGraphN::add(
  self : DshashclosedGraphN,
  other : DshashclosedGraphN,
) -> DshashclosedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedGraphN::copy(
  self : DshashclosedGraphN,
) -> DshashclosedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedGraphN::fill(
  self : DshashclosedGraphN,
  v : Double,
) -> DshashclosedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedGraphN::min(self : DshashclosedGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedGraphN::max(self : DshashclosedGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedGraphN::to_string(self : DshashclosedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_node_make(size : Int32) -> DshashclosedNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedNode::len(self : DshashclosedNode) -> Int32 {
  self.size
}

///|
pub fn DshashclosedNode::get(self : DshashclosedNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedNode::set(
  self : DshashclosedNode,
  i : Int32,
  v : Double,
) -> DshashclosedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedNode::sum(self : DshashclosedNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedNode::mean(self : DshashclosedNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedNode::scale(
  self : DshashclosedNode,
  f : Double,
) -> DshashclosedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedNode::add(
  self : DshashclosedNode,
  other : DshashclosedNode,
) -> DshashclosedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedNode::copy(self : DshashclosedNode) -> DshashclosedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedNode::fill(
  self : DshashclosedNode,
  v : Double,
) -> DshashclosedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedNode::min(self : DshashclosedNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedNode::max(self : DshashclosedNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedNode::to_string(self : DshashclosedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_edge_make(size : Int32) -> DshashclosedEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedEdge::len(self : DshashclosedEdge) -> Int32 {
  self.size
}

///|
pub fn DshashclosedEdge::get(self : DshashclosedEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedEdge::set(
  self : DshashclosedEdge,
  i : Int32,
  v : Double,
) -> DshashclosedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedEdge::sum(self : DshashclosedEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedEdge::mean(self : DshashclosedEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedEdge::scale(
  self : DshashclosedEdge,
  f : Double,
) -> DshashclosedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedEdge::add(
  self : DshashclosedEdge,
  other : DshashclosedEdge,
) -> DshashclosedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedEdge::copy(self : DshashclosedEdge) -> DshashclosedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedEdge::fill(
  self : DshashclosedEdge,
  v : Double,
) -> DshashclosedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedEdge::min(self : DshashclosedEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedEdge::max(self : DshashclosedEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedEdge::to_string(self : DshashclosedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_path_make(size : Int32) -> DshashclosedPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedPath::len(self : DshashclosedPath) -> Int32 {
  self.size
}

///|
pub fn DshashclosedPath::get(self : DshashclosedPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedPath::set(
  self : DshashclosedPath,
  i : Int32,
  v : Double,
) -> DshashclosedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedPath::sum(self : DshashclosedPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedPath::mean(self : DshashclosedPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedPath::scale(
  self : DshashclosedPath,
  f : Double,
) -> DshashclosedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedPath::add(
  self : DshashclosedPath,
  other : DshashclosedPath,
) -> DshashclosedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedPath::copy(self : DshashclosedPath) -> DshashclosedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedPath::fill(
  self : DshashclosedPath,
  v : Double,
) -> DshashclosedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedPath::min(self : DshashclosedPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedPath::max(self : DshashclosedPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedPath::to_string(self : DshashclosedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_cluster_make(size : Int32) -> DshashclosedCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedCluster::len(self : DshashclosedCluster) -> Int32 {
  self.size
}

///|
pub fn DshashclosedCluster::get(
  self : DshashclosedCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedCluster::set(
  self : DshashclosedCluster,
  i : Int32,
  v : Double,
) -> DshashclosedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCluster::sum(self : DshashclosedCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedCluster::mean(self : DshashclosedCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedCluster::scale(
  self : DshashclosedCluster,
  f : Double,
) -> DshashclosedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCluster::add(
  self : DshashclosedCluster,
  other : DshashclosedCluster,
) -> DshashclosedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedCluster::copy(
  self : DshashclosedCluster,
) -> DshashclosedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCluster::fill(
  self : DshashclosedCluster,
  v : Double,
) -> DshashclosedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCluster::min(self : DshashclosedCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedCluster::max(self : DshashclosedCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedCluster::to_string(self : DshashclosedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_model_make(size : Int32) -> DshashclosedModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedModel::len(self : DshashclosedModel) -> Int32 {
  self.size
}

///|
pub fn DshashclosedModel::get(self : DshashclosedModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedModel::set(
  self : DshashclosedModel,
  i : Int32,
  v : Double,
) -> DshashclosedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedModel::sum(self : DshashclosedModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedModel::mean(self : DshashclosedModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedModel::scale(
  self : DshashclosedModel,
  f : Double,
) -> DshashclosedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedModel::add(
  self : DshashclosedModel,
  other : DshashclosedModel,
) -> DshashclosedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedModel::copy(self : DshashclosedModel) -> DshashclosedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedModel::fill(
  self : DshashclosedModel,
  v : Double,
) -> DshashclosedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedModel::min(self : DshashclosedModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedModel::max(self : DshashclosedModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedModel::to_string(self : DshashclosedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_layer_make(size : Int32) -> DshashclosedLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedLayer::len(self : DshashclosedLayer) -> Int32 {
  self.size
}

///|
pub fn DshashclosedLayer::get(self : DshashclosedLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedLayer::set(
  self : DshashclosedLayer,
  i : Int32,
  v : Double,
) -> DshashclosedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedLayer::sum(self : DshashclosedLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedLayer::mean(self : DshashclosedLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedLayer::scale(
  self : DshashclosedLayer,
  f : Double,
) -> DshashclosedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedLayer::add(
  self : DshashclosedLayer,
  other : DshashclosedLayer,
) -> DshashclosedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedLayer::copy(self : DshashclosedLayer) -> DshashclosedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedLayer::fill(
  self : DshashclosedLayer,
  v : Double,
) -> DshashclosedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedLayer::min(self : DshashclosedLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedLayer::max(self : DshashclosedLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedLayer::to_string(self : DshashclosedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_buffer_make(size : Int32) -> DshashclosedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedBuffer::len(self : DshashclosedBuffer) -> Int32 {
  self.size
}

///|
pub fn DshashclosedBuffer::get(self : DshashclosedBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedBuffer::set(
  self : DshashclosedBuffer,
  i : Int32,
  v : Double,
) -> DshashclosedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedBuffer::sum(self : DshashclosedBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedBuffer::mean(self : DshashclosedBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedBuffer::scale(
  self : DshashclosedBuffer,
  f : Double,
) -> DshashclosedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedBuffer::add(
  self : DshashclosedBuffer,
  other : DshashclosedBuffer,
) -> DshashclosedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedBuffer::copy(
  self : DshashclosedBuffer,
) -> DshashclosedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedBuffer::fill(
  self : DshashclosedBuffer,
  v : Double,
) -> DshashclosedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedBuffer::min(self : DshashclosedBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedBuffer::max(self : DshashclosedBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedBuffer::to_string(self : DshashclosedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_cursor_make(size : Int32) -> DshashclosedCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedCursor::len(self : DshashclosedCursor) -> Int32 {
  self.size
}

///|
pub fn DshashclosedCursor::get(self : DshashclosedCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedCursor::set(
  self : DshashclosedCursor,
  i : Int32,
  v : Double,
) -> DshashclosedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCursor::sum(self : DshashclosedCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedCursor::mean(self : DshashclosedCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedCursor::scale(
  self : DshashclosedCursor,
  f : Double,
) -> DshashclosedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCursor::add(
  self : DshashclosedCursor,
  other : DshashclosedCursor,
) -> DshashclosedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedCursor::copy(
  self : DshashclosedCursor,
) -> DshashclosedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCursor::fill(
  self : DshashclosedCursor,
  v : Double,
) -> DshashclosedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedCursor::min(self : DshashclosedCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedCursor::max(self : DshashclosedCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedCursor::to_string(self : DshashclosedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_view_make(size : Int32) -> DshashclosedView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedView::len(self : DshashclosedView) -> Int32 {
  self.size
}

///|
pub fn DshashclosedView::get(self : DshashclosedView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedView::set(
  self : DshashclosedView,
  i : Int32,
  v : Double,
) -> DshashclosedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedView::sum(self : DshashclosedView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedView::mean(self : DshashclosedView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedView::scale(
  self : DshashclosedView,
  f : Double,
) -> DshashclosedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedView::add(
  self : DshashclosedView,
  other : DshashclosedView,
) -> DshashclosedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedView::copy(self : DshashclosedView) -> DshashclosedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedView::fill(
  self : DshashclosedView,
  v : Double,
) -> DshashclosedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedView::min(self : DshashclosedView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedView::max(self : DshashclosedView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedView::to_string(self : DshashclosedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_range_make(size : Int32) -> DshashclosedRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedRange::len(self : DshashclosedRange) -> Int32 {
  self.size
}

///|
pub fn DshashclosedRange::get(self : DshashclosedRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedRange::set(
  self : DshashclosedRange,
  i : Int32,
  v : Double,
) -> DshashclosedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedRange::sum(self : DshashclosedRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedRange::mean(self : DshashclosedRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedRange::scale(
  self : DshashclosedRange,
  f : Double,
) -> DshashclosedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedRange::add(
  self : DshashclosedRange,
  other : DshashclosedRange,
) -> DshashclosedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedRange::copy(self : DshashclosedRange) -> DshashclosedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedRange::fill(
  self : DshashclosedRange,
  v : Double,
) -> DshashclosedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedRange::min(self : DshashclosedRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedRange::max(self : DshashclosedRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedRange::to_string(self : DshashclosedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DshashclosedSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_hash_closed_slice_make(size : Int32) -> DshashclosedSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DshashclosedSlice::len(self : DshashclosedSlice) -> Int32 {
  self.size
}

///|
pub fn DshashclosedSlice::get(self : DshashclosedSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DshashclosedSlice::set(
  self : DshashclosedSlice,
  i : Int32,
  v : Double,
) -> DshashclosedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedSlice::sum(self : DshashclosedSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DshashclosedSlice::mean(self : DshashclosedSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DshashclosedSlice::scale(
  self : DshashclosedSlice,
  f : Double,
) -> DshashclosedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedSlice::add(
  self : DshashclosedSlice,
  other : DshashclosedSlice,
) -> DshashclosedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DshashclosedSlice::copy(self : DshashclosedSlice) -> DshashclosedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedSlice::fill(
  self : DshashclosedSlice,
  v : Double,
) -> DshashclosedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DshashclosedSlice::min(self : DshashclosedSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DshashclosedSlice::max(self : DshashclosedSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DshashclosedSlice::to_string(self : DshashclosedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

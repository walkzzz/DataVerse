///|
///===
/// extcore/db_store_spatial
pub(all) struct DbstorespatialPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_store_spatial_make_point(
  x : Double,
  y : Double,
) -> DbstorespatialPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_store_spatial_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbstorespatialPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbstorespatialPoint::x(self : DbstorespatialPoint) -> Double {
  self.x
}

///|
pub fn DbstorespatialPoint::y(self : DbstorespatialPoint) -> Double {
  self.y
}

///|
pub fn DbstorespatialPoint::z(self : DbstorespatialPoint) -> Double {
  self.z
}

///|
pub fn DbstorespatialPoint::label(self : DbstorespatialPoint) -> Int32 {
  self.label
}

///|
pub fn DbstorespatialPoint::dist(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbstorespatialPoint::add(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> DbstorespatialPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbstorespatialPoint::sub(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> DbstorespatialPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbstorespatialPoint::scale(
  self : DbstorespatialPoint,
  s : Double,
) -> DbstorespatialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbstorespatialPoint::dot(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbstorespatialPoint::cross(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> DbstorespatialPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbstorespatialPoint::norm(self : DbstorespatialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbstorespatialPoint::normalize(
  self : DbstorespatialPoint,
) -> DbstorespatialPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbstorespatialPoint::negate(
  self : DbstorespatialPoint,
) -> DbstorespatialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbstorespatialPoint::mid(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
) -> DbstorespatialPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbstorespatialPoint::lerp(
  self : DbstorespatialPoint,
  other : DbstorespatialPoint,
  t : Double,
) -> DbstorespatialPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbstorespatialPoint::to_string(self : DbstorespatialPoint) -> String {
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
pub(all) struct DbstorespatialSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_store_spatial_make_series(
  vals : Array[Double],
  name : String,
) -> DbstorespatialSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbstorespatialSeries::len(self : DbstorespatialSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbstorespatialSeries::sum(self : DbstorespatialSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbstorespatialSeries::mean(self : DbstorespatialSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbstorespatialSeries::min(self : DbstorespatialSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbstorespatialSeries::max(self : DbstorespatialSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbstorespatialSeries::range(self : DbstorespatialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbstorespatialSeries::variance(self : DbstorespatialSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbstorespatialSeries::std(self : DbstorespatialSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbstorespatialSeries::median(self : DbstorespatialSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbstorespatialSeries::scale(
  self : DbstorespatialSeries,
  f : Double,
) -> DbstorespatialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbstorespatialSeries::add(
  self : DbstorespatialSeries,
  other : DbstorespatialSeries,
) -> DbstorespatialSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbstorespatialSeries::sub(
  self : DbstorespatialSeries,
  other : DbstorespatialSeries,
) -> DbstorespatialSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbstorespatialSeries::normalize(
  self : DbstorespatialSeries,
) -> DbstorespatialSeries {
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
pub fn DbstorespatialSeries::cumsum(
  self : DbstorespatialSeries,
) -> DbstorespatialSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbstorespatialSeries::to_string(self : DbstorespatialSeries) -> String {
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
pub(all) struct DbstorespatialMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_store_spatial_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbstorespatialMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_store_spatial_matrix_identity(n : Int32) -> DbstorespatialMatrix {
  let m = db_store_spatial_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbstorespatialMatrix::get(
  self : DbstorespatialMatrix,
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
pub fn DbstorespatialMatrix::transpose(
  self : DbstorespatialMatrix,
) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbstorespatialMatrix::add(
  self : DbstorespatialMatrix,
  other : DbstorespatialMatrix,
) -> DbstorespatialMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_store_spatial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbstorespatialMatrix::scale(
  self : DbstorespatialMatrix,
  s : Double,
) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbstorespatialMatrix::multiply(
  self : DbstorespatialMatrix,
  other : DbstorespatialMatrix,
) -> DbstorespatialMatrix {
  if self.cols != other.rows {
    return db_store_spatial_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_store_spatial_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbstorespatialMatrix::trace(self : DbstorespatialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbstorespatialMatrix::det(self : DbstorespatialMatrix) -> Double {
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
pub fn DbstorespatialMatrix::norm(self : DbstorespatialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbstorespatialMatrix::to_string(self : DbstorespatialMatrix) -> String {
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
pub(all) struct DbstorespatialVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_store_spatial_make_vector(
  comps : Array[Double],
) -> DbstorespatialVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_store_spatial_vector_zero(dim : Int32) -> DbstorespatialVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbstorespatialVector::add(
  self : DbstorespatialVector,
  other : DbstorespatialVector,
) -> DbstorespatialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbstorespatialVector::sub(
  self : DbstorespatialVector,
  other : DbstorespatialVector,
) -> DbstorespatialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbstorespatialVector::scale(
  self : DbstorespatialVector,
  s : Double,
) -> DbstorespatialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbstorespatialVector::dot(
  self : DbstorespatialVector,
  other : DbstorespatialVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbstorespatialVector::norm(self : DbstorespatialVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbstorespatialVector::normalize(
  self : DbstorespatialVector,
) -> DbstorespatialVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbstorespatialVector::dist(
  self : DbstorespatialVector,
  other : DbstorespatialVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbstorespatialVector::to_string(self : DbstorespatialVector) -> String {
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
pub(all) struct DbstorespatialFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_frame_make(size : Int32) -> DbstorespatialFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialFrame::len(self : DbstorespatialFrame) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialFrame::get(
  self : DbstorespatialFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialFrame::set(
  self : DbstorespatialFrame,
  i : Int32,
  v : Double,
) -> DbstorespatialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialFrame::sum(self : DbstorespatialFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialFrame::mean(self : DbstorespatialFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialFrame::scale(
  self : DbstorespatialFrame,
  f : Double,
) -> DbstorespatialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialFrame::add(
  self : DbstorespatialFrame,
  other : DbstorespatialFrame,
) -> DbstorespatialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialFrame::copy(
  self : DbstorespatialFrame,
) -> DbstorespatialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialFrame::fill(
  self : DbstorespatialFrame,
  v : Double,
) -> DbstorespatialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialFrame::min(self : DbstorespatialFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialFrame::max(self : DbstorespatialFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialFrame::to_string(self : DbstorespatialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_table_make(size : Int32) -> DbstorespatialTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialTable::len(self : DbstorespatialTable) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialTable::get(
  self : DbstorespatialTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialTable::set(
  self : DbstorespatialTable,
  i : Int32,
  v : Double,
) -> DbstorespatialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialTable::sum(self : DbstorespatialTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialTable::mean(self : DbstorespatialTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialTable::scale(
  self : DbstorespatialTable,
  f : Double,
) -> DbstorespatialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialTable::add(
  self : DbstorespatialTable,
  other : DbstorespatialTable,
) -> DbstorespatialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialTable::copy(
  self : DbstorespatialTable,
) -> DbstorespatialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialTable::fill(
  self : DbstorespatialTable,
  v : Double,
) -> DbstorespatialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialTable::min(self : DbstorespatialTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialTable::max(self : DbstorespatialTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialTable::to_string(self : DbstorespatialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_graphn_make(size : Int32) -> DbstorespatialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialGraphN::len(self : DbstorespatialGraphN) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialGraphN::get(
  self : DbstorespatialGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialGraphN::set(
  self : DbstorespatialGraphN,
  i : Int32,
  v : Double,
) -> DbstorespatialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialGraphN::sum(self : DbstorespatialGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialGraphN::mean(self : DbstorespatialGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialGraphN::scale(
  self : DbstorespatialGraphN,
  f : Double,
) -> DbstorespatialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialGraphN::add(
  self : DbstorespatialGraphN,
  other : DbstorespatialGraphN,
) -> DbstorespatialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialGraphN::copy(
  self : DbstorespatialGraphN,
) -> DbstorespatialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialGraphN::fill(
  self : DbstorespatialGraphN,
  v : Double,
) -> DbstorespatialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialGraphN::min(self : DbstorespatialGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialGraphN::max(self : DbstorespatialGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialGraphN::to_string(self : DbstorespatialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_node_make(size : Int32) -> DbstorespatialNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialNode::len(self : DbstorespatialNode) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialNode::get(self : DbstorespatialNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialNode::set(
  self : DbstorespatialNode,
  i : Int32,
  v : Double,
) -> DbstorespatialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialNode::sum(self : DbstorespatialNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialNode::mean(self : DbstorespatialNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialNode::scale(
  self : DbstorespatialNode,
  f : Double,
) -> DbstorespatialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialNode::add(
  self : DbstorespatialNode,
  other : DbstorespatialNode,
) -> DbstorespatialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialNode::copy(
  self : DbstorespatialNode,
) -> DbstorespatialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialNode::fill(
  self : DbstorespatialNode,
  v : Double,
) -> DbstorespatialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialNode::min(self : DbstorespatialNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialNode::max(self : DbstorespatialNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialNode::to_string(self : DbstorespatialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_edge_make(size : Int32) -> DbstorespatialEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialEdge::len(self : DbstorespatialEdge) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialEdge::get(self : DbstorespatialEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialEdge::set(
  self : DbstorespatialEdge,
  i : Int32,
  v : Double,
) -> DbstorespatialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialEdge::sum(self : DbstorespatialEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialEdge::mean(self : DbstorespatialEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialEdge::scale(
  self : DbstorespatialEdge,
  f : Double,
) -> DbstorespatialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialEdge::add(
  self : DbstorespatialEdge,
  other : DbstorespatialEdge,
) -> DbstorespatialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialEdge::copy(
  self : DbstorespatialEdge,
) -> DbstorespatialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialEdge::fill(
  self : DbstorespatialEdge,
  v : Double,
) -> DbstorespatialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialEdge::min(self : DbstorespatialEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialEdge::max(self : DbstorespatialEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialEdge::to_string(self : DbstorespatialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_path_make(size : Int32) -> DbstorespatialPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialPath::len(self : DbstorespatialPath) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialPath::get(self : DbstorespatialPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialPath::set(
  self : DbstorespatialPath,
  i : Int32,
  v : Double,
) -> DbstorespatialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialPath::sum(self : DbstorespatialPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialPath::mean(self : DbstorespatialPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialPath::scale(
  self : DbstorespatialPath,
  f : Double,
) -> DbstorespatialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialPath::add(
  self : DbstorespatialPath,
  other : DbstorespatialPath,
) -> DbstorespatialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialPath::copy(
  self : DbstorespatialPath,
) -> DbstorespatialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialPath::fill(
  self : DbstorespatialPath,
  v : Double,
) -> DbstorespatialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialPath::min(self : DbstorespatialPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialPath::max(self : DbstorespatialPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialPath::to_string(self : DbstorespatialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_cluster_make(size : Int32) -> DbstorespatialCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialCluster::len(self : DbstorespatialCluster) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialCluster::get(
  self : DbstorespatialCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialCluster::set(
  self : DbstorespatialCluster,
  i : Int32,
  v : Double,
) -> DbstorespatialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCluster::sum(self : DbstorespatialCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialCluster::mean(self : DbstorespatialCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialCluster::scale(
  self : DbstorespatialCluster,
  f : Double,
) -> DbstorespatialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCluster::add(
  self : DbstorespatialCluster,
  other : DbstorespatialCluster,
) -> DbstorespatialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialCluster::copy(
  self : DbstorespatialCluster,
) -> DbstorespatialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCluster::fill(
  self : DbstorespatialCluster,
  v : Double,
) -> DbstorespatialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCluster::min(self : DbstorespatialCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialCluster::max(self : DbstorespatialCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialCluster::to_string(self : DbstorespatialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_model_make(size : Int32) -> DbstorespatialModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialModel::len(self : DbstorespatialModel) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialModel::get(
  self : DbstorespatialModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialModel::set(
  self : DbstorespatialModel,
  i : Int32,
  v : Double,
) -> DbstorespatialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialModel::sum(self : DbstorespatialModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialModel::mean(self : DbstorespatialModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialModel::scale(
  self : DbstorespatialModel,
  f : Double,
) -> DbstorespatialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialModel::add(
  self : DbstorespatialModel,
  other : DbstorespatialModel,
) -> DbstorespatialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialModel::copy(
  self : DbstorespatialModel,
) -> DbstorespatialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialModel::fill(
  self : DbstorespatialModel,
  v : Double,
) -> DbstorespatialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialModel::min(self : DbstorespatialModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialModel::max(self : DbstorespatialModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialModel::to_string(self : DbstorespatialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_layer_make(size : Int32) -> DbstorespatialLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialLayer::len(self : DbstorespatialLayer) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialLayer::get(
  self : DbstorespatialLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialLayer::set(
  self : DbstorespatialLayer,
  i : Int32,
  v : Double,
) -> DbstorespatialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialLayer::sum(self : DbstorespatialLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialLayer::mean(self : DbstorespatialLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialLayer::scale(
  self : DbstorespatialLayer,
  f : Double,
) -> DbstorespatialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialLayer::add(
  self : DbstorespatialLayer,
  other : DbstorespatialLayer,
) -> DbstorespatialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialLayer::copy(
  self : DbstorespatialLayer,
) -> DbstorespatialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialLayer::fill(
  self : DbstorespatialLayer,
  v : Double,
) -> DbstorespatialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialLayer::min(self : DbstorespatialLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialLayer::max(self : DbstorespatialLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialLayer::to_string(self : DbstorespatialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_buffer_make(size : Int32) -> DbstorespatialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialBuffer::len(self : DbstorespatialBuffer) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialBuffer::get(
  self : DbstorespatialBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialBuffer::set(
  self : DbstorespatialBuffer,
  i : Int32,
  v : Double,
) -> DbstorespatialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialBuffer::sum(self : DbstorespatialBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialBuffer::mean(self : DbstorespatialBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialBuffer::scale(
  self : DbstorespatialBuffer,
  f : Double,
) -> DbstorespatialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialBuffer::add(
  self : DbstorespatialBuffer,
  other : DbstorespatialBuffer,
) -> DbstorespatialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialBuffer::copy(
  self : DbstorespatialBuffer,
) -> DbstorespatialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialBuffer::fill(
  self : DbstorespatialBuffer,
  v : Double,
) -> DbstorespatialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialBuffer::min(self : DbstorespatialBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialBuffer::max(self : DbstorespatialBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialBuffer::to_string(self : DbstorespatialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_cursor_make(size : Int32) -> DbstorespatialCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialCursor::len(self : DbstorespatialCursor) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialCursor::get(
  self : DbstorespatialCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialCursor::set(
  self : DbstorespatialCursor,
  i : Int32,
  v : Double,
) -> DbstorespatialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCursor::sum(self : DbstorespatialCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialCursor::mean(self : DbstorespatialCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialCursor::scale(
  self : DbstorespatialCursor,
  f : Double,
) -> DbstorespatialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCursor::add(
  self : DbstorespatialCursor,
  other : DbstorespatialCursor,
) -> DbstorespatialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialCursor::copy(
  self : DbstorespatialCursor,
) -> DbstorespatialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCursor::fill(
  self : DbstorespatialCursor,
  v : Double,
) -> DbstorespatialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialCursor::min(self : DbstorespatialCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialCursor::max(self : DbstorespatialCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialCursor::to_string(self : DbstorespatialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_view_make(size : Int32) -> DbstorespatialView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialView::len(self : DbstorespatialView) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialView::get(self : DbstorespatialView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialView::set(
  self : DbstorespatialView,
  i : Int32,
  v : Double,
) -> DbstorespatialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialView::sum(self : DbstorespatialView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialView::mean(self : DbstorespatialView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialView::scale(
  self : DbstorespatialView,
  f : Double,
) -> DbstorespatialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialView::add(
  self : DbstorespatialView,
  other : DbstorespatialView,
) -> DbstorespatialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialView::copy(
  self : DbstorespatialView,
) -> DbstorespatialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialView::fill(
  self : DbstorespatialView,
  v : Double,
) -> DbstorespatialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialView::min(self : DbstorespatialView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialView::max(self : DbstorespatialView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialView::to_string(self : DbstorespatialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_range_make(size : Int32) -> DbstorespatialRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialRange::len(self : DbstorespatialRange) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialRange::get(
  self : DbstorespatialRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialRange::set(
  self : DbstorespatialRange,
  i : Int32,
  v : Double,
) -> DbstorespatialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialRange::sum(self : DbstorespatialRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialRange::mean(self : DbstorespatialRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialRange::scale(
  self : DbstorespatialRange,
  f : Double,
) -> DbstorespatialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialRange::add(
  self : DbstorespatialRange,
  other : DbstorespatialRange,
) -> DbstorespatialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialRange::copy(
  self : DbstorespatialRange,
) -> DbstorespatialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialRange::fill(
  self : DbstorespatialRange,
  v : Double,
) -> DbstorespatialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialRange::min(self : DbstorespatialRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialRange::max(self : DbstorespatialRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialRange::to_string(self : DbstorespatialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbstorespatialSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_store_spatial_slice_make(size : Int32) -> DbstorespatialSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbstorespatialSlice::len(self : DbstorespatialSlice) -> Int32 {
  self.size
}

///|
pub fn DbstorespatialSlice::get(
  self : DbstorespatialSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbstorespatialSlice::set(
  self : DbstorespatialSlice,
  i : Int32,
  v : Double,
) -> DbstorespatialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialSlice::sum(self : DbstorespatialSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbstorespatialSlice::mean(self : DbstorespatialSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbstorespatialSlice::scale(
  self : DbstorespatialSlice,
  f : Double,
) -> DbstorespatialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialSlice::add(
  self : DbstorespatialSlice,
  other : DbstorespatialSlice,
) -> DbstorespatialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbstorespatialSlice::copy(
  self : DbstorespatialSlice,
) -> DbstorespatialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialSlice::fill(
  self : DbstorespatialSlice,
  v : Double,
) -> DbstorespatialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbstorespatialSlice::min(self : DbstorespatialSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbstorespatialSlice::max(self : DbstorespatialSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbstorespatialSlice::to_string(self : DbstorespatialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

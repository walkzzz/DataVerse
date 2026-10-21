///|
///===
/// extcore/db_index_lsm
pub(all) struct DbindexlsmPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_index_lsm_make_point(x : Double, y : Double) -> DbindexlsmPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_index_lsm_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbindexlsmPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbindexlsmPoint::x(self : DbindexlsmPoint) -> Double {
  self.x
}

///|
pub fn DbindexlsmPoint::y(self : DbindexlsmPoint) -> Double {
  self.y
}

///|
pub fn DbindexlsmPoint::z(self : DbindexlsmPoint) -> Double {
  self.z
}

///|
pub fn DbindexlsmPoint::label(self : DbindexlsmPoint) -> Int32 {
  self.label
}

///|
pub fn DbindexlsmPoint::dist(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbindexlsmPoint::add(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> DbindexlsmPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbindexlsmPoint::sub(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> DbindexlsmPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbindexlsmPoint::scale(
  self : DbindexlsmPoint,
  s : Double,
) -> DbindexlsmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbindexlsmPoint::dot(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbindexlsmPoint::cross(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> DbindexlsmPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbindexlsmPoint::norm(self : DbindexlsmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbindexlsmPoint::normalize(self : DbindexlsmPoint) -> DbindexlsmPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexlsmPoint::negate(self : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbindexlsmPoint::mid(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
) -> DbindexlsmPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbindexlsmPoint::lerp(
  self : DbindexlsmPoint,
  other : DbindexlsmPoint,
  t : Double,
) -> DbindexlsmPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbindexlsmPoint::to_string(self : DbindexlsmPoint) -> String {
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
pub(all) struct DbindexlsmSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_index_lsm_make_series(
  vals : Array[Double],
  name : String,
) -> DbindexlsmSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbindexlsmSeries::len(self : DbindexlsmSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbindexlsmSeries::sum(self : DbindexlsmSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbindexlsmSeries::mean(self : DbindexlsmSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbindexlsmSeries::min(self : DbindexlsmSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbindexlsmSeries::max(self : DbindexlsmSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbindexlsmSeries::range(self : DbindexlsmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbindexlsmSeries::variance(self : DbindexlsmSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbindexlsmSeries::std(self : DbindexlsmSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbindexlsmSeries::median(self : DbindexlsmSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbindexlsmSeries::scale(
  self : DbindexlsmSeries,
  f : Double,
) -> DbindexlsmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbindexlsmSeries::add(
  self : DbindexlsmSeries,
  other : DbindexlsmSeries,
) -> DbindexlsmSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexlsmSeries::sub(
  self : DbindexlsmSeries,
  other : DbindexlsmSeries,
) -> DbindexlsmSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexlsmSeries::normalize(self : DbindexlsmSeries) -> DbindexlsmSeries {
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
pub fn DbindexlsmSeries::cumsum(self : DbindexlsmSeries) -> DbindexlsmSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbindexlsmSeries::to_string(self : DbindexlsmSeries) -> String {
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
pub(all) struct DbindexlsmMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_index_lsm_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbindexlsmMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_index_lsm_matrix_identity(n : Int32) -> DbindexlsmMatrix {
  let m = db_index_lsm_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbindexlsmMatrix::get(
  self : DbindexlsmMatrix,
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
pub fn DbindexlsmMatrix::transpose(self : DbindexlsmMatrix) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexlsmMatrix::add(
  self : DbindexlsmMatrix,
  other : DbindexlsmMatrix,
) -> DbindexlsmMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_index_lsm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexlsmMatrix::scale(
  self : DbindexlsmMatrix,
  s : Double,
) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbindexlsmMatrix::multiply(
  self : DbindexlsmMatrix,
  other : DbindexlsmMatrix,
) -> DbindexlsmMatrix {
  if self.cols != other.rows {
    return db_index_lsm_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_index_lsm_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbindexlsmMatrix::trace(self : DbindexlsmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbindexlsmMatrix::det(self : DbindexlsmMatrix) -> Double {
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
pub fn DbindexlsmMatrix::norm(self : DbindexlsmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbindexlsmMatrix::to_string(self : DbindexlsmMatrix) -> String {
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
pub(all) struct DbindexlsmVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_index_lsm_make_vector(comps : Array[Double]) -> DbindexlsmVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_index_lsm_vector_zero(dim : Int32) -> DbindexlsmVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbindexlsmVector::add(
  self : DbindexlsmVector,
  other : DbindexlsmVector,
) -> DbindexlsmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexlsmVector::sub(
  self : DbindexlsmVector,
  other : DbindexlsmVector,
) -> DbindexlsmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexlsmVector::scale(
  self : DbindexlsmVector,
  s : Double,
) -> DbindexlsmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbindexlsmVector::dot(
  self : DbindexlsmVector,
  other : DbindexlsmVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbindexlsmVector::norm(self : DbindexlsmVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbindexlsmVector::normalize(self : DbindexlsmVector) -> DbindexlsmVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexlsmVector::dist(
  self : DbindexlsmVector,
  other : DbindexlsmVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbindexlsmVector::to_string(self : DbindexlsmVector) -> String {
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
pub(all) struct DbindexlsmFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_frame_make(size : Int32) -> DbindexlsmFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmFrame::len(self : DbindexlsmFrame) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmFrame::get(self : DbindexlsmFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmFrame::set(
  self : DbindexlsmFrame,
  i : Int32,
  v : Double,
) -> DbindexlsmFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmFrame::sum(self : DbindexlsmFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmFrame::mean(self : DbindexlsmFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmFrame::scale(
  self : DbindexlsmFrame,
  f : Double,
) -> DbindexlsmFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmFrame::add(
  self : DbindexlsmFrame,
  other : DbindexlsmFrame,
) -> DbindexlsmFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmFrame::copy(self : DbindexlsmFrame) -> DbindexlsmFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmFrame::fill(
  self : DbindexlsmFrame,
  v : Double,
) -> DbindexlsmFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmFrame::min(self : DbindexlsmFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmFrame::max(self : DbindexlsmFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmFrame::to_string(self : DbindexlsmFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_table_make(size : Int32) -> DbindexlsmTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmTable::len(self : DbindexlsmTable) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmTable::get(self : DbindexlsmTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmTable::set(
  self : DbindexlsmTable,
  i : Int32,
  v : Double,
) -> DbindexlsmTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmTable::sum(self : DbindexlsmTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmTable::mean(self : DbindexlsmTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmTable::scale(
  self : DbindexlsmTable,
  f : Double,
) -> DbindexlsmTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmTable::add(
  self : DbindexlsmTable,
  other : DbindexlsmTable,
) -> DbindexlsmTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmTable::copy(self : DbindexlsmTable) -> DbindexlsmTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmTable::fill(
  self : DbindexlsmTable,
  v : Double,
) -> DbindexlsmTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmTable::min(self : DbindexlsmTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmTable::max(self : DbindexlsmTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmTable::to_string(self : DbindexlsmTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_graphn_make(size : Int32) -> DbindexlsmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmGraphN::len(self : DbindexlsmGraphN) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmGraphN::get(self : DbindexlsmGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmGraphN::set(
  self : DbindexlsmGraphN,
  i : Int32,
  v : Double,
) -> DbindexlsmGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmGraphN::sum(self : DbindexlsmGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmGraphN::mean(self : DbindexlsmGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmGraphN::scale(
  self : DbindexlsmGraphN,
  f : Double,
) -> DbindexlsmGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmGraphN::add(
  self : DbindexlsmGraphN,
  other : DbindexlsmGraphN,
) -> DbindexlsmGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmGraphN::copy(self : DbindexlsmGraphN) -> DbindexlsmGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmGraphN::fill(
  self : DbindexlsmGraphN,
  v : Double,
) -> DbindexlsmGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmGraphN::min(self : DbindexlsmGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmGraphN::max(self : DbindexlsmGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmGraphN::to_string(self : DbindexlsmGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_node_make(size : Int32) -> DbindexlsmNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmNode::len(self : DbindexlsmNode) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmNode::get(self : DbindexlsmNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmNode::set(
  self : DbindexlsmNode,
  i : Int32,
  v : Double,
) -> DbindexlsmNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmNode::sum(self : DbindexlsmNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmNode::mean(self : DbindexlsmNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmNode::scale(
  self : DbindexlsmNode,
  f : Double,
) -> DbindexlsmNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmNode::add(
  self : DbindexlsmNode,
  other : DbindexlsmNode,
) -> DbindexlsmNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmNode::copy(self : DbindexlsmNode) -> DbindexlsmNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmNode::fill(
  self : DbindexlsmNode,
  v : Double,
) -> DbindexlsmNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmNode::min(self : DbindexlsmNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmNode::max(self : DbindexlsmNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmNode::to_string(self : DbindexlsmNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_edge_make(size : Int32) -> DbindexlsmEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmEdge::len(self : DbindexlsmEdge) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmEdge::get(self : DbindexlsmEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmEdge::set(
  self : DbindexlsmEdge,
  i : Int32,
  v : Double,
) -> DbindexlsmEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmEdge::sum(self : DbindexlsmEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmEdge::mean(self : DbindexlsmEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmEdge::scale(
  self : DbindexlsmEdge,
  f : Double,
) -> DbindexlsmEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmEdge::add(
  self : DbindexlsmEdge,
  other : DbindexlsmEdge,
) -> DbindexlsmEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmEdge::copy(self : DbindexlsmEdge) -> DbindexlsmEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmEdge::fill(
  self : DbindexlsmEdge,
  v : Double,
) -> DbindexlsmEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmEdge::min(self : DbindexlsmEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmEdge::max(self : DbindexlsmEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmEdge::to_string(self : DbindexlsmEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_path_make(size : Int32) -> DbindexlsmPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmPath::len(self : DbindexlsmPath) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmPath::get(self : DbindexlsmPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmPath::set(
  self : DbindexlsmPath,
  i : Int32,
  v : Double,
) -> DbindexlsmPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmPath::sum(self : DbindexlsmPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmPath::mean(self : DbindexlsmPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmPath::scale(
  self : DbindexlsmPath,
  f : Double,
) -> DbindexlsmPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmPath::add(
  self : DbindexlsmPath,
  other : DbindexlsmPath,
) -> DbindexlsmPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmPath::copy(self : DbindexlsmPath) -> DbindexlsmPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmPath::fill(
  self : DbindexlsmPath,
  v : Double,
) -> DbindexlsmPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmPath::min(self : DbindexlsmPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmPath::max(self : DbindexlsmPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmPath::to_string(self : DbindexlsmPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_cluster_make(size : Int32) -> DbindexlsmCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmCluster::len(self : DbindexlsmCluster) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmCluster::get(self : DbindexlsmCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmCluster::set(
  self : DbindexlsmCluster,
  i : Int32,
  v : Double,
) -> DbindexlsmCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCluster::sum(self : DbindexlsmCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmCluster::mean(self : DbindexlsmCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmCluster::scale(
  self : DbindexlsmCluster,
  f : Double,
) -> DbindexlsmCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCluster::add(
  self : DbindexlsmCluster,
  other : DbindexlsmCluster,
) -> DbindexlsmCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmCluster::copy(self : DbindexlsmCluster) -> DbindexlsmCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCluster::fill(
  self : DbindexlsmCluster,
  v : Double,
) -> DbindexlsmCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCluster::min(self : DbindexlsmCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmCluster::max(self : DbindexlsmCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmCluster::to_string(self : DbindexlsmCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_model_make(size : Int32) -> DbindexlsmModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmModel::len(self : DbindexlsmModel) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmModel::get(self : DbindexlsmModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmModel::set(
  self : DbindexlsmModel,
  i : Int32,
  v : Double,
) -> DbindexlsmModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmModel::sum(self : DbindexlsmModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmModel::mean(self : DbindexlsmModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmModel::scale(
  self : DbindexlsmModel,
  f : Double,
) -> DbindexlsmModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmModel::add(
  self : DbindexlsmModel,
  other : DbindexlsmModel,
) -> DbindexlsmModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmModel::copy(self : DbindexlsmModel) -> DbindexlsmModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmModel::fill(
  self : DbindexlsmModel,
  v : Double,
) -> DbindexlsmModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmModel::min(self : DbindexlsmModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmModel::max(self : DbindexlsmModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmModel::to_string(self : DbindexlsmModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_layer_make(size : Int32) -> DbindexlsmLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmLayer::len(self : DbindexlsmLayer) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmLayer::get(self : DbindexlsmLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmLayer::set(
  self : DbindexlsmLayer,
  i : Int32,
  v : Double,
) -> DbindexlsmLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmLayer::sum(self : DbindexlsmLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmLayer::mean(self : DbindexlsmLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmLayer::scale(
  self : DbindexlsmLayer,
  f : Double,
) -> DbindexlsmLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmLayer::add(
  self : DbindexlsmLayer,
  other : DbindexlsmLayer,
) -> DbindexlsmLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmLayer::copy(self : DbindexlsmLayer) -> DbindexlsmLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmLayer::fill(
  self : DbindexlsmLayer,
  v : Double,
) -> DbindexlsmLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmLayer::min(self : DbindexlsmLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmLayer::max(self : DbindexlsmLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmLayer::to_string(self : DbindexlsmLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_buffer_make(size : Int32) -> DbindexlsmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmBuffer::len(self : DbindexlsmBuffer) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmBuffer::get(self : DbindexlsmBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmBuffer::set(
  self : DbindexlsmBuffer,
  i : Int32,
  v : Double,
) -> DbindexlsmBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmBuffer::sum(self : DbindexlsmBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmBuffer::mean(self : DbindexlsmBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmBuffer::scale(
  self : DbindexlsmBuffer,
  f : Double,
) -> DbindexlsmBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmBuffer::add(
  self : DbindexlsmBuffer,
  other : DbindexlsmBuffer,
) -> DbindexlsmBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmBuffer::copy(self : DbindexlsmBuffer) -> DbindexlsmBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmBuffer::fill(
  self : DbindexlsmBuffer,
  v : Double,
) -> DbindexlsmBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmBuffer::min(self : DbindexlsmBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmBuffer::max(self : DbindexlsmBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmBuffer::to_string(self : DbindexlsmBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_cursor_make(size : Int32) -> DbindexlsmCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmCursor::len(self : DbindexlsmCursor) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmCursor::get(self : DbindexlsmCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmCursor::set(
  self : DbindexlsmCursor,
  i : Int32,
  v : Double,
) -> DbindexlsmCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCursor::sum(self : DbindexlsmCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmCursor::mean(self : DbindexlsmCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmCursor::scale(
  self : DbindexlsmCursor,
  f : Double,
) -> DbindexlsmCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCursor::add(
  self : DbindexlsmCursor,
  other : DbindexlsmCursor,
) -> DbindexlsmCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmCursor::copy(self : DbindexlsmCursor) -> DbindexlsmCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCursor::fill(
  self : DbindexlsmCursor,
  v : Double,
) -> DbindexlsmCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmCursor::min(self : DbindexlsmCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmCursor::max(self : DbindexlsmCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmCursor::to_string(self : DbindexlsmCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_view_make(size : Int32) -> DbindexlsmView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmView::len(self : DbindexlsmView) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmView::get(self : DbindexlsmView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmView::set(
  self : DbindexlsmView,
  i : Int32,
  v : Double,
) -> DbindexlsmView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmView::sum(self : DbindexlsmView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmView::mean(self : DbindexlsmView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmView::scale(
  self : DbindexlsmView,
  f : Double,
) -> DbindexlsmView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmView::add(
  self : DbindexlsmView,
  other : DbindexlsmView,
) -> DbindexlsmView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmView::copy(self : DbindexlsmView) -> DbindexlsmView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmView::fill(
  self : DbindexlsmView,
  v : Double,
) -> DbindexlsmView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmView::min(self : DbindexlsmView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmView::max(self : DbindexlsmView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmView::to_string(self : DbindexlsmView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_range_make(size : Int32) -> DbindexlsmRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmRange::len(self : DbindexlsmRange) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmRange::get(self : DbindexlsmRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmRange::set(
  self : DbindexlsmRange,
  i : Int32,
  v : Double,
) -> DbindexlsmRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmRange::sum(self : DbindexlsmRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmRange::mean(self : DbindexlsmRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmRange::scale(
  self : DbindexlsmRange,
  f : Double,
) -> DbindexlsmRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmRange::add(
  self : DbindexlsmRange,
  other : DbindexlsmRange,
) -> DbindexlsmRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmRange::copy(self : DbindexlsmRange) -> DbindexlsmRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmRange::fill(
  self : DbindexlsmRange,
  v : Double,
) -> DbindexlsmRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmRange::min(self : DbindexlsmRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmRange::max(self : DbindexlsmRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmRange::to_string(self : DbindexlsmRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexlsmSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_lsm_slice_make(size : Int32) -> DbindexlsmSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexlsmSlice::len(self : DbindexlsmSlice) -> Int32 {
  self.size
}

///|
pub fn DbindexlsmSlice::get(self : DbindexlsmSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexlsmSlice::set(
  self : DbindexlsmSlice,
  i : Int32,
  v : Double,
) -> DbindexlsmSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmSlice::sum(self : DbindexlsmSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexlsmSlice::mean(self : DbindexlsmSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexlsmSlice::scale(
  self : DbindexlsmSlice,
  f : Double,
) -> DbindexlsmSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmSlice::add(
  self : DbindexlsmSlice,
  other : DbindexlsmSlice,
) -> DbindexlsmSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexlsmSlice::copy(self : DbindexlsmSlice) -> DbindexlsmSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmSlice::fill(
  self : DbindexlsmSlice,
  v : Double,
) -> DbindexlsmSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexlsmSlice::min(self : DbindexlsmSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexlsmSlice::max(self : DbindexlsmSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexlsmSlice::to_string(self : DbindexlsmSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

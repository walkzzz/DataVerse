///|
///===
/// extcore/db_index_hash
pub(all) struct DbindexhashPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_index_hash_make_point(x : Double, y : Double) -> DbindexhashPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_index_hash_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbindexhashPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbindexhashPoint::x(self : DbindexhashPoint) -> Double {
  self.x
}

///|
pub fn DbindexhashPoint::y(self : DbindexhashPoint) -> Double {
  self.y
}

///|
pub fn DbindexhashPoint::z(self : DbindexhashPoint) -> Double {
  self.z
}

///|
pub fn DbindexhashPoint::label(self : DbindexhashPoint) -> Int32 {
  self.label
}

///|
pub fn DbindexhashPoint::dist(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbindexhashPoint::add(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> DbindexhashPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbindexhashPoint::sub(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> DbindexhashPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbindexhashPoint::scale(
  self : DbindexhashPoint,
  s : Double,
) -> DbindexhashPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbindexhashPoint::dot(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbindexhashPoint::cross(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> DbindexhashPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbindexhashPoint::norm(self : DbindexhashPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbindexhashPoint::normalize(self : DbindexhashPoint) -> DbindexhashPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexhashPoint::negate(self : DbindexhashPoint) -> DbindexhashPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbindexhashPoint::mid(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
) -> DbindexhashPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbindexhashPoint::lerp(
  self : DbindexhashPoint,
  other : DbindexhashPoint,
  t : Double,
) -> DbindexhashPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbindexhashPoint::to_string(self : DbindexhashPoint) -> String {
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
pub(all) struct DbindexhashSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_index_hash_make_series(
  vals : Array[Double],
  name : String,
) -> DbindexhashSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbindexhashSeries::len(self : DbindexhashSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbindexhashSeries::sum(self : DbindexhashSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbindexhashSeries::mean(self : DbindexhashSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbindexhashSeries::min(self : DbindexhashSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbindexhashSeries::max(self : DbindexhashSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbindexhashSeries::range(self : DbindexhashSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbindexhashSeries::variance(self : DbindexhashSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbindexhashSeries::std(self : DbindexhashSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbindexhashSeries::median(self : DbindexhashSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbindexhashSeries::scale(
  self : DbindexhashSeries,
  f : Double,
) -> DbindexhashSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbindexhashSeries::add(
  self : DbindexhashSeries,
  other : DbindexhashSeries,
) -> DbindexhashSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexhashSeries::sub(
  self : DbindexhashSeries,
  other : DbindexhashSeries,
) -> DbindexhashSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexhashSeries::normalize(
  self : DbindexhashSeries,
) -> DbindexhashSeries {
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
pub fn DbindexhashSeries::cumsum(self : DbindexhashSeries) -> DbindexhashSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbindexhashSeries::to_string(self : DbindexhashSeries) -> String {
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
pub(all) struct DbindexhashMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_index_hash_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbindexhashMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_index_hash_matrix_identity(n : Int32) -> DbindexhashMatrix {
  let m = db_index_hash_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbindexhashMatrix::get(
  self : DbindexhashMatrix,
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
pub fn DbindexhashMatrix::transpose(
  self : DbindexhashMatrix,
) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexhashMatrix::add(
  self : DbindexhashMatrix,
  other : DbindexhashMatrix,
) -> DbindexhashMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_index_hash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexhashMatrix::scale(
  self : DbindexhashMatrix,
  s : Double,
) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbindexhashMatrix::multiply(
  self : DbindexhashMatrix,
  other : DbindexhashMatrix,
) -> DbindexhashMatrix {
  if self.cols != other.rows {
    return db_index_hash_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_index_hash_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbindexhashMatrix::trace(self : DbindexhashMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbindexhashMatrix::det(self : DbindexhashMatrix) -> Double {
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
pub fn DbindexhashMatrix::norm(self : DbindexhashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbindexhashMatrix::to_string(self : DbindexhashMatrix) -> String {
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
pub(all) struct DbindexhashVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_index_hash_make_vector(comps : Array[Double]) -> DbindexhashVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_index_hash_vector_zero(dim : Int32) -> DbindexhashVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbindexhashVector::add(
  self : DbindexhashVector,
  other : DbindexhashVector,
) -> DbindexhashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexhashVector::sub(
  self : DbindexhashVector,
  other : DbindexhashVector,
) -> DbindexhashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexhashVector::scale(
  self : DbindexhashVector,
  s : Double,
) -> DbindexhashVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbindexhashVector::dot(
  self : DbindexhashVector,
  other : DbindexhashVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbindexhashVector::norm(self : DbindexhashVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbindexhashVector::normalize(
  self : DbindexhashVector,
) -> DbindexhashVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexhashVector::dist(
  self : DbindexhashVector,
  other : DbindexhashVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbindexhashVector::to_string(self : DbindexhashVector) -> String {
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
pub(all) struct DbindexhashFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_frame_make(size : Int32) -> DbindexhashFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashFrame::len(self : DbindexhashFrame) -> Int32 {
  self.size
}

///|
pub fn DbindexhashFrame::get(self : DbindexhashFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashFrame::set(
  self : DbindexhashFrame,
  i : Int32,
  v : Double,
) -> DbindexhashFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashFrame::sum(self : DbindexhashFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashFrame::mean(self : DbindexhashFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashFrame::scale(
  self : DbindexhashFrame,
  f : Double,
) -> DbindexhashFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashFrame::add(
  self : DbindexhashFrame,
  other : DbindexhashFrame,
) -> DbindexhashFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashFrame::copy(self : DbindexhashFrame) -> DbindexhashFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashFrame::fill(
  self : DbindexhashFrame,
  v : Double,
) -> DbindexhashFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashFrame::min(self : DbindexhashFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashFrame::max(self : DbindexhashFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashFrame::to_string(self : DbindexhashFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_table_make(size : Int32) -> DbindexhashTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashTable::len(self : DbindexhashTable) -> Int32 {
  self.size
}

///|
pub fn DbindexhashTable::get(self : DbindexhashTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashTable::set(
  self : DbindexhashTable,
  i : Int32,
  v : Double,
) -> DbindexhashTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashTable::sum(self : DbindexhashTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashTable::mean(self : DbindexhashTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashTable::scale(
  self : DbindexhashTable,
  f : Double,
) -> DbindexhashTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashTable::add(
  self : DbindexhashTable,
  other : DbindexhashTable,
) -> DbindexhashTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashTable::copy(self : DbindexhashTable) -> DbindexhashTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashTable::fill(
  self : DbindexhashTable,
  v : Double,
) -> DbindexhashTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashTable::min(self : DbindexhashTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashTable::max(self : DbindexhashTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashTable::to_string(self : DbindexhashTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_graphn_make(size : Int32) -> DbindexhashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashGraphN::len(self : DbindexhashGraphN) -> Int32 {
  self.size
}

///|
pub fn DbindexhashGraphN::get(self : DbindexhashGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashGraphN::set(
  self : DbindexhashGraphN,
  i : Int32,
  v : Double,
) -> DbindexhashGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashGraphN::sum(self : DbindexhashGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashGraphN::mean(self : DbindexhashGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashGraphN::scale(
  self : DbindexhashGraphN,
  f : Double,
) -> DbindexhashGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashGraphN::add(
  self : DbindexhashGraphN,
  other : DbindexhashGraphN,
) -> DbindexhashGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashGraphN::copy(self : DbindexhashGraphN) -> DbindexhashGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashGraphN::fill(
  self : DbindexhashGraphN,
  v : Double,
) -> DbindexhashGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashGraphN::min(self : DbindexhashGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashGraphN::max(self : DbindexhashGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashGraphN::to_string(self : DbindexhashGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_node_make(size : Int32) -> DbindexhashNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashNode::len(self : DbindexhashNode) -> Int32 {
  self.size
}

///|
pub fn DbindexhashNode::get(self : DbindexhashNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashNode::set(
  self : DbindexhashNode,
  i : Int32,
  v : Double,
) -> DbindexhashNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashNode::sum(self : DbindexhashNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashNode::mean(self : DbindexhashNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashNode::scale(
  self : DbindexhashNode,
  f : Double,
) -> DbindexhashNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashNode::add(
  self : DbindexhashNode,
  other : DbindexhashNode,
) -> DbindexhashNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashNode::copy(self : DbindexhashNode) -> DbindexhashNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashNode::fill(
  self : DbindexhashNode,
  v : Double,
) -> DbindexhashNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashNode::min(self : DbindexhashNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashNode::max(self : DbindexhashNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashNode::to_string(self : DbindexhashNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_edge_make(size : Int32) -> DbindexhashEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashEdge::len(self : DbindexhashEdge) -> Int32 {
  self.size
}

///|
pub fn DbindexhashEdge::get(self : DbindexhashEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashEdge::set(
  self : DbindexhashEdge,
  i : Int32,
  v : Double,
) -> DbindexhashEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashEdge::sum(self : DbindexhashEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashEdge::mean(self : DbindexhashEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashEdge::scale(
  self : DbindexhashEdge,
  f : Double,
) -> DbindexhashEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashEdge::add(
  self : DbindexhashEdge,
  other : DbindexhashEdge,
) -> DbindexhashEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashEdge::copy(self : DbindexhashEdge) -> DbindexhashEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashEdge::fill(
  self : DbindexhashEdge,
  v : Double,
) -> DbindexhashEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashEdge::min(self : DbindexhashEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashEdge::max(self : DbindexhashEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashEdge::to_string(self : DbindexhashEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_path_make(size : Int32) -> DbindexhashPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashPath::len(self : DbindexhashPath) -> Int32 {
  self.size
}

///|
pub fn DbindexhashPath::get(self : DbindexhashPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashPath::set(
  self : DbindexhashPath,
  i : Int32,
  v : Double,
) -> DbindexhashPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashPath::sum(self : DbindexhashPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashPath::mean(self : DbindexhashPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashPath::scale(
  self : DbindexhashPath,
  f : Double,
) -> DbindexhashPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashPath::add(
  self : DbindexhashPath,
  other : DbindexhashPath,
) -> DbindexhashPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashPath::copy(self : DbindexhashPath) -> DbindexhashPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashPath::fill(
  self : DbindexhashPath,
  v : Double,
) -> DbindexhashPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashPath::min(self : DbindexhashPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashPath::max(self : DbindexhashPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashPath::to_string(self : DbindexhashPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_cluster_make(size : Int32) -> DbindexhashCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashCluster::len(self : DbindexhashCluster) -> Int32 {
  self.size
}

///|
pub fn DbindexhashCluster::get(self : DbindexhashCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashCluster::set(
  self : DbindexhashCluster,
  i : Int32,
  v : Double,
) -> DbindexhashCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCluster::sum(self : DbindexhashCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashCluster::mean(self : DbindexhashCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashCluster::scale(
  self : DbindexhashCluster,
  f : Double,
) -> DbindexhashCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCluster::add(
  self : DbindexhashCluster,
  other : DbindexhashCluster,
) -> DbindexhashCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashCluster::copy(
  self : DbindexhashCluster,
) -> DbindexhashCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCluster::fill(
  self : DbindexhashCluster,
  v : Double,
) -> DbindexhashCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCluster::min(self : DbindexhashCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashCluster::max(self : DbindexhashCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashCluster::to_string(self : DbindexhashCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_model_make(size : Int32) -> DbindexhashModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashModel::len(self : DbindexhashModel) -> Int32 {
  self.size
}

///|
pub fn DbindexhashModel::get(self : DbindexhashModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashModel::set(
  self : DbindexhashModel,
  i : Int32,
  v : Double,
) -> DbindexhashModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashModel::sum(self : DbindexhashModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashModel::mean(self : DbindexhashModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashModel::scale(
  self : DbindexhashModel,
  f : Double,
) -> DbindexhashModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashModel::add(
  self : DbindexhashModel,
  other : DbindexhashModel,
) -> DbindexhashModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashModel::copy(self : DbindexhashModel) -> DbindexhashModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashModel::fill(
  self : DbindexhashModel,
  v : Double,
) -> DbindexhashModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashModel::min(self : DbindexhashModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashModel::max(self : DbindexhashModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashModel::to_string(self : DbindexhashModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_layer_make(size : Int32) -> DbindexhashLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashLayer::len(self : DbindexhashLayer) -> Int32 {
  self.size
}

///|
pub fn DbindexhashLayer::get(self : DbindexhashLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashLayer::set(
  self : DbindexhashLayer,
  i : Int32,
  v : Double,
) -> DbindexhashLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashLayer::sum(self : DbindexhashLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashLayer::mean(self : DbindexhashLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashLayer::scale(
  self : DbindexhashLayer,
  f : Double,
) -> DbindexhashLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashLayer::add(
  self : DbindexhashLayer,
  other : DbindexhashLayer,
) -> DbindexhashLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashLayer::copy(self : DbindexhashLayer) -> DbindexhashLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashLayer::fill(
  self : DbindexhashLayer,
  v : Double,
) -> DbindexhashLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashLayer::min(self : DbindexhashLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashLayer::max(self : DbindexhashLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashLayer::to_string(self : DbindexhashLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_buffer_make(size : Int32) -> DbindexhashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashBuffer::len(self : DbindexhashBuffer) -> Int32 {
  self.size
}

///|
pub fn DbindexhashBuffer::get(self : DbindexhashBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashBuffer::set(
  self : DbindexhashBuffer,
  i : Int32,
  v : Double,
) -> DbindexhashBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashBuffer::sum(self : DbindexhashBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashBuffer::mean(self : DbindexhashBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashBuffer::scale(
  self : DbindexhashBuffer,
  f : Double,
) -> DbindexhashBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashBuffer::add(
  self : DbindexhashBuffer,
  other : DbindexhashBuffer,
) -> DbindexhashBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashBuffer::copy(self : DbindexhashBuffer) -> DbindexhashBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashBuffer::fill(
  self : DbindexhashBuffer,
  v : Double,
) -> DbindexhashBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashBuffer::min(self : DbindexhashBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashBuffer::max(self : DbindexhashBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashBuffer::to_string(self : DbindexhashBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_cursor_make(size : Int32) -> DbindexhashCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashCursor::len(self : DbindexhashCursor) -> Int32 {
  self.size
}

///|
pub fn DbindexhashCursor::get(self : DbindexhashCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashCursor::set(
  self : DbindexhashCursor,
  i : Int32,
  v : Double,
) -> DbindexhashCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCursor::sum(self : DbindexhashCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashCursor::mean(self : DbindexhashCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashCursor::scale(
  self : DbindexhashCursor,
  f : Double,
) -> DbindexhashCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCursor::add(
  self : DbindexhashCursor,
  other : DbindexhashCursor,
) -> DbindexhashCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashCursor::copy(self : DbindexhashCursor) -> DbindexhashCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCursor::fill(
  self : DbindexhashCursor,
  v : Double,
) -> DbindexhashCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashCursor::min(self : DbindexhashCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashCursor::max(self : DbindexhashCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashCursor::to_string(self : DbindexhashCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_view_make(size : Int32) -> DbindexhashView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashView::len(self : DbindexhashView) -> Int32 {
  self.size
}

///|
pub fn DbindexhashView::get(self : DbindexhashView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashView::set(
  self : DbindexhashView,
  i : Int32,
  v : Double,
) -> DbindexhashView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashView::sum(self : DbindexhashView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashView::mean(self : DbindexhashView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashView::scale(
  self : DbindexhashView,
  f : Double,
) -> DbindexhashView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashView::add(
  self : DbindexhashView,
  other : DbindexhashView,
) -> DbindexhashView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashView::copy(self : DbindexhashView) -> DbindexhashView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashView::fill(
  self : DbindexhashView,
  v : Double,
) -> DbindexhashView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashView::min(self : DbindexhashView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashView::max(self : DbindexhashView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashView::to_string(self : DbindexhashView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_range_make(size : Int32) -> DbindexhashRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashRange::len(self : DbindexhashRange) -> Int32 {
  self.size
}

///|
pub fn DbindexhashRange::get(self : DbindexhashRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashRange::set(
  self : DbindexhashRange,
  i : Int32,
  v : Double,
) -> DbindexhashRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashRange::sum(self : DbindexhashRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashRange::mean(self : DbindexhashRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashRange::scale(
  self : DbindexhashRange,
  f : Double,
) -> DbindexhashRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashRange::add(
  self : DbindexhashRange,
  other : DbindexhashRange,
) -> DbindexhashRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashRange::copy(self : DbindexhashRange) -> DbindexhashRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashRange::fill(
  self : DbindexhashRange,
  v : Double,
) -> DbindexhashRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashRange::min(self : DbindexhashRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashRange::max(self : DbindexhashRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashRange::to_string(self : DbindexhashRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexhashSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_hash_slice_make(size : Int32) -> DbindexhashSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexhashSlice::len(self : DbindexhashSlice) -> Int32 {
  self.size
}

///|
pub fn DbindexhashSlice::get(self : DbindexhashSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexhashSlice::set(
  self : DbindexhashSlice,
  i : Int32,
  v : Double,
) -> DbindexhashSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashSlice::sum(self : DbindexhashSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexhashSlice::mean(self : DbindexhashSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexhashSlice::scale(
  self : DbindexhashSlice,
  f : Double,
) -> DbindexhashSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashSlice::add(
  self : DbindexhashSlice,
  other : DbindexhashSlice,
) -> DbindexhashSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexhashSlice::copy(self : DbindexhashSlice) -> DbindexhashSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashSlice::fill(
  self : DbindexhashSlice,
  v : Double,
) -> DbindexhashSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexhashSlice::min(self : DbindexhashSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexhashSlice::max(self : DbindexhashSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexhashSlice::to_string(self : DbindexhashSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

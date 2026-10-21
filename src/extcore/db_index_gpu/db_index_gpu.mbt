///|
///===
/// extcore/db_index_gpu
pub(all) struct DbindexgpuPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_index_gpu_make_point(x : Double, y : Double) -> DbindexgpuPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_index_gpu_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbindexgpuPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbindexgpuPoint::x(self : DbindexgpuPoint) -> Double {
  self.x
}

///|
pub fn DbindexgpuPoint::y(self : DbindexgpuPoint) -> Double {
  self.y
}

///|
pub fn DbindexgpuPoint::z(self : DbindexgpuPoint) -> Double {
  self.z
}

///|
pub fn DbindexgpuPoint::label(self : DbindexgpuPoint) -> Int32 {
  self.label
}

///|
pub fn DbindexgpuPoint::dist(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbindexgpuPoint::add(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> DbindexgpuPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbindexgpuPoint::sub(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> DbindexgpuPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbindexgpuPoint::scale(
  self : DbindexgpuPoint,
  s : Double,
) -> DbindexgpuPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbindexgpuPoint::dot(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbindexgpuPoint::cross(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> DbindexgpuPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbindexgpuPoint::norm(self : DbindexgpuPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbindexgpuPoint::normalize(self : DbindexgpuPoint) -> DbindexgpuPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexgpuPoint::negate(self : DbindexgpuPoint) -> DbindexgpuPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbindexgpuPoint::mid(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
) -> DbindexgpuPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbindexgpuPoint::lerp(
  self : DbindexgpuPoint,
  other : DbindexgpuPoint,
  t : Double,
) -> DbindexgpuPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbindexgpuPoint::to_string(self : DbindexgpuPoint) -> String {
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
pub(all) struct DbindexgpuSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_index_gpu_make_series(
  vals : Array[Double],
  name : String,
) -> DbindexgpuSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbindexgpuSeries::len(self : DbindexgpuSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbindexgpuSeries::sum(self : DbindexgpuSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbindexgpuSeries::mean(self : DbindexgpuSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbindexgpuSeries::min(self : DbindexgpuSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbindexgpuSeries::max(self : DbindexgpuSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbindexgpuSeries::range(self : DbindexgpuSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbindexgpuSeries::variance(self : DbindexgpuSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbindexgpuSeries::std(self : DbindexgpuSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbindexgpuSeries::median(self : DbindexgpuSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbindexgpuSeries::scale(
  self : DbindexgpuSeries,
  f : Double,
) -> DbindexgpuSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbindexgpuSeries::add(
  self : DbindexgpuSeries,
  other : DbindexgpuSeries,
) -> DbindexgpuSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexgpuSeries::sub(
  self : DbindexgpuSeries,
  other : DbindexgpuSeries,
) -> DbindexgpuSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbindexgpuSeries::normalize(self : DbindexgpuSeries) -> DbindexgpuSeries {
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
pub fn DbindexgpuSeries::cumsum(self : DbindexgpuSeries) -> DbindexgpuSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbindexgpuSeries::to_string(self : DbindexgpuSeries) -> String {
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
pub(all) struct DbindexgpuMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_index_gpu_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbindexgpuMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_index_gpu_matrix_identity(n : Int32) -> DbindexgpuMatrix {
  let m = db_index_gpu_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbindexgpuMatrix::get(
  self : DbindexgpuMatrix,
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
pub fn DbindexgpuMatrix::transpose(self : DbindexgpuMatrix) -> DbindexgpuMatrix {
  let result = db_index_gpu_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexgpuMatrix::add(
  self : DbindexgpuMatrix,
  other : DbindexgpuMatrix,
) -> DbindexgpuMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_index_gpu_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbindexgpuMatrix::scale(
  self : DbindexgpuMatrix,
  s : Double,
) -> DbindexgpuMatrix {
  let result = db_index_gpu_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbindexgpuMatrix::multiply(
  self : DbindexgpuMatrix,
  other : DbindexgpuMatrix,
) -> DbindexgpuMatrix {
  if self.cols != other.rows {
    return db_index_gpu_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_index_gpu_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbindexgpuMatrix::trace(self : DbindexgpuMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbindexgpuMatrix::det(self : DbindexgpuMatrix) -> Double {
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
pub fn DbindexgpuMatrix::norm(self : DbindexgpuMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbindexgpuMatrix::to_string(self : DbindexgpuMatrix) -> String {
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
pub(all) struct DbindexgpuVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_index_gpu_make_vector(comps : Array[Double]) -> DbindexgpuVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_index_gpu_vector_zero(dim : Int32) -> DbindexgpuVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbindexgpuVector::add(
  self : DbindexgpuVector,
  other : DbindexgpuVector,
) -> DbindexgpuVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexgpuVector::sub(
  self : DbindexgpuVector,
  other : DbindexgpuVector,
) -> DbindexgpuVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbindexgpuVector::scale(
  self : DbindexgpuVector,
  s : Double,
) -> DbindexgpuVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbindexgpuVector::dot(
  self : DbindexgpuVector,
  other : DbindexgpuVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbindexgpuVector::norm(self : DbindexgpuVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbindexgpuVector::normalize(self : DbindexgpuVector) -> DbindexgpuVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbindexgpuVector::dist(
  self : DbindexgpuVector,
  other : DbindexgpuVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbindexgpuVector::to_string(self : DbindexgpuVector) -> String {
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
pub(all) struct DbindexgpuFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_frame_make(size : Int32) -> DbindexgpuFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuFrame::len(self : DbindexgpuFrame) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuFrame::get(self : DbindexgpuFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuFrame::set(
  self : DbindexgpuFrame,
  i : Int32,
  v : Double,
) -> DbindexgpuFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuFrame::sum(self : DbindexgpuFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuFrame::mean(self : DbindexgpuFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuFrame::scale(
  self : DbindexgpuFrame,
  f : Double,
) -> DbindexgpuFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuFrame::add(
  self : DbindexgpuFrame,
  other : DbindexgpuFrame,
) -> DbindexgpuFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuFrame::copy(self : DbindexgpuFrame) -> DbindexgpuFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuFrame::fill(
  self : DbindexgpuFrame,
  v : Double,
) -> DbindexgpuFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuFrame::min(self : DbindexgpuFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuFrame::max(self : DbindexgpuFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuFrame::to_string(self : DbindexgpuFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_table_make(size : Int32) -> DbindexgpuTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuTable::len(self : DbindexgpuTable) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuTable::get(self : DbindexgpuTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuTable::set(
  self : DbindexgpuTable,
  i : Int32,
  v : Double,
) -> DbindexgpuTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuTable::sum(self : DbindexgpuTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuTable::mean(self : DbindexgpuTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuTable::scale(
  self : DbindexgpuTable,
  f : Double,
) -> DbindexgpuTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuTable::add(
  self : DbindexgpuTable,
  other : DbindexgpuTable,
) -> DbindexgpuTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuTable::copy(self : DbindexgpuTable) -> DbindexgpuTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuTable::fill(
  self : DbindexgpuTable,
  v : Double,
) -> DbindexgpuTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuTable::min(self : DbindexgpuTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuTable::max(self : DbindexgpuTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuTable::to_string(self : DbindexgpuTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_graphn_make(size : Int32) -> DbindexgpuGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuGraphN::len(self : DbindexgpuGraphN) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuGraphN::get(self : DbindexgpuGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuGraphN::set(
  self : DbindexgpuGraphN,
  i : Int32,
  v : Double,
) -> DbindexgpuGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuGraphN::sum(self : DbindexgpuGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuGraphN::mean(self : DbindexgpuGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuGraphN::scale(
  self : DbindexgpuGraphN,
  f : Double,
) -> DbindexgpuGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuGraphN::add(
  self : DbindexgpuGraphN,
  other : DbindexgpuGraphN,
) -> DbindexgpuGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuGraphN::copy(self : DbindexgpuGraphN) -> DbindexgpuGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuGraphN::fill(
  self : DbindexgpuGraphN,
  v : Double,
) -> DbindexgpuGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuGraphN::min(self : DbindexgpuGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuGraphN::max(self : DbindexgpuGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuGraphN::to_string(self : DbindexgpuGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_node_make(size : Int32) -> DbindexgpuNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuNode::len(self : DbindexgpuNode) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuNode::get(self : DbindexgpuNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuNode::set(
  self : DbindexgpuNode,
  i : Int32,
  v : Double,
) -> DbindexgpuNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuNode::sum(self : DbindexgpuNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuNode::mean(self : DbindexgpuNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuNode::scale(
  self : DbindexgpuNode,
  f : Double,
) -> DbindexgpuNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuNode::add(
  self : DbindexgpuNode,
  other : DbindexgpuNode,
) -> DbindexgpuNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuNode::copy(self : DbindexgpuNode) -> DbindexgpuNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuNode::fill(
  self : DbindexgpuNode,
  v : Double,
) -> DbindexgpuNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuNode::min(self : DbindexgpuNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuNode::max(self : DbindexgpuNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuNode::to_string(self : DbindexgpuNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_edge_make(size : Int32) -> DbindexgpuEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuEdge::len(self : DbindexgpuEdge) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuEdge::get(self : DbindexgpuEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuEdge::set(
  self : DbindexgpuEdge,
  i : Int32,
  v : Double,
) -> DbindexgpuEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuEdge::sum(self : DbindexgpuEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuEdge::mean(self : DbindexgpuEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuEdge::scale(
  self : DbindexgpuEdge,
  f : Double,
) -> DbindexgpuEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuEdge::add(
  self : DbindexgpuEdge,
  other : DbindexgpuEdge,
) -> DbindexgpuEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuEdge::copy(self : DbindexgpuEdge) -> DbindexgpuEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuEdge::fill(
  self : DbindexgpuEdge,
  v : Double,
) -> DbindexgpuEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuEdge::min(self : DbindexgpuEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuEdge::max(self : DbindexgpuEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuEdge::to_string(self : DbindexgpuEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_path_make(size : Int32) -> DbindexgpuPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuPath::len(self : DbindexgpuPath) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuPath::get(self : DbindexgpuPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuPath::set(
  self : DbindexgpuPath,
  i : Int32,
  v : Double,
) -> DbindexgpuPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuPath::sum(self : DbindexgpuPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuPath::mean(self : DbindexgpuPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuPath::scale(
  self : DbindexgpuPath,
  f : Double,
) -> DbindexgpuPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuPath::add(
  self : DbindexgpuPath,
  other : DbindexgpuPath,
) -> DbindexgpuPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuPath::copy(self : DbindexgpuPath) -> DbindexgpuPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuPath::fill(
  self : DbindexgpuPath,
  v : Double,
) -> DbindexgpuPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuPath::min(self : DbindexgpuPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuPath::max(self : DbindexgpuPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuPath::to_string(self : DbindexgpuPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_cluster_make(size : Int32) -> DbindexgpuCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuCluster::len(self : DbindexgpuCluster) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuCluster::get(self : DbindexgpuCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuCluster::set(
  self : DbindexgpuCluster,
  i : Int32,
  v : Double,
) -> DbindexgpuCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCluster::sum(self : DbindexgpuCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuCluster::mean(self : DbindexgpuCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuCluster::scale(
  self : DbindexgpuCluster,
  f : Double,
) -> DbindexgpuCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCluster::add(
  self : DbindexgpuCluster,
  other : DbindexgpuCluster,
) -> DbindexgpuCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuCluster::copy(self : DbindexgpuCluster) -> DbindexgpuCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCluster::fill(
  self : DbindexgpuCluster,
  v : Double,
) -> DbindexgpuCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCluster::min(self : DbindexgpuCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuCluster::max(self : DbindexgpuCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuCluster::to_string(self : DbindexgpuCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_model_make(size : Int32) -> DbindexgpuModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuModel::len(self : DbindexgpuModel) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuModel::get(self : DbindexgpuModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuModel::set(
  self : DbindexgpuModel,
  i : Int32,
  v : Double,
) -> DbindexgpuModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuModel::sum(self : DbindexgpuModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuModel::mean(self : DbindexgpuModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuModel::scale(
  self : DbindexgpuModel,
  f : Double,
) -> DbindexgpuModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuModel::add(
  self : DbindexgpuModel,
  other : DbindexgpuModel,
) -> DbindexgpuModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuModel::copy(self : DbindexgpuModel) -> DbindexgpuModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuModel::fill(
  self : DbindexgpuModel,
  v : Double,
) -> DbindexgpuModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuModel::min(self : DbindexgpuModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuModel::max(self : DbindexgpuModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuModel::to_string(self : DbindexgpuModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_layer_make(size : Int32) -> DbindexgpuLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuLayer::len(self : DbindexgpuLayer) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuLayer::get(self : DbindexgpuLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuLayer::set(
  self : DbindexgpuLayer,
  i : Int32,
  v : Double,
) -> DbindexgpuLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuLayer::sum(self : DbindexgpuLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuLayer::mean(self : DbindexgpuLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuLayer::scale(
  self : DbindexgpuLayer,
  f : Double,
) -> DbindexgpuLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuLayer::add(
  self : DbindexgpuLayer,
  other : DbindexgpuLayer,
) -> DbindexgpuLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuLayer::copy(self : DbindexgpuLayer) -> DbindexgpuLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuLayer::fill(
  self : DbindexgpuLayer,
  v : Double,
) -> DbindexgpuLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuLayer::min(self : DbindexgpuLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuLayer::max(self : DbindexgpuLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuLayer::to_string(self : DbindexgpuLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_buffer_make(size : Int32) -> DbindexgpuBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuBuffer::len(self : DbindexgpuBuffer) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuBuffer::get(self : DbindexgpuBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuBuffer::set(
  self : DbindexgpuBuffer,
  i : Int32,
  v : Double,
) -> DbindexgpuBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuBuffer::sum(self : DbindexgpuBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuBuffer::mean(self : DbindexgpuBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuBuffer::scale(
  self : DbindexgpuBuffer,
  f : Double,
) -> DbindexgpuBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuBuffer::add(
  self : DbindexgpuBuffer,
  other : DbindexgpuBuffer,
) -> DbindexgpuBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuBuffer::copy(self : DbindexgpuBuffer) -> DbindexgpuBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuBuffer::fill(
  self : DbindexgpuBuffer,
  v : Double,
) -> DbindexgpuBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuBuffer::min(self : DbindexgpuBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuBuffer::max(self : DbindexgpuBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuBuffer::to_string(self : DbindexgpuBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_cursor_make(size : Int32) -> DbindexgpuCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuCursor::len(self : DbindexgpuCursor) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuCursor::get(self : DbindexgpuCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuCursor::set(
  self : DbindexgpuCursor,
  i : Int32,
  v : Double,
) -> DbindexgpuCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCursor::sum(self : DbindexgpuCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuCursor::mean(self : DbindexgpuCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuCursor::scale(
  self : DbindexgpuCursor,
  f : Double,
) -> DbindexgpuCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCursor::add(
  self : DbindexgpuCursor,
  other : DbindexgpuCursor,
) -> DbindexgpuCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuCursor::copy(self : DbindexgpuCursor) -> DbindexgpuCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCursor::fill(
  self : DbindexgpuCursor,
  v : Double,
) -> DbindexgpuCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuCursor::min(self : DbindexgpuCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuCursor::max(self : DbindexgpuCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuCursor::to_string(self : DbindexgpuCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_view_make(size : Int32) -> DbindexgpuView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuView::len(self : DbindexgpuView) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuView::get(self : DbindexgpuView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuView::set(
  self : DbindexgpuView,
  i : Int32,
  v : Double,
) -> DbindexgpuView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuView::sum(self : DbindexgpuView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuView::mean(self : DbindexgpuView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuView::scale(
  self : DbindexgpuView,
  f : Double,
) -> DbindexgpuView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuView::add(
  self : DbindexgpuView,
  other : DbindexgpuView,
) -> DbindexgpuView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuView::copy(self : DbindexgpuView) -> DbindexgpuView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuView::fill(
  self : DbindexgpuView,
  v : Double,
) -> DbindexgpuView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuView::min(self : DbindexgpuView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuView::max(self : DbindexgpuView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuView::to_string(self : DbindexgpuView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_range_make(size : Int32) -> DbindexgpuRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuRange::len(self : DbindexgpuRange) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuRange::get(self : DbindexgpuRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuRange::set(
  self : DbindexgpuRange,
  i : Int32,
  v : Double,
) -> DbindexgpuRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuRange::sum(self : DbindexgpuRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuRange::mean(self : DbindexgpuRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuRange::scale(
  self : DbindexgpuRange,
  f : Double,
) -> DbindexgpuRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuRange::add(
  self : DbindexgpuRange,
  other : DbindexgpuRange,
) -> DbindexgpuRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuRange::copy(self : DbindexgpuRange) -> DbindexgpuRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuRange::fill(
  self : DbindexgpuRange,
  v : Double,
) -> DbindexgpuRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuRange::min(self : DbindexgpuRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuRange::max(self : DbindexgpuRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuRange::to_string(self : DbindexgpuRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbindexgpuSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_index_gpu_slice_make(size : Int32) -> DbindexgpuSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbindexgpuSlice::len(self : DbindexgpuSlice) -> Int32 {
  self.size
}

///|
pub fn DbindexgpuSlice::get(self : DbindexgpuSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbindexgpuSlice::set(
  self : DbindexgpuSlice,
  i : Int32,
  v : Double,
) -> DbindexgpuSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuSlice::sum(self : DbindexgpuSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbindexgpuSlice::mean(self : DbindexgpuSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbindexgpuSlice::scale(
  self : DbindexgpuSlice,
  f : Double,
) -> DbindexgpuSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuSlice::add(
  self : DbindexgpuSlice,
  other : DbindexgpuSlice,
) -> DbindexgpuSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbindexgpuSlice::copy(self : DbindexgpuSlice) -> DbindexgpuSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuSlice::fill(
  self : DbindexgpuSlice,
  v : Double,
) -> DbindexgpuSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbindexgpuSlice::min(self : DbindexgpuSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbindexgpuSlice::max(self : DbindexgpuSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbindexgpuSlice::to_string(self : DbindexgpuSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

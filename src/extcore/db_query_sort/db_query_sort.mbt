///|
///===
/// extcore/db_query_sort
pub(all) struct DbquerysortPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn db_query_sort_make_point(x : Double, y : Double) -> DbquerysortPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn db_query_sort_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DbquerysortPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DbquerysortPoint::x(self : DbquerysortPoint) -> Double {
  self.x
}

///|
pub fn DbquerysortPoint::y(self : DbquerysortPoint) -> Double {
  self.y
}

///|
pub fn DbquerysortPoint::z(self : DbquerysortPoint) -> Double {
  self.z
}

///|
pub fn DbquerysortPoint::label(self : DbquerysortPoint) -> Int32 {
  self.label
}

///|
pub fn DbquerysortPoint::dist(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DbquerysortPoint::add(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> DbquerysortPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DbquerysortPoint::sub(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> DbquerysortPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DbquerysortPoint::scale(
  self : DbquerysortPoint,
  s : Double,
) -> DbquerysortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DbquerysortPoint::dot(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DbquerysortPoint::cross(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> DbquerysortPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DbquerysortPoint::norm(self : DbquerysortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DbquerysortPoint::normalize(self : DbquerysortPoint) -> DbquerysortPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbquerysortPoint::negate(self : DbquerysortPoint) -> DbquerysortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DbquerysortPoint::mid(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
) -> DbquerysortPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DbquerysortPoint::lerp(
  self : DbquerysortPoint,
  other : DbquerysortPoint,
  t : Double,
) -> DbquerysortPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DbquerysortPoint::to_string(self : DbquerysortPoint) -> String {
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
pub(all) struct DbquerysortSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn db_query_sort_make_series(
  vals : Array[Double],
  name : String,
) -> DbquerysortSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DbquerysortSeries::len(self : DbquerysortSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DbquerysortSeries::sum(self : DbquerysortSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DbquerysortSeries::mean(self : DbquerysortSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DbquerysortSeries::min(self : DbquerysortSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DbquerysortSeries::max(self : DbquerysortSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DbquerysortSeries::range(self : DbquerysortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DbquerysortSeries::variance(self : DbquerysortSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DbquerysortSeries::std(self : DbquerysortSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DbquerysortSeries::median(self : DbquerysortSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DbquerysortSeries::scale(
  self : DbquerysortSeries,
  f : Double,
) -> DbquerysortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DbquerysortSeries::add(
  self : DbquerysortSeries,
  other : DbquerysortSeries,
) -> DbquerysortSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbquerysortSeries::sub(
  self : DbquerysortSeries,
  other : DbquerysortSeries,
) -> DbquerysortSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DbquerysortSeries::normalize(
  self : DbquerysortSeries,
) -> DbquerysortSeries {
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
pub fn DbquerysortSeries::cumsum(self : DbquerysortSeries) -> DbquerysortSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DbquerysortSeries::to_string(self : DbquerysortSeries) -> String {
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
pub(all) struct DbquerysortMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn db_query_sort_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DbquerysortMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn db_query_sort_matrix_identity(n : Int32) -> DbquerysortMatrix {
  let m = db_query_sort_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DbquerysortMatrix::get(
  self : DbquerysortMatrix,
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
pub fn DbquerysortMatrix::transpose(
  self : DbquerysortMatrix,
) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DbquerysortMatrix::add(
  self : DbquerysortMatrix,
  other : DbquerysortMatrix,
) -> DbquerysortMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = db_query_sort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DbquerysortMatrix::scale(
  self : DbquerysortMatrix,
  s : Double,
) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DbquerysortMatrix::multiply(
  self : DbquerysortMatrix,
  other : DbquerysortMatrix,
) -> DbquerysortMatrix {
  if self.cols != other.rows {
    return db_query_sort_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = db_query_sort_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DbquerysortMatrix::trace(self : DbquerysortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DbquerysortMatrix::det(self : DbquerysortMatrix) -> Double {
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
pub fn DbquerysortMatrix::norm(self : DbquerysortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DbquerysortMatrix::to_string(self : DbquerysortMatrix) -> String {
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
pub(all) struct DbquerysortVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn db_query_sort_make_vector(comps : Array[Double]) -> DbquerysortVector {
  { comps, dim: comps.length(), }
}

///|
pub fn db_query_sort_vector_zero(dim : Int32) -> DbquerysortVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DbquerysortVector::add(
  self : DbquerysortVector,
  other : DbquerysortVector,
) -> DbquerysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbquerysortVector::sub(
  self : DbquerysortVector,
  other : DbquerysortVector,
) -> DbquerysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DbquerysortVector::scale(
  self : DbquerysortVector,
  s : Double,
) -> DbquerysortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DbquerysortVector::dot(
  self : DbquerysortVector,
  other : DbquerysortVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DbquerysortVector::norm(self : DbquerysortVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DbquerysortVector::normalize(
  self : DbquerysortVector,
) -> DbquerysortVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DbquerysortVector::dist(
  self : DbquerysortVector,
  other : DbquerysortVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DbquerysortVector::to_string(self : DbquerysortVector) -> String {
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
pub(all) struct DbquerysortFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_frame_make(size : Int32) -> DbquerysortFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortFrame::len(self : DbquerysortFrame) -> Int32 {
  self.size
}

///|
pub fn DbquerysortFrame::get(self : DbquerysortFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortFrame::set(
  self : DbquerysortFrame,
  i : Int32,
  v : Double,
) -> DbquerysortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortFrame::sum(self : DbquerysortFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortFrame::mean(self : DbquerysortFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortFrame::scale(
  self : DbquerysortFrame,
  f : Double,
) -> DbquerysortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortFrame::add(
  self : DbquerysortFrame,
  other : DbquerysortFrame,
) -> DbquerysortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortFrame::copy(self : DbquerysortFrame) -> DbquerysortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortFrame::fill(
  self : DbquerysortFrame,
  v : Double,
) -> DbquerysortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortFrame::min(self : DbquerysortFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortFrame::max(self : DbquerysortFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortFrame::to_string(self : DbquerysortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_table_make(size : Int32) -> DbquerysortTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortTable::len(self : DbquerysortTable) -> Int32 {
  self.size
}

///|
pub fn DbquerysortTable::get(self : DbquerysortTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortTable::set(
  self : DbquerysortTable,
  i : Int32,
  v : Double,
) -> DbquerysortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortTable::sum(self : DbquerysortTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortTable::mean(self : DbquerysortTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortTable::scale(
  self : DbquerysortTable,
  f : Double,
) -> DbquerysortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortTable::add(
  self : DbquerysortTable,
  other : DbquerysortTable,
) -> DbquerysortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortTable::copy(self : DbquerysortTable) -> DbquerysortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortTable::fill(
  self : DbquerysortTable,
  v : Double,
) -> DbquerysortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortTable::min(self : DbquerysortTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortTable::max(self : DbquerysortTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortTable::to_string(self : DbquerysortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_graphn_make(size : Int32) -> DbquerysortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortGraphN::len(self : DbquerysortGraphN) -> Int32 {
  self.size
}

///|
pub fn DbquerysortGraphN::get(self : DbquerysortGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortGraphN::set(
  self : DbquerysortGraphN,
  i : Int32,
  v : Double,
) -> DbquerysortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortGraphN::sum(self : DbquerysortGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortGraphN::mean(self : DbquerysortGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortGraphN::scale(
  self : DbquerysortGraphN,
  f : Double,
) -> DbquerysortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortGraphN::add(
  self : DbquerysortGraphN,
  other : DbquerysortGraphN,
) -> DbquerysortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortGraphN::copy(self : DbquerysortGraphN) -> DbquerysortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortGraphN::fill(
  self : DbquerysortGraphN,
  v : Double,
) -> DbquerysortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortGraphN::min(self : DbquerysortGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortGraphN::max(self : DbquerysortGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortGraphN::to_string(self : DbquerysortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_node_make(size : Int32) -> DbquerysortNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortNode::len(self : DbquerysortNode) -> Int32 {
  self.size
}

///|
pub fn DbquerysortNode::get(self : DbquerysortNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortNode::set(
  self : DbquerysortNode,
  i : Int32,
  v : Double,
) -> DbquerysortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortNode::sum(self : DbquerysortNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortNode::mean(self : DbquerysortNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortNode::scale(
  self : DbquerysortNode,
  f : Double,
) -> DbquerysortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortNode::add(
  self : DbquerysortNode,
  other : DbquerysortNode,
) -> DbquerysortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortNode::copy(self : DbquerysortNode) -> DbquerysortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortNode::fill(
  self : DbquerysortNode,
  v : Double,
) -> DbquerysortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortNode::min(self : DbquerysortNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortNode::max(self : DbquerysortNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortNode::to_string(self : DbquerysortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_edge_make(size : Int32) -> DbquerysortEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortEdge::len(self : DbquerysortEdge) -> Int32 {
  self.size
}

///|
pub fn DbquerysortEdge::get(self : DbquerysortEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortEdge::set(
  self : DbquerysortEdge,
  i : Int32,
  v : Double,
) -> DbquerysortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortEdge::sum(self : DbquerysortEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortEdge::mean(self : DbquerysortEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortEdge::scale(
  self : DbquerysortEdge,
  f : Double,
) -> DbquerysortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortEdge::add(
  self : DbquerysortEdge,
  other : DbquerysortEdge,
) -> DbquerysortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortEdge::copy(self : DbquerysortEdge) -> DbquerysortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortEdge::fill(
  self : DbquerysortEdge,
  v : Double,
) -> DbquerysortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortEdge::min(self : DbquerysortEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortEdge::max(self : DbquerysortEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortEdge::to_string(self : DbquerysortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_path_make(size : Int32) -> DbquerysortPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortPath::len(self : DbquerysortPath) -> Int32 {
  self.size
}

///|
pub fn DbquerysortPath::get(self : DbquerysortPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortPath::set(
  self : DbquerysortPath,
  i : Int32,
  v : Double,
) -> DbquerysortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortPath::sum(self : DbquerysortPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortPath::mean(self : DbquerysortPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortPath::scale(
  self : DbquerysortPath,
  f : Double,
) -> DbquerysortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortPath::add(
  self : DbquerysortPath,
  other : DbquerysortPath,
) -> DbquerysortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortPath::copy(self : DbquerysortPath) -> DbquerysortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortPath::fill(
  self : DbquerysortPath,
  v : Double,
) -> DbquerysortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortPath::min(self : DbquerysortPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortPath::max(self : DbquerysortPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortPath::to_string(self : DbquerysortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_cluster_make(size : Int32) -> DbquerysortCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortCluster::len(self : DbquerysortCluster) -> Int32 {
  self.size
}

///|
pub fn DbquerysortCluster::get(self : DbquerysortCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortCluster::set(
  self : DbquerysortCluster,
  i : Int32,
  v : Double,
) -> DbquerysortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCluster::sum(self : DbquerysortCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortCluster::mean(self : DbquerysortCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortCluster::scale(
  self : DbquerysortCluster,
  f : Double,
) -> DbquerysortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCluster::add(
  self : DbquerysortCluster,
  other : DbquerysortCluster,
) -> DbquerysortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortCluster::copy(
  self : DbquerysortCluster,
) -> DbquerysortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCluster::fill(
  self : DbquerysortCluster,
  v : Double,
) -> DbquerysortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCluster::min(self : DbquerysortCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortCluster::max(self : DbquerysortCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortCluster::to_string(self : DbquerysortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_model_make(size : Int32) -> DbquerysortModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortModel::len(self : DbquerysortModel) -> Int32 {
  self.size
}

///|
pub fn DbquerysortModel::get(self : DbquerysortModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortModel::set(
  self : DbquerysortModel,
  i : Int32,
  v : Double,
) -> DbquerysortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortModel::sum(self : DbquerysortModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortModel::mean(self : DbquerysortModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortModel::scale(
  self : DbquerysortModel,
  f : Double,
) -> DbquerysortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortModel::add(
  self : DbquerysortModel,
  other : DbquerysortModel,
) -> DbquerysortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortModel::copy(self : DbquerysortModel) -> DbquerysortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortModel::fill(
  self : DbquerysortModel,
  v : Double,
) -> DbquerysortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortModel::min(self : DbquerysortModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortModel::max(self : DbquerysortModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortModel::to_string(self : DbquerysortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_layer_make(size : Int32) -> DbquerysortLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortLayer::len(self : DbquerysortLayer) -> Int32 {
  self.size
}

///|
pub fn DbquerysortLayer::get(self : DbquerysortLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortLayer::set(
  self : DbquerysortLayer,
  i : Int32,
  v : Double,
) -> DbquerysortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortLayer::sum(self : DbquerysortLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortLayer::mean(self : DbquerysortLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortLayer::scale(
  self : DbquerysortLayer,
  f : Double,
) -> DbquerysortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortLayer::add(
  self : DbquerysortLayer,
  other : DbquerysortLayer,
) -> DbquerysortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortLayer::copy(self : DbquerysortLayer) -> DbquerysortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortLayer::fill(
  self : DbquerysortLayer,
  v : Double,
) -> DbquerysortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortLayer::min(self : DbquerysortLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortLayer::max(self : DbquerysortLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortLayer::to_string(self : DbquerysortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_buffer_make(size : Int32) -> DbquerysortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortBuffer::len(self : DbquerysortBuffer) -> Int32 {
  self.size
}

///|
pub fn DbquerysortBuffer::get(self : DbquerysortBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortBuffer::set(
  self : DbquerysortBuffer,
  i : Int32,
  v : Double,
) -> DbquerysortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortBuffer::sum(self : DbquerysortBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortBuffer::mean(self : DbquerysortBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortBuffer::scale(
  self : DbquerysortBuffer,
  f : Double,
) -> DbquerysortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortBuffer::add(
  self : DbquerysortBuffer,
  other : DbquerysortBuffer,
) -> DbquerysortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortBuffer::copy(self : DbquerysortBuffer) -> DbquerysortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortBuffer::fill(
  self : DbquerysortBuffer,
  v : Double,
) -> DbquerysortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortBuffer::min(self : DbquerysortBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortBuffer::max(self : DbquerysortBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortBuffer::to_string(self : DbquerysortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_cursor_make(size : Int32) -> DbquerysortCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortCursor::len(self : DbquerysortCursor) -> Int32 {
  self.size
}

///|
pub fn DbquerysortCursor::get(self : DbquerysortCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortCursor::set(
  self : DbquerysortCursor,
  i : Int32,
  v : Double,
) -> DbquerysortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCursor::sum(self : DbquerysortCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortCursor::mean(self : DbquerysortCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortCursor::scale(
  self : DbquerysortCursor,
  f : Double,
) -> DbquerysortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCursor::add(
  self : DbquerysortCursor,
  other : DbquerysortCursor,
) -> DbquerysortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortCursor::copy(self : DbquerysortCursor) -> DbquerysortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCursor::fill(
  self : DbquerysortCursor,
  v : Double,
) -> DbquerysortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortCursor::min(self : DbquerysortCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortCursor::max(self : DbquerysortCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortCursor::to_string(self : DbquerysortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_view_make(size : Int32) -> DbquerysortView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortView::len(self : DbquerysortView) -> Int32 {
  self.size
}

///|
pub fn DbquerysortView::get(self : DbquerysortView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortView::set(
  self : DbquerysortView,
  i : Int32,
  v : Double,
) -> DbquerysortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortView::sum(self : DbquerysortView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortView::mean(self : DbquerysortView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortView::scale(
  self : DbquerysortView,
  f : Double,
) -> DbquerysortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortView::add(
  self : DbquerysortView,
  other : DbquerysortView,
) -> DbquerysortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortView::copy(self : DbquerysortView) -> DbquerysortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortView::fill(
  self : DbquerysortView,
  v : Double,
) -> DbquerysortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortView::min(self : DbquerysortView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortView::max(self : DbquerysortView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortView::to_string(self : DbquerysortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_range_make(size : Int32) -> DbquerysortRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortRange::len(self : DbquerysortRange) -> Int32 {
  self.size
}

///|
pub fn DbquerysortRange::get(self : DbquerysortRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortRange::set(
  self : DbquerysortRange,
  i : Int32,
  v : Double,
) -> DbquerysortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortRange::sum(self : DbquerysortRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortRange::mean(self : DbquerysortRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortRange::scale(
  self : DbquerysortRange,
  f : Double,
) -> DbquerysortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortRange::add(
  self : DbquerysortRange,
  other : DbquerysortRange,
) -> DbquerysortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortRange::copy(self : DbquerysortRange) -> DbquerysortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortRange::fill(
  self : DbquerysortRange,
  v : Double,
) -> DbquerysortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortRange::min(self : DbquerysortRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortRange::max(self : DbquerysortRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortRange::to_string(self : DbquerysortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DbquerysortSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn db_query_sort_slice_make(size : Int32) -> DbquerysortSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DbquerysortSlice::len(self : DbquerysortSlice) -> Int32 {
  self.size
}

///|
pub fn DbquerysortSlice::get(self : DbquerysortSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DbquerysortSlice::set(
  self : DbquerysortSlice,
  i : Int32,
  v : Double,
) -> DbquerysortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortSlice::sum(self : DbquerysortSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DbquerysortSlice::mean(self : DbquerysortSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DbquerysortSlice::scale(
  self : DbquerysortSlice,
  f : Double,
) -> DbquerysortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortSlice::add(
  self : DbquerysortSlice,
  other : DbquerysortSlice,
) -> DbquerysortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DbquerysortSlice::copy(self : DbquerysortSlice) -> DbquerysortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortSlice::fill(
  self : DbquerysortSlice,
  v : Double,
) -> DbquerysortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DbquerysortSlice::min(self : DbquerysortSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DbquerysortSlice::max(self : DbquerysortSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DbquerysortSlice::to_string(self : DbquerysortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

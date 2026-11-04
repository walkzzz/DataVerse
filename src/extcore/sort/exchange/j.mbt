///|
///===
/// extcore/sort_exchange_j
pub(all) struct SortexchangejPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn sort_exchange_j_make_point(x : Double, y : Double) -> SortexchangejPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn sort_exchange_j_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> SortexchangejPoint {
  { x, y, z, label: 0, }
}

///|
pub fn SortexchangejPoint::x(self : SortexchangejPoint) -> Double {
  self.x
}

///|
pub fn SortexchangejPoint::y(self : SortexchangejPoint) -> Double {
  self.y
}

///|
pub fn SortexchangejPoint::z(self : SortexchangejPoint) -> Double {
  self.z
}

///|
pub fn SortexchangejPoint::label(self : SortexchangejPoint) -> Int32 {
  self.label
}

///|
pub fn SortexchangejPoint::dist(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn SortexchangejPoint::add(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> SortexchangejPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangejPoint::sub(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> SortexchangejPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn SortexchangejPoint::scale(
  self : SortexchangejPoint,
  s : Double,
) -> SortexchangejPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn SortexchangejPoint::dot(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn SortexchangejPoint::cross(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> SortexchangejPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn SortexchangejPoint::norm(self : SortexchangejPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn SortexchangejPoint::normalize(
  self : SortexchangejPoint,
) -> SortexchangejPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangejPoint::negate(
  self : SortexchangejPoint,
) -> SortexchangejPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn SortexchangejPoint::mid(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
) -> SortexchangejPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn SortexchangejPoint::lerp(
  self : SortexchangejPoint,
  other : SortexchangejPoint,
  t : Double,
) -> SortexchangejPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn SortexchangejPoint::to_string(self : SortexchangejPoint) -> String {
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
pub(all) struct SortexchangejSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn sort_exchange_j_make_series(
  vals : Array[Double],
  name : String,
) -> SortexchangejSeries {
  { vals, name, meta: 0, }
}

///|
pub fn SortexchangejSeries::len(self : SortexchangejSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn SortexchangejSeries::sum(self : SortexchangejSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn SortexchangejSeries::mean(self : SortexchangejSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn SortexchangejSeries::min(self : SortexchangejSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn SortexchangejSeries::max(self : SortexchangejSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn SortexchangejSeries::range(self : SortexchangejSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn SortexchangejSeries::variance(self : SortexchangejSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn SortexchangejSeries::std(self : SortexchangejSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn SortexchangejSeries::median(self : SortexchangejSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn SortexchangejSeries::scale(
  self : SortexchangejSeries,
  f : Double,
) -> SortexchangejSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn SortexchangejSeries::add(
  self : SortexchangejSeries,
  other : SortexchangejSeries,
) -> SortexchangejSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangejSeries::sub(
  self : SortexchangejSeries,
  other : SortexchangejSeries,
) -> SortexchangejSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn SortexchangejSeries::normalize(
  self : SortexchangejSeries,
) -> SortexchangejSeries {
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
pub fn SortexchangejSeries::cumsum(
  self : SortexchangejSeries,
) -> SortexchangejSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn SortexchangejSeries::to_string(self : SortexchangejSeries) -> String {
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
pub(all) struct SortexchangejMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn sort_exchange_j_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> SortexchangejMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn sort_exchange_j_matrix_identity(n : Int32) -> SortexchangejMatrix {
  let m = sort_exchange_j_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn SortexchangejMatrix::get(
  self : SortexchangejMatrix,
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
pub fn SortexchangejMatrix::transpose(
  self : SortexchangejMatrix,
) -> SortexchangejMatrix {
  let result = sort_exchange_j_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangejMatrix::add(
  self : SortexchangejMatrix,
  other : SortexchangejMatrix,
) -> SortexchangejMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = sort_exchange_j_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn SortexchangejMatrix::scale(
  self : SortexchangejMatrix,
  s : Double,
) -> SortexchangejMatrix {
  let result = sort_exchange_j_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn SortexchangejMatrix::multiply(
  self : SortexchangejMatrix,
  other : SortexchangejMatrix,
) -> SortexchangejMatrix {
  if self.cols != other.rows {
    return sort_exchange_j_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = sort_exchange_j_make_matrix(self.rows, other.cols, 0.0)
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
pub fn SortexchangejMatrix::trace(self : SortexchangejMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn SortexchangejMatrix::det(self : SortexchangejMatrix) -> Double {
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
pub fn SortexchangejMatrix::norm(self : SortexchangejMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn SortexchangejMatrix::to_string(self : SortexchangejMatrix) -> String {
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
pub(all) struct SortexchangejVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn sort_exchange_j_make_vector(
  comps : Array[Double],
) -> SortexchangejVector {
  { comps, dim: comps.length(), }
}

///|
pub fn sort_exchange_j_vector_zero(dim : Int32) -> SortexchangejVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn SortexchangejVector::add(
  self : SortexchangejVector,
  other : SortexchangejVector,
) -> SortexchangejVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangejVector::sub(
  self : SortexchangejVector,
  other : SortexchangejVector,
) -> SortexchangejVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn SortexchangejVector::scale(
  self : SortexchangejVector,
  s : Double,
) -> SortexchangejVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn SortexchangejVector::dot(
  self : SortexchangejVector,
  other : SortexchangejVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn SortexchangejVector::norm(self : SortexchangejVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn SortexchangejVector::normalize(
  self : SortexchangejVector,
) -> SortexchangejVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn SortexchangejVector::dist(
  self : SortexchangejVector,
  other : SortexchangejVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn SortexchangejVector::to_string(self : SortexchangejVector) -> String {
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
pub(all) struct SortexchangejFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_frame_make(size : Int32) -> SortexchangejFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejFrame::len(self : SortexchangejFrame) -> Int32 {
  self.size
}

///|
pub fn SortexchangejFrame::get(self : SortexchangejFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejFrame::set(
  self : SortexchangejFrame,
  i : Int32,
  v : Double,
) -> SortexchangejFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejFrame::sum(self : SortexchangejFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejFrame::mean(self : SortexchangejFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejFrame::scale(
  self : SortexchangejFrame,
  f : Double,
) -> SortexchangejFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejFrame::add(
  self : SortexchangejFrame,
  other : SortexchangejFrame,
) -> SortexchangejFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejFrame::copy(
  self : SortexchangejFrame,
) -> SortexchangejFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejFrame::fill(
  self : SortexchangejFrame,
  v : Double,
) -> SortexchangejFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejFrame::min(self : SortexchangejFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejFrame::max(self : SortexchangejFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejFrame::to_string(self : SortexchangejFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_table_make(size : Int32) -> SortexchangejTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejTable::len(self : SortexchangejTable) -> Int32 {
  self.size
}

///|
pub fn SortexchangejTable::get(self : SortexchangejTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejTable::set(
  self : SortexchangejTable,
  i : Int32,
  v : Double,
) -> SortexchangejTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejTable::sum(self : SortexchangejTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejTable::mean(self : SortexchangejTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejTable::scale(
  self : SortexchangejTable,
  f : Double,
) -> SortexchangejTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejTable::add(
  self : SortexchangejTable,
  other : SortexchangejTable,
) -> SortexchangejTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejTable::copy(
  self : SortexchangejTable,
) -> SortexchangejTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejTable::fill(
  self : SortexchangejTable,
  v : Double,
) -> SortexchangejTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejTable::min(self : SortexchangejTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejTable::max(self : SortexchangejTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejTable::to_string(self : SortexchangejTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_graphn_make(size : Int32) -> SortexchangejGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejGraphN::len(self : SortexchangejGraphN) -> Int32 {
  self.size
}

///|
pub fn SortexchangejGraphN::get(
  self : SortexchangejGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejGraphN::set(
  self : SortexchangejGraphN,
  i : Int32,
  v : Double,
) -> SortexchangejGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejGraphN::sum(self : SortexchangejGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejGraphN::mean(self : SortexchangejGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejGraphN::scale(
  self : SortexchangejGraphN,
  f : Double,
) -> SortexchangejGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejGraphN::add(
  self : SortexchangejGraphN,
  other : SortexchangejGraphN,
) -> SortexchangejGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejGraphN::copy(
  self : SortexchangejGraphN,
) -> SortexchangejGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejGraphN::fill(
  self : SortexchangejGraphN,
  v : Double,
) -> SortexchangejGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejGraphN::min(self : SortexchangejGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejGraphN::max(self : SortexchangejGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejGraphN::to_string(self : SortexchangejGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_node_make(size : Int32) -> SortexchangejNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejNode::len(self : SortexchangejNode) -> Int32 {
  self.size
}

///|
pub fn SortexchangejNode::get(self : SortexchangejNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejNode::set(
  self : SortexchangejNode,
  i : Int32,
  v : Double,
) -> SortexchangejNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejNode::sum(self : SortexchangejNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejNode::mean(self : SortexchangejNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejNode::scale(
  self : SortexchangejNode,
  f : Double,
) -> SortexchangejNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejNode::add(
  self : SortexchangejNode,
  other : SortexchangejNode,
) -> SortexchangejNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejNode::copy(self : SortexchangejNode) -> SortexchangejNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejNode::fill(
  self : SortexchangejNode,
  v : Double,
) -> SortexchangejNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejNode::min(self : SortexchangejNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejNode::max(self : SortexchangejNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejNode::to_string(self : SortexchangejNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_edge_make(size : Int32) -> SortexchangejEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejEdge::len(self : SortexchangejEdge) -> Int32 {
  self.size
}

///|
pub fn SortexchangejEdge::get(self : SortexchangejEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejEdge::set(
  self : SortexchangejEdge,
  i : Int32,
  v : Double,
) -> SortexchangejEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejEdge::sum(self : SortexchangejEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejEdge::mean(self : SortexchangejEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejEdge::scale(
  self : SortexchangejEdge,
  f : Double,
) -> SortexchangejEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejEdge::add(
  self : SortexchangejEdge,
  other : SortexchangejEdge,
) -> SortexchangejEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejEdge::copy(self : SortexchangejEdge) -> SortexchangejEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejEdge::fill(
  self : SortexchangejEdge,
  v : Double,
) -> SortexchangejEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejEdge::min(self : SortexchangejEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejEdge::max(self : SortexchangejEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejEdge::to_string(self : SortexchangejEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_path_make(size : Int32) -> SortexchangejPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejPath::len(self : SortexchangejPath) -> Int32 {
  self.size
}

///|
pub fn SortexchangejPath::get(self : SortexchangejPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejPath::set(
  self : SortexchangejPath,
  i : Int32,
  v : Double,
) -> SortexchangejPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejPath::sum(self : SortexchangejPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejPath::mean(self : SortexchangejPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejPath::scale(
  self : SortexchangejPath,
  f : Double,
) -> SortexchangejPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejPath::add(
  self : SortexchangejPath,
  other : SortexchangejPath,
) -> SortexchangejPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejPath::copy(self : SortexchangejPath) -> SortexchangejPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejPath::fill(
  self : SortexchangejPath,
  v : Double,
) -> SortexchangejPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejPath::min(self : SortexchangejPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejPath::max(self : SortexchangejPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejPath::to_string(self : SortexchangejPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_cluster_make(size : Int32) -> SortexchangejCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejCluster::len(self : SortexchangejCluster) -> Int32 {
  self.size
}

///|
pub fn SortexchangejCluster::get(
  self : SortexchangejCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejCluster::set(
  self : SortexchangejCluster,
  i : Int32,
  v : Double,
) -> SortexchangejCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCluster::sum(self : SortexchangejCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejCluster::mean(self : SortexchangejCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejCluster::scale(
  self : SortexchangejCluster,
  f : Double,
) -> SortexchangejCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCluster::add(
  self : SortexchangejCluster,
  other : SortexchangejCluster,
) -> SortexchangejCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejCluster::copy(
  self : SortexchangejCluster,
) -> SortexchangejCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCluster::fill(
  self : SortexchangejCluster,
  v : Double,
) -> SortexchangejCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCluster::min(self : SortexchangejCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejCluster::max(self : SortexchangejCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejCluster::to_string(self : SortexchangejCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_model_make(size : Int32) -> SortexchangejModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejModel::len(self : SortexchangejModel) -> Int32 {
  self.size
}

///|
pub fn SortexchangejModel::get(self : SortexchangejModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejModel::set(
  self : SortexchangejModel,
  i : Int32,
  v : Double,
) -> SortexchangejModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejModel::sum(self : SortexchangejModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejModel::mean(self : SortexchangejModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejModel::scale(
  self : SortexchangejModel,
  f : Double,
) -> SortexchangejModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejModel::add(
  self : SortexchangejModel,
  other : SortexchangejModel,
) -> SortexchangejModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejModel::copy(
  self : SortexchangejModel,
) -> SortexchangejModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejModel::fill(
  self : SortexchangejModel,
  v : Double,
) -> SortexchangejModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejModel::min(self : SortexchangejModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejModel::max(self : SortexchangejModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejModel::to_string(self : SortexchangejModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_layer_make(size : Int32) -> SortexchangejLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejLayer::len(self : SortexchangejLayer) -> Int32 {
  self.size
}

///|
pub fn SortexchangejLayer::get(self : SortexchangejLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejLayer::set(
  self : SortexchangejLayer,
  i : Int32,
  v : Double,
) -> SortexchangejLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejLayer::sum(self : SortexchangejLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejLayer::mean(self : SortexchangejLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejLayer::scale(
  self : SortexchangejLayer,
  f : Double,
) -> SortexchangejLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejLayer::add(
  self : SortexchangejLayer,
  other : SortexchangejLayer,
) -> SortexchangejLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejLayer::copy(
  self : SortexchangejLayer,
) -> SortexchangejLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejLayer::fill(
  self : SortexchangejLayer,
  v : Double,
) -> SortexchangejLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejLayer::min(self : SortexchangejLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejLayer::max(self : SortexchangejLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejLayer::to_string(self : SortexchangejLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_buffer_make(size : Int32) -> SortexchangejBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejBuffer::len(self : SortexchangejBuffer) -> Int32 {
  self.size
}

///|
pub fn SortexchangejBuffer::get(
  self : SortexchangejBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejBuffer::set(
  self : SortexchangejBuffer,
  i : Int32,
  v : Double,
) -> SortexchangejBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejBuffer::sum(self : SortexchangejBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejBuffer::mean(self : SortexchangejBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejBuffer::scale(
  self : SortexchangejBuffer,
  f : Double,
) -> SortexchangejBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejBuffer::add(
  self : SortexchangejBuffer,
  other : SortexchangejBuffer,
) -> SortexchangejBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejBuffer::copy(
  self : SortexchangejBuffer,
) -> SortexchangejBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejBuffer::fill(
  self : SortexchangejBuffer,
  v : Double,
) -> SortexchangejBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejBuffer::min(self : SortexchangejBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejBuffer::max(self : SortexchangejBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejBuffer::to_string(self : SortexchangejBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_cursor_make(size : Int32) -> SortexchangejCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejCursor::len(self : SortexchangejCursor) -> Int32 {
  self.size
}

///|
pub fn SortexchangejCursor::get(
  self : SortexchangejCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejCursor::set(
  self : SortexchangejCursor,
  i : Int32,
  v : Double,
) -> SortexchangejCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCursor::sum(self : SortexchangejCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejCursor::mean(self : SortexchangejCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejCursor::scale(
  self : SortexchangejCursor,
  f : Double,
) -> SortexchangejCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCursor::add(
  self : SortexchangejCursor,
  other : SortexchangejCursor,
) -> SortexchangejCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejCursor::copy(
  self : SortexchangejCursor,
) -> SortexchangejCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCursor::fill(
  self : SortexchangejCursor,
  v : Double,
) -> SortexchangejCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejCursor::min(self : SortexchangejCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejCursor::max(self : SortexchangejCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejCursor::to_string(self : SortexchangejCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_view_make(size : Int32) -> SortexchangejView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejView::len(self : SortexchangejView) -> Int32 {
  self.size
}

///|
pub fn SortexchangejView::get(self : SortexchangejView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejView::set(
  self : SortexchangejView,
  i : Int32,
  v : Double,
) -> SortexchangejView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejView::sum(self : SortexchangejView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejView::mean(self : SortexchangejView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejView::scale(
  self : SortexchangejView,
  f : Double,
) -> SortexchangejView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejView::add(
  self : SortexchangejView,
  other : SortexchangejView,
) -> SortexchangejView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejView::copy(self : SortexchangejView) -> SortexchangejView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejView::fill(
  self : SortexchangejView,
  v : Double,
) -> SortexchangejView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejView::min(self : SortexchangejView) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejView::max(self : SortexchangejView) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejView::to_string(self : SortexchangejView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_range_make(size : Int32) -> SortexchangejRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejRange::len(self : SortexchangejRange) -> Int32 {
  self.size
}

///|
pub fn SortexchangejRange::get(self : SortexchangejRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejRange::set(
  self : SortexchangejRange,
  i : Int32,
  v : Double,
) -> SortexchangejRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejRange::sum(self : SortexchangejRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejRange::mean(self : SortexchangejRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejRange::scale(
  self : SortexchangejRange,
  f : Double,
) -> SortexchangejRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejRange::add(
  self : SortexchangejRange,
  other : SortexchangejRange,
) -> SortexchangejRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejRange::copy(
  self : SortexchangejRange,
) -> SortexchangejRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejRange::fill(
  self : SortexchangejRange,
  v : Double,
) -> SortexchangejRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejRange::min(self : SortexchangejRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejRange::max(self : SortexchangejRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejRange::to_string(self : SortexchangejRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct SortexchangejSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn sort_exchange_j_slice_make(size : Int32) -> SortexchangejSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn SortexchangejSlice::len(self : SortexchangejSlice) -> Int32 {
  self.size
}

///|
pub fn SortexchangejSlice::get(self : SortexchangejSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn SortexchangejSlice::set(
  self : SortexchangejSlice,
  i : Int32,
  v : Double,
) -> SortexchangejSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejSlice::sum(self : SortexchangejSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn SortexchangejSlice::mean(self : SortexchangejSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn SortexchangejSlice::scale(
  self : SortexchangejSlice,
  f : Double,
) -> SortexchangejSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejSlice::add(
  self : SortexchangejSlice,
  other : SortexchangejSlice,
) -> SortexchangejSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn SortexchangejSlice::copy(
  self : SortexchangejSlice,
) -> SortexchangejSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejSlice::fill(
  self : SortexchangejSlice,
  v : Double,
) -> SortexchangejSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn SortexchangejSlice::min(self : SortexchangejSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn SortexchangejSlice::max(self : SortexchangejSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn SortexchangejSlice::to_string(self : SortexchangejSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
///===
/// extcore/ds_list_block
pub(all) struct DslistblockPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_list_block_make_point(x : Double, y : Double) -> DslistblockPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_list_block_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DslistblockPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DslistblockPoint::x(self : DslistblockPoint) -> Double {
  self.x
}

///|
pub fn DslistblockPoint::y(self : DslistblockPoint) -> Double {
  self.y
}

///|
pub fn DslistblockPoint::z(self : DslistblockPoint) -> Double {
  self.z
}

///|
pub fn DslistblockPoint::label(self : DslistblockPoint) -> Int32 {
  self.label
}

///|
pub fn DslistblockPoint::dist(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DslistblockPoint::add(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> DslistblockPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DslistblockPoint::sub(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> DslistblockPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DslistblockPoint::scale(
  self : DslistblockPoint,
  s : Double,
) -> DslistblockPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DslistblockPoint::dot(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DslistblockPoint::cross(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> DslistblockPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DslistblockPoint::norm(self : DslistblockPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DslistblockPoint::normalize(self : DslistblockPoint) -> DslistblockPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DslistblockPoint::negate(self : DslistblockPoint) -> DslistblockPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DslistblockPoint::mid(
  self : DslistblockPoint,
  other : DslistblockPoint,
) -> DslistblockPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DslistblockPoint::lerp(
  self : DslistblockPoint,
  other : DslistblockPoint,
  t : Double,
) -> DslistblockPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DslistblockPoint::to_string(self : DslistblockPoint) -> String {
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
pub(all) struct DslistblockSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_list_block_make_series(
  vals : Array[Double],
  name : String,
) -> DslistblockSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DslistblockSeries::len(self : DslistblockSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DslistblockSeries::sum(self : DslistblockSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DslistblockSeries::mean(self : DslistblockSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DslistblockSeries::min(self : DslistblockSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DslistblockSeries::max(self : DslistblockSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DslistblockSeries::range(self : DslistblockSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DslistblockSeries::variance(self : DslistblockSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DslistblockSeries::std(self : DslistblockSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DslistblockSeries::median(self : DslistblockSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DslistblockSeries::scale(
  self : DslistblockSeries,
  f : Double,
) -> DslistblockSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DslistblockSeries::add(
  self : DslistblockSeries,
  other : DslistblockSeries,
) -> DslistblockSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DslistblockSeries::sub(
  self : DslistblockSeries,
  other : DslistblockSeries,
) -> DslistblockSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DslistblockSeries::normalize(
  self : DslistblockSeries,
) -> DslistblockSeries {
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
pub fn DslistblockSeries::cumsum(self : DslistblockSeries) -> DslistblockSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DslistblockSeries::to_string(self : DslistblockSeries) -> String {
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
pub(all) struct DslistblockMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_list_block_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DslistblockMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_list_block_matrix_identity(n : Int32) -> DslistblockMatrix {
  let m = ds_list_block_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DslistblockMatrix::get(
  self : DslistblockMatrix,
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
pub fn DslistblockMatrix::transpose(
  self : DslistblockMatrix,
) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DslistblockMatrix::add(
  self : DslistblockMatrix,
  other : DslistblockMatrix,
) -> DslistblockMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_list_block_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DslistblockMatrix::scale(
  self : DslistblockMatrix,
  s : Double,
) -> DslistblockMatrix {
  let result = ds_list_block_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DslistblockMatrix::multiply(
  self : DslistblockMatrix,
  other : DslistblockMatrix,
) -> DslistblockMatrix {
  if self.cols != other.rows {
    return ds_list_block_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_list_block_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DslistblockMatrix::trace(self : DslistblockMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DslistblockMatrix::det(self : DslistblockMatrix) -> Double {
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
pub fn DslistblockMatrix::norm(self : DslistblockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DslistblockMatrix::to_string(self : DslistblockMatrix) -> String {
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
pub(all) struct DslistblockVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_list_block_make_vector(comps : Array[Double]) -> DslistblockVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_list_block_vector_zero(dim : Int32) -> DslistblockVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DslistblockVector::add(
  self : DslistblockVector,
  other : DslistblockVector,
) -> DslistblockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DslistblockVector::sub(
  self : DslistblockVector,
  other : DslistblockVector,
) -> DslistblockVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DslistblockVector::scale(
  self : DslistblockVector,
  s : Double,
) -> DslistblockVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DslistblockVector::dot(
  self : DslistblockVector,
  other : DslistblockVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DslistblockVector::norm(self : DslistblockVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DslistblockVector::normalize(
  self : DslistblockVector,
) -> DslistblockVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DslistblockVector::dist(
  self : DslistblockVector,
  other : DslistblockVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DslistblockVector::to_string(self : DslistblockVector) -> String {
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
pub(all) struct DslistblockFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_frame_make(size : Int32) -> DslistblockFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockFrame::len(self : DslistblockFrame) -> Int32 {
  self.size
}

///|
pub fn DslistblockFrame::get(self : DslistblockFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockFrame::set(
  self : DslistblockFrame,
  i : Int32,
  v : Double,
) -> DslistblockFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockFrame::sum(self : DslistblockFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockFrame::mean(self : DslistblockFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockFrame::scale(
  self : DslistblockFrame,
  f : Double,
) -> DslistblockFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockFrame::add(
  self : DslistblockFrame,
  other : DslistblockFrame,
) -> DslistblockFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockFrame::copy(self : DslistblockFrame) -> DslistblockFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockFrame::fill(
  self : DslistblockFrame,
  v : Double,
) -> DslistblockFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockFrame::min(self : DslistblockFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockFrame::max(self : DslistblockFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockFrame::to_string(self : DslistblockFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_table_make(size : Int32) -> DslistblockTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockTable::len(self : DslistblockTable) -> Int32 {
  self.size
}

///|
pub fn DslistblockTable::get(self : DslistblockTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockTable::set(
  self : DslistblockTable,
  i : Int32,
  v : Double,
) -> DslistblockTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockTable::sum(self : DslistblockTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockTable::mean(self : DslistblockTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockTable::scale(
  self : DslistblockTable,
  f : Double,
) -> DslistblockTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockTable::add(
  self : DslistblockTable,
  other : DslistblockTable,
) -> DslistblockTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockTable::copy(self : DslistblockTable) -> DslistblockTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockTable::fill(
  self : DslistblockTable,
  v : Double,
) -> DslistblockTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockTable::min(self : DslistblockTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockTable::max(self : DslistblockTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockTable::to_string(self : DslistblockTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_graphn_make(size : Int32) -> DslistblockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockGraphN::len(self : DslistblockGraphN) -> Int32 {
  self.size
}

///|
pub fn DslistblockGraphN::get(self : DslistblockGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockGraphN::set(
  self : DslistblockGraphN,
  i : Int32,
  v : Double,
) -> DslistblockGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockGraphN::sum(self : DslistblockGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockGraphN::mean(self : DslistblockGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockGraphN::scale(
  self : DslistblockGraphN,
  f : Double,
) -> DslistblockGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockGraphN::add(
  self : DslistblockGraphN,
  other : DslistblockGraphN,
) -> DslistblockGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockGraphN::copy(self : DslistblockGraphN) -> DslistblockGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockGraphN::fill(
  self : DslistblockGraphN,
  v : Double,
) -> DslistblockGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockGraphN::min(self : DslistblockGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockGraphN::max(self : DslistblockGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockGraphN::to_string(self : DslistblockGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_node_make(size : Int32) -> DslistblockNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockNode::len(self : DslistblockNode) -> Int32 {
  self.size
}

///|
pub fn DslistblockNode::get(self : DslistblockNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockNode::set(
  self : DslistblockNode,
  i : Int32,
  v : Double,
) -> DslistblockNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockNode::sum(self : DslistblockNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockNode::mean(self : DslistblockNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockNode::scale(
  self : DslistblockNode,
  f : Double,
) -> DslistblockNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockNode::add(
  self : DslistblockNode,
  other : DslistblockNode,
) -> DslistblockNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockNode::copy(self : DslistblockNode) -> DslistblockNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockNode::fill(
  self : DslistblockNode,
  v : Double,
) -> DslistblockNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockNode::min(self : DslistblockNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockNode::max(self : DslistblockNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockNode::to_string(self : DslistblockNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_edge_make(size : Int32) -> DslistblockEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockEdge::len(self : DslistblockEdge) -> Int32 {
  self.size
}

///|
pub fn DslistblockEdge::get(self : DslistblockEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockEdge::set(
  self : DslistblockEdge,
  i : Int32,
  v : Double,
) -> DslistblockEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockEdge::sum(self : DslistblockEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockEdge::mean(self : DslistblockEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockEdge::scale(
  self : DslistblockEdge,
  f : Double,
) -> DslistblockEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockEdge::add(
  self : DslistblockEdge,
  other : DslistblockEdge,
) -> DslistblockEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockEdge::copy(self : DslistblockEdge) -> DslistblockEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockEdge::fill(
  self : DslistblockEdge,
  v : Double,
) -> DslistblockEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockEdge::min(self : DslistblockEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockEdge::max(self : DslistblockEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockEdge::to_string(self : DslistblockEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_path_make(size : Int32) -> DslistblockPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockPath::len(self : DslistblockPath) -> Int32 {
  self.size
}

///|
pub fn DslistblockPath::get(self : DslistblockPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockPath::set(
  self : DslistblockPath,
  i : Int32,
  v : Double,
) -> DslistblockPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockPath::sum(self : DslistblockPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockPath::mean(self : DslistblockPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockPath::scale(
  self : DslistblockPath,
  f : Double,
) -> DslistblockPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockPath::add(
  self : DslistblockPath,
  other : DslistblockPath,
) -> DslistblockPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockPath::copy(self : DslistblockPath) -> DslistblockPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockPath::fill(
  self : DslistblockPath,
  v : Double,
) -> DslistblockPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockPath::min(self : DslistblockPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockPath::max(self : DslistblockPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockPath::to_string(self : DslistblockPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_cluster_make(size : Int32) -> DslistblockCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockCluster::len(self : DslistblockCluster) -> Int32 {
  self.size
}

///|
pub fn DslistblockCluster::get(self : DslistblockCluster, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockCluster::set(
  self : DslistblockCluster,
  i : Int32,
  v : Double,
) -> DslistblockCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCluster::sum(self : DslistblockCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockCluster::mean(self : DslistblockCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockCluster::scale(
  self : DslistblockCluster,
  f : Double,
) -> DslistblockCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCluster::add(
  self : DslistblockCluster,
  other : DslistblockCluster,
) -> DslistblockCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockCluster::copy(
  self : DslistblockCluster,
) -> DslistblockCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCluster::fill(
  self : DslistblockCluster,
  v : Double,
) -> DslistblockCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCluster::min(self : DslistblockCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockCluster::max(self : DslistblockCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockCluster::to_string(self : DslistblockCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_model_make(size : Int32) -> DslistblockModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockModel::len(self : DslistblockModel) -> Int32 {
  self.size
}

///|
pub fn DslistblockModel::get(self : DslistblockModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockModel::set(
  self : DslistblockModel,
  i : Int32,
  v : Double,
) -> DslistblockModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockModel::sum(self : DslistblockModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockModel::mean(self : DslistblockModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockModel::scale(
  self : DslistblockModel,
  f : Double,
) -> DslistblockModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockModel::add(
  self : DslistblockModel,
  other : DslistblockModel,
) -> DslistblockModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockModel::copy(self : DslistblockModel) -> DslistblockModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockModel::fill(
  self : DslistblockModel,
  v : Double,
) -> DslistblockModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockModel::min(self : DslistblockModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockModel::max(self : DslistblockModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockModel::to_string(self : DslistblockModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_layer_make(size : Int32) -> DslistblockLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockLayer::len(self : DslistblockLayer) -> Int32 {
  self.size
}

///|
pub fn DslistblockLayer::get(self : DslistblockLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockLayer::set(
  self : DslistblockLayer,
  i : Int32,
  v : Double,
) -> DslistblockLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockLayer::sum(self : DslistblockLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockLayer::mean(self : DslistblockLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockLayer::scale(
  self : DslistblockLayer,
  f : Double,
) -> DslistblockLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockLayer::add(
  self : DslistblockLayer,
  other : DslistblockLayer,
) -> DslistblockLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockLayer::copy(self : DslistblockLayer) -> DslistblockLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockLayer::fill(
  self : DslistblockLayer,
  v : Double,
) -> DslistblockLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockLayer::min(self : DslistblockLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockLayer::max(self : DslistblockLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockLayer::to_string(self : DslistblockLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_buffer_make(size : Int32) -> DslistblockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockBuffer::len(self : DslistblockBuffer) -> Int32 {
  self.size
}

///|
pub fn DslistblockBuffer::get(self : DslistblockBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockBuffer::set(
  self : DslistblockBuffer,
  i : Int32,
  v : Double,
) -> DslistblockBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockBuffer::sum(self : DslistblockBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockBuffer::mean(self : DslistblockBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockBuffer::scale(
  self : DslistblockBuffer,
  f : Double,
) -> DslistblockBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockBuffer::add(
  self : DslistblockBuffer,
  other : DslistblockBuffer,
) -> DslistblockBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockBuffer::copy(self : DslistblockBuffer) -> DslistblockBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockBuffer::fill(
  self : DslistblockBuffer,
  v : Double,
) -> DslistblockBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockBuffer::min(self : DslistblockBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockBuffer::max(self : DslistblockBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockBuffer::to_string(self : DslistblockBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_cursor_make(size : Int32) -> DslistblockCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockCursor::len(self : DslistblockCursor) -> Int32 {
  self.size
}

///|
pub fn DslistblockCursor::get(self : DslistblockCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockCursor::set(
  self : DslistblockCursor,
  i : Int32,
  v : Double,
) -> DslistblockCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCursor::sum(self : DslistblockCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockCursor::mean(self : DslistblockCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockCursor::scale(
  self : DslistblockCursor,
  f : Double,
) -> DslistblockCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCursor::add(
  self : DslistblockCursor,
  other : DslistblockCursor,
) -> DslistblockCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockCursor::copy(self : DslistblockCursor) -> DslistblockCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCursor::fill(
  self : DslistblockCursor,
  v : Double,
) -> DslistblockCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockCursor::min(self : DslistblockCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockCursor::max(self : DslistblockCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockCursor::to_string(self : DslistblockCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_view_make(size : Int32) -> DslistblockView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockView::len(self : DslistblockView) -> Int32 {
  self.size
}

///|
pub fn DslistblockView::get(self : DslistblockView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockView::set(
  self : DslistblockView,
  i : Int32,
  v : Double,
) -> DslistblockView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockView::sum(self : DslistblockView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockView::mean(self : DslistblockView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockView::scale(
  self : DslistblockView,
  f : Double,
) -> DslistblockView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockView::add(
  self : DslistblockView,
  other : DslistblockView,
) -> DslistblockView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockView::copy(self : DslistblockView) -> DslistblockView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockView::fill(
  self : DslistblockView,
  v : Double,
) -> DslistblockView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockView::min(self : DslistblockView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockView::max(self : DslistblockView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockView::to_string(self : DslistblockView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_range_make(size : Int32) -> DslistblockRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockRange::len(self : DslistblockRange) -> Int32 {
  self.size
}

///|
pub fn DslistblockRange::get(self : DslistblockRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockRange::set(
  self : DslistblockRange,
  i : Int32,
  v : Double,
) -> DslistblockRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockRange::sum(self : DslistblockRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockRange::mean(self : DslistblockRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockRange::scale(
  self : DslistblockRange,
  f : Double,
) -> DslistblockRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockRange::add(
  self : DslistblockRange,
  other : DslistblockRange,
) -> DslistblockRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockRange::copy(self : DslistblockRange) -> DslistblockRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockRange::fill(
  self : DslistblockRange,
  v : Double,
) -> DslistblockRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockRange::min(self : DslistblockRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockRange::max(self : DslistblockRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockRange::to_string(self : DslistblockRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DslistblockSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_list_block_slice_make(size : Int32) -> DslistblockSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DslistblockSlice::len(self : DslistblockSlice) -> Int32 {
  self.size
}

///|
pub fn DslistblockSlice::get(self : DslistblockSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DslistblockSlice::set(
  self : DslistblockSlice,
  i : Int32,
  v : Double,
) -> DslistblockSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockSlice::sum(self : DslistblockSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DslistblockSlice::mean(self : DslistblockSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DslistblockSlice::scale(
  self : DslistblockSlice,
  f : Double,
) -> DslistblockSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockSlice::add(
  self : DslistblockSlice,
  other : DslistblockSlice,
) -> DslistblockSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DslistblockSlice::copy(self : DslistblockSlice) -> DslistblockSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockSlice::fill(
  self : DslistblockSlice,
  v : Double,
) -> DslistblockSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DslistblockSlice::min(self : DslistblockSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DslistblockSlice::max(self : DslistblockSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DslistblockSlice::to_string(self : DslistblockSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

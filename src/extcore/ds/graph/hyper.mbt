///|
///===
/// extcore/ds_graph_hyper
pub(all) struct DsgraphhyperPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn ds_graph_hyper_make_point(x : Double, y : Double) -> DsgraphhyperPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn ds_graph_hyper_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> DsgraphhyperPoint {
  { x, y, z, label: 0, }
}

///|
pub fn DsgraphhyperPoint::x(self : DsgraphhyperPoint) -> Double {
  self.x
}

///|
pub fn DsgraphhyperPoint::y(self : DsgraphhyperPoint) -> Double {
  self.y
}

///|
pub fn DsgraphhyperPoint::z(self : DsgraphhyperPoint) -> Double {
  self.z
}

///|
pub fn DsgraphhyperPoint::label(self : DsgraphhyperPoint) -> Int32 {
  self.label
}

///|
pub fn DsgraphhyperPoint::dist(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn DsgraphhyperPoint::add(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> DsgraphhyperPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn DsgraphhyperPoint::sub(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> DsgraphhyperPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn DsgraphhyperPoint::scale(
  self : DsgraphhyperPoint,
  s : Double,
) -> DsgraphhyperPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn DsgraphhyperPoint::dot(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn DsgraphhyperPoint::cross(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> DsgraphhyperPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn DsgraphhyperPoint::norm(self : DsgraphhyperPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn DsgraphhyperPoint::normalize(
  self : DsgraphhyperPoint,
) -> DsgraphhyperPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DsgraphhyperPoint::negate(self : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn DsgraphhyperPoint::mid(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
) -> DsgraphhyperPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn DsgraphhyperPoint::lerp(
  self : DsgraphhyperPoint,
  other : DsgraphhyperPoint,
  t : Double,
) -> DsgraphhyperPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn DsgraphhyperPoint::to_string(self : DsgraphhyperPoint) -> String {
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
pub(all) struct DsgraphhyperSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn ds_graph_hyper_make_series(
  vals : Array[Double],
  name : String,
) -> DsgraphhyperSeries {
  { vals, name, meta: 0, }
}

///|
pub fn DsgraphhyperSeries::len(self : DsgraphhyperSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn DsgraphhyperSeries::sum(self : DsgraphhyperSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn DsgraphhyperSeries::mean(self : DsgraphhyperSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn DsgraphhyperSeries::min(self : DsgraphhyperSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn DsgraphhyperSeries::max(self : DsgraphhyperSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn DsgraphhyperSeries::range(self : DsgraphhyperSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn DsgraphhyperSeries::variance(self : DsgraphhyperSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn DsgraphhyperSeries::std(self : DsgraphhyperSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn DsgraphhyperSeries::median(self : DsgraphhyperSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn DsgraphhyperSeries::scale(
  self : DsgraphhyperSeries,
  f : Double,
) -> DsgraphhyperSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn DsgraphhyperSeries::add(
  self : DsgraphhyperSeries,
  other : DsgraphhyperSeries,
) -> DsgraphhyperSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DsgraphhyperSeries::sub(
  self : DsgraphhyperSeries,
  other : DsgraphhyperSeries,
) -> DsgraphhyperSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn DsgraphhyperSeries::normalize(
  self : DsgraphhyperSeries,
) -> DsgraphhyperSeries {
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
pub fn DsgraphhyperSeries::cumsum(
  self : DsgraphhyperSeries,
) -> DsgraphhyperSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn DsgraphhyperSeries::to_string(self : DsgraphhyperSeries) -> String {
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
pub(all) struct DsgraphhyperMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn ds_graph_hyper_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> DsgraphhyperMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn ds_graph_hyper_matrix_identity(n : Int32) -> DsgraphhyperMatrix {
  let m = ds_graph_hyper_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn DsgraphhyperMatrix::get(
  self : DsgraphhyperMatrix,
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
pub fn DsgraphhyperMatrix::transpose(
  self : DsgraphhyperMatrix,
) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn DsgraphhyperMatrix::add(
  self : DsgraphhyperMatrix,
  other : DsgraphhyperMatrix,
) -> DsgraphhyperMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = ds_graph_hyper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn DsgraphhyperMatrix::scale(
  self : DsgraphhyperMatrix,
  s : Double,
) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn DsgraphhyperMatrix::multiply(
  self : DsgraphhyperMatrix,
  other : DsgraphhyperMatrix,
) -> DsgraphhyperMatrix {
  if self.cols != other.rows {
    return ds_graph_hyper_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = ds_graph_hyper_make_matrix(self.rows, other.cols, 0.0)
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
pub fn DsgraphhyperMatrix::trace(self : DsgraphhyperMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn DsgraphhyperMatrix::det(self : DsgraphhyperMatrix) -> Double {
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
pub fn DsgraphhyperMatrix::norm(self : DsgraphhyperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn DsgraphhyperMatrix::to_string(self : DsgraphhyperMatrix) -> String {
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
pub(all) struct DsgraphhyperVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn ds_graph_hyper_make_vector(comps : Array[Double]) -> DsgraphhyperVector {
  { comps, dim: comps.length(), }
}

///|
pub fn ds_graph_hyper_vector_zero(dim : Int32) -> DsgraphhyperVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn DsgraphhyperVector::add(
  self : DsgraphhyperVector,
  other : DsgraphhyperVector,
) -> DsgraphhyperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DsgraphhyperVector::sub(
  self : DsgraphhyperVector,
  other : DsgraphhyperVector,
) -> DsgraphhyperVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn DsgraphhyperVector::scale(
  self : DsgraphhyperVector,
  s : Double,
) -> DsgraphhyperVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn DsgraphhyperVector::dot(
  self : DsgraphhyperVector,
  other : DsgraphhyperVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn DsgraphhyperVector::norm(self : DsgraphhyperVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn DsgraphhyperVector::normalize(
  self : DsgraphhyperVector,
) -> DsgraphhyperVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn DsgraphhyperVector::dist(
  self : DsgraphhyperVector,
  other : DsgraphhyperVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn DsgraphhyperVector::to_string(self : DsgraphhyperVector) -> String {
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
pub(all) struct DsgraphhyperFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_frame_make(size : Int32) -> DsgraphhyperFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperFrame::len(self : DsgraphhyperFrame) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperFrame::get(self : DsgraphhyperFrame, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperFrame::set(
  self : DsgraphhyperFrame,
  i : Int32,
  v : Double,
) -> DsgraphhyperFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperFrame::sum(self : DsgraphhyperFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperFrame::mean(self : DsgraphhyperFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperFrame::scale(
  self : DsgraphhyperFrame,
  f : Double,
) -> DsgraphhyperFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperFrame::add(
  self : DsgraphhyperFrame,
  other : DsgraphhyperFrame,
) -> DsgraphhyperFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperFrame::copy(self : DsgraphhyperFrame) -> DsgraphhyperFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperFrame::fill(
  self : DsgraphhyperFrame,
  v : Double,
) -> DsgraphhyperFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperFrame::min(self : DsgraphhyperFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperFrame::max(self : DsgraphhyperFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperFrame::to_string(self : DsgraphhyperFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_table_make(size : Int32) -> DsgraphhyperTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperTable::len(self : DsgraphhyperTable) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperTable::get(self : DsgraphhyperTable, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperTable::set(
  self : DsgraphhyperTable,
  i : Int32,
  v : Double,
) -> DsgraphhyperTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperTable::sum(self : DsgraphhyperTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperTable::mean(self : DsgraphhyperTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperTable::scale(
  self : DsgraphhyperTable,
  f : Double,
) -> DsgraphhyperTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperTable::add(
  self : DsgraphhyperTable,
  other : DsgraphhyperTable,
) -> DsgraphhyperTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperTable::copy(self : DsgraphhyperTable) -> DsgraphhyperTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperTable::fill(
  self : DsgraphhyperTable,
  v : Double,
) -> DsgraphhyperTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperTable::min(self : DsgraphhyperTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperTable::max(self : DsgraphhyperTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperTable::to_string(self : DsgraphhyperTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_graphn_make(size : Int32) -> DsgraphhyperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperGraphN::len(self : DsgraphhyperGraphN) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperGraphN::get(self : DsgraphhyperGraphN, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperGraphN::set(
  self : DsgraphhyperGraphN,
  i : Int32,
  v : Double,
) -> DsgraphhyperGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperGraphN::sum(self : DsgraphhyperGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperGraphN::mean(self : DsgraphhyperGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperGraphN::scale(
  self : DsgraphhyperGraphN,
  f : Double,
) -> DsgraphhyperGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperGraphN::add(
  self : DsgraphhyperGraphN,
  other : DsgraphhyperGraphN,
) -> DsgraphhyperGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperGraphN::copy(
  self : DsgraphhyperGraphN,
) -> DsgraphhyperGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperGraphN::fill(
  self : DsgraphhyperGraphN,
  v : Double,
) -> DsgraphhyperGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperGraphN::min(self : DsgraphhyperGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperGraphN::max(self : DsgraphhyperGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperGraphN::to_string(self : DsgraphhyperGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_node_make(size : Int32) -> DsgraphhyperNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperNode::len(self : DsgraphhyperNode) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperNode::get(self : DsgraphhyperNode, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperNode::set(
  self : DsgraphhyperNode,
  i : Int32,
  v : Double,
) -> DsgraphhyperNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperNode::sum(self : DsgraphhyperNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperNode::mean(self : DsgraphhyperNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperNode::scale(
  self : DsgraphhyperNode,
  f : Double,
) -> DsgraphhyperNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperNode::add(
  self : DsgraphhyperNode,
  other : DsgraphhyperNode,
) -> DsgraphhyperNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperNode::copy(self : DsgraphhyperNode) -> DsgraphhyperNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperNode::fill(
  self : DsgraphhyperNode,
  v : Double,
) -> DsgraphhyperNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperNode::min(self : DsgraphhyperNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperNode::max(self : DsgraphhyperNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperNode::to_string(self : DsgraphhyperNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_edge_make(size : Int32) -> DsgraphhyperEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperEdge::len(self : DsgraphhyperEdge) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperEdge::get(self : DsgraphhyperEdge, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperEdge::set(
  self : DsgraphhyperEdge,
  i : Int32,
  v : Double,
) -> DsgraphhyperEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperEdge::sum(self : DsgraphhyperEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperEdge::mean(self : DsgraphhyperEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperEdge::scale(
  self : DsgraphhyperEdge,
  f : Double,
) -> DsgraphhyperEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperEdge::add(
  self : DsgraphhyperEdge,
  other : DsgraphhyperEdge,
) -> DsgraphhyperEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperEdge::copy(self : DsgraphhyperEdge) -> DsgraphhyperEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperEdge::fill(
  self : DsgraphhyperEdge,
  v : Double,
) -> DsgraphhyperEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperEdge::min(self : DsgraphhyperEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperEdge::max(self : DsgraphhyperEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperEdge::to_string(self : DsgraphhyperEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_path_make(size : Int32) -> DsgraphhyperPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperPath::len(self : DsgraphhyperPath) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperPath::get(self : DsgraphhyperPath, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperPath::set(
  self : DsgraphhyperPath,
  i : Int32,
  v : Double,
) -> DsgraphhyperPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperPath::sum(self : DsgraphhyperPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperPath::mean(self : DsgraphhyperPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperPath::scale(
  self : DsgraphhyperPath,
  f : Double,
) -> DsgraphhyperPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperPath::add(
  self : DsgraphhyperPath,
  other : DsgraphhyperPath,
) -> DsgraphhyperPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperPath::copy(self : DsgraphhyperPath) -> DsgraphhyperPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperPath::fill(
  self : DsgraphhyperPath,
  v : Double,
) -> DsgraphhyperPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperPath::min(self : DsgraphhyperPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperPath::max(self : DsgraphhyperPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperPath::to_string(self : DsgraphhyperPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_cluster_make(size : Int32) -> DsgraphhyperCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperCluster::len(self : DsgraphhyperCluster) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperCluster::get(
  self : DsgraphhyperCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperCluster::set(
  self : DsgraphhyperCluster,
  i : Int32,
  v : Double,
) -> DsgraphhyperCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCluster::sum(self : DsgraphhyperCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperCluster::mean(self : DsgraphhyperCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperCluster::scale(
  self : DsgraphhyperCluster,
  f : Double,
) -> DsgraphhyperCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCluster::add(
  self : DsgraphhyperCluster,
  other : DsgraphhyperCluster,
) -> DsgraphhyperCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperCluster::copy(
  self : DsgraphhyperCluster,
) -> DsgraphhyperCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCluster::fill(
  self : DsgraphhyperCluster,
  v : Double,
) -> DsgraphhyperCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCluster::min(self : DsgraphhyperCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperCluster::max(self : DsgraphhyperCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperCluster::to_string(self : DsgraphhyperCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_model_make(size : Int32) -> DsgraphhyperModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperModel::len(self : DsgraphhyperModel) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperModel::get(self : DsgraphhyperModel, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperModel::set(
  self : DsgraphhyperModel,
  i : Int32,
  v : Double,
) -> DsgraphhyperModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperModel::sum(self : DsgraphhyperModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperModel::mean(self : DsgraphhyperModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperModel::scale(
  self : DsgraphhyperModel,
  f : Double,
) -> DsgraphhyperModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperModel::add(
  self : DsgraphhyperModel,
  other : DsgraphhyperModel,
) -> DsgraphhyperModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperModel::copy(self : DsgraphhyperModel) -> DsgraphhyperModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperModel::fill(
  self : DsgraphhyperModel,
  v : Double,
) -> DsgraphhyperModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperModel::min(self : DsgraphhyperModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperModel::max(self : DsgraphhyperModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperModel::to_string(self : DsgraphhyperModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_layer_make(size : Int32) -> DsgraphhyperLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperLayer::len(self : DsgraphhyperLayer) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperLayer::get(self : DsgraphhyperLayer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperLayer::set(
  self : DsgraphhyperLayer,
  i : Int32,
  v : Double,
) -> DsgraphhyperLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperLayer::sum(self : DsgraphhyperLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperLayer::mean(self : DsgraphhyperLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperLayer::scale(
  self : DsgraphhyperLayer,
  f : Double,
) -> DsgraphhyperLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperLayer::add(
  self : DsgraphhyperLayer,
  other : DsgraphhyperLayer,
) -> DsgraphhyperLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperLayer::copy(self : DsgraphhyperLayer) -> DsgraphhyperLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperLayer::fill(
  self : DsgraphhyperLayer,
  v : Double,
) -> DsgraphhyperLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperLayer::min(self : DsgraphhyperLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperLayer::max(self : DsgraphhyperLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperLayer::to_string(self : DsgraphhyperLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_buffer_make(size : Int32) -> DsgraphhyperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperBuffer::len(self : DsgraphhyperBuffer) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperBuffer::get(self : DsgraphhyperBuffer, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperBuffer::set(
  self : DsgraphhyperBuffer,
  i : Int32,
  v : Double,
) -> DsgraphhyperBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperBuffer::sum(self : DsgraphhyperBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperBuffer::mean(self : DsgraphhyperBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperBuffer::scale(
  self : DsgraphhyperBuffer,
  f : Double,
) -> DsgraphhyperBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperBuffer::add(
  self : DsgraphhyperBuffer,
  other : DsgraphhyperBuffer,
) -> DsgraphhyperBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperBuffer::copy(
  self : DsgraphhyperBuffer,
) -> DsgraphhyperBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperBuffer::fill(
  self : DsgraphhyperBuffer,
  v : Double,
) -> DsgraphhyperBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperBuffer::min(self : DsgraphhyperBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperBuffer::max(self : DsgraphhyperBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperBuffer::to_string(self : DsgraphhyperBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_cursor_make(size : Int32) -> DsgraphhyperCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperCursor::len(self : DsgraphhyperCursor) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperCursor::get(self : DsgraphhyperCursor, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperCursor::set(
  self : DsgraphhyperCursor,
  i : Int32,
  v : Double,
) -> DsgraphhyperCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCursor::sum(self : DsgraphhyperCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperCursor::mean(self : DsgraphhyperCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperCursor::scale(
  self : DsgraphhyperCursor,
  f : Double,
) -> DsgraphhyperCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCursor::add(
  self : DsgraphhyperCursor,
  other : DsgraphhyperCursor,
) -> DsgraphhyperCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperCursor::copy(
  self : DsgraphhyperCursor,
) -> DsgraphhyperCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCursor::fill(
  self : DsgraphhyperCursor,
  v : Double,
) -> DsgraphhyperCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperCursor::min(self : DsgraphhyperCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperCursor::max(self : DsgraphhyperCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperCursor::to_string(self : DsgraphhyperCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_view_make(size : Int32) -> DsgraphhyperView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperView::len(self : DsgraphhyperView) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperView::get(self : DsgraphhyperView, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperView::set(
  self : DsgraphhyperView,
  i : Int32,
  v : Double,
) -> DsgraphhyperView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperView::sum(self : DsgraphhyperView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperView::mean(self : DsgraphhyperView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperView::scale(
  self : DsgraphhyperView,
  f : Double,
) -> DsgraphhyperView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperView::add(
  self : DsgraphhyperView,
  other : DsgraphhyperView,
) -> DsgraphhyperView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperView::copy(self : DsgraphhyperView) -> DsgraphhyperView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperView::fill(
  self : DsgraphhyperView,
  v : Double,
) -> DsgraphhyperView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperView::min(self : DsgraphhyperView) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperView::max(self : DsgraphhyperView) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperView::to_string(self : DsgraphhyperView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_range_make(size : Int32) -> DsgraphhyperRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperRange::len(self : DsgraphhyperRange) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperRange::get(self : DsgraphhyperRange, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperRange::set(
  self : DsgraphhyperRange,
  i : Int32,
  v : Double,
) -> DsgraphhyperRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperRange::sum(self : DsgraphhyperRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperRange::mean(self : DsgraphhyperRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperRange::scale(
  self : DsgraphhyperRange,
  f : Double,
) -> DsgraphhyperRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperRange::add(
  self : DsgraphhyperRange,
  other : DsgraphhyperRange,
) -> DsgraphhyperRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperRange::copy(self : DsgraphhyperRange) -> DsgraphhyperRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperRange::fill(
  self : DsgraphhyperRange,
  v : Double,
) -> DsgraphhyperRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperRange::min(self : DsgraphhyperRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperRange::max(self : DsgraphhyperRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperRange::to_string(self : DsgraphhyperRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct DsgraphhyperSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn ds_graph_hyper_slice_make(size : Int32) -> DsgraphhyperSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn DsgraphhyperSlice::len(self : DsgraphhyperSlice) -> Int32 {
  self.size
}

///|
pub fn DsgraphhyperSlice::get(self : DsgraphhyperSlice, i : Int32) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn DsgraphhyperSlice::set(
  self : DsgraphhyperSlice,
  i : Int32,
  v : Double,
) -> DsgraphhyperSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperSlice::sum(self : DsgraphhyperSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn DsgraphhyperSlice::mean(self : DsgraphhyperSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn DsgraphhyperSlice::scale(
  self : DsgraphhyperSlice,
  f : Double,
) -> DsgraphhyperSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperSlice::add(
  self : DsgraphhyperSlice,
  other : DsgraphhyperSlice,
) -> DsgraphhyperSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn DsgraphhyperSlice::copy(self : DsgraphhyperSlice) -> DsgraphhyperSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperSlice::fill(
  self : DsgraphhyperSlice,
  v : Double,
) -> DsgraphhyperSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn DsgraphhyperSlice::min(self : DsgraphhyperSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn DsgraphhyperSlice::max(self : DsgraphhyperSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn DsgraphhyperSlice::to_string(self : DsgraphhyperSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

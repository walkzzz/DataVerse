///|
///===
/// extcore/graph_search_floyd
pub(all) struct GraphsearchfloydPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_search_floyd_make_point(
  x : Double,
  y : Double,
) -> GraphsearchfloydPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_search_floyd_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphsearchfloydPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphsearchfloydPoint::x(self : GraphsearchfloydPoint) -> Double {
  self.x
}

///|
pub fn GraphsearchfloydPoint::y(self : GraphsearchfloydPoint) -> Double {
  self.y
}

///|
pub fn GraphsearchfloydPoint::z(self : GraphsearchfloydPoint) -> Double {
  self.z
}

///|
pub fn GraphsearchfloydPoint::label(self : GraphsearchfloydPoint) -> Int32 {
  self.label
}

///|
pub fn GraphsearchfloydPoint::dist(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphsearchfloydPoint::add(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchfloydPoint::sub(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchfloydPoint::scale(
  self : GraphsearchfloydPoint,
  s : Double,
) -> GraphsearchfloydPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphsearchfloydPoint::dot(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphsearchfloydPoint::cross(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphsearchfloydPoint::norm(self : GraphsearchfloydPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphsearchfloydPoint::normalize(
  self : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchfloydPoint::negate(
  self : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphsearchfloydPoint::mid(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
) -> GraphsearchfloydPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphsearchfloydPoint::lerp(
  self : GraphsearchfloydPoint,
  other : GraphsearchfloydPoint,
  t : Double,
) -> GraphsearchfloydPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphsearchfloydPoint::to_string(self : GraphsearchfloydPoint) -> String {
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
pub(all) struct GraphsearchfloydSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_search_floyd_make_series(
  vals : Array[Double],
  name : String,
) -> GraphsearchfloydSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphsearchfloydSeries::len(self : GraphsearchfloydSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphsearchfloydSeries::sum(self : GraphsearchfloydSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphsearchfloydSeries::mean(self : GraphsearchfloydSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphsearchfloydSeries::min(self : GraphsearchfloydSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphsearchfloydSeries::max(self : GraphsearchfloydSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphsearchfloydSeries::range(self : GraphsearchfloydSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphsearchfloydSeries::variance(
  self : GraphsearchfloydSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphsearchfloydSeries::std(self : GraphsearchfloydSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphsearchfloydSeries::median(self : GraphsearchfloydSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphsearchfloydSeries::scale(
  self : GraphsearchfloydSeries,
  f : Double,
) -> GraphsearchfloydSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphsearchfloydSeries::add(
  self : GraphsearchfloydSeries,
  other : GraphsearchfloydSeries,
) -> GraphsearchfloydSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchfloydSeries::sub(
  self : GraphsearchfloydSeries,
  other : GraphsearchfloydSeries,
) -> GraphsearchfloydSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchfloydSeries::normalize(
  self : GraphsearchfloydSeries,
) -> GraphsearchfloydSeries {
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
pub fn GraphsearchfloydSeries::cumsum(
  self : GraphsearchfloydSeries,
) -> GraphsearchfloydSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphsearchfloydSeries::to_string(
  self : GraphsearchfloydSeries,
) -> String {
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
pub(all) struct GraphsearchfloydMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_search_floyd_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphsearchfloydMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_search_floyd_matrix_identity(n : Int32) -> GraphsearchfloydMatrix {
  let m = graph_search_floyd_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphsearchfloydMatrix::get(
  self : GraphsearchfloydMatrix,
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
pub fn GraphsearchfloydMatrix::transpose(
  self : GraphsearchfloydMatrix,
) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchfloydMatrix::add(
  self : GraphsearchfloydMatrix,
  other : GraphsearchfloydMatrix,
) -> GraphsearchfloydMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_search_floyd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchfloydMatrix::scale(
  self : GraphsearchfloydMatrix,
  s : Double,
) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphsearchfloydMatrix::multiply(
  self : GraphsearchfloydMatrix,
  other : GraphsearchfloydMatrix,
) -> GraphsearchfloydMatrix {
  if self.cols != other.rows {
    return graph_search_floyd_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_search_floyd_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphsearchfloydMatrix::trace(self : GraphsearchfloydMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphsearchfloydMatrix::det(self : GraphsearchfloydMatrix) -> Double {
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
pub fn GraphsearchfloydMatrix::norm(self : GraphsearchfloydMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GraphsearchfloydMatrix::to_string(
  self : GraphsearchfloydMatrix,
) -> String {
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
pub(all) struct GraphsearchfloydVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_search_floyd_make_vector(
  comps : Array[Double],
) -> GraphsearchfloydVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_search_floyd_vector_zero(dim : Int32) -> GraphsearchfloydVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphsearchfloydVector::add(
  self : GraphsearchfloydVector,
  other : GraphsearchfloydVector,
) -> GraphsearchfloydVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchfloydVector::sub(
  self : GraphsearchfloydVector,
  other : GraphsearchfloydVector,
) -> GraphsearchfloydVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchfloydVector::scale(
  self : GraphsearchfloydVector,
  s : Double,
) -> GraphsearchfloydVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphsearchfloydVector::dot(
  self : GraphsearchfloydVector,
  other : GraphsearchfloydVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphsearchfloydVector::norm(self : GraphsearchfloydVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphsearchfloydVector::normalize(
  self : GraphsearchfloydVector,
) -> GraphsearchfloydVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchfloydVector::dist(
  self : GraphsearchfloydVector,
  other : GraphsearchfloydVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphsearchfloydVector::to_string(
  self : GraphsearchfloydVector,
) -> String {
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
pub(all) struct GraphsearchfloydFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_frame_make(size : Int32) -> GraphsearchfloydFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydFrame::len(self : GraphsearchfloydFrame) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydFrame::get(
  self : GraphsearchfloydFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydFrame::set(
  self : GraphsearchfloydFrame,
  i : Int32,
  v : Double,
) -> GraphsearchfloydFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydFrame::sum(self : GraphsearchfloydFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydFrame::mean(self : GraphsearchfloydFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydFrame::scale(
  self : GraphsearchfloydFrame,
  f : Double,
) -> GraphsearchfloydFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydFrame::add(
  self : GraphsearchfloydFrame,
  other : GraphsearchfloydFrame,
) -> GraphsearchfloydFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydFrame::copy(
  self : GraphsearchfloydFrame,
) -> GraphsearchfloydFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydFrame::fill(
  self : GraphsearchfloydFrame,
  v : Double,
) -> GraphsearchfloydFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydFrame::min(self : GraphsearchfloydFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydFrame::max(self : GraphsearchfloydFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydFrame::to_string(self : GraphsearchfloydFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_table_make(size : Int32) -> GraphsearchfloydTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydTable::len(self : GraphsearchfloydTable) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydTable::get(
  self : GraphsearchfloydTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydTable::set(
  self : GraphsearchfloydTable,
  i : Int32,
  v : Double,
) -> GraphsearchfloydTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydTable::sum(self : GraphsearchfloydTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydTable::mean(self : GraphsearchfloydTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydTable::scale(
  self : GraphsearchfloydTable,
  f : Double,
) -> GraphsearchfloydTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydTable::add(
  self : GraphsearchfloydTable,
  other : GraphsearchfloydTable,
) -> GraphsearchfloydTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydTable::copy(
  self : GraphsearchfloydTable,
) -> GraphsearchfloydTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydTable::fill(
  self : GraphsearchfloydTable,
  v : Double,
) -> GraphsearchfloydTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydTable::min(self : GraphsearchfloydTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydTable::max(self : GraphsearchfloydTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydTable::to_string(self : GraphsearchfloydTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_graphn_make(size : Int32) -> GraphsearchfloydGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydGraphN::len(self : GraphsearchfloydGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydGraphN::get(
  self : GraphsearchfloydGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydGraphN::set(
  self : GraphsearchfloydGraphN,
  i : Int32,
  v : Double,
) -> GraphsearchfloydGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydGraphN::sum(self : GraphsearchfloydGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydGraphN::mean(self : GraphsearchfloydGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydGraphN::scale(
  self : GraphsearchfloydGraphN,
  f : Double,
) -> GraphsearchfloydGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydGraphN::add(
  self : GraphsearchfloydGraphN,
  other : GraphsearchfloydGraphN,
) -> GraphsearchfloydGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydGraphN::copy(
  self : GraphsearchfloydGraphN,
) -> GraphsearchfloydGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydGraphN::fill(
  self : GraphsearchfloydGraphN,
  v : Double,
) -> GraphsearchfloydGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydGraphN::min(self : GraphsearchfloydGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydGraphN::max(self : GraphsearchfloydGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydGraphN::to_string(
  self : GraphsearchfloydGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_node_make(size : Int32) -> GraphsearchfloydNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydNode::len(self : GraphsearchfloydNode) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydNode::get(
  self : GraphsearchfloydNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydNode::set(
  self : GraphsearchfloydNode,
  i : Int32,
  v : Double,
) -> GraphsearchfloydNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydNode::sum(self : GraphsearchfloydNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydNode::mean(self : GraphsearchfloydNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydNode::scale(
  self : GraphsearchfloydNode,
  f : Double,
) -> GraphsearchfloydNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydNode::add(
  self : GraphsearchfloydNode,
  other : GraphsearchfloydNode,
) -> GraphsearchfloydNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydNode::copy(
  self : GraphsearchfloydNode,
) -> GraphsearchfloydNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydNode::fill(
  self : GraphsearchfloydNode,
  v : Double,
) -> GraphsearchfloydNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydNode::min(self : GraphsearchfloydNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydNode::max(self : GraphsearchfloydNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydNode::to_string(self : GraphsearchfloydNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_edge_make(size : Int32) -> GraphsearchfloydEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydEdge::len(self : GraphsearchfloydEdge) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydEdge::get(
  self : GraphsearchfloydEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydEdge::set(
  self : GraphsearchfloydEdge,
  i : Int32,
  v : Double,
) -> GraphsearchfloydEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydEdge::sum(self : GraphsearchfloydEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydEdge::mean(self : GraphsearchfloydEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydEdge::scale(
  self : GraphsearchfloydEdge,
  f : Double,
) -> GraphsearchfloydEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydEdge::add(
  self : GraphsearchfloydEdge,
  other : GraphsearchfloydEdge,
) -> GraphsearchfloydEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydEdge::copy(
  self : GraphsearchfloydEdge,
) -> GraphsearchfloydEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydEdge::fill(
  self : GraphsearchfloydEdge,
  v : Double,
) -> GraphsearchfloydEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydEdge::min(self : GraphsearchfloydEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydEdge::max(self : GraphsearchfloydEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydEdge::to_string(self : GraphsearchfloydEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_path_make(size : Int32) -> GraphsearchfloydPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydPath::len(self : GraphsearchfloydPath) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydPath::get(
  self : GraphsearchfloydPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydPath::set(
  self : GraphsearchfloydPath,
  i : Int32,
  v : Double,
) -> GraphsearchfloydPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydPath::sum(self : GraphsearchfloydPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydPath::mean(self : GraphsearchfloydPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydPath::scale(
  self : GraphsearchfloydPath,
  f : Double,
) -> GraphsearchfloydPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydPath::add(
  self : GraphsearchfloydPath,
  other : GraphsearchfloydPath,
) -> GraphsearchfloydPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydPath::copy(
  self : GraphsearchfloydPath,
) -> GraphsearchfloydPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydPath::fill(
  self : GraphsearchfloydPath,
  v : Double,
) -> GraphsearchfloydPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydPath::min(self : GraphsearchfloydPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydPath::max(self : GraphsearchfloydPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydPath::to_string(self : GraphsearchfloydPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_cluster_make(size : Int32) -> GraphsearchfloydCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydCluster::len(self : GraphsearchfloydCluster) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydCluster::get(
  self : GraphsearchfloydCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydCluster::set(
  self : GraphsearchfloydCluster,
  i : Int32,
  v : Double,
) -> GraphsearchfloydCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCluster::sum(self : GraphsearchfloydCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydCluster::mean(self : GraphsearchfloydCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydCluster::scale(
  self : GraphsearchfloydCluster,
  f : Double,
) -> GraphsearchfloydCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCluster::add(
  self : GraphsearchfloydCluster,
  other : GraphsearchfloydCluster,
) -> GraphsearchfloydCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCluster::copy(
  self : GraphsearchfloydCluster,
) -> GraphsearchfloydCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCluster::fill(
  self : GraphsearchfloydCluster,
  v : Double,
) -> GraphsearchfloydCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCluster::min(self : GraphsearchfloydCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydCluster::max(self : GraphsearchfloydCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydCluster::to_string(
  self : GraphsearchfloydCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_model_make(size : Int32) -> GraphsearchfloydModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydModel::len(self : GraphsearchfloydModel) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydModel::get(
  self : GraphsearchfloydModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydModel::set(
  self : GraphsearchfloydModel,
  i : Int32,
  v : Double,
) -> GraphsearchfloydModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydModel::sum(self : GraphsearchfloydModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydModel::mean(self : GraphsearchfloydModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydModel::scale(
  self : GraphsearchfloydModel,
  f : Double,
) -> GraphsearchfloydModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydModel::add(
  self : GraphsearchfloydModel,
  other : GraphsearchfloydModel,
) -> GraphsearchfloydModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydModel::copy(
  self : GraphsearchfloydModel,
) -> GraphsearchfloydModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydModel::fill(
  self : GraphsearchfloydModel,
  v : Double,
) -> GraphsearchfloydModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydModel::min(self : GraphsearchfloydModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydModel::max(self : GraphsearchfloydModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydModel::to_string(self : GraphsearchfloydModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_layer_make(size : Int32) -> GraphsearchfloydLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydLayer::len(self : GraphsearchfloydLayer) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydLayer::get(
  self : GraphsearchfloydLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydLayer::set(
  self : GraphsearchfloydLayer,
  i : Int32,
  v : Double,
) -> GraphsearchfloydLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydLayer::sum(self : GraphsearchfloydLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydLayer::mean(self : GraphsearchfloydLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydLayer::scale(
  self : GraphsearchfloydLayer,
  f : Double,
) -> GraphsearchfloydLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydLayer::add(
  self : GraphsearchfloydLayer,
  other : GraphsearchfloydLayer,
) -> GraphsearchfloydLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydLayer::copy(
  self : GraphsearchfloydLayer,
) -> GraphsearchfloydLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydLayer::fill(
  self : GraphsearchfloydLayer,
  v : Double,
) -> GraphsearchfloydLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydLayer::min(self : GraphsearchfloydLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydLayer::max(self : GraphsearchfloydLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydLayer::to_string(self : GraphsearchfloydLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_buffer_make(size : Int32) -> GraphsearchfloydBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydBuffer::len(self : GraphsearchfloydBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydBuffer::get(
  self : GraphsearchfloydBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydBuffer::set(
  self : GraphsearchfloydBuffer,
  i : Int32,
  v : Double,
) -> GraphsearchfloydBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydBuffer::sum(self : GraphsearchfloydBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydBuffer::mean(self : GraphsearchfloydBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydBuffer::scale(
  self : GraphsearchfloydBuffer,
  f : Double,
) -> GraphsearchfloydBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydBuffer::add(
  self : GraphsearchfloydBuffer,
  other : GraphsearchfloydBuffer,
) -> GraphsearchfloydBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydBuffer::copy(
  self : GraphsearchfloydBuffer,
) -> GraphsearchfloydBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydBuffer::fill(
  self : GraphsearchfloydBuffer,
  v : Double,
) -> GraphsearchfloydBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydBuffer::min(self : GraphsearchfloydBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydBuffer::max(self : GraphsearchfloydBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydBuffer::to_string(
  self : GraphsearchfloydBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_cursor_make(size : Int32) -> GraphsearchfloydCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydCursor::len(self : GraphsearchfloydCursor) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydCursor::get(
  self : GraphsearchfloydCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydCursor::set(
  self : GraphsearchfloydCursor,
  i : Int32,
  v : Double,
) -> GraphsearchfloydCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCursor::sum(self : GraphsearchfloydCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydCursor::mean(self : GraphsearchfloydCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydCursor::scale(
  self : GraphsearchfloydCursor,
  f : Double,
) -> GraphsearchfloydCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCursor::add(
  self : GraphsearchfloydCursor,
  other : GraphsearchfloydCursor,
) -> GraphsearchfloydCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCursor::copy(
  self : GraphsearchfloydCursor,
) -> GraphsearchfloydCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCursor::fill(
  self : GraphsearchfloydCursor,
  v : Double,
) -> GraphsearchfloydCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydCursor::min(self : GraphsearchfloydCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydCursor::max(self : GraphsearchfloydCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydCursor::to_string(
  self : GraphsearchfloydCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_view_make(size : Int32) -> GraphsearchfloydView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydView::len(self : GraphsearchfloydView) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydView::get(
  self : GraphsearchfloydView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydView::set(
  self : GraphsearchfloydView,
  i : Int32,
  v : Double,
) -> GraphsearchfloydView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydView::sum(self : GraphsearchfloydView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydView::mean(self : GraphsearchfloydView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydView::scale(
  self : GraphsearchfloydView,
  f : Double,
) -> GraphsearchfloydView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydView::add(
  self : GraphsearchfloydView,
  other : GraphsearchfloydView,
) -> GraphsearchfloydView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydView::copy(
  self : GraphsearchfloydView,
) -> GraphsearchfloydView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydView::fill(
  self : GraphsearchfloydView,
  v : Double,
) -> GraphsearchfloydView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydView::min(self : GraphsearchfloydView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydView::max(self : GraphsearchfloydView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydView::to_string(self : GraphsearchfloydView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_range_make(size : Int32) -> GraphsearchfloydRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydRange::len(self : GraphsearchfloydRange) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydRange::get(
  self : GraphsearchfloydRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydRange::set(
  self : GraphsearchfloydRange,
  i : Int32,
  v : Double,
) -> GraphsearchfloydRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydRange::sum(self : GraphsearchfloydRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydRange::mean(self : GraphsearchfloydRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydRange::scale(
  self : GraphsearchfloydRange,
  f : Double,
) -> GraphsearchfloydRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydRange::add(
  self : GraphsearchfloydRange,
  other : GraphsearchfloydRange,
) -> GraphsearchfloydRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydRange::copy(
  self : GraphsearchfloydRange,
) -> GraphsearchfloydRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydRange::fill(
  self : GraphsearchfloydRange,
  v : Double,
) -> GraphsearchfloydRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydRange::min(self : GraphsearchfloydRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydRange::max(self : GraphsearchfloydRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydRange::to_string(self : GraphsearchfloydRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchfloydSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_floyd_slice_make(size : Int32) -> GraphsearchfloydSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchfloydSlice::len(self : GraphsearchfloydSlice) -> Int32 {
  self.size
}

///|
pub fn GraphsearchfloydSlice::get(
  self : GraphsearchfloydSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchfloydSlice::set(
  self : GraphsearchfloydSlice,
  i : Int32,
  v : Double,
) -> GraphsearchfloydSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydSlice::sum(self : GraphsearchfloydSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchfloydSlice::mean(self : GraphsearchfloydSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchfloydSlice::scale(
  self : GraphsearchfloydSlice,
  f : Double,
) -> GraphsearchfloydSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydSlice::add(
  self : GraphsearchfloydSlice,
  other : GraphsearchfloydSlice,
) -> GraphsearchfloydSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchfloydSlice::copy(
  self : GraphsearchfloydSlice,
) -> GraphsearchfloydSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydSlice::fill(
  self : GraphsearchfloydSlice,
  v : Double,
) -> GraphsearchfloydSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchfloydSlice::min(self : GraphsearchfloydSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchfloydSlice::max(self : GraphsearchfloydSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchfloydSlice::to_string(self : GraphsearchfloydSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

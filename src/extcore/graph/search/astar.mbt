///|
///===
/// extcore/graph_search_astar
pub(all) struct GraphsearchastarPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_search_astar_make_point(
  x : Double,
  y : Double,
) -> GraphsearchastarPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_search_astar_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphsearchastarPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphsearchastarPoint::x(self : GraphsearchastarPoint) -> Double {
  self.x
}

///|
pub fn GraphsearchastarPoint::y(self : GraphsearchastarPoint) -> Double {
  self.y
}

///|
pub fn GraphsearchastarPoint::z(self : GraphsearchastarPoint) -> Double {
  self.z
}

///|
pub fn GraphsearchastarPoint::label(self : GraphsearchastarPoint) -> Int32 {
  self.label
}

///|
pub fn GraphsearchastarPoint::dist(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphsearchastarPoint::add(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchastarPoint::sub(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphsearchastarPoint::scale(
  self : GraphsearchastarPoint,
  s : Double,
) -> GraphsearchastarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphsearchastarPoint::dot(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphsearchastarPoint::cross(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphsearchastarPoint::norm(self : GraphsearchastarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphsearchastarPoint::normalize(
  self : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchastarPoint::negate(
  self : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphsearchastarPoint::mid(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
) -> GraphsearchastarPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphsearchastarPoint::lerp(
  self : GraphsearchastarPoint,
  other : GraphsearchastarPoint,
  t : Double,
) -> GraphsearchastarPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphsearchastarPoint::to_string(self : GraphsearchastarPoint) -> String {
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
pub(all) struct GraphsearchastarSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_search_astar_make_series(
  vals : Array[Double],
  name : String,
) -> GraphsearchastarSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphsearchastarSeries::len(self : GraphsearchastarSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphsearchastarSeries::sum(self : GraphsearchastarSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphsearchastarSeries::mean(self : GraphsearchastarSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphsearchastarSeries::min(self : GraphsearchastarSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphsearchastarSeries::max(self : GraphsearchastarSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphsearchastarSeries::range(self : GraphsearchastarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphsearchastarSeries::variance(
  self : GraphsearchastarSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphsearchastarSeries::std(self : GraphsearchastarSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphsearchastarSeries::median(self : GraphsearchastarSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphsearchastarSeries::scale(
  self : GraphsearchastarSeries,
  f : Double,
) -> GraphsearchastarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphsearchastarSeries::add(
  self : GraphsearchastarSeries,
  other : GraphsearchastarSeries,
) -> GraphsearchastarSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchastarSeries::sub(
  self : GraphsearchastarSeries,
  other : GraphsearchastarSeries,
) -> GraphsearchastarSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphsearchastarSeries::normalize(
  self : GraphsearchastarSeries,
) -> GraphsearchastarSeries {
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
pub fn GraphsearchastarSeries::cumsum(
  self : GraphsearchastarSeries,
) -> GraphsearchastarSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphsearchastarSeries::to_string(
  self : GraphsearchastarSeries,
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
pub(all) struct GraphsearchastarMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_search_astar_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphsearchastarMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_search_astar_matrix_identity(n : Int32) -> GraphsearchastarMatrix {
  let m = graph_search_astar_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphsearchastarMatrix::get(
  self : GraphsearchastarMatrix,
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
pub fn GraphsearchastarMatrix::transpose(
  self : GraphsearchastarMatrix,
) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchastarMatrix::add(
  self : GraphsearchastarMatrix,
  other : GraphsearchastarMatrix,
) -> GraphsearchastarMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_search_astar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphsearchastarMatrix::scale(
  self : GraphsearchastarMatrix,
  s : Double,
) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphsearchastarMatrix::multiply(
  self : GraphsearchastarMatrix,
  other : GraphsearchastarMatrix,
) -> GraphsearchastarMatrix {
  if self.cols != other.rows {
    return graph_search_astar_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_search_astar_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphsearchastarMatrix::trace(self : GraphsearchastarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphsearchastarMatrix::det(self : GraphsearchastarMatrix) -> Double {
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
pub fn GraphsearchastarMatrix::norm(self : GraphsearchastarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GraphsearchastarMatrix::to_string(
  self : GraphsearchastarMatrix,
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
pub(all) struct GraphsearchastarVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_search_astar_make_vector(
  comps : Array[Double],
) -> GraphsearchastarVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_search_astar_vector_zero(dim : Int32) -> GraphsearchastarVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphsearchastarVector::add(
  self : GraphsearchastarVector,
  other : GraphsearchastarVector,
) -> GraphsearchastarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchastarVector::sub(
  self : GraphsearchastarVector,
  other : GraphsearchastarVector,
) -> GraphsearchastarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphsearchastarVector::scale(
  self : GraphsearchastarVector,
  s : Double,
) -> GraphsearchastarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphsearchastarVector::dot(
  self : GraphsearchastarVector,
  other : GraphsearchastarVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphsearchastarVector::norm(self : GraphsearchastarVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphsearchastarVector::normalize(
  self : GraphsearchastarVector,
) -> GraphsearchastarVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphsearchastarVector::dist(
  self : GraphsearchastarVector,
  other : GraphsearchastarVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphsearchastarVector::to_string(
  self : GraphsearchastarVector,
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
pub(all) struct GraphsearchastarFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_frame_make(size : Int32) -> GraphsearchastarFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarFrame::len(self : GraphsearchastarFrame) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarFrame::get(
  self : GraphsearchastarFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarFrame::set(
  self : GraphsearchastarFrame,
  i : Int32,
  v : Double,
) -> GraphsearchastarFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarFrame::sum(self : GraphsearchastarFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarFrame::mean(self : GraphsearchastarFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarFrame::scale(
  self : GraphsearchastarFrame,
  f : Double,
) -> GraphsearchastarFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarFrame::add(
  self : GraphsearchastarFrame,
  other : GraphsearchastarFrame,
) -> GraphsearchastarFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarFrame::copy(
  self : GraphsearchastarFrame,
) -> GraphsearchastarFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarFrame::fill(
  self : GraphsearchastarFrame,
  v : Double,
) -> GraphsearchastarFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarFrame::min(self : GraphsearchastarFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarFrame::max(self : GraphsearchastarFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarFrame::to_string(self : GraphsearchastarFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_table_make(size : Int32) -> GraphsearchastarTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarTable::len(self : GraphsearchastarTable) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarTable::get(
  self : GraphsearchastarTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarTable::set(
  self : GraphsearchastarTable,
  i : Int32,
  v : Double,
) -> GraphsearchastarTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarTable::sum(self : GraphsearchastarTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarTable::mean(self : GraphsearchastarTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarTable::scale(
  self : GraphsearchastarTable,
  f : Double,
) -> GraphsearchastarTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarTable::add(
  self : GraphsearchastarTable,
  other : GraphsearchastarTable,
) -> GraphsearchastarTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarTable::copy(
  self : GraphsearchastarTable,
) -> GraphsearchastarTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarTable::fill(
  self : GraphsearchastarTable,
  v : Double,
) -> GraphsearchastarTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarTable::min(self : GraphsearchastarTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarTable::max(self : GraphsearchastarTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarTable::to_string(self : GraphsearchastarTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_graphn_make(size : Int32) -> GraphsearchastarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarGraphN::len(self : GraphsearchastarGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarGraphN::get(
  self : GraphsearchastarGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarGraphN::set(
  self : GraphsearchastarGraphN,
  i : Int32,
  v : Double,
) -> GraphsearchastarGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarGraphN::sum(self : GraphsearchastarGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarGraphN::mean(self : GraphsearchastarGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarGraphN::scale(
  self : GraphsearchastarGraphN,
  f : Double,
) -> GraphsearchastarGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarGraphN::add(
  self : GraphsearchastarGraphN,
  other : GraphsearchastarGraphN,
) -> GraphsearchastarGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarGraphN::copy(
  self : GraphsearchastarGraphN,
) -> GraphsearchastarGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarGraphN::fill(
  self : GraphsearchastarGraphN,
  v : Double,
) -> GraphsearchastarGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarGraphN::min(self : GraphsearchastarGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarGraphN::max(self : GraphsearchastarGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarGraphN::to_string(
  self : GraphsearchastarGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_node_make(size : Int32) -> GraphsearchastarNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarNode::len(self : GraphsearchastarNode) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarNode::get(
  self : GraphsearchastarNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarNode::set(
  self : GraphsearchastarNode,
  i : Int32,
  v : Double,
) -> GraphsearchastarNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarNode::sum(self : GraphsearchastarNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarNode::mean(self : GraphsearchastarNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarNode::scale(
  self : GraphsearchastarNode,
  f : Double,
) -> GraphsearchastarNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarNode::add(
  self : GraphsearchastarNode,
  other : GraphsearchastarNode,
) -> GraphsearchastarNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarNode::copy(
  self : GraphsearchastarNode,
) -> GraphsearchastarNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarNode::fill(
  self : GraphsearchastarNode,
  v : Double,
) -> GraphsearchastarNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarNode::min(self : GraphsearchastarNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarNode::max(self : GraphsearchastarNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarNode::to_string(self : GraphsearchastarNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_edge_make(size : Int32) -> GraphsearchastarEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarEdge::len(self : GraphsearchastarEdge) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarEdge::get(
  self : GraphsearchastarEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarEdge::set(
  self : GraphsearchastarEdge,
  i : Int32,
  v : Double,
) -> GraphsearchastarEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarEdge::sum(self : GraphsearchastarEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarEdge::mean(self : GraphsearchastarEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarEdge::scale(
  self : GraphsearchastarEdge,
  f : Double,
) -> GraphsearchastarEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarEdge::add(
  self : GraphsearchastarEdge,
  other : GraphsearchastarEdge,
) -> GraphsearchastarEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarEdge::copy(
  self : GraphsearchastarEdge,
) -> GraphsearchastarEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarEdge::fill(
  self : GraphsearchastarEdge,
  v : Double,
) -> GraphsearchastarEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarEdge::min(self : GraphsearchastarEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarEdge::max(self : GraphsearchastarEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarEdge::to_string(self : GraphsearchastarEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_path_make(size : Int32) -> GraphsearchastarPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarPath::len(self : GraphsearchastarPath) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarPath::get(
  self : GraphsearchastarPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarPath::set(
  self : GraphsearchastarPath,
  i : Int32,
  v : Double,
) -> GraphsearchastarPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarPath::sum(self : GraphsearchastarPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarPath::mean(self : GraphsearchastarPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarPath::scale(
  self : GraphsearchastarPath,
  f : Double,
) -> GraphsearchastarPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarPath::add(
  self : GraphsearchastarPath,
  other : GraphsearchastarPath,
) -> GraphsearchastarPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarPath::copy(
  self : GraphsearchastarPath,
) -> GraphsearchastarPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarPath::fill(
  self : GraphsearchastarPath,
  v : Double,
) -> GraphsearchastarPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarPath::min(self : GraphsearchastarPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarPath::max(self : GraphsearchastarPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarPath::to_string(self : GraphsearchastarPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_cluster_make(size : Int32) -> GraphsearchastarCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarCluster::len(self : GraphsearchastarCluster) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarCluster::get(
  self : GraphsearchastarCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarCluster::set(
  self : GraphsearchastarCluster,
  i : Int32,
  v : Double,
) -> GraphsearchastarCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCluster::sum(self : GraphsearchastarCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarCluster::mean(self : GraphsearchastarCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarCluster::scale(
  self : GraphsearchastarCluster,
  f : Double,
) -> GraphsearchastarCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCluster::add(
  self : GraphsearchastarCluster,
  other : GraphsearchastarCluster,
) -> GraphsearchastarCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarCluster::copy(
  self : GraphsearchastarCluster,
) -> GraphsearchastarCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCluster::fill(
  self : GraphsearchastarCluster,
  v : Double,
) -> GraphsearchastarCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCluster::min(self : GraphsearchastarCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarCluster::max(self : GraphsearchastarCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarCluster::to_string(
  self : GraphsearchastarCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_model_make(size : Int32) -> GraphsearchastarModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarModel::len(self : GraphsearchastarModel) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarModel::get(
  self : GraphsearchastarModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarModel::set(
  self : GraphsearchastarModel,
  i : Int32,
  v : Double,
) -> GraphsearchastarModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarModel::sum(self : GraphsearchastarModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarModel::mean(self : GraphsearchastarModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarModel::scale(
  self : GraphsearchastarModel,
  f : Double,
) -> GraphsearchastarModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarModel::add(
  self : GraphsearchastarModel,
  other : GraphsearchastarModel,
) -> GraphsearchastarModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarModel::copy(
  self : GraphsearchastarModel,
) -> GraphsearchastarModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarModel::fill(
  self : GraphsearchastarModel,
  v : Double,
) -> GraphsearchastarModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarModel::min(self : GraphsearchastarModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarModel::max(self : GraphsearchastarModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarModel::to_string(self : GraphsearchastarModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_layer_make(size : Int32) -> GraphsearchastarLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarLayer::len(self : GraphsearchastarLayer) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarLayer::get(
  self : GraphsearchastarLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarLayer::set(
  self : GraphsearchastarLayer,
  i : Int32,
  v : Double,
) -> GraphsearchastarLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarLayer::sum(self : GraphsearchastarLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarLayer::mean(self : GraphsearchastarLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarLayer::scale(
  self : GraphsearchastarLayer,
  f : Double,
) -> GraphsearchastarLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarLayer::add(
  self : GraphsearchastarLayer,
  other : GraphsearchastarLayer,
) -> GraphsearchastarLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarLayer::copy(
  self : GraphsearchastarLayer,
) -> GraphsearchastarLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarLayer::fill(
  self : GraphsearchastarLayer,
  v : Double,
) -> GraphsearchastarLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarLayer::min(self : GraphsearchastarLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarLayer::max(self : GraphsearchastarLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarLayer::to_string(self : GraphsearchastarLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_buffer_make(size : Int32) -> GraphsearchastarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarBuffer::len(self : GraphsearchastarBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarBuffer::get(
  self : GraphsearchastarBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarBuffer::set(
  self : GraphsearchastarBuffer,
  i : Int32,
  v : Double,
) -> GraphsearchastarBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarBuffer::sum(self : GraphsearchastarBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarBuffer::mean(self : GraphsearchastarBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarBuffer::scale(
  self : GraphsearchastarBuffer,
  f : Double,
) -> GraphsearchastarBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarBuffer::add(
  self : GraphsearchastarBuffer,
  other : GraphsearchastarBuffer,
) -> GraphsearchastarBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarBuffer::copy(
  self : GraphsearchastarBuffer,
) -> GraphsearchastarBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarBuffer::fill(
  self : GraphsearchastarBuffer,
  v : Double,
) -> GraphsearchastarBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarBuffer::min(self : GraphsearchastarBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarBuffer::max(self : GraphsearchastarBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarBuffer::to_string(
  self : GraphsearchastarBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_cursor_make(size : Int32) -> GraphsearchastarCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarCursor::len(self : GraphsearchastarCursor) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarCursor::get(
  self : GraphsearchastarCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarCursor::set(
  self : GraphsearchastarCursor,
  i : Int32,
  v : Double,
) -> GraphsearchastarCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCursor::sum(self : GraphsearchastarCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarCursor::mean(self : GraphsearchastarCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarCursor::scale(
  self : GraphsearchastarCursor,
  f : Double,
) -> GraphsearchastarCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCursor::add(
  self : GraphsearchastarCursor,
  other : GraphsearchastarCursor,
) -> GraphsearchastarCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarCursor::copy(
  self : GraphsearchastarCursor,
) -> GraphsearchastarCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCursor::fill(
  self : GraphsearchastarCursor,
  v : Double,
) -> GraphsearchastarCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarCursor::min(self : GraphsearchastarCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarCursor::max(self : GraphsearchastarCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarCursor::to_string(
  self : GraphsearchastarCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_view_make(size : Int32) -> GraphsearchastarView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarView::len(self : GraphsearchastarView) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarView::get(
  self : GraphsearchastarView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarView::set(
  self : GraphsearchastarView,
  i : Int32,
  v : Double,
) -> GraphsearchastarView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarView::sum(self : GraphsearchastarView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarView::mean(self : GraphsearchastarView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarView::scale(
  self : GraphsearchastarView,
  f : Double,
) -> GraphsearchastarView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarView::add(
  self : GraphsearchastarView,
  other : GraphsearchastarView,
) -> GraphsearchastarView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarView::copy(
  self : GraphsearchastarView,
) -> GraphsearchastarView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarView::fill(
  self : GraphsearchastarView,
  v : Double,
) -> GraphsearchastarView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarView::min(self : GraphsearchastarView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarView::max(self : GraphsearchastarView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarView::to_string(self : GraphsearchastarView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_range_make(size : Int32) -> GraphsearchastarRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarRange::len(self : GraphsearchastarRange) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarRange::get(
  self : GraphsearchastarRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarRange::set(
  self : GraphsearchastarRange,
  i : Int32,
  v : Double,
) -> GraphsearchastarRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarRange::sum(self : GraphsearchastarRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarRange::mean(self : GraphsearchastarRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarRange::scale(
  self : GraphsearchastarRange,
  f : Double,
) -> GraphsearchastarRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarRange::add(
  self : GraphsearchastarRange,
  other : GraphsearchastarRange,
) -> GraphsearchastarRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarRange::copy(
  self : GraphsearchastarRange,
) -> GraphsearchastarRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarRange::fill(
  self : GraphsearchastarRange,
  v : Double,
) -> GraphsearchastarRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarRange::min(self : GraphsearchastarRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarRange::max(self : GraphsearchastarRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarRange::to_string(self : GraphsearchastarRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphsearchastarSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_search_astar_slice_make(size : Int32) -> GraphsearchastarSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphsearchastarSlice::len(self : GraphsearchastarSlice) -> Int32 {
  self.size
}

///|
pub fn GraphsearchastarSlice::get(
  self : GraphsearchastarSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphsearchastarSlice::set(
  self : GraphsearchastarSlice,
  i : Int32,
  v : Double,
) -> GraphsearchastarSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarSlice::sum(self : GraphsearchastarSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphsearchastarSlice::mean(self : GraphsearchastarSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphsearchastarSlice::scale(
  self : GraphsearchastarSlice,
  f : Double,
) -> GraphsearchastarSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarSlice::add(
  self : GraphsearchastarSlice,
  other : GraphsearchastarSlice,
) -> GraphsearchastarSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphsearchastarSlice::copy(
  self : GraphsearchastarSlice,
) -> GraphsearchastarSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarSlice::fill(
  self : GraphsearchastarSlice,
  v : Double,
) -> GraphsearchastarSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphsearchastarSlice::min(self : GraphsearchastarSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphsearchastarSlice::max(self : GraphsearchastarSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphsearchastarSlice::to_string(self : GraphsearchastarSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
///===
/// extcore/graph_tree_spanning
pub(all) struct GraphtreespanningPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_tree_spanning_make_point(
  x : Double,
  y : Double,
) -> GraphtreespanningPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_tree_spanning_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphtreespanningPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphtreespanningPoint::x(self : GraphtreespanningPoint) -> Double {
  self.x
}

///|
pub fn GraphtreespanningPoint::y(self : GraphtreespanningPoint) -> Double {
  self.y
}

///|
pub fn GraphtreespanningPoint::z(self : GraphtreespanningPoint) -> Double {
  self.z
}

///|
pub fn GraphtreespanningPoint::label(self : GraphtreespanningPoint) -> Int32 {
  self.label
}

///|
pub fn GraphtreespanningPoint::dist(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphtreespanningPoint::add(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreespanningPoint::sub(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreespanningPoint::scale(
  self : GraphtreespanningPoint,
  s : Double,
) -> GraphtreespanningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphtreespanningPoint::dot(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphtreespanningPoint::cross(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphtreespanningPoint::norm(self : GraphtreespanningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphtreespanningPoint::normalize(
  self : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreespanningPoint::negate(
  self : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphtreespanningPoint::mid(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
) -> GraphtreespanningPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphtreespanningPoint::lerp(
  self : GraphtreespanningPoint,
  other : GraphtreespanningPoint,
  t : Double,
) -> GraphtreespanningPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphtreespanningPoint::to_string(
  self : GraphtreespanningPoint,
) -> String {
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
pub(all) struct GraphtreespanningSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_tree_spanning_make_series(
  vals : Array[Double],
  name : String,
) -> GraphtreespanningSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphtreespanningSeries::len(self : GraphtreespanningSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphtreespanningSeries::sum(self : GraphtreespanningSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphtreespanningSeries::mean(self : GraphtreespanningSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphtreespanningSeries::min(self : GraphtreespanningSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphtreespanningSeries::max(self : GraphtreespanningSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphtreespanningSeries::range(self : GraphtreespanningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphtreespanningSeries::variance(
  self : GraphtreespanningSeries,
) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphtreespanningSeries::std(self : GraphtreespanningSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphtreespanningSeries::median(
  self : GraphtreespanningSeries,
) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphtreespanningSeries::scale(
  self : GraphtreespanningSeries,
  f : Double,
) -> GraphtreespanningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphtreespanningSeries::add(
  self : GraphtreespanningSeries,
  other : GraphtreespanningSeries,
) -> GraphtreespanningSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreespanningSeries::sub(
  self : GraphtreespanningSeries,
  other : GraphtreespanningSeries,
) -> GraphtreespanningSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreespanningSeries::normalize(
  self : GraphtreespanningSeries,
) -> GraphtreespanningSeries {
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
pub fn GraphtreespanningSeries::cumsum(
  self : GraphtreespanningSeries,
) -> GraphtreespanningSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphtreespanningSeries::to_string(
  self : GraphtreespanningSeries,
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
pub(all) struct GraphtreespanningMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_tree_spanning_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphtreespanningMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_tree_spanning_matrix_identity(
  n : Int32,
) -> GraphtreespanningMatrix {
  let m = graph_tree_spanning_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphtreespanningMatrix::get(
  self : GraphtreespanningMatrix,
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
pub fn GraphtreespanningMatrix::transpose(
  self : GraphtreespanningMatrix,
) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreespanningMatrix::add(
  self : GraphtreespanningMatrix,
  other : GraphtreespanningMatrix,
) -> GraphtreespanningMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_tree_spanning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreespanningMatrix::scale(
  self : GraphtreespanningMatrix,
  s : Double,
) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphtreespanningMatrix::multiply(
  self : GraphtreespanningMatrix,
  other : GraphtreespanningMatrix,
) -> GraphtreespanningMatrix {
  if self.cols != other.rows {
    return graph_tree_spanning_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_tree_spanning_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphtreespanningMatrix::trace(self : GraphtreespanningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphtreespanningMatrix::det(self : GraphtreespanningMatrix) -> Double {
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
pub fn GraphtreespanningMatrix::norm(self : GraphtreespanningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GraphtreespanningMatrix::to_string(
  self : GraphtreespanningMatrix,
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
pub(all) struct GraphtreespanningVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_tree_spanning_make_vector(
  comps : Array[Double],
) -> GraphtreespanningVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_tree_spanning_vector_zero(dim : Int32) -> GraphtreespanningVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphtreespanningVector::add(
  self : GraphtreespanningVector,
  other : GraphtreespanningVector,
) -> GraphtreespanningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreespanningVector::sub(
  self : GraphtreespanningVector,
  other : GraphtreespanningVector,
) -> GraphtreespanningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreespanningVector::scale(
  self : GraphtreespanningVector,
  s : Double,
) -> GraphtreespanningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphtreespanningVector::dot(
  self : GraphtreespanningVector,
  other : GraphtreespanningVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphtreespanningVector::norm(self : GraphtreespanningVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphtreespanningVector::normalize(
  self : GraphtreespanningVector,
) -> GraphtreespanningVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreespanningVector::dist(
  self : GraphtreespanningVector,
  other : GraphtreespanningVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphtreespanningVector::to_string(
  self : GraphtreespanningVector,
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
pub(all) struct GraphtreespanningFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_frame_make(size : Int32) -> GraphtreespanningFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningFrame::len(self : GraphtreespanningFrame) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningFrame::get(
  self : GraphtreespanningFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningFrame::set(
  self : GraphtreespanningFrame,
  i : Int32,
  v : Double,
) -> GraphtreespanningFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningFrame::sum(self : GraphtreespanningFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningFrame::mean(self : GraphtreespanningFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningFrame::scale(
  self : GraphtreespanningFrame,
  f : Double,
) -> GraphtreespanningFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningFrame::add(
  self : GraphtreespanningFrame,
  other : GraphtreespanningFrame,
) -> GraphtreespanningFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningFrame::copy(
  self : GraphtreespanningFrame,
) -> GraphtreespanningFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningFrame::fill(
  self : GraphtreespanningFrame,
  v : Double,
) -> GraphtreespanningFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningFrame::min(self : GraphtreespanningFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningFrame::max(self : GraphtreespanningFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningFrame::to_string(
  self : GraphtreespanningFrame,
) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_table_make(size : Int32) -> GraphtreespanningTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningTable::len(self : GraphtreespanningTable) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningTable::get(
  self : GraphtreespanningTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningTable::set(
  self : GraphtreespanningTable,
  i : Int32,
  v : Double,
) -> GraphtreespanningTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningTable::sum(self : GraphtreespanningTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningTable::mean(self : GraphtreespanningTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningTable::scale(
  self : GraphtreespanningTable,
  f : Double,
) -> GraphtreespanningTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningTable::add(
  self : GraphtreespanningTable,
  other : GraphtreespanningTable,
) -> GraphtreespanningTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningTable::copy(
  self : GraphtreespanningTable,
) -> GraphtreespanningTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningTable::fill(
  self : GraphtreespanningTable,
  v : Double,
) -> GraphtreespanningTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningTable::min(self : GraphtreespanningTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningTable::max(self : GraphtreespanningTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningTable::to_string(
  self : GraphtreespanningTable,
) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_graphn_make(size : Int32) -> GraphtreespanningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningGraphN::len(self : GraphtreespanningGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningGraphN::get(
  self : GraphtreespanningGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningGraphN::set(
  self : GraphtreespanningGraphN,
  i : Int32,
  v : Double,
) -> GraphtreespanningGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningGraphN::sum(self : GraphtreespanningGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningGraphN::mean(self : GraphtreespanningGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningGraphN::scale(
  self : GraphtreespanningGraphN,
  f : Double,
) -> GraphtreespanningGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningGraphN::add(
  self : GraphtreespanningGraphN,
  other : GraphtreespanningGraphN,
) -> GraphtreespanningGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningGraphN::copy(
  self : GraphtreespanningGraphN,
) -> GraphtreespanningGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningGraphN::fill(
  self : GraphtreespanningGraphN,
  v : Double,
) -> GraphtreespanningGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningGraphN::min(self : GraphtreespanningGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningGraphN::max(self : GraphtreespanningGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningGraphN::to_string(
  self : GraphtreespanningGraphN,
) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_node_make(size : Int32) -> GraphtreespanningNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningNode::len(self : GraphtreespanningNode) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningNode::get(
  self : GraphtreespanningNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningNode::set(
  self : GraphtreespanningNode,
  i : Int32,
  v : Double,
) -> GraphtreespanningNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningNode::sum(self : GraphtreespanningNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningNode::mean(self : GraphtreespanningNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningNode::scale(
  self : GraphtreespanningNode,
  f : Double,
) -> GraphtreespanningNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningNode::add(
  self : GraphtreespanningNode,
  other : GraphtreespanningNode,
) -> GraphtreespanningNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningNode::copy(
  self : GraphtreespanningNode,
) -> GraphtreespanningNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningNode::fill(
  self : GraphtreespanningNode,
  v : Double,
) -> GraphtreespanningNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningNode::min(self : GraphtreespanningNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningNode::max(self : GraphtreespanningNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningNode::to_string(self : GraphtreespanningNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_edge_make(size : Int32) -> GraphtreespanningEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningEdge::len(self : GraphtreespanningEdge) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningEdge::get(
  self : GraphtreespanningEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningEdge::set(
  self : GraphtreespanningEdge,
  i : Int32,
  v : Double,
) -> GraphtreespanningEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningEdge::sum(self : GraphtreespanningEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningEdge::mean(self : GraphtreespanningEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningEdge::scale(
  self : GraphtreespanningEdge,
  f : Double,
) -> GraphtreespanningEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningEdge::add(
  self : GraphtreespanningEdge,
  other : GraphtreespanningEdge,
) -> GraphtreespanningEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningEdge::copy(
  self : GraphtreespanningEdge,
) -> GraphtreespanningEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningEdge::fill(
  self : GraphtreespanningEdge,
  v : Double,
) -> GraphtreespanningEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningEdge::min(self : GraphtreespanningEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningEdge::max(self : GraphtreespanningEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningEdge::to_string(self : GraphtreespanningEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_path_make(size : Int32) -> GraphtreespanningPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningPath::len(self : GraphtreespanningPath) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningPath::get(
  self : GraphtreespanningPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningPath::set(
  self : GraphtreespanningPath,
  i : Int32,
  v : Double,
) -> GraphtreespanningPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningPath::sum(self : GraphtreespanningPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningPath::mean(self : GraphtreespanningPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningPath::scale(
  self : GraphtreespanningPath,
  f : Double,
) -> GraphtreespanningPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningPath::add(
  self : GraphtreespanningPath,
  other : GraphtreespanningPath,
) -> GraphtreespanningPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningPath::copy(
  self : GraphtreespanningPath,
) -> GraphtreespanningPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningPath::fill(
  self : GraphtreespanningPath,
  v : Double,
) -> GraphtreespanningPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningPath::min(self : GraphtreespanningPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningPath::max(self : GraphtreespanningPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningPath::to_string(self : GraphtreespanningPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_cluster_make(
  size : Int32,
) -> GraphtreespanningCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningCluster::len(self : GraphtreespanningCluster) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningCluster::get(
  self : GraphtreespanningCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningCluster::set(
  self : GraphtreespanningCluster,
  i : Int32,
  v : Double,
) -> GraphtreespanningCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCluster::sum(self : GraphtreespanningCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningCluster::mean(
  self : GraphtreespanningCluster,
) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningCluster::scale(
  self : GraphtreespanningCluster,
  f : Double,
) -> GraphtreespanningCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCluster::add(
  self : GraphtreespanningCluster,
  other : GraphtreespanningCluster,
) -> GraphtreespanningCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningCluster::copy(
  self : GraphtreespanningCluster,
) -> GraphtreespanningCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCluster::fill(
  self : GraphtreespanningCluster,
  v : Double,
) -> GraphtreespanningCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCluster::min(self : GraphtreespanningCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningCluster::max(self : GraphtreespanningCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningCluster::to_string(
  self : GraphtreespanningCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_model_make(size : Int32) -> GraphtreespanningModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningModel::len(self : GraphtreespanningModel) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningModel::get(
  self : GraphtreespanningModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningModel::set(
  self : GraphtreespanningModel,
  i : Int32,
  v : Double,
) -> GraphtreespanningModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningModel::sum(self : GraphtreespanningModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningModel::mean(self : GraphtreespanningModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningModel::scale(
  self : GraphtreespanningModel,
  f : Double,
) -> GraphtreespanningModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningModel::add(
  self : GraphtreespanningModel,
  other : GraphtreespanningModel,
) -> GraphtreespanningModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningModel::copy(
  self : GraphtreespanningModel,
) -> GraphtreespanningModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningModel::fill(
  self : GraphtreespanningModel,
  v : Double,
) -> GraphtreespanningModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningModel::min(self : GraphtreespanningModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningModel::max(self : GraphtreespanningModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningModel::to_string(
  self : GraphtreespanningModel,
) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_layer_make(size : Int32) -> GraphtreespanningLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningLayer::len(self : GraphtreespanningLayer) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningLayer::get(
  self : GraphtreespanningLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningLayer::set(
  self : GraphtreespanningLayer,
  i : Int32,
  v : Double,
) -> GraphtreespanningLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningLayer::sum(self : GraphtreespanningLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningLayer::mean(self : GraphtreespanningLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningLayer::scale(
  self : GraphtreespanningLayer,
  f : Double,
) -> GraphtreespanningLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningLayer::add(
  self : GraphtreespanningLayer,
  other : GraphtreespanningLayer,
) -> GraphtreespanningLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningLayer::copy(
  self : GraphtreespanningLayer,
) -> GraphtreespanningLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningLayer::fill(
  self : GraphtreespanningLayer,
  v : Double,
) -> GraphtreespanningLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningLayer::min(self : GraphtreespanningLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningLayer::max(self : GraphtreespanningLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningLayer::to_string(
  self : GraphtreespanningLayer,
) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_buffer_make(size : Int32) -> GraphtreespanningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningBuffer::len(self : GraphtreespanningBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningBuffer::get(
  self : GraphtreespanningBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningBuffer::set(
  self : GraphtreespanningBuffer,
  i : Int32,
  v : Double,
) -> GraphtreespanningBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningBuffer::sum(self : GraphtreespanningBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningBuffer::mean(self : GraphtreespanningBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningBuffer::scale(
  self : GraphtreespanningBuffer,
  f : Double,
) -> GraphtreespanningBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningBuffer::add(
  self : GraphtreespanningBuffer,
  other : GraphtreespanningBuffer,
) -> GraphtreespanningBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningBuffer::copy(
  self : GraphtreespanningBuffer,
) -> GraphtreespanningBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningBuffer::fill(
  self : GraphtreespanningBuffer,
  v : Double,
) -> GraphtreespanningBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningBuffer::min(self : GraphtreespanningBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningBuffer::max(self : GraphtreespanningBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningBuffer::to_string(
  self : GraphtreespanningBuffer,
) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_cursor_make(size : Int32) -> GraphtreespanningCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningCursor::len(self : GraphtreespanningCursor) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningCursor::get(
  self : GraphtreespanningCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningCursor::set(
  self : GraphtreespanningCursor,
  i : Int32,
  v : Double,
) -> GraphtreespanningCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCursor::sum(self : GraphtreespanningCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningCursor::mean(self : GraphtreespanningCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningCursor::scale(
  self : GraphtreespanningCursor,
  f : Double,
) -> GraphtreespanningCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCursor::add(
  self : GraphtreespanningCursor,
  other : GraphtreespanningCursor,
) -> GraphtreespanningCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningCursor::copy(
  self : GraphtreespanningCursor,
) -> GraphtreespanningCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCursor::fill(
  self : GraphtreespanningCursor,
  v : Double,
) -> GraphtreespanningCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningCursor::min(self : GraphtreespanningCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningCursor::max(self : GraphtreespanningCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningCursor::to_string(
  self : GraphtreespanningCursor,
) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_view_make(size : Int32) -> GraphtreespanningView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningView::len(self : GraphtreespanningView) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningView::get(
  self : GraphtreespanningView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningView::set(
  self : GraphtreespanningView,
  i : Int32,
  v : Double,
) -> GraphtreespanningView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningView::sum(self : GraphtreespanningView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningView::mean(self : GraphtreespanningView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningView::scale(
  self : GraphtreespanningView,
  f : Double,
) -> GraphtreespanningView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningView::add(
  self : GraphtreespanningView,
  other : GraphtreespanningView,
) -> GraphtreespanningView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningView::copy(
  self : GraphtreespanningView,
) -> GraphtreespanningView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningView::fill(
  self : GraphtreespanningView,
  v : Double,
) -> GraphtreespanningView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningView::min(self : GraphtreespanningView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningView::max(self : GraphtreespanningView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningView::to_string(self : GraphtreespanningView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_range_make(size : Int32) -> GraphtreespanningRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningRange::len(self : GraphtreespanningRange) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningRange::get(
  self : GraphtreespanningRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningRange::set(
  self : GraphtreespanningRange,
  i : Int32,
  v : Double,
) -> GraphtreespanningRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningRange::sum(self : GraphtreespanningRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningRange::mean(self : GraphtreespanningRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningRange::scale(
  self : GraphtreespanningRange,
  f : Double,
) -> GraphtreespanningRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningRange::add(
  self : GraphtreespanningRange,
  other : GraphtreespanningRange,
) -> GraphtreespanningRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningRange::copy(
  self : GraphtreespanningRange,
) -> GraphtreespanningRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningRange::fill(
  self : GraphtreespanningRange,
  v : Double,
) -> GraphtreespanningRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningRange::min(self : GraphtreespanningRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningRange::max(self : GraphtreespanningRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningRange::to_string(
  self : GraphtreespanningRange,
) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreespanningSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_spanning_slice_make(size : Int32) -> GraphtreespanningSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreespanningSlice::len(self : GraphtreespanningSlice) -> Int32 {
  self.size
}

///|
pub fn GraphtreespanningSlice::get(
  self : GraphtreespanningSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreespanningSlice::set(
  self : GraphtreespanningSlice,
  i : Int32,
  v : Double,
) -> GraphtreespanningSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningSlice::sum(self : GraphtreespanningSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreespanningSlice::mean(self : GraphtreespanningSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreespanningSlice::scale(
  self : GraphtreespanningSlice,
  f : Double,
) -> GraphtreespanningSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningSlice::add(
  self : GraphtreespanningSlice,
  other : GraphtreespanningSlice,
) -> GraphtreespanningSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreespanningSlice::copy(
  self : GraphtreespanningSlice,
) -> GraphtreespanningSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningSlice::fill(
  self : GraphtreespanningSlice,
  v : Double,
) -> GraphtreespanningSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreespanningSlice::min(self : GraphtreespanningSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreespanningSlice::max(self : GraphtreespanningSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreespanningSlice::to_string(
  self : GraphtreespanningSlice,
) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

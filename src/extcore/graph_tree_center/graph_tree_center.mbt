///|
///===
/// extcore/graph_tree_center
pub(all) struct GraphtreecenterPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_tree_center_make_point(
  x : Double,
  y : Double,
) -> GraphtreecenterPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_tree_center_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphtreecenterPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphtreecenterPoint::x(self : GraphtreecenterPoint) -> Double {
  self.x
}

///|
pub fn GraphtreecenterPoint::y(self : GraphtreecenterPoint) -> Double {
  self.y
}

///|
pub fn GraphtreecenterPoint::z(self : GraphtreecenterPoint) -> Double {
  self.z
}

///|
pub fn GraphtreecenterPoint::label(self : GraphtreecenterPoint) -> Int32 {
  self.label
}

///|
pub fn GraphtreecenterPoint::dist(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphtreecenterPoint::add(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreecenterPoint::sub(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphtreecenterPoint::scale(
  self : GraphtreecenterPoint,
  s : Double,
) -> GraphtreecenterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphtreecenterPoint::dot(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphtreecenterPoint::cross(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphtreecenterPoint::norm(self : GraphtreecenterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphtreecenterPoint::normalize(
  self : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreecenterPoint::negate(
  self : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphtreecenterPoint::mid(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
) -> GraphtreecenterPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphtreecenterPoint::lerp(
  self : GraphtreecenterPoint,
  other : GraphtreecenterPoint,
  t : Double,
) -> GraphtreecenterPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphtreecenterPoint::to_string(self : GraphtreecenterPoint) -> String {
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
pub(all) struct GraphtreecenterSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_tree_center_make_series(
  vals : Array[Double],
  name : String,
) -> GraphtreecenterSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphtreecenterSeries::len(self : GraphtreecenterSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphtreecenterSeries::sum(self : GraphtreecenterSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphtreecenterSeries::mean(self : GraphtreecenterSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphtreecenterSeries::min(self : GraphtreecenterSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphtreecenterSeries::max(self : GraphtreecenterSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphtreecenterSeries::range(self : GraphtreecenterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphtreecenterSeries::variance(self : GraphtreecenterSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphtreecenterSeries::std(self : GraphtreecenterSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphtreecenterSeries::median(self : GraphtreecenterSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphtreecenterSeries::scale(
  self : GraphtreecenterSeries,
  f : Double,
) -> GraphtreecenterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphtreecenterSeries::add(
  self : GraphtreecenterSeries,
  other : GraphtreecenterSeries,
) -> GraphtreecenterSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreecenterSeries::sub(
  self : GraphtreecenterSeries,
  other : GraphtreecenterSeries,
) -> GraphtreecenterSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphtreecenterSeries::normalize(
  self : GraphtreecenterSeries,
) -> GraphtreecenterSeries {
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
pub fn GraphtreecenterSeries::cumsum(
  self : GraphtreecenterSeries,
) -> GraphtreecenterSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphtreecenterSeries::to_string(self : GraphtreecenterSeries) -> String {
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
pub(all) struct GraphtreecenterMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_tree_center_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphtreecenterMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_tree_center_matrix_identity(n : Int32) -> GraphtreecenterMatrix {
  let m = graph_tree_center_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphtreecenterMatrix::get(
  self : GraphtreecenterMatrix,
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
pub fn GraphtreecenterMatrix::transpose(
  self : GraphtreecenterMatrix,
) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreecenterMatrix::add(
  self : GraphtreecenterMatrix,
  other : GraphtreecenterMatrix,
) -> GraphtreecenterMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_tree_center_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphtreecenterMatrix::scale(
  self : GraphtreecenterMatrix,
  s : Double,
) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphtreecenterMatrix::multiply(
  self : GraphtreecenterMatrix,
  other : GraphtreecenterMatrix,
) -> GraphtreecenterMatrix {
  if self.cols != other.rows {
    return graph_tree_center_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_tree_center_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphtreecenterMatrix::trace(self : GraphtreecenterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphtreecenterMatrix::det(self : GraphtreecenterMatrix) -> Double {
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
pub fn GraphtreecenterMatrix::norm(self : GraphtreecenterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GraphtreecenterMatrix::to_string(self : GraphtreecenterMatrix) -> String {
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
pub(all) struct GraphtreecenterVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_tree_center_make_vector(
  comps : Array[Double],
) -> GraphtreecenterVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_tree_center_vector_zero(dim : Int32) -> GraphtreecenterVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphtreecenterVector::add(
  self : GraphtreecenterVector,
  other : GraphtreecenterVector,
) -> GraphtreecenterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreecenterVector::sub(
  self : GraphtreecenterVector,
  other : GraphtreecenterVector,
) -> GraphtreecenterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphtreecenterVector::scale(
  self : GraphtreecenterVector,
  s : Double,
) -> GraphtreecenterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphtreecenterVector::dot(
  self : GraphtreecenterVector,
  other : GraphtreecenterVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphtreecenterVector::norm(self : GraphtreecenterVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphtreecenterVector::normalize(
  self : GraphtreecenterVector,
) -> GraphtreecenterVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphtreecenterVector::dist(
  self : GraphtreecenterVector,
  other : GraphtreecenterVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphtreecenterVector::to_string(self : GraphtreecenterVector) -> String {
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
pub(all) struct GraphtreecenterFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_frame_make(size : Int32) -> GraphtreecenterFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterFrame::len(self : GraphtreecenterFrame) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterFrame::get(
  self : GraphtreecenterFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterFrame::set(
  self : GraphtreecenterFrame,
  i : Int32,
  v : Double,
) -> GraphtreecenterFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterFrame::sum(self : GraphtreecenterFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterFrame::mean(self : GraphtreecenterFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterFrame::scale(
  self : GraphtreecenterFrame,
  f : Double,
) -> GraphtreecenterFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterFrame::add(
  self : GraphtreecenterFrame,
  other : GraphtreecenterFrame,
) -> GraphtreecenterFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterFrame::copy(
  self : GraphtreecenterFrame,
) -> GraphtreecenterFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterFrame::fill(
  self : GraphtreecenterFrame,
  v : Double,
) -> GraphtreecenterFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterFrame::min(self : GraphtreecenterFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterFrame::max(self : GraphtreecenterFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterFrame::to_string(self : GraphtreecenterFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_table_make(size : Int32) -> GraphtreecenterTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterTable::len(self : GraphtreecenterTable) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterTable::get(
  self : GraphtreecenterTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterTable::set(
  self : GraphtreecenterTable,
  i : Int32,
  v : Double,
) -> GraphtreecenterTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterTable::sum(self : GraphtreecenterTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterTable::mean(self : GraphtreecenterTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterTable::scale(
  self : GraphtreecenterTable,
  f : Double,
) -> GraphtreecenterTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterTable::add(
  self : GraphtreecenterTable,
  other : GraphtreecenterTable,
) -> GraphtreecenterTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterTable::copy(
  self : GraphtreecenterTable,
) -> GraphtreecenterTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterTable::fill(
  self : GraphtreecenterTable,
  v : Double,
) -> GraphtreecenterTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterTable::min(self : GraphtreecenterTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterTable::max(self : GraphtreecenterTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterTable::to_string(self : GraphtreecenterTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_graphn_make(size : Int32) -> GraphtreecenterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterGraphN::len(self : GraphtreecenterGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterGraphN::get(
  self : GraphtreecenterGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterGraphN::set(
  self : GraphtreecenterGraphN,
  i : Int32,
  v : Double,
) -> GraphtreecenterGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterGraphN::sum(self : GraphtreecenterGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterGraphN::mean(self : GraphtreecenterGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterGraphN::scale(
  self : GraphtreecenterGraphN,
  f : Double,
) -> GraphtreecenterGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterGraphN::add(
  self : GraphtreecenterGraphN,
  other : GraphtreecenterGraphN,
) -> GraphtreecenterGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterGraphN::copy(
  self : GraphtreecenterGraphN,
) -> GraphtreecenterGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterGraphN::fill(
  self : GraphtreecenterGraphN,
  v : Double,
) -> GraphtreecenterGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterGraphN::min(self : GraphtreecenterGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterGraphN::max(self : GraphtreecenterGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterGraphN::to_string(self : GraphtreecenterGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_node_make(size : Int32) -> GraphtreecenterNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterNode::len(self : GraphtreecenterNode) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterNode::get(
  self : GraphtreecenterNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterNode::set(
  self : GraphtreecenterNode,
  i : Int32,
  v : Double,
) -> GraphtreecenterNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterNode::sum(self : GraphtreecenterNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterNode::mean(self : GraphtreecenterNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterNode::scale(
  self : GraphtreecenterNode,
  f : Double,
) -> GraphtreecenterNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterNode::add(
  self : GraphtreecenterNode,
  other : GraphtreecenterNode,
) -> GraphtreecenterNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterNode::copy(
  self : GraphtreecenterNode,
) -> GraphtreecenterNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterNode::fill(
  self : GraphtreecenterNode,
  v : Double,
) -> GraphtreecenterNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterNode::min(self : GraphtreecenterNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterNode::max(self : GraphtreecenterNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterNode::to_string(self : GraphtreecenterNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_edge_make(size : Int32) -> GraphtreecenterEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterEdge::len(self : GraphtreecenterEdge) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterEdge::get(
  self : GraphtreecenterEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterEdge::set(
  self : GraphtreecenterEdge,
  i : Int32,
  v : Double,
) -> GraphtreecenterEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterEdge::sum(self : GraphtreecenterEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterEdge::mean(self : GraphtreecenterEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterEdge::scale(
  self : GraphtreecenterEdge,
  f : Double,
) -> GraphtreecenterEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterEdge::add(
  self : GraphtreecenterEdge,
  other : GraphtreecenterEdge,
) -> GraphtreecenterEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterEdge::copy(
  self : GraphtreecenterEdge,
) -> GraphtreecenterEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterEdge::fill(
  self : GraphtreecenterEdge,
  v : Double,
) -> GraphtreecenterEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterEdge::min(self : GraphtreecenterEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterEdge::max(self : GraphtreecenterEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterEdge::to_string(self : GraphtreecenterEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_path_make(size : Int32) -> GraphtreecenterPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterPath::len(self : GraphtreecenterPath) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterPath::get(
  self : GraphtreecenterPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterPath::set(
  self : GraphtreecenterPath,
  i : Int32,
  v : Double,
) -> GraphtreecenterPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterPath::sum(self : GraphtreecenterPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterPath::mean(self : GraphtreecenterPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterPath::scale(
  self : GraphtreecenterPath,
  f : Double,
) -> GraphtreecenterPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterPath::add(
  self : GraphtreecenterPath,
  other : GraphtreecenterPath,
) -> GraphtreecenterPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterPath::copy(
  self : GraphtreecenterPath,
) -> GraphtreecenterPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterPath::fill(
  self : GraphtreecenterPath,
  v : Double,
) -> GraphtreecenterPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterPath::min(self : GraphtreecenterPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterPath::max(self : GraphtreecenterPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterPath::to_string(self : GraphtreecenterPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_cluster_make(size : Int32) -> GraphtreecenterCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterCluster::len(self : GraphtreecenterCluster) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterCluster::get(
  self : GraphtreecenterCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterCluster::set(
  self : GraphtreecenterCluster,
  i : Int32,
  v : Double,
) -> GraphtreecenterCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCluster::sum(self : GraphtreecenterCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterCluster::mean(self : GraphtreecenterCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterCluster::scale(
  self : GraphtreecenterCluster,
  f : Double,
) -> GraphtreecenterCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCluster::add(
  self : GraphtreecenterCluster,
  other : GraphtreecenterCluster,
) -> GraphtreecenterCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterCluster::copy(
  self : GraphtreecenterCluster,
) -> GraphtreecenterCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCluster::fill(
  self : GraphtreecenterCluster,
  v : Double,
) -> GraphtreecenterCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCluster::min(self : GraphtreecenterCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterCluster::max(self : GraphtreecenterCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterCluster::to_string(
  self : GraphtreecenterCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_model_make(size : Int32) -> GraphtreecenterModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterModel::len(self : GraphtreecenterModel) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterModel::get(
  self : GraphtreecenterModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterModel::set(
  self : GraphtreecenterModel,
  i : Int32,
  v : Double,
) -> GraphtreecenterModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterModel::sum(self : GraphtreecenterModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterModel::mean(self : GraphtreecenterModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterModel::scale(
  self : GraphtreecenterModel,
  f : Double,
) -> GraphtreecenterModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterModel::add(
  self : GraphtreecenterModel,
  other : GraphtreecenterModel,
) -> GraphtreecenterModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterModel::copy(
  self : GraphtreecenterModel,
) -> GraphtreecenterModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterModel::fill(
  self : GraphtreecenterModel,
  v : Double,
) -> GraphtreecenterModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterModel::min(self : GraphtreecenterModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterModel::max(self : GraphtreecenterModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterModel::to_string(self : GraphtreecenterModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_layer_make(size : Int32) -> GraphtreecenterLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterLayer::len(self : GraphtreecenterLayer) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterLayer::get(
  self : GraphtreecenterLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterLayer::set(
  self : GraphtreecenterLayer,
  i : Int32,
  v : Double,
) -> GraphtreecenterLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterLayer::sum(self : GraphtreecenterLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterLayer::mean(self : GraphtreecenterLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterLayer::scale(
  self : GraphtreecenterLayer,
  f : Double,
) -> GraphtreecenterLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterLayer::add(
  self : GraphtreecenterLayer,
  other : GraphtreecenterLayer,
) -> GraphtreecenterLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterLayer::copy(
  self : GraphtreecenterLayer,
) -> GraphtreecenterLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterLayer::fill(
  self : GraphtreecenterLayer,
  v : Double,
) -> GraphtreecenterLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterLayer::min(self : GraphtreecenterLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterLayer::max(self : GraphtreecenterLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterLayer::to_string(self : GraphtreecenterLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_buffer_make(size : Int32) -> GraphtreecenterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterBuffer::len(self : GraphtreecenterBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterBuffer::get(
  self : GraphtreecenterBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterBuffer::set(
  self : GraphtreecenterBuffer,
  i : Int32,
  v : Double,
) -> GraphtreecenterBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterBuffer::sum(self : GraphtreecenterBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterBuffer::mean(self : GraphtreecenterBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterBuffer::scale(
  self : GraphtreecenterBuffer,
  f : Double,
) -> GraphtreecenterBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterBuffer::add(
  self : GraphtreecenterBuffer,
  other : GraphtreecenterBuffer,
) -> GraphtreecenterBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterBuffer::copy(
  self : GraphtreecenterBuffer,
) -> GraphtreecenterBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterBuffer::fill(
  self : GraphtreecenterBuffer,
  v : Double,
) -> GraphtreecenterBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterBuffer::min(self : GraphtreecenterBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterBuffer::max(self : GraphtreecenterBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterBuffer::to_string(self : GraphtreecenterBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_cursor_make(size : Int32) -> GraphtreecenterCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterCursor::len(self : GraphtreecenterCursor) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterCursor::get(
  self : GraphtreecenterCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterCursor::set(
  self : GraphtreecenterCursor,
  i : Int32,
  v : Double,
) -> GraphtreecenterCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCursor::sum(self : GraphtreecenterCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterCursor::mean(self : GraphtreecenterCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterCursor::scale(
  self : GraphtreecenterCursor,
  f : Double,
) -> GraphtreecenterCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCursor::add(
  self : GraphtreecenterCursor,
  other : GraphtreecenterCursor,
) -> GraphtreecenterCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterCursor::copy(
  self : GraphtreecenterCursor,
) -> GraphtreecenterCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCursor::fill(
  self : GraphtreecenterCursor,
  v : Double,
) -> GraphtreecenterCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterCursor::min(self : GraphtreecenterCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterCursor::max(self : GraphtreecenterCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterCursor::to_string(self : GraphtreecenterCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_view_make(size : Int32) -> GraphtreecenterView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterView::len(self : GraphtreecenterView) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterView::get(
  self : GraphtreecenterView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterView::set(
  self : GraphtreecenterView,
  i : Int32,
  v : Double,
) -> GraphtreecenterView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterView::sum(self : GraphtreecenterView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterView::mean(self : GraphtreecenterView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterView::scale(
  self : GraphtreecenterView,
  f : Double,
) -> GraphtreecenterView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterView::add(
  self : GraphtreecenterView,
  other : GraphtreecenterView,
) -> GraphtreecenterView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterView::copy(
  self : GraphtreecenterView,
) -> GraphtreecenterView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterView::fill(
  self : GraphtreecenterView,
  v : Double,
) -> GraphtreecenterView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterView::min(self : GraphtreecenterView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterView::max(self : GraphtreecenterView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterView::to_string(self : GraphtreecenterView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_range_make(size : Int32) -> GraphtreecenterRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterRange::len(self : GraphtreecenterRange) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterRange::get(
  self : GraphtreecenterRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterRange::set(
  self : GraphtreecenterRange,
  i : Int32,
  v : Double,
) -> GraphtreecenterRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterRange::sum(self : GraphtreecenterRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterRange::mean(self : GraphtreecenterRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterRange::scale(
  self : GraphtreecenterRange,
  f : Double,
) -> GraphtreecenterRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterRange::add(
  self : GraphtreecenterRange,
  other : GraphtreecenterRange,
) -> GraphtreecenterRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterRange::copy(
  self : GraphtreecenterRange,
) -> GraphtreecenterRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterRange::fill(
  self : GraphtreecenterRange,
  v : Double,
) -> GraphtreecenterRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterRange::min(self : GraphtreecenterRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterRange::max(self : GraphtreecenterRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterRange::to_string(self : GraphtreecenterRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphtreecenterSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_tree_center_slice_make(size : Int32) -> GraphtreecenterSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphtreecenterSlice::len(self : GraphtreecenterSlice) -> Int32 {
  self.size
}

///|
pub fn GraphtreecenterSlice::get(
  self : GraphtreecenterSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphtreecenterSlice::set(
  self : GraphtreecenterSlice,
  i : Int32,
  v : Double,
) -> GraphtreecenterSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterSlice::sum(self : GraphtreecenterSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphtreecenterSlice::mean(self : GraphtreecenterSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphtreecenterSlice::scale(
  self : GraphtreecenterSlice,
  f : Double,
) -> GraphtreecenterSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterSlice::add(
  self : GraphtreecenterSlice,
  other : GraphtreecenterSlice,
) -> GraphtreecenterSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphtreecenterSlice::copy(
  self : GraphtreecenterSlice,
) -> GraphtreecenterSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterSlice::fill(
  self : GraphtreecenterSlice,
  v : Double,
) -> GraphtreecenterSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphtreecenterSlice::min(self : GraphtreecenterSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphtreecenterSlice::max(self : GraphtreecenterSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphtreecenterSlice::to_string(self : GraphtreecenterSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

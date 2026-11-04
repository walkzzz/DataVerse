///|
///===
/// extcore/graph_color_welsh
pub(all) struct GraphcolorwelshPoint {
  x : Double
  y : Double
  z : Double
  label : Int32
}

///|
pub fn graph_color_welsh_make_point(
  x : Double,
  y : Double,
) -> GraphcolorwelshPoint {
  { x, y, z: 0.0, label: 0, }
}

///|
pub fn graph_color_welsh_make_point3(
  x : Double,
  y : Double,
  z : Double,
) -> GraphcolorwelshPoint {
  { x, y, z, label: 0, }
}

///|
pub fn GraphcolorwelshPoint::x(self : GraphcolorwelshPoint) -> Double {
  self.x
}

///|
pub fn GraphcolorwelshPoint::y(self : GraphcolorwelshPoint) -> Double {
  self.y
}

///|
pub fn GraphcolorwelshPoint::z(self : GraphcolorwelshPoint) -> Double {
  self.z
}

///|
pub fn GraphcolorwelshPoint::label(self : GraphcolorwelshPoint) -> Int32 {
  self.label
}

///|
pub fn GraphcolorwelshPoint::dist(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

///|
pub fn GraphcolorwelshPoint::add(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  {
    x: self.x + other.x,
    y: self.y + other.y,
    z: self.z + other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorwelshPoint::sub(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  {
    x: self.x - other.x,
    y: self.y - other.y,
    z: self.z - other.z,
    label: self.label,
  }
}

///|
pub fn GraphcolorwelshPoint::scale(
  self : GraphcolorwelshPoint,
  s : Double,
) -> GraphcolorwelshPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label, }
}

///|
pub fn GraphcolorwelshPoint::dot(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
pub fn GraphcolorwelshPoint::cross(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
    label: 0,
  }
}

///|
pub fn GraphcolorwelshPoint::norm(self : GraphcolorwelshPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

///|
pub fn GraphcolorwelshPoint::normalize(
  self : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorwelshPoint::negate(
  self : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label, }
}

///|
pub fn GraphcolorwelshPoint::mid(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
) -> GraphcolorwelshPoint {
  {
    x: (self.x + other.x) / 2.0,
    y: (self.y + other.y) / 2.0,
    z: (self.z + other.z) / 2.0,
    label: self.label,
  }
}

///|
pub fn GraphcolorwelshPoint::lerp(
  self : GraphcolorwelshPoint,
  other : GraphcolorwelshPoint,
  t : Double,
) -> GraphcolorwelshPoint {
  {
    x: self.x + (other.x - self.x) * t,
    y: self.y + (other.y - self.y) * t,
    z: self.z + (other.z - self.z) * t,
    label: self.label,
  }
}

///|
pub fn GraphcolorwelshPoint::to_string(self : GraphcolorwelshPoint) -> String {
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
pub(all) struct GraphcolorwelshSeries {
  vals : Array[Double]
  name : String
  meta : Int32
}

///|
pub fn graph_color_welsh_make_series(
  vals : Array[Double],
  name : String,
) -> GraphcolorwelshSeries {
  { vals, name, meta: 0, }
}

///|
pub fn GraphcolorwelshSeries::len(self : GraphcolorwelshSeries) -> Int32 {
  self.vals.length()
}

///|
pub fn GraphcolorwelshSeries::sum(self : GraphcolorwelshSeries) -> Double {
  @_common.sum(self.vals)
}

///|
pub fn GraphcolorwelshSeries::mean(self : GraphcolorwelshSeries) -> Double {
  @_common.mean(self.vals)
}

///|
pub fn GraphcolorwelshSeries::min(self : GraphcolorwelshSeries) -> Double {
  @_common.min(self.vals)
}

///|
pub fn GraphcolorwelshSeries::max(self : GraphcolorwelshSeries) -> Double {
  @_common.max(self.vals)
}

///|
pub fn GraphcolorwelshSeries::range(self : GraphcolorwelshSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

///|
pub fn GraphcolorwelshSeries::variance(self : GraphcolorwelshSeries) -> Double {
  @_common.variance(self.vals)
}

///|
pub fn GraphcolorwelshSeries::std(self : GraphcolorwelshSeries) -> Double {
  @_common.std(self.vals)
}

///|
pub fn GraphcolorwelshSeries::median(self : GraphcolorwelshSeries) -> Double {
  @_common.median(self.vals)
}

///|
pub fn GraphcolorwelshSeries::scale(
  self : GraphcolorwelshSeries,
  f : Double,
) -> GraphcolorwelshSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta, }
}

///|
pub fn GraphcolorwelshSeries::add(
  self : GraphcolorwelshSeries,
  other : GraphcolorwelshSeries,
) -> GraphcolorwelshSeries {
  {
    vals: @_common.add_arr(self.vals, other.vals),
    name: self.name + "+" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorwelshSeries::sub(
  self : GraphcolorwelshSeries,
  other : GraphcolorwelshSeries,
) -> GraphcolorwelshSeries {
  {
    vals: @_common.sub_arr(self.vals, other.vals),
    name: self.name + "-" + other.name,
    meta: self.meta,
  }
}

///|
pub fn GraphcolorwelshSeries::normalize(
  self : GraphcolorwelshSeries,
) -> GraphcolorwelshSeries {
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
pub fn GraphcolorwelshSeries::cumsum(
  self : GraphcolorwelshSeries,
) -> GraphcolorwelshSeries {
  {
    vals: @_common.cumsum(self.vals),
    name: self.name + "_cumsum",
    meta: self.meta,
  }
}

///|
pub fn GraphcolorwelshSeries::to_string(self : GraphcolorwelshSeries) -> String {
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
pub(all) struct GraphcolorwelshMatrix {
  data : Array[Array[Double]]
  rows : Int32
  cols : Int32
}

///|
pub fn graph_color_welsh_make_matrix(
  rows : Int32,
  cols : Int32,
  val : Double,
) -> GraphcolorwelshMatrix {
  let data = []
  for _ in 0..<rows {
    data.push(Array::make(cols, val))
  }
  { data, rows, cols, }
}

///|
pub fn graph_color_welsh_matrix_identity(n : Int32) -> GraphcolorwelshMatrix {
  let m = graph_color_welsh_make_matrix(n, n, 0.0)
  for i in 0..<n {
    m.data[i][i] = 1.0
  }
  m
}

///|
pub fn GraphcolorwelshMatrix::get(
  self : GraphcolorwelshMatrix,
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
pub fn GraphcolorwelshMatrix::transpose(
  self : GraphcolorwelshMatrix,
) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[j][i] = self.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorwelshMatrix::add(
  self : GraphcolorwelshMatrix,
  other : GraphcolorwelshMatrix,
) -> GraphcolorwelshMatrix {
  if self.rows != other.rows || self.cols != other.cols {
    return self
  }
  let result = graph_color_welsh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] + other.data[i][j]
    }
  }
  result
}

///|
pub fn GraphcolorwelshMatrix::scale(
  self : GraphcolorwelshMatrix,
  s : Double,
) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      result.data[i][j] = self.data[i][j] * s
    }
  }
  result
}

///|
pub fn GraphcolorwelshMatrix::multiply(
  self : GraphcolorwelshMatrix,
  other : GraphcolorwelshMatrix,
) -> GraphcolorwelshMatrix {
  if self.cols != other.rows {
    return graph_color_welsh_make_matrix(self.rows, other.cols, 0.0)
  }
  let result = graph_color_welsh_make_matrix(self.rows, other.cols, 0.0)
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
pub fn GraphcolorwelshMatrix::trace(self : GraphcolorwelshMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.data[i][i]
  }
  sum
}

///|
pub fn GraphcolorwelshMatrix::det(self : GraphcolorwelshMatrix) -> Double {
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
pub fn GraphcolorwelshMatrix::norm(self : GraphcolorwelshMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows {
    for j in 0..<self.cols {
      sum = sum + self.data[i][j] * self.data[i][j]
    }
  }
  @_common.sqrt(sum)
}

///|
pub fn GraphcolorwelshMatrix::to_string(self : GraphcolorwelshMatrix) -> String {
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
pub(all) struct GraphcolorwelshVector {
  comps : Array[Double]
  dim : Int32
}

///|
pub fn graph_color_welsh_make_vector(
  comps : Array[Double],
) -> GraphcolorwelshVector {
  { comps, dim: comps.length(), }
}

///|
pub fn graph_color_welsh_vector_zero(dim : Int32) -> GraphcolorwelshVector {
  { comps: Array::make(dim, 0.0), dim, }
}

///|
pub fn GraphcolorwelshVector::add(
  self : GraphcolorwelshVector,
  other : GraphcolorwelshVector,
) -> GraphcolorwelshVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorwelshVector::sub(
  self : GraphcolorwelshVector,
  other : GraphcolorwelshVector,
) -> GraphcolorwelshVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n, }
}

///|
pub fn GraphcolorwelshVector::scale(
  self : GraphcolorwelshVector,
  s : Double,
) -> GraphcolorwelshVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim, }
}

///|
pub fn GraphcolorwelshVector::dot(
  self : GraphcolorwelshVector,
  other : GraphcolorwelshVector,
) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + self.comps[i] * other.comps[i]
  }
  sum
}

///|
pub fn GraphcolorwelshVector::norm(self : GraphcolorwelshVector) -> Double {
  self.dot(self) |> @_common.sqrt
}

///|
pub fn GraphcolorwelshVector::normalize(
  self : GraphcolorwelshVector,
) -> GraphcolorwelshVector {
  let n = self.norm()
  if n < 0.0000001 {
    self
  } else {
    self.scale(1.0 / n)
  }
}

///|
pub fn GraphcolorwelshVector::dist(
  self : GraphcolorwelshVector,
  other : GraphcolorwelshVector,
) -> Double {
  self.sub(other).norm()
}

///|
pub fn GraphcolorwelshVector::to_string(self : GraphcolorwelshVector) -> String {
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
pub(all) struct GraphcolorwelshFrame {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_frame_make(size : Int32) -> GraphcolorwelshFrame {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshFrame::len(self : GraphcolorwelshFrame) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshFrame::get(
  self : GraphcolorwelshFrame,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshFrame::set(
  self : GraphcolorwelshFrame,
  i : Int32,
  v : Double,
) -> GraphcolorwelshFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshFrame::sum(self : GraphcolorwelshFrame) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshFrame::mean(self : GraphcolorwelshFrame) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshFrame::scale(
  self : GraphcolorwelshFrame,
  f : Double,
) -> GraphcolorwelshFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshFrame::add(
  self : GraphcolorwelshFrame,
  other : GraphcolorwelshFrame,
) -> GraphcolorwelshFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshFrame::copy(
  self : GraphcolorwelshFrame,
) -> GraphcolorwelshFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshFrame::fill(
  self : GraphcolorwelshFrame,
  v : Double,
) -> GraphcolorwelshFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshFrame::min(self : GraphcolorwelshFrame) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshFrame::max(self : GraphcolorwelshFrame) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshFrame::to_string(self : GraphcolorwelshFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshTable {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_table_make(size : Int32) -> GraphcolorwelshTable {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshTable::len(self : GraphcolorwelshTable) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshTable::get(
  self : GraphcolorwelshTable,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshTable::set(
  self : GraphcolorwelshTable,
  i : Int32,
  v : Double,
) -> GraphcolorwelshTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshTable::sum(self : GraphcolorwelshTable) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshTable::mean(self : GraphcolorwelshTable) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshTable::scale(
  self : GraphcolorwelshTable,
  f : Double,
) -> GraphcolorwelshTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshTable::add(
  self : GraphcolorwelshTable,
  other : GraphcolorwelshTable,
) -> GraphcolorwelshTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshTable::copy(
  self : GraphcolorwelshTable,
) -> GraphcolorwelshTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshTable::fill(
  self : GraphcolorwelshTable,
  v : Double,
) -> GraphcolorwelshTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshTable::min(self : GraphcolorwelshTable) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshTable::max(self : GraphcolorwelshTable) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshTable::to_string(self : GraphcolorwelshTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshGraphN {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_graphn_make(size : Int32) -> GraphcolorwelshGraphN {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshGraphN::len(self : GraphcolorwelshGraphN) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshGraphN::get(
  self : GraphcolorwelshGraphN,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshGraphN::set(
  self : GraphcolorwelshGraphN,
  i : Int32,
  v : Double,
) -> GraphcolorwelshGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshGraphN::sum(self : GraphcolorwelshGraphN) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshGraphN::mean(self : GraphcolorwelshGraphN) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshGraphN::scale(
  self : GraphcolorwelshGraphN,
  f : Double,
) -> GraphcolorwelshGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshGraphN::add(
  self : GraphcolorwelshGraphN,
  other : GraphcolorwelshGraphN,
) -> GraphcolorwelshGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshGraphN::copy(
  self : GraphcolorwelshGraphN,
) -> GraphcolorwelshGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshGraphN::fill(
  self : GraphcolorwelshGraphN,
  v : Double,
) -> GraphcolorwelshGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshGraphN::min(self : GraphcolorwelshGraphN) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshGraphN::max(self : GraphcolorwelshGraphN) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshGraphN::to_string(self : GraphcolorwelshGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshNode {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_node_make(size : Int32) -> GraphcolorwelshNode {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshNode::len(self : GraphcolorwelshNode) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshNode::get(
  self : GraphcolorwelshNode,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshNode::set(
  self : GraphcolorwelshNode,
  i : Int32,
  v : Double,
) -> GraphcolorwelshNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshNode::sum(self : GraphcolorwelshNode) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshNode::mean(self : GraphcolorwelshNode) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshNode::scale(
  self : GraphcolorwelshNode,
  f : Double,
) -> GraphcolorwelshNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshNode::add(
  self : GraphcolorwelshNode,
  other : GraphcolorwelshNode,
) -> GraphcolorwelshNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshNode::copy(
  self : GraphcolorwelshNode,
) -> GraphcolorwelshNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshNode::fill(
  self : GraphcolorwelshNode,
  v : Double,
) -> GraphcolorwelshNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshNode::min(self : GraphcolorwelshNode) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshNode::max(self : GraphcolorwelshNode) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshNode::to_string(self : GraphcolorwelshNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshEdge {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_edge_make(size : Int32) -> GraphcolorwelshEdge {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshEdge::len(self : GraphcolorwelshEdge) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshEdge::get(
  self : GraphcolorwelshEdge,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshEdge::set(
  self : GraphcolorwelshEdge,
  i : Int32,
  v : Double,
) -> GraphcolorwelshEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshEdge::sum(self : GraphcolorwelshEdge) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshEdge::mean(self : GraphcolorwelshEdge) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshEdge::scale(
  self : GraphcolorwelshEdge,
  f : Double,
) -> GraphcolorwelshEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshEdge::add(
  self : GraphcolorwelshEdge,
  other : GraphcolorwelshEdge,
) -> GraphcolorwelshEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshEdge::copy(
  self : GraphcolorwelshEdge,
) -> GraphcolorwelshEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshEdge::fill(
  self : GraphcolorwelshEdge,
  v : Double,
) -> GraphcolorwelshEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshEdge::min(self : GraphcolorwelshEdge) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshEdge::max(self : GraphcolorwelshEdge) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshEdge::to_string(self : GraphcolorwelshEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshPath {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_path_make(size : Int32) -> GraphcolorwelshPath {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshPath::len(self : GraphcolorwelshPath) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshPath::get(
  self : GraphcolorwelshPath,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshPath::set(
  self : GraphcolorwelshPath,
  i : Int32,
  v : Double,
) -> GraphcolorwelshPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshPath::sum(self : GraphcolorwelshPath) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshPath::mean(self : GraphcolorwelshPath) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshPath::scale(
  self : GraphcolorwelshPath,
  f : Double,
) -> GraphcolorwelshPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshPath::add(
  self : GraphcolorwelshPath,
  other : GraphcolorwelshPath,
) -> GraphcolorwelshPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshPath::copy(
  self : GraphcolorwelshPath,
) -> GraphcolorwelshPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshPath::fill(
  self : GraphcolorwelshPath,
  v : Double,
) -> GraphcolorwelshPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshPath::min(self : GraphcolorwelshPath) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshPath::max(self : GraphcolorwelshPath) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshPath::to_string(self : GraphcolorwelshPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshCluster {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_cluster_make(size : Int32) -> GraphcolorwelshCluster {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshCluster::len(self : GraphcolorwelshCluster) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshCluster::get(
  self : GraphcolorwelshCluster,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshCluster::set(
  self : GraphcolorwelshCluster,
  i : Int32,
  v : Double,
) -> GraphcolorwelshCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCluster::sum(self : GraphcolorwelshCluster) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshCluster::mean(self : GraphcolorwelshCluster) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshCluster::scale(
  self : GraphcolorwelshCluster,
  f : Double,
) -> GraphcolorwelshCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCluster::add(
  self : GraphcolorwelshCluster,
  other : GraphcolorwelshCluster,
) -> GraphcolorwelshCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCluster::copy(
  self : GraphcolorwelshCluster,
) -> GraphcolorwelshCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCluster::fill(
  self : GraphcolorwelshCluster,
  v : Double,
) -> GraphcolorwelshCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCluster::min(self : GraphcolorwelshCluster) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshCluster::max(self : GraphcolorwelshCluster) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshCluster::to_string(
  self : GraphcolorwelshCluster,
) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshModel {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_model_make(size : Int32) -> GraphcolorwelshModel {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshModel::len(self : GraphcolorwelshModel) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshModel::get(
  self : GraphcolorwelshModel,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshModel::set(
  self : GraphcolorwelshModel,
  i : Int32,
  v : Double,
) -> GraphcolorwelshModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshModel::sum(self : GraphcolorwelshModel) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshModel::mean(self : GraphcolorwelshModel) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshModel::scale(
  self : GraphcolorwelshModel,
  f : Double,
) -> GraphcolorwelshModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshModel::add(
  self : GraphcolorwelshModel,
  other : GraphcolorwelshModel,
) -> GraphcolorwelshModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshModel::copy(
  self : GraphcolorwelshModel,
) -> GraphcolorwelshModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshModel::fill(
  self : GraphcolorwelshModel,
  v : Double,
) -> GraphcolorwelshModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshModel::min(self : GraphcolorwelshModel) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshModel::max(self : GraphcolorwelshModel) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshModel::to_string(self : GraphcolorwelshModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshLayer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_layer_make(size : Int32) -> GraphcolorwelshLayer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshLayer::len(self : GraphcolorwelshLayer) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshLayer::get(
  self : GraphcolorwelshLayer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshLayer::set(
  self : GraphcolorwelshLayer,
  i : Int32,
  v : Double,
) -> GraphcolorwelshLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshLayer::sum(self : GraphcolorwelshLayer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshLayer::mean(self : GraphcolorwelshLayer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshLayer::scale(
  self : GraphcolorwelshLayer,
  f : Double,
) -> GraphcolorwelshLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshLayer::add(
  self : GraphcolorwelshLayer,
  other : GraphcolorwelshLayer,
) -> GraphcolorwelshLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshLayer::copy(
  self : GraphcolorwelshLayer,
) -> GraphcolorwelshLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshLayer::fill(
  self : GraphcolorwelshLayer,
  v : Double,
) -> GraphcolorwelshLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshLayer::min(self : GraphcolorwelshLayer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshLayer::max(self : GraphcolorwelshLayer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshLayer::to_string(self : GraphcolorwelshLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshBuffer {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_buffer_make(size : Int32) -> GraphcolorwelshBuffer {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshBuffer::len(self : GraphcolorwelshBuffer) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshBuffer::get(
  self : GraphcolorwelshBuffer,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshBuffer::set(
  self : GraphcolorwelshBuffer,
  i : Int32,
  v : Double,
) -> GraphcolorwelshBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshBuffer::sum(self : GraphcolorwelshBuffer) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshBuffer::mean(self : GraphcolorwelshBuffer) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshBuffer::scale(
  self : GraphcolorwelshBuffer,
  f : Double,
) -> GraphcolorwelshBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshBuffer::add(
  self : GraphcolorwelshBuffer,
  other : GraphcolorwelshBuffer,
) -> GraphcolorwelshBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshBuffer::copy(
  self : GraphcolorwelshBuffer,
) -> GraphcolorwelshBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshBuffer::fill(
  self : GraphcolorwelshBuffer,
  v : Double,
) -> GraphcolorwelshBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshBuffer::min(self : GraphcolorwelshBuffer) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshBuffer::max(self : GraphcolorwelshBuffer) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshBuffer::to_string(self : GraphcolorwelshBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshCursor {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_cursor_make(size : Int32) -> GraphcolorwelshCursor {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshCursor::len(self : GraphcolorwelshCursor) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshCursor::get(
  self : GraphcolorwelshCursor,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshCursor::set(
  self : GraphcolorwelshCursor,
  i : Int32,
  v : Double,
) -> GraphcolorwelshCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCursor::sum(self : GraphcolorwelshCursor) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshCursor::mean(self : GraphcolorwelshCursor) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshCursor::scale(
  self : GraphcolorwelshCursor,
  f : Double,
) -> GraphcolorwelshCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCursor::add(
  self : GraphcolorwelshCursor,
  other : GraphcolorwelshCursor,
) -> GraphcolorwelshCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCursor::copy(
  self : GraphcolorwelshCursor,
) -> GraphcolorwelshCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCursor::fill(
  self : GraphcolorwelshCursor,
  v : Double,
) -> GraphcolorwelshCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshCursor::min(self : GraphcolorwelshCursor) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshCursor::max(self : GraphcolorwelshCursor) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshCursor::to_string(self : GraphcolorwelshCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshView {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_view_make(size : Int32) -> GraphcolorwelshView {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshView::len(self : GraphcolorwelshView) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshView::get(
  self : GraphcolorwelshView,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshView::set(
  self : GraphcolorwelshView,
  i : Int32,
  v : Double,
) -> GraphcolorwelshView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshView::sum(self : GraphcolorwelshView) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshView::mean(self : GraphcolorwelshView) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshView::scale(
  self : GraphcolorwelshView,
  f : Double,
) -> GraphcolorwelshView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshView::add(
  self : GraphcolorwelshView,
  other : GraphcolorwelshView,
) -> GraphcolorwelshView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshView::copy(
  self : GraphcolorwelshView,
) -> GraphcolorwelshView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshView::fill(
  self : GraphcolorwelshView,
  v : Double,
) -> GraphcolorwelshView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshView::min(self : GraphcolorwelshView) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshView::max(self : GraphcolorwelshView) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshView::to_string(self : GraphcolorwelshView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshRange {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_range_make(size : Int32) -> GraphcolorwelshRange {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshRange::len(self : GraphcolorwelshRange) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshRange::get(
  self : GraphcolorwelshRange,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshRange::set(
  self : GraphcolorwelshRange,
  i : Int32,
  v : Double,
) -> GraphcolorwelshRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshRange::sum(self : GraphcolorwelshRange) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshRange::mean(self : GraphcolorwelshRange) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshRange::scale(
  self : GraphcolorwelshRange,
  f : Double,
) -> GraphcolorwelshRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshRange::add(
  self : GraphcolorwelshRange,
  other : GraphcolorwelshRange,
) -> GraphcolorwelshRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshRange::copy(
  self : GraphcolorwelshRange,
) -> GraphcolorwelshRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshRange::fill(
  self : GraphcolorwelshRange,
  v : Double,
) -> GraphcolorwelshRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshRange::min(self : GraphcolorwelshRange) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshRange::max(self : GraphcolorwelshRange) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshRange::to_string(self : GraphcolorwelshRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

///|
pub(all) struct GraphcolorwelshSlice {
  data : Array[Double]
  size : Int32
  tag : Int32
}

///|
pub fn graph_color_welsh_slice_make(size : Int32) -> GraphcolorwelshSlice {
  { data: Array::make(size, 0.0), size, tag: 0, }
}

///|
pub fn GraphcolorwelshSlice::len(self : GraphcolorwelshSlice) -> Int32 {
  self.size
}

///|
pub fn GraphcolorwelshSlice::get(
  self : GraphcolorwelshSlice,
  i : Int32,
) -> Double {
  if i < 0 || i >= self.size {
    0.0
  } else {
    self.data[i]
  }
}

///|
pub fn GraphcolorwelshSlice::set(
  self : GraphcolorwelshSlice,
  i : Int32,
  v : Double,
) -> GraphcolorwelshSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size {
    data[i] = v
  }
  { data, size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshSlice::sum(self : GraphcolorwelshSlice) -> Double {
  @_common.sum(self.data)
}

///|
pub fn GraphcolorwelshSlice::mean(self : GraphcolorwelshSlice) -> Double {
  @_common.mean(self.data)
}

///|
pub fn GraphcolorwelshSlice::scale(
  self : GraphcolorwelshSlice,
  f : Double,
) -> GraphcolorwelshSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshSlice::add(
  self : GraphcolorwelshSlice,
  other : GraphcolorwelshSlice,
) -> GraphcolorwelshSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag, }
}

///|
pub fn GraphcolorwelshSlice::copy(
  self : GraphcolorwelshSlice,
) -> GraphcolorwelshSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshSlice::fill(
  self : GraphcolorwelshSlice,
  v : Double,
) -> GraphcolorwelshSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag, }
}

///|
pub fn GraphcolorwelshSlice::min(self : GraphcolorwelshSlice) -> Double {
  @_common.min(self.data)
}

///|
pub fn GraphcolorwelshSlice::max(self : GraphcolorwelshSlice) -> Double {
  @_common.max(self.data)
}

///|
pub fn GraphcolorwelshSlice::to_string(self : GraphcolorwelshSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}
